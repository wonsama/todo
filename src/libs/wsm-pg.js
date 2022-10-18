// file : wsm-pg.js
// title : postgresql 유틸
// since : 22.08.25
// desc : -
// see more : https://node-postgres.com/

import debug from "debug";
import { fileURLToPath } from "url";
import fs from "fs";
import path from "path";
import pg from "pg";

const { join } = path;
const { Client } = pg;

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const qlog = new debug("todo:query");

/**
 * 쿼리를 수행한다
 * @param {string} prefix 접두사 (.env 설정 정보 참조용)
 * @param {string} domain 도메인
 * @param {string} seq 일련번호
 * @param {string} params 파라미터
 * @returns 쿼리 수행 결과
 */
export async function getQuery(prefix, domain, seq, params) {
  qlog("run query :\n", _load(domain, seq, params));

  let client = getClient(prefix);

  await client.connect();

  let res = await client.query(_load(domain, seq, params), []);
  client.end();

  // console.log(res);

  return {
    rowCount: res.rowCount,
    command: res.command,
    fields: res.fields.map((x) => x.name),
    rows: res.rows,
  };
}

/**
 * 쿼리 정보를 읽어들인다
 * @param {string} domain 업무구분
 * @param {string} seq 4자리 시퀀스, 0000 부터 시작
 * @param {string} params 파라미터 목록 (sql에서는 1부터 매칭)
 */
function _load(domain = "st", seq = "0000", params = []) {
  let sql = fs.readFileSync(
    join(__dirname, `../sql/${domain}/${seq}.sql`),
    "utf-8"
  );

  for (let i = 0; i < params.length; i++) {
    var replace = `\\$${i + 1}`;
    var re = new RegExp(replace, "gi");
    sql = sql.replace(re, params[i]);
  }

  let split = sql.replace(/\n/gi, "\r").split("\r"); // 라인 단위 리딩
  split = split.filter((x) => x.indexOf("--") != 0); // 주석 시작 제거
  split = split.filter((x) => x.indexOf(":exist()") == -1); // EXIST 점검
  split = split.map((x) => {
    // NOT EXIST 점검
    if (x.indexOf(":notexist()") >= 0) {
      return x.replace(":notexist()", "");
    } else if (/\:notexist\(.*\)/.test(x)) {
      return "";
    }
    return x.replace(/\:exist\(.*\)\s/, "");
  });
  split = split.filter((x) => x.trim() != "");

  return split.join("\r\n");
}

/**
 * 클라이언트 정보를 반환한다
 * @param {string} prefix 설정정보 접두사
 * @returns 클라이언트 정보
 */
function getClient(prefix = "TODO") {
  return new Client({
    user: process.env[prefix + "_PG_USER"],
    host: process.env[prefix + "_PG_HOST"],
    database: process.env[prefix + "_PG_DATABASE"],
    password: process.env[prefix + "_PG_PW"],
    port: process.env[prefix + "_PG_PORT"],
  });
}
