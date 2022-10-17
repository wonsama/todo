# sequence

> 출처 : [[PostgreSQL] 시퀀스(Sequence) 사용법 (nextval, currval, setval)](https://mine-it-record.tistory.com/m/341)

## 예제1) 시퀀스 생성과 삭제

```sql
CREATE SEQUENCE mine_seq;
DROP SEQUENCE mine_seq;
```

## 예제2) 시퀀스 현재값과 다음값

```sql
SELECT currval('mine_seq');
SELECT nextval('mine_seq');
```

## 예제3) 시퀀스 초기화

```sql
SELECT setval('mine_seq', 1, true); -- nextval('mine_seq') = 2
SELECT setval('mine_seq', 1, false); -- nextval('mine_seq') = 1
```

## 예제4) 쿼리문으로 목록 가져오기

```sql
select n.nspname as sequence_schema,
          c.relname as sequence_name,
          u.usename as owner
from pg_class c
     join pg_namespace n on n.oid = c.relnamespace
     join pg_user u on u.usesysid = c.relowner
where c.relkind = 'S'
     and u.usename = current_user;
```
