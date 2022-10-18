--
--  SEQUENCE
-- 
CREATE SEQUENCE IF NOT EXISTS public.seq_tb_todo_id;

--
--  TABLE tb_code_grp
-- 
CREATE TABLE IF NOT EXISTS public.tb_code_grp (
	grp_cd varchar(32) NOT NULL,
	grp_cd_nm varchar(128) NOT NULL,
	grp_cd_desc varchar(512) NOT NULL,

	is_use boolean NOT NULL DEFAULT true,
	creator_id varchar(16) NOT NULL DEFAULT 'SYSTEM',
	created_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	modifier_id varchar(16) NOT NULL DEFAULT 'SYSTEM',
	modified_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,

	CONSTRAINT pk_tb_code_grp PRIMARY KEY (grp_cd)
);
COMMENT ON TABLE public.tb_code_grp IS '코드 그룹';

COMMENT ON COLUMN public.tb_code_grp.grp_cd IS '그룹 코드';
COMMENT ON COLUMN public.tb_code_grp.grp_cd_nm IS '그룹 코드 명';
COMMENT ON COLUMN public.tb_code_grp.grp_cd_desc IS '그룹 코드 설명';

COMMENT ON COLUMN public.tb_code_grp.is_use IS '사용 여부';
COMMENT ON COLUMN public.tb_code_grp.creator_id IS '생성자 아이디';
COMMENT ON COLUMN public.tb_code_grp.created_at IS '생성 일시';
COMMENT ON COLUMN public.tb_code_grp.modifier_id IS '수정자 아이디';
COMMENT ON COLUMN public.tb_code_grp.modified_at IS '수정 일시';

--
--  TABLE tb_code
-- 

CREATE TABLE IF NOT EXISTS public.tb_code (
	grp_cd varchar(32) NOT NULL,
	cd varchar(32) NOT NULL,
	cd_nm varchar(128) NOT NULL,
	cd_desc varchar(512) NOT NULL,
	
    is_use boolean NOT NULL DEFAULT true,
	creator_id varchar(16) NOT NULL DEFAULT 'SYSTEM',
	created_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	modifier_id varchar(16) NOT NULL DEFAULT 'SYSTEM',
	modified_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,

	CONSTRAINT pk_tb_code PRIMARY KEY (grp_cd, cd)
);
COMMENT ON TABLE public.tb_code IS '코드';

COMMENT ON COLUMN public.tb_code.grp_cd IS '그룹 코드';
COMMENT ON COLUMN public.tb_code.cd IS '코드';
COMMENT ON COLUMN public.tb_code.cd_nm IS '코드 명';
COMMENT ON COLUMN public.tb_code.cd_desc IS '코드 설명';

COMMENT ON COLUMN public.tb_code.is_use IS '사용 여부';
COMMENT ON COLUMN public.tb_code.creator_id IS '생성자 아이디';
COMMENT ON COLUMN public.tb_code.created_at IS '생성 일시';
COMMENT ON COLUMN public.tb_code.modifier_id IS '수정자 아이디';
COMMENT ON COLUMN public.tb_code.modified_at IS '수정 일시';

--
--  TABLE tb_holyday
-- 

CREATE TABLE IF NOT EXISTS public.tb_holyday (
	locdate varchar(8) NOT NULL,
	date_name varchar(128) NOT NULL,
	date_kind_cd varchar(2) NOT NULL,
    is_holyday boolean NOT NULL DEFAULT true,

	is_use boolean NOT NULL DEFAULT true,
	creator_id varchar(16) NOT NULL DEFAULT 'SYSTEM',
	created_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	modifier_id varchar(16) NOT NULL DEFAULT 'SYSTEM',
	modified_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,

	CONSTRAINT pk_tb_holyday PRIMARY KEY (locdate)
);
COMMENT ON TABLE public.tb_holyday IS '휴일';

COMMENT ON COLUMN public.tb_holyday.locdate IS '날짜';
COMMENT ON COLUMN public.tb_holyday.locdate IS '날짜 명칭';
COMMENT ON COLUMN public.tb_holyday.locdate IS '날짜 종류 코드';
COMMENT ON COLUMN public.tb_holyday.locdate IS '공공기관 휴일여부';

COMMENT ON COLUMN public.tb_holyday.is_use IS '사용 여부';
COMMENT ON COLUMN public.tb_holyday.creator_id IS '생성자 아이디';
COMMENT ON COLUMN public.tb_holyday.created_at IS '생성 일시';
COMMENT ON COLUMN public.tb_holyday.modifier_id IS '수정자 아이디';
COMMENT ON COLUMN public.tb_holyday.modified_at IS '수정 일시';

--
--  TABLE tb_todo_assign
-- 

