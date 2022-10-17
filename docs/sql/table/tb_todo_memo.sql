-- public.todo_memo definition

-- Drop table

-- DROP TABLE public.todo_memo;

CREATE TABLE public.todo_memo (
	todo_id bigint NOT NULL,
    seq smallint NOT NULL,
	memo varchar(2048) NOT NULL,
	
    is_use boolean NOT NULL DEFAULT true,
	creator_id varchar(16) NOT NULL DEFAULT 'SYSTEM',
	created_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	modifier_id varchar(16) NOT NULL DEFAULT 'SYSTEM',
	modified_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,

	CONSTRAINT todo_memo_pk PRIMARY KEY (todo_id, seq)
);
COMMENT ON TABLE public.todo_memo IS '할 일 메모';

-- Column comments

COMMENT ON COLUMN public.todo_memo.todo_id IS 'TODO 아이디';
COMMENT ON COLUMN public.todo_memo.seq IS '일련번호'; -- coalesce((select max(todo_id) from todo_memo), 0) + 1
COMMENT ON COLUMN public.todo_memo.memo IS '메모';

COMMENT ON COLUMN public.todo_memo.is_use IS '사용 여부';
COMMENT ON COLUMN public.todo_memo.creator_id IS '생성자 아이디';
COMMENT ON COLUMN public.todo_memo.created_at IS '생성 일시';
COMMENT ON COLUMN public.todo_memo.modifier_id IS '수정자 아이디';
COMMENT ON COLUMN public.todo_memo.modified_at IS '수정 일시';
