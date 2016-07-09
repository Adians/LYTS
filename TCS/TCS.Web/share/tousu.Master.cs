using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TCS.Common;
using TCS.Model;

namespace TCS.Web.share
{
    public partial class tousu : System.Web.UI.MasterPage
    {
        protected string userName;
        protected Model.T_UserInfo CurrentUser;
        protected string language { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            
            /*if (Session["language"] == null)
            {
                language = "zh_cn";
            }
            else
            {
                language = Session["language"].ToString();

            }*/
            language = "zh_cn";
            if (CookieHelper.Get("language") == null)
            {
                language = "zh_cn";
            }
            else
            {
                language = CookieHelper.Get("language").ToString();

            }
           
            if (Session["current_user"] == null)
            {
                userName = string.Empty;
            }
            else
            {
                CurrentUser = Session["current_user"] as T_UserInfo;
                userName = (string.IsNullOrEmpty(CurrentUser.u_nickName)?CurrentUser.u_loginName: CurrentUser.u_nickName);
            }
        }
    }
}