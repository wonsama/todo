// file : app.js
// title : TODO Application
// since : 22.10.19
// desc : -
// see more : -

// .env 정보 로딩
dotenv.config();

import * as dotenv from "dotenv";

import bodyParser from "body-parser";
import connectRedis from "connect-redis";
import debug from "debug";
import express from "express";
import { fileURLToPath } from "url";
import path from "path";
import redis from "ioredis";
import registerRoutes from "./src/routes/_register.js";
import session from "express-session";

// CONFIG - WEB
const WEB_PORT = process.env.WEB_PORT || 5555;
const WEB_SESSION_SECRET = process.env.WEB_SESSION_SECRET || "secret";

// CONFIG - REDIS
const REDIS_HOST = process.env.REDIS_HOST || "127.0.0.1";
const REDIS_PORT = process.env.REDIS_PORT || 6379;

// LOGGERs
const dlog = new debug("todo:debug");
const ilog = new debug("todo:info");
const elog = new debug("todo:error");

// ETC Consts
const RedisStore = connectRedis(session);
const app = express();

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

// redis client setting
const redisClient = redis.createClient(REDIS_PORT, REDIS_HOST);
redisClient.on("error", (err) =>
  ilog(`redis client error : ${REDIS_HOST}:${REDIS_PORT} - ${err?.toString()}`)
);
redisClient.on("connect", function (err) {
  ilog(`redis client connected : ${REDIS_HOST}:${REDIS_PORT}`);
});

// Express Set
app.set("views", path.join(__dirname, "./src/views"));
app.set("view engine", "pug");
app.set("trust proxy", 1); // enable this if you run behind a proxy (e.g. nginx)

// Express MiddleWares
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));
app.use(express.static(path.join(__dirname, "./src/public")));
app.use(
  session({
    store: new RedisStore({ client: redisClient }),
    secret: WEB_SESSION_SECRET,
    resave: false,
    saveUninitialized: false,
    cookie: {
      secure: false, // if true only transmit cookie over https
      httpOnly: false, // if true prevent client side JS from reading the cookie
      maxAge: 1000 * 60 * 10, // session max age in miliseconds
    },
  })
);

// Express Routes
registerRoutes(app);

// 내부서버 오류
app.use(function (err, req, res, next) {
  elog("internal error", err);
  res.status(err.status || 500);
  res.render("error", { err });
});

// maching page not found
app.get("*", function (req, res) {
  let fullUrl = req.protocol + "://" + req.get("host") + req.originalUrl;

  elog(`not found : ${fullUrl}`);

  res.render("error", {
    message: "Page Not Found",
    err: {
      status: 404,
      stack: `${fullUrl}`,
    },
  });
});

// Express listen
app.listen(WEB_PORT, () =>
  ilog(`web server started http://127.0.0.1:${WEB_PORT}`)
);
