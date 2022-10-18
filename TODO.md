# TODO

## NOT YET

- 22.10.18 : `redis pub/sub` 을 활용하여 알림 구현
  - 누군가 신규로 `todo` 를 작성하면 해당 정보를 웹 페이지를 보고 있는 모두에게 `broadcating` 처리

## CHECK

- 22.10.18 : REST API(`nestjs` 활용 안) 와 FRONT 를 분리하여 동작하도록 고려
- 22.10.18 : 나중에 수행 쿼리를 DB에 넣고 가져오는 형태로 고려

## DONE

- 22.10.18 : SQL 폴더에 있는 `sql 파일을 all-in-one.sql 하나의 sql 파일로 생성` 해 주는 script 파일 만들기 (in scripts)
  - 매번 `all-in-one.sql` 파일을 삭제 한 후 생성하도록 유도
  - :::> `scripts/docker/postgresql/create_tables.sql` 로 대체
- 22.10.18 : `scripts` 에 포함된 것들은 `npm run xxx` 형태의 커맨드로 수행 될 수 있어야 됨
  - :::> `yarn wcache` 와 같이 스크립트를 `pakage.json` 에 정의하여 수행 하도록 처리
- 22.10.18 : docker 로 db 를 기동하면 최초 테이블 생성 및 기초 데이터 적재가 자동으로 이뤄지도록 구성 ( `docker-compose.yml` 파일 내 구성 가능 )
  - :::> `scripts/docker/postgresql/create_tables.sql` 에서 테이블 생성, 기초데이터 적재 등을 수행하도록 함
