-- public.tb_holyday definition

-- Drop table

-- DROP TABLE public.tb_holyday;

CREATE TABLE public.tb_holyday (
	locdate varchar(8) NOT NULL,
	date_name varchar(128) NOT NULL,
	date_kind_cd varchar(2) NOT NULL,
    is_holyday boolean NOT NULL DEFAULT true,

	is_use boolean NOT NULL DEFAULT true,
	creator_id varchar(16) NOT NULL DEFAULT 'SYSTEM',
	created_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	modifier_id varchar(16) NOT NULL DEFAULT 'SYSTEM',
	modified_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,

	CONSTRAINT tb_holyday_pk PRIMARY KEY (locdate)
);
COMMENT ON TABLE public.tb_holyday IS '휴일';

-- Column comments

COMMENT ON COLUMN public.tb_holyday.locdate IS '날짜';
COMMENT ON COLUMN public.tb_holyday.locdate IS '날짜 명칭';
COMMENT ON COLUMN public.tb_holyday.locdate IS '날짜 종류 코드';
COMMENT ON COLUMN public.tb_holyday.locdate IS '공공기관 휴일여부';

COMMENT ON COLUMN public.tb_holyday.is_use IS '사용 여부';
COMMENT ON COLUMN public.tb_holyday.creator_id IS '생성자 아이디';
COMMENT ON COLUMN public.tb_holyday.created_at IS '생성 일시';
COMMENT ON COLUMN public.tb_holyday.modifier_id IS '수정자 아이디';
COMMENT ON COLUMN public.tb_holyday.modified_at IS '수정 일시';
