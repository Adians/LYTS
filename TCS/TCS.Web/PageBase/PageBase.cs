using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using TCS.Common;
using TCS.Model;

namespace TCS.Web.PageBase
{
    public class PageBase: Page
    {
        //protected T_UserInfo CurrentUser { get; set; }

        //protected override void OnInit(EventArgs e)
        //{
        //    CurrentUser = Session["current_user"] as T_UserInfo;
        //    base.OnInit(e);
        //}
        //protected void NotFound()
        //{
        //    throw new HttpException(404, "NotFound");
        //}

        protected string language { get; set; }
        protected override void OnLoad(EventArgs e)
        {
            /*if (Session["language"] == null)
            {
                language = "zh_cn";
            }
            else {
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

            base.OnLoad(e);
        }
    }
}