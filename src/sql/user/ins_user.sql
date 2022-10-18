-- file : user/ins_user.sql
-- title :사용자 정보를 등록한다 
-- desc : -
-- tables : tb_user (사용자)
-- since : 2022.10.18
insert into tb_user (user_id, user_nm, user_pw, user_email, role_grp_cd) values ('$1', '$2', '$3', '$4', '$5');
