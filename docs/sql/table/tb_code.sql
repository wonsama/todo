-- public.tb_code definition

-- Drop table

-- DROP TABLE public.tb_code;

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

-- Column comments

COMMENT ON COLUMN public.tb_code.grp_cd IS '그룹 코드';
COMMENT ON COLUMN public.tb_code.cd IS '코드';
COMMENT ON COLUMN public.tb_code.cd_nm IS '코드 명';
COMMENT ON COLUMN public.tb_code.cd_desc IS '코드 설명';

COMMENT ON COLUMN public.tb_code.is_use IS '사용 여부';
COMMENT ON COLUMN public.tb_code.creator_id IS '생성자 아이디';
COMMENT ON COLUMN public.tb_code.created_at IS '생성 일시';
COMMENT ON COLUMN public.tb_code.modifier_id IS '수정자 아이디';
COMMENT ON COLUMN public.tb_code.modified_at IS '수정 일시';
