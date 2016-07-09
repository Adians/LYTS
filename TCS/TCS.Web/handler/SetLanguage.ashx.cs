using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.SessionState;
using TCS.Common;

namespace TCS.Web.handler
{
    /// <summary>
    /// SetLanguage 的摘要说明
    /// </summary>
    public class SetLanguage : IHttpHandler, IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            if (context.Request["language"] != null)
            {
                CookieHelper.Set("language", context.Request["language"], DateTime.Now.AddDays(7));
                context.Session["language"] = context.Request["language"];
                context.Response.Write("ok");
            }
            else {
                context.Response.Write("false");
            }
            
           
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}