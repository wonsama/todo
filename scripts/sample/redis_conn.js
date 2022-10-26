import bodyParser from "body-parser";
import express from "express";
import redis from "redis";

const WEB_HOST = "127.0.0.1";
const WEB_PORT = 5555;
const REDIS_HOST = "127.0.0.11";
const REDIS_PORT = 6666;
const REDIS_DB = 0;
const REDIS_PASSWORD = "systodo1234";

const app = express();
const router = express.Router();

// const redisClient = redis.createClient({
//   host: REDIS_HOST,
//   port: REDIS_PORT, //6379
//   db: REDIS_DB,
//   password: REDIS_PASSWORD,
// });
const redisClient = redis.createClient({
  // host: REDIS_HOST,
  // port: REDIS_PORT,
  // password: REDIS_PASSWORD,
});
redisClient.connect();

/* GET home page. */
router.get("/", async function (req, res, next) {
  let count = await redisClient.get("count");
  console.log("count", count);
  if (count == null) {
    await redisClient.set("count", 1);
  } else {
    await redisClient.set("count", parseInt(count) + 1);
  }
  await redisClient.save();
  count = await redisClient.get("count");
  res.send({ count });
});

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

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
