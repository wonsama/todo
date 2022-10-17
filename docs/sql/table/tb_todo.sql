-- public.tb_todo definition

-- Drop table

-- DROP TABLE public.tb_todo;

CREATE TABLE public.tb_todo (
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

	CONSTRAINT tb_todo_pk PRIMARY KEY (id)
);
COMMENT ON TABLE public.tb_todo IS '할 일';

-- Column comments

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
