import express from "express";

export const router = express.Router();

router.get("/", async function (req, res, next) {
  // console.log(req.sessionStore);

  // req.sessionStore.get(req.cookies, function (err, session) {
  //   console.log(session);
  // });

  let a = await req.sessionStore.get("wonsama");
  console.log(req.sessionStore);

  res.render(`./`, {});
});

router.get("/login", function (req, res, next) {
  res.send("login");
});

router.get("/logout", function (req, res, next) {
  res.send("logout");
});
