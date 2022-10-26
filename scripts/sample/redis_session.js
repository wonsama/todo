import connectRedis from "connect-redis";
import express from "express";
// import redis from "redis"; // redis의 client로 app 서버 지정
import redis from "ioredis";
import session from "express-session";

const RedisStore = connectRedis(session); // session과 redis 연결

const WEB_HOST = "127.0.0.1";
const WEB_PORT = 5555;
// const REDIS_PASSWORD = "systodo1234";

const redisClient = redis.createClient(); // redis 서버의 포트, host 값을 인자로 넘긴다.

const app = express();
const router = express.Router();

const sessOption = {
  name: "sessionId",
  secret: "keyboard cat",
  resave: true,
  saveUninitialized: false,
  cookie: {},
  store: new RedisStore({
    client: redisClient,
    ttl: 200,
  }),
};

app.use(session(sessOption));

// app.use(bodyParser.json());
// app.use(bodyParser.urlencoded({ extended: true }));

/* GET home page. */
router.get("/", async function (req, res, next) {
  let count = await redisClient.get("count");
  console.log(req.session.id);

  if (!req.session.num) {
    req.session.num = "a";
  }

  if (count == null) {
    await redisClient.set("count", 1);
  } else {
    await redisClient.set("count", parseInt(count) + 1);
  }
  await redisClient.save();
  count = await redisClient.get("count");
  res.send({ count });
});
app.use("/", router);

// maching page not found
app.get("*", function (req, res) {
  console.log(req.query);
  res.send({ fail: "not found" });
});

// Express listen
app.listen("5555", () =>
  console.log(`web server started http://${WEB_HOST}:${WEB_PORT}`)
);
