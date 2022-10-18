// file : redis-cache.js
// title : 레디스 테스트 ( 캐싱 & 세션 )
// since : 22.10.18
// desc : -
// see more : -

import * as dotenv from "dotenv";

import bodyParser from "body-parser";
import connectRedis from "connect-redis";
import { createClient } from "redis";
import debug from "debug";
import express from "express";
import fetch from "node-fetch";
import session from "express-session";

// .env 정보 로딩
dotenv.config();

const GIT_URL = "https://api.github.com/users/";
const REDIS_HOST = process.env.REDIS_HOST || "127.0.0.1";
const REDIS_PORT = process.env.REDIS_PORT || 6379;
const REDIS_PASSWORD = process.env.REDIS_PASSWORD || "";
const WEB_PORT = process.env.WEB_PORT || 5555;

const dlog = new debug("todo:debug");
const ilog = new debug("todo:info");
const elog = new debug("todo:error");
const RedisStore = connectRedis(session);

const app = express();

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

// enable this if you run behind a proxy (e.g. nginx)
app.set("trust proxy", 1);

// redis client setting
const redisClient = createClient({
  socket: {
    host: REDIS_HOST,
    port: REDIS_PORT,
  },
  password: REDIS_PASSWORD,
});
redisClient.on("error", (err) =>
  ilog(`redis client error : ${REDIS_HOST}:${REDIS_PORT} - ${err?.toString()}`)
);
redisClient.on("connect", function (err) {
  ilog(`redis client connected : ${REDIS_HOST}:${REDIS_PORT}`);
});
await redisClient.connect();

//Configure session middleware
app.use(
  session({
    store: new RedisStore({ client: redisClient }),
    secret: "secret$%^134",
    resave: false,
    saveUninitialized: false,
    cookie: {
      secure: false, // if true only transmit cookie over https
      httpOnly: false, // if true prevent client side JS from reading the cookie
      maxAge: 1000 * 60 * 10, // session max age in miliseconds
    },
  })
);

// redis session check
// const getSession = (req, res, next) => {
//   client.get(`sess:${req.session.id}`, (err, data) => {
//     if (err) res.json({ err });
//     if (data) {
//       res.send(genView(req.session.username, req.session.repos));
//     } else {
//       next();
//     }
//   });
// };

// redis cache check
const getCache = async (req, res, next) => {
  const { username } = req.params;
  const { reload } = req.query;

  // dlog("req.session.id", req.session.id);

  if (reload === "true") {
    next();
  } else {
    redisClient
      .get(username)
      .then((data) => {
        if (data) {
          res.send(genView(username, JSON.parse(data)));
        } else {
          next();
        }
      })
      .catch((err) => {
        throw err;
      });
  }
};

// redis set data
const getRepos = async (req, res, next) => {
  const { username } = req.params;
  dlog("getRepos", username);
  try {
    const response = await fetch(`${GIT_URL}${username}`);
    const data = await response.json();
    if (data.public_repos) {
      // redis 에 undefined, null 을 기록 할 수 없음 - Invalid argument type
      await redisClient.set(username, JSON.stringify(data));
    }
    res.send(genView(username, data));
  } catch (err) {
    elog(err);
    throw err;
  }
};

// respose drawing
const genView = (username, data) => {
  if (data.public_repos) {
    return `<img src='${data.avatar_url}' style='height:50px;'/><h1>${username} \'s numbers of repositories are ${data.public_repos}</h1>`;
  }
  return `<h1>${username} \'s account does not exist.</h1>`;
};

// listen & routing
app.get("/repo/:username", getCache, getRepos);
app.listen(WEB_PORT, () => console.log("server started..."));
