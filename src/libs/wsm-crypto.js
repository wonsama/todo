// file : wsm-crypto.js
// title : 암복호화 유틸리티
// since : 22.10.26
// desc : -
// see more : -

import crypto from "crypto";
import debug from "debug";

const dlog = new debug("crypto:debug");
const elog = new debug("crypto:error");

/**
 * 입력 문자열[source]을 hash 처리한다
 * @param {string} source 입력 문자열
 * @param {string} algorism 알고리즘  ( 기본 : sha256 )
 * @param {string} digest 압축방식 ( 기본 : base64)
 * @returns hash 화 된 문자열
 */
export function tohash(source, algorism = "sha256", digest = "base64") {
  let encrypt = crypto.createHash(algorism).update(source).digest(digest);
  dlog(source, encrypt);
  return encrypt;
}
