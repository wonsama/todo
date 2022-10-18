import * as dotenv from "dotenv";

import debug from "debug";
import express from "express";
import fetch from "node-fetch";
import redis from "redis";

const ilog = new debug("todo:info");
const dlog = new debug("todo:debug");
const elog = new debug("todo:error");

// .env 정보 로딩
dotenv.config();

const REDIS_PORT = process.env.PORT_REDIS || 6666;
const PORT_WEB = process.env.PORT_WEB || 5000;
const app = express();
const client = redis.createClient({
  host: "127.0.0.1",
  port: 6379,
  db: 0, // Redis에서 사용하는 DB 번호
  password: "systodo1234",
});
ilog("REDIS_PORT", REDIS_PORT);
ilog("client", client);
const GIT_URL = "https://api.github.com/users/";

const getRepos = async (req, res, next) => {
  dlog("getRepos");
  try {
    const { username } = req.params;
    const response = await fetch(`${GIT_URL}${username}`);
    const data = await response.json();
    const repos = data.public_repos;
    client.set(username, repos);
    res.send(genView(username, repos));
  } catch (e) {
    if (e) elog("error: ", e);
  }
};

const getCache = (req, res, next) => {
  const { username } = req.params;
  dlog("getCache", username);
  client.get(username, (err, data) => {
    if (err) throw err;
    if (data) {
      res.send(genView(username, data));
    } else {
      next();
    }
  });
};

const genView = (username, repos) => {
  return `<h1>${username} \'s numbers of repositories are ${repos}</h1>`;
};

app.get("/:username", getCache, getRepos);
app.listen(PORT_WEB, () => console.log("server started..."));
