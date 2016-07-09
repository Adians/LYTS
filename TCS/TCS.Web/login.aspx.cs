using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TCS.Common;
using TCS.Model.Enums;

namespace TCS.Web
{
    public partial class login : TCS.Web.PageBase.PageBase
    {
        public string Username { get; set; }
        public string Password { get; set; }
        public string Message { get; set; }
        public string role { get; set; }

        private BLL.T_UserInfoService _userService = new BLL.T_UserInfoService();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.IsPostBack())
            {
                Login();
            }
        }

        private void Login()
        {
            // 接收参数
            Username = Request["userName"];
            Password = Request["Password"];
            var vcode = Request["viCode"];
            var isRemember = Request["checked"] != null;
            string redirect = Request["redirect"];
            role = "user";
            redirect = string.IsNullOrEmpty(redirect) ? "/" : redirect;

            // 参数校验
            if (string.IsNullOrEmpty(Username) || string.IsNullOrEmpty(Password))
            {
                Message = "用户名或密码为空！";
                return;
            }

            // 校验验证码
            var session = Session["user_vcode"];
            if (session == null || vcode != session.ToString())
            {
                Message = "验证码错误！";
                return;
            }

            Model.T_UserInfo user;
            LoginResult res = _userService.Login(Username, Password,role, out user);
            switch (res)
            {
                case LoginResult.用户名不存在:
                case LoginResult.密码错误:
                    Message = "用户名或密码错误！";
                    return;
                case LoginResult.用户已被冻结:
                    Message = "用户状态异常！";
                    return;
                case LoginResult.登录成功:
                    // 将当前用户实体放到Session中
                    Session["current_user"] = user;

                    if (isRemember)
                    {
                        //处理记住我
                       //HttpCookie c1 = new HttpCookie("yh");
                       // c1.Value = Username;
                       // HttpCookie c2 = new HttpCookie("yhmm");
                       // c2.Value = user.u_password;
                       // Response.Cookies.Add(c1);
                       // Response.Cookies.Add(c2);
                        CookieHelper.Set("ysb", Username, DateTime.Now.AddDays(7));
                        CookieHelper.Set("yssb", user.u_password, DateTime.Now.AddDays(7));
                    }

                    // 跳转到注册之前的页面
                    Response.Redirect(redirect);
                    break;
            }
        }
    }
}