# README

## 개발 환경 구성

- postgresql(15.0) + express(4.18.2) + redis(alpine) + pug(3.0.2) + tailwind-css(3.1.8)

## YARN INSTALL

- [로컬 YARN 설치](https://yarnpkg.com/latest.msi)
- [YARN OFFLINE RELEASE JS 설치](https://github.com/yarnpkg/yarn/releases)
- 패키지 만들기 : `$ yarn package`
- 오프라인 설치 : `$ node ./scripts/install/yarn-1.22.19.js install --offline`

## TAILWIND CSS AUTO BUILD

```sh
npx tailwindcss -i ./scripts/tailwind/input.css -o ./src/public/css/tailwind.css --watch
```

## DB (postgresql) 구동

> 사전에 `docker 또는 docker desktop` 이 설치되어 있어야 됨

```sh
cd scripts/docker
docker compose up -d
```

## REFERENCE

- [express에서 에러로 HTTP status code 통제하기](https://if1live.github.io/web/express-error-and-http-status-code/)
- [내 redis가 해킹당했다고? 심지어 local인데?](https://thxwelchs.github.io/%EB%82%B4redis%EA%B0%80%ED%95%B4%ED%82%B9%EB%8B%B9%ED%96%88%EB%8B%A4%EA%B3%A0%EC%8B%AC%EC%A7%80%EC%96%B4local%EC%9D%B8%EB%8D%B0/)
- [Node.js에서 redis사용하기](https://soonysoon.tistory.com/m/70)
- [Redis with Node.js (node_redis)](https://docs.redis.com/latest/rs/references/client_references/client_nodejs/)
- [Bitnami package for Redis®](https://hub.docker.com/r/bitnami/redis)
- [Redis configuration](https://redis.io/docs/manual/config/)
- [Environment variables in Compose](https://docs.docker.com/compose/environment-variables/)
- [Nodemon - exclusion of files](https://stackoverflow.com/questions/24120004/nodemon-exclusion-of-files)
- [Node.js에서 ES 모듈(import/export) 사용하기](https://www.daleseo.com/js-node-es-modules/)
- [npm:dotenv](https://www.npmjs.com/package/dotenv)
- [[Node.js] NPM Debug 모듈 사용법](https://jaenjoy.tistory.com/m/16)
- [[NodeJS] crypto를 이용한 단방향 암호화(해시 함수) 만들기](https://minu0807.tistory.com/m/84)
- [ERR_UNSAFE_PORT 오류를 수정하는 방법](https://ziphyoun.tistory.com/m/947)
- [Redis 설치 후 Warning 제거하기](https://comcube.tistory.com/m/entry/Redis-%EC%84%A4%EC%B9%98-%ED%9B%84-Warning-%EC%A0%9C%EA%B1%B0%ED%95%98%EA%B8%B0) - 미반영
- [[JS]Express Session과 Redis Store 연결하여 사용하기](https://krpeppermint100.medium.com/js-express-session%EA%B3%BC-redis-store-%EC%97%B0%EA%B2%B0%ED%95%98%EC%97%AC-%EC%82%AC%EC%9A%A9%ED%95%98%EA%B8%B0-bf4df45eb15b)
- [Fix "\_\_dirname is not defined in ES module scope" in JS](https://bobbyhadz.com/blog/javascript-dirname-is-not-defined-in-es-module-scope)
