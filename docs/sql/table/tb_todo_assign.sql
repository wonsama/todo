-- public.tb_todo_assign definition

-- Drop table

-- DROP TABLE public.tb_todo_assign;

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

-- Column comments

COMMENT ON COLUMN public.tb_todo_assign.todo_id IS 'TODO 아이디';
COMMENT ON COLUMN public.tb_todo_assign.account_id IS '할당 계정 아이디';
COMMENT ON COLUMN public.tb_todo_assign.done_yn IS '완료 여부';
COMMENT ON COLUMN public.tb_todo_assign.done_date IS '완료 일자';

COMMENT ON COLUMN public.tb_todo_assign.is_use IS '사용 여부';
COMMENT ON COLUMN public.tb_todo_assign.creator_id IS '생성자 아이디';
COMMENT ON COLUMN public.tb_todo_assign.created_at IS '생성 일시';
COMMENT ON COLUMN public.tb_todo_assign.modifier_id IS '수정자 아이디';
COMMENT ON COLUMN public.tb_todo_assign.modified_at IS '수정 일시';
