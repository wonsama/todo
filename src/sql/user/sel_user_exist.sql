-- file : user/sel_user_exist.sql
-- title :사용자 존재 여부 검사
-- desc : -
-- tables : tb_user (사용자)
-- since : 2022.10.18
SELECT user_id FROM tb_user where user_id ='$1'