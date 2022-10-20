-- file : user/sel_one_user.sql
-- title :사용자 존재 여부 검사
-- desc : -
-- tables : tb_user (사용자)
-- since : 2022.10.18
SELECT 
    user_id, 
    user_nm,
    user_pw,
    user_email,
    role_grp_cd
FROM 
    tb_user 
where 1=1
    and user_id ='$1' 
    and is_use = true