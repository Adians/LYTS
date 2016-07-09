using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using TCS.Model;

namespace TCS.Web.PageBase
{
    public class AdminAuthBasePage : Page
    {
        protected T_UserInfo CurrentUser;
        protected override void OnLoad(EventArgs e)
        {
            if (Session["current_admin"] == null)
            {
                // Session中没有用户信息
                Response.Redirect("/admin/login.aspx");
            }
            CurrentUser = Session["current_admin"] as T_UserInfo;
            base.OnLoad(e);
        }
    }
}