import express from "express";

// import session from "express-session";

export const router = express.Router();

router.get("/", async function (req, res, next) {
  // console.log(req.sessionStore);

  // req.sessionStore.get(req.cookies, function (err, session) {
  //   console.log(session);
  // });

  // let a = await req.sessionStore.get("wonsama");
  // console.log(req.sessionStore);

  // console.log(req.session.name);
  req.session.name = "abc";

  res.render(`./`, {});

  // if (req.session.name) {
  //   res.render(`./`, {});
  // } else {
  //   res.redirect("login");
  // }
});

router.get("/login", function (req, res, next) {
  req.session.name = "wonsama";
  res.send("login");
});

// router.get("/check", function (req, res, next) {
//   res.send(`req.session.key : ${req.session.key}`);
// });

// router.get("/logout", function (req, res, next) {
//   req.session.res.send("logout");
//   req.session.destroy(function (err) {
//     if (err) {
//       connsole.log("logout error", err);
//       res.send("logout error");
//     } else {
//       res.send("logout");
//     }
//   });
// });
