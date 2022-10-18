import * as dotenv from "dotenv";

import { createClient } from "redis";
import debug from "debug";
import express from "express";
import fetch from "node-fetch";

// .env 정보 로딩
dotenv.config();

const GIT_URL = "https://api.github.com/users/";
const REDIS_HOST = process.env.REDIS_HOST || "127.0.0.1";
const REDIS_PORT = process.env.REDIS_PORT || 6379;
const REDIS_PASSWORD = process.env.REDIS_PASSWORD || "";
const WEB_PORT = process.env.PORT_WEB || 5000;

const dlog = new debug("todo:debug");
const ilog = new debug("todo:info");
const elog = new debug("todo:error");
const app = express();

let client = createClient({
  socket: {
    host: REDIS_HOST,
    port: REDIS_PORT,
  },
  password: REDIS_PASSWORD,
});
client.on("error", (err) => console.log("Redis Client Error", err));

await client.connect();
ilog(`redis connected : ${REDIS_HOST}:${REDIS_PORT}`);

const getRepos = async (req, res, next) => {
  const { username } = req.params;
  dlog("getRepos", username);
  try {
    const response = await fetch(`${GIT_URL}${username}`);
    const data = await response.json();
    const repos = data.public_repos;
    dlog(username, repos);
    await client.set(username, repos);
    res.send(genView(username, repos));
  } catch (err) {
    elog(err);
    throw err;
  }
};

const getCache = async (req, res, next) => {
  const { username } = req.params;
  const { reload } = req.query;
  if (reload === "true") {
    next();
  } else {
    client
      .get(username)
      .then((data) => {
        if (data) {
          res.send(genView(username, data));
        } else {
          next();
        }
      })
      .catch((err) => {
        throw err;
      });
  }
};
const genView = (username, repos) => {
  return `<h1>${username} \'s numbers of repositories are ${repos}</h1>`;
};

app.get("/repo/:username", getCache, getRepos);
app.listen(WEB_PORT, () => console.log("server started..."));
