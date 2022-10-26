# TROUBLES

## [The client is closed](https://stackoverflow.com/questions/70402383/redis-cloud-and-connect-redis-the-client-is-closed)

- 상황
  - `The client is closed` 라는 메시지 출력
  - hang이 걸리는 상황 발생
- 해결
  - dependency 를 `redis` 대신에 `ioredis` 를 사용하도록 한다
  - 일반적인 connection 은 상관없으나 session 과 연동하여 사용하려면 문제 발생 ( v7 이상의 redis 설치 시 )
