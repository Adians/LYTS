using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using TCS.Model;
using TCS.Model.Enums;

namespace TCS.BLL
{
    partial class T_UserInfoService
    {
        public RegisterResult Register(string username, string password, out T_UserInfo user)
        {
            // 1.检验用户名的合法性
            var exist = _dao.QueryCount(new { u_loginName = username }) > 0;
            if (exist)
            {
                user = null;
                return RegisterResult.用户名已存在;
            }
            user = new T_UserInfo();
            user.u_loginName = username;
            user.u_password = password.Md5();
            user.u_nickName = username;
            user.u_email = string.Empty;
            user.u_phoneNo = string.Empty;
            user.u_regTime = DateTime.Now;
            user.u_status = 1;
            user.u_sex = string.Empty;
            user.u_roleId = 1;
            user.u_realName = string.Empty;
            user.u_lastLoginTime = DateTime.Now;
            user.u_loginTime = DateTime.Now;
            user.u_pic = "/admin/images/user.png";
            user.u_id = _dao.Insert(user);
            if (user.u_id == 0)
            {
                return RegisterResult.注册失败;
            }
            return RegisterResult.注册成功;
        }

        public LoginResult Login(string username, string password,string role, out T_UserInfo user)
        {
            user = null;
            // 根据用户名检索数据
            var temp = QuerySingle(new { u_loginName = username });

            // 判断有没有查到
            if (temp == null)
            {
                return LoginResult.用户名不存在;
            }

            // 用户存在
            if (temp.u_password != password.Md5()) // 密码加密
            {
                return LoginResult.密码错误;
            }

            if (temp.u_status == 0)
            {
                return LoginResult.用户已被冻结;
            }
            if (role == "user") {
                if (temp.u_roleId != 1) {
                    return LoginResult.用户名不存在;
                }
            }
            if (role == "admin")
            {
                if (temp.u_roleId <= 1)
                {
                    return LoginResult.用户名不存在;
                }

            }

            user = temp;
            user.u_lastLoginTime = user.u_loginTime;
            user.u_loginTime = DateTime.Now;
            _dao.Update(user);
            return LoginResult.登录成功;
        }

        public LoginResult CookieLogin(string username, string password, out T_UserInfo user)
        {
            user = null;
            // 根据用户名检索数据
            var temp = QuerySingle(new { u_loginName = username });

            // 判断有没有查到
            if (temp == null)
            {
                return LoginResult.用户名不存在;
            }

            // 用户存在
            if (temp.u_password != password) // 密码无需加密比对  因为cookie中本来就是加密的
            {
                return LoginResult.密码错误;
            }

            if (temp.u_status == 0)
            {
                return LoginResult.用户已被冻结;
            }

            user = temp;
            return LoginResult.登录成功;
        }
    }
}
