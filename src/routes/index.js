// file : src/routes/index.js
// title : 메인 페이지 : 로그인, 로그아웃 등
// since : 22.10.26
// desc : -
// see more : -

///////////////////////////////////////////////
//
// import
//

import debug from "debug";
import express from "express";
import query from "../libs/wsm-pg.js";
import { tohash } from "../libs/wsm-crypto.js";

///////////////////////////////////////////////
//
// module exports
//
export const router = express.Router();

///////////////////////////////////////////////
//
// loggers
//
const dlog = new debug("todo:debug");
const ilog = new debug("todo:info");
const elog = new debug("todo:error");

///////////////////////////////////////////////
//
// private functions
//

// path : /login
// title : HOME, 로그인 된 경우에는 dash board 아니라면 login 페이지로 redirect 처리를 수행
router.get("/", async function (req, res, next) {
  if (req.session.name) {
    res.render(`./`, {});
  } else {
    res.redirect("login");
  }
});

// path : /login
// title : 로그인 페이지
router.get("/login", function (req, res, next) {
  res.render("login", {});
});

router.post("/login", async function (req, res, next) {
  let { user_id, user_pw } = req.body;

  dlog(user_id, user_pw);
  if (!user_id || !user_pw) {
    res.json({ logined: false, msg: "Be sure to enter id and pw." });
    return;
  }

  let qres = await query("TODO", "user", "sel_one_user", [
    user_id,
    tohash(user_pw),
  ]);
  dlog(tohash(user_id), qres.rows);

  if (qres.rowCount == 1) {
    // success
    res.json({ logined: true, msg: "" });
  } else {
    // fail
    res.json({
      logined: false,
      msg: `There are no matching values in your account[${user_id}] information.`,
    });
  }
});

// path : /logout
// title : 로그아웃 페이지
router.get("/logout", function (req, res, next) {
  req.session.destroy(function (err) {
    if (err) {
      connsole.log("logout error", err);
      res.send("logout error");
    } else {
      console.log(req.session);
      res.send("logout");
    }
  });
});
