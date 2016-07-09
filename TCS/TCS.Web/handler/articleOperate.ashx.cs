using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.SessionState;
using TCS.Model;

namespace TCS.Web.handler
{
    /// <summary>
    /// articleOperate 的摘要说明
    /// </summary>
    public class articleOperate : IHttpHandler, IRequiresSessionState
    {

        BLL.T_ArticleService _ArticleService = new BLL.T_ArticleService();
        public void ProcessRequest(HttpContext context)
        {
            var aid = context.Request["aid"].ToInt32(0);
            string act = context.Request["action"].ToString();
            var uid = 0;
            var currentAdmin = (T_UserInfo)null;
            if (HttpContext.Current.Session["current_admin"] != null)
            {
                currentAdmin = HttpContext.Current.Session["current_admin"] as T_UserInfo;
                uid = currentAdmin.u_id;
            }

            if (uid == 0)
            {
                context.Response.Write("false");
            }
            else
            {
                if (act == "del" && currentAdmin.u_roleId == 4)
                {
                   
                        if (_ArticleService.Delete(aid) > 0)
                        {
                            context.Response.Write("true");
                        }
                        else
                        {
                            context.Response.Write("false");
                        }
                    }
               
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