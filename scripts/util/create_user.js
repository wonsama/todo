// file : create_user.js
// title : user 계정생성 유틸
// since : 22.10.18
// desc : -
// see more : https://github.com/motdotla/dotenv#how-do-i-use-dotenv-with-import

import * as dotenv from "dotenv";

import crypto from "crypto";
import debug from "debug";
import query from "../../src/libs/wsm-pg.js";
import { tohash } from "../../src/libs/wsm-crypto.js";

// .env 정보 로딩
dotenv.config();

const dlog = new debug("create-user:debug");
const elog = new debug("create-user:error");

/**
 * 진입점
 * @returns N/A
 */
async function init() {
  let user_id = process.env.USER_ID || "TESTER";
  let user_nm = process.env.USER_NM || "테스터";
  let user_pw = process.env.USER_PW || "TESTER1234";
  let user_email = process.env.USER_EMAIL || "tester@tester.com";
  let role_grp_cd = process.env.ROLE_GRP_CD || "ROLE_GRP_CD_USER";

  // 사용자 존재여부 조회
  let p1 = [user_id];
  let r1 = await query("TODO", "user", "sel_one_user", p1);
  if (r1.rowCount == 1) {
    elog(`user [${user_id}] already exist`);
    return;
  }
  dlog(r1);

  // 사용자 등록
  let p2 = [user_id, user_nm, tohash(user_pw), user_email, role_grp_cd];
  let r2 = await query("TODO", "user", "ins_user", p2);
  dlog(r2);
}
init();
