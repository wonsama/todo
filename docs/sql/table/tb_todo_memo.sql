-- public.todo_memo definition

-- Drop table

-- DROP TABLE public.todo_memo;

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

-- Column comments

COMMENT ON COLUMN public.tb_todo_memo.todo_id IS 'TODO 아이디';
COMMENT ON COLUMN public.tb_todo_memo.seq IS '일련번호'; -- coalesce((select max(todo_id) from tb_todo_memo), 0) + 1
COMMENT ON COLUMN public.tb_todo_memo.memo IS '메모';

COMMENT ON COLUMN public.tb_todo_memo.is_use IS '사용 여부';
COMMENT ON COLUMN public.tb_todo_memo.creator_id IS '생성자 아이디';
COMMENT ON COLUMN public.tb_todo_memo.created_at IS '생성 일시';
COMMENT ON COLUMN public.tb_todo_memo.modifier_id IS '수정자 아이디';
COMMENT ON COLUMN public.tb_todo_memo.modified_at IS '수정 일시';
