using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.SessionState;
using TCS.Model;

namespace TCS.Web.handler
{
    /// <summary>
    /// commentOperate 的摘要说明
    /// </summary>
    public class commentOperate : IHttpHandler, IRequiresSessionState
    {
        
        BLL.T_ComplaintDiscussService _ComplaintDiscussService = new BLL.T_ComplaintDiscussService();
        public void ProcessRequest(HttpContext context)
        {
            var cid = context.Request["cid"].ToInt32(0);
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
                    if (_ComplaintDiscussService.QueryCount(new { cd_parentId = cid }) > 0)
                    {
                        context.Response.Write("false");
                    }
                    else
                    {
                        if (_ComplaintDiscussService.Delete(cid) > 0)
                        {
                            context.Response.Write("true");
                        }
                        else
                        {
                            context.Response.Write("false");
                        }

                    }
                }
                else
                {

                    context.Response.Write("false");
                    
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