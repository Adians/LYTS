using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using TCS.Model;

namespace TCS.Web.PageBase
{
    public class AuthBasePage: PageBase
    {
        protected T_UserInfo CurrentUser;
        protected override void OnLoad(EventArgs e)
        {
            if (Session["current_user"] == null)
            {
                // Session中没有用户信息
                Response.Redirect("/login.aspx?redirect=" + HttpUtility.UrlEncode(Request.Url.ToString()));
            }
            CurrentUser = Session["current_user"] as T_UserInfo;
            base.OnLoad(e);
        }
    }
}