using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using TCS.BLL;

namespace TCS.Web.handler
{
    /// <summary>
    /// RolesOperate 的摘要说明
    /// </summary>
    public class RolesOperate : IHttpHandler
    {
        BLL.T_RolesService _RolesService = new T_RolesService();
        BLL.T_UserInfoService _UserInfoService = new T_UserInfoService();
        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";

            int rid = context.Request["rid"].ToInt32(0);
            if (rid > 0)
            {
                if (_UserInfoService.QueryCount(new { u_roleId = rid }) == 0)
                {
                    int res = _RolesService.Delete(rid);
                    if (res > 0)
                    {
                        context.Response.Write("ok");
                    }
                    else
                    {
                        context.Response.Write("false");
                    }
                }
                else
                {
                    context.Response.Write("false");
                }

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