CREATE TABLE IF NOT EXISTS public.tb_todo_assign (
	todo_id bigint NOT NULL,
    account_id varchar(16) NOT NULL,
	done_yn char(1) NOT NULL DEFAULT 'N',
    done_date date NOT NULL DEFAULT 'infinity',

    is_use boolean NOT NULL DEFAULT true,
	creator_id varchar(16) NOT NULL DEFAULT 'SYSTEM',
	created_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	modifier_id varchar(16) NOT NULL DEFAULT 'SYSTEM',
	modified_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,

	CONSTRAINT pk_tb_todo_assign PRIMARY KEY (todo_id, account_id)
);
COMMENT ON TABLE public.tb_todo_assign IS '할 일 할당';

COMMENT ON COLUMN public.tb_todo_assign.todo_id IS 'TODO 아이디';
COMMENT ON COLUMN public.tb_todo_assign.account_id IS '할당 계정 아이디';
COMMENT ON COLUMN public.tb_todo_assign.done_yn IS '완료 여부';
COMMENT ON COLUMN public.tb_todo_assign.done_date IS '완료 일자';

COMMENT ON COLUMN public.tb_todo_assign.is_use IS '사용 여부';
COMMENT ON COLUMN public.tb_todo_assign.creator_id IS '생성자 아이디';
COMMENT ON COLUMN public.tb_todo_assign.created_at IS '생성 일시';
COMMENT ON COLUMN public.tb_todo_assign.modifier_id IS '수정자 아이디';
COMMENT ON COLUMN public.tb_todo_assign.modified_at IS '수정 일시';

--
--  TABLE tb_todo_memo
-- 

CREATE TABLE IF NOT EXISTS public.tb_todo_memo (
	todo_id bigint NOT NULL,
    seq smallint NOT NULL,
	memo varchar(2048) NOT NULL,
	
    is_use boolean NOT NULL DEFAULT true,
	creator_id varchar(16) NOT NULL DEFAULT 'SYSTEM',
	created_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	modifier_id varchar(16) NOT NULL DEFAULT 'SYSTEM',
	modified_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,

	CONSTRAINT pk_tb_todo_memo PRIMARY KEY (todo_id, seq)
);
COMMENT ON TABLE public.tb_todo_memo IS '할 일 메모';

COMMENT ON COLUMN public.tb_todo_memo.todo_id IS 'TODO 아이디';
COMMENT ON COLUMN public.tb_todo_memo.seq IS '일련번호'; -- coalesce((select max(todo_id) from tb_todo_memo), 0) + 1
COMMENT ON COLUMN public.tb_todo_memo.memo IS '메모';

COMMENT ON COLUMN public.tb_todo_memo.is_use IS '사용 여부';
COMMENT ON COLUMN public.tb_todo_memo.creator_id IS '생성자 아이디';
COMMENT ON COLUMN public.tb_todo_memo.created_at IS '생성 일시';
COMMENT ON COLUMN public.tb_todo_memo.modifier_id IS '수정자 아이디';
COMMENT ON COLUMN public.tb_todo_memo.modified_at IS '수정 일시';

--
--  TABLE tb_todo
-- 

CREATE TABLE IF NOT EXISTS public.tb_todo (
	id bigint NOT NULL DEFAULT nextval('seq_tb_todo_id'::regclass),
	assigned_yn char(1) NOT NULL DEFAULT 'N',
	cont varchar(2048) NOT NULL,
    level_cd varchar(32) NOT NULL DEFAULT 'MIDDLE',
    start_date date NOT NULL DEFAULT CURRENT_DATE,
    end_date date NOT NULL DEFAULT CURRENT_DATE,
	
    is_use boolean NOT NULL DEFAULT true,
	creator_id varchar(16) NOT NULL DEFAULT 'SYSTEM',
	created_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	modifier_id varchar(16) NOT NULL DEFAULT 'SYSTEM',
	modified_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,

	CONSTRAINT pk_tb_todo PRIMARY KEY (id)
);
COMMENT ON TABLE public.tb_todo IS '할 일';

COMMENT ON COLUMN public.tb_todo.id IS '아이디';
COMMENT ON COLUMN public.tb_todo.assigned_yn IS '할당 여부';
COMMENT ON COLUMN public.tb_todo.cont IS '내용';
COMMENT ON COLUMN public.tb_todo.level_cd IS '등급 코드';
COMMENT ON COLUMN public.tb_todo.start_date IS '시작 일';
COMMENT ON COLUMN public.tb_todo.end_date IS '종료 일';

COMMENT ON COLUMN public.tb_todo.is_use IS '사용 여부';
COMMENT ON COLUMN public.tb_todo.creator_id IS '생성자 아이디';
COMMENT ON COLUMN public.tb_todo.created_at IS '생성 일시';
COMMENT ON COLUMN public.tb_todo.modifier_id IS '수정자 아이디';
COMMENT ON COLUMN public.tb_todo.modified_at IS '수정 일시';

--
--  TABLE tb_user
-- 

