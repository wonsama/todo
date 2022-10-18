-- public.tb_code_grp definition

-- Drop table

-- DROP TABLE public.tb_code_grp;

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

-- Column comments

COMMENT ON COLUMN public.tb_code_grp.grp_cd IS '그룹 코드';
COMMENT ON COLUMN public.tb_code_grp.grp_cd_nm IS '그룹 코드 명';
COMMENT ON COLUMN public.tb_code_grp.grp_cd_desc IS '그룹 코드 설명';

COMMENT ON COLUMN public.tb_code_grp.is_use IS '사용 여부';
COMMENT ON COLUMN public.tb_code_grp.creator_id IS '생성자 아이디';
COMMENT ON COLUMN public.tb_code_grp.created_at IS '생성 일시';
COMMENT ON COLUMN public.tb_code_grp.modifier_id IS '수정자 아이디';
COMMENT ON COLUMN public.tb_code_grp.modified_at IS '수정 일시';
