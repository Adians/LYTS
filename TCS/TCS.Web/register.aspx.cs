using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TCS.BLL;
using TCS.Model.Enums;

namespace TCS.Web
{
    public partial class register : TCS.Web.PageBase.PageBase
    {
        T_UserInfoService _service = new T_UserInfoService();

        protected string Message { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.IsPostBack())
            {
                PostBack();
            }
        }

        private void PostBack()
        {
            string login = Request["userName"];
            string password = Request["password"];
            string confirm = Request["cPassword"];
            string vcode = Request["viCode"];
            bool isChecked = Request["checked"].ToBoolean();
            string redirect = Request["redirect"];
            redirect = string.IsNullOrEmpty(redirect) ? "/" : redirect;
            // 2.参数校验

            if (!isChecked)
            {
                Message = "请同意注册协议";
                return;
            }

            if (string.IsNullOrEmpty(login)
                || string.IsNullOrEmpty(password)
                || confirm != password
                || string.IsNullOrEmpty(vcode))
            {
                Message = "请正确填写表单";
                return;
            }
            // 3.验证码校验
            var session = Session["user_vcode"];
            if (session == null)
            {
                Message = "请输入验证码";
                return;
            }
            var sessionCode = session.ToString();
            if (sessionCode != vcode)
            {
                // 验证码错误
                Message = "验证码错误";
                return;
            }
            Model.T_UserInfo user;
            // 4.调用业务方法
            var res = _service.Register(login, password, out user);
            switch (res)
            {
                case RegisterResult.用户名已存在:
                    Message = "用户名已存在";
                    return;
                case RegisterResult.注册成功:
                    Message = "注册成功";
                    // 跳转到注册之前的页面
                    Response.Redirect(redirect);
                    break;
                case RegisterResult.注册失败:
                    Message = "注册失败";
                    return;
            }
        }
    }
}