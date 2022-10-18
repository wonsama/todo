-- public.tb_user definition

-- Drop table

-- DROP TABLE public.tb_user;

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

-- Column comments

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