CREATE TABLE IF NOT EXISTS public.tb_user (
	user_id varchar(16) NOT NULL,
	user_nm varchar(32) NOT NULL,
    user_pw varchar(64) NOT NULL, -- SHA256, 단방향 확인
	user_email varchar(64) NOT NULL,
	role_grp_cd varchar(32) NOT NULL default 'ROLE_GRP_CD_USER',

    is_use boolean NOT NULL DEFAULT true,
	creator_id varchar(16) NOT NULL DEFAULT 'SYSTEM',
	created_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	modifier_id varchar(16) NOT NULL DEFAULT 'SYSTEM',
	modified_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,

	CONSTRAINT pk_tb_user PRIMARY KEY (user_id)
);
COMMENT ON TABLE public.tb_user IS '사용자';

COMMENT ON COLUMN public.tb_user.user_id IS '사용자 아이디';
COMMENT ON COLUMN public.tb_user.user_nm IS '사용자 이름';
COMMENT ON COLUMN public.tb_user.user_pw IS '사용자 암호';
COMMENT ON COLUMN public.tb_user.user_email IS '사용자 이메일';
COMMENT ON COLUMN public.tb_user.role_grp_cd IS '롤 그룹 코드';

COMMENT ON COLUMN public.tb_user.is_use IS '사용 여부';
COMMENT ON COLUMN public.tb_user.creator_id IS '생성자 아이디';
COMMENT ON COLUMN public.tb_user.created_at IS '생성 일시';
COMMENT ON COLUMN public.tb_user.modifier_id IS '수정자 아이디';
COMMENT ON COLUMN public.tb_user.modified_at IS '수정 일시';

--
--  INSERT tb_code_grp
-- 

insert into tb_code_grp (grp_cd, grp_cd_nm, grp_cd_desc) values ('DATE_KIND_CD', '날짜종류', '날짜종류');
insert into tb_code_grp (grp_cd, grp_cd_nm, grp_cd_desc) values ('ROLE_CD', '권한코드', '권한코드');
insert into tb_code_grp (grp_cd, grp_cd_nm, grp_cd_desc) values ('LEVEL_CD', '등급코드', '등급코드');
insert into tb_code_grp (grp_cd, grp_cd_nm, grp_cd_desc) values ('ROLE_GRP_CD_USER', '롤사용자그룹코드', '롤그룹코드-롤사용자그룹코드');
insert into tb_code_grp (grp_cd, grp_cd_nm, grp_cd_desc) values ('ROLE_GRP_CD_LEADER', '롤리더그룹코드', '롤그룹코드-롤리더그룹코드');
insert into tb_code_grp (grp_cd, grp_cd_nm, grp_cd_desc) values ('ROLE_GRP_CD_SUPERVISOR', '롤관리자그룹코드', '롤그룹코드-롤관리자그룹코드');

--
--  INSERT tb_code
-- 

insert into tb_code (grp_cd, cd, cd_nm, cd_desc) values ('ROLE_CD', 'INPUT', '입력', '롤-입력');
insert into tb_code (grp_cd, cd, cd_nm, cd_desc) values ('ROLE_CD', 'VIEW', '조회', '롤-조회');
insert into tb_code (grp_cd, cd, cd_nm, cd_desc) values ('ROLE_CD', 'ASSIGN', '배분', '롤-배분');

insert into tb_code (grp_cd, cd, cd_nm, cd_desc) values ('LEVEL_CD', 'HIGH', '높음', '등급-높음');
insert into tb_code (grp_cd, cd, cd_nm, cd_desc) values ('LEVEL_CD', 'MIDDLE', '중간', '등급-중간');
insert into tb_code (grp_cd, cd, cd_nm, cd_desc) values ('LEVEL_CD', 'LOW', '낮음', '등급-낮음');

insert into tb_code (grp_cd, cd, cd_nm, cd_desc) values ('ROLE_GRP_CD_USER', 'INPUT', '입력', '롤사용자그룹코드-입력');

insert into tb_code (grp_cd, cd, cd_nm, cd_desc) values ('ROLE_GRP_CD_LEADER', 'INPUT', '입력', '롤리더그룹코드-입력');
insert into tb_code (grp_cd, cd, cd_nm, cd_desc) values ('ROLE_GRP_CD_LEADER', 'VIEW', '조회', '롤리더그룹코드-조회');
insert into tb_code (grp_cd, cd, cd_nm, cd_desc) values ('ROLE_GRP_CD_LEADER', 'ASSIGN', '배분', '롤리더그룹코드-배분');

insert into tb_code (grp_cd, cd, cd_nm, cd_desc) values ('ROLE_GRP_CD_SUPERVISOR', 'VIEW', '조회', '롤관리자그룹코드-조회');

insert into tb_code (grp_cd, cd, cd_nm, cd_desc) values ('DATE_KIND_CD', '01', '국경일', '휴일종류-국경일');
insert into tb_code (grp_cd, cd, cd_nm, cd_desc) values ('DATE_KIND_CD', '02', '기념일', '휴일종류-기념일');
insert into tb_code (grp_cd, cd, cd_nm, cd_desc) values ('DATE_KIND_CD', '03', '24절기', '휴일종류-24절기');
insert into tb_code (grp_cd, cd, cd_nm, cd_desc) values ('DATE_KIND_CD', '04', '잡절', '휴일종류-잡절');
