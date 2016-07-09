using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TCS.Web.handler
{
    /// <summary>
    /// UserExistCheck 的摘要说明
    /// </summary>
    public class UserExistCheck : IHttpHandler
    {
        BLL.T_UserInfoService _UserInfoService = new BLL.T_UserInfoService();

        public void ProcessRequest(HttpContext context)
        {
            string userName = context.Request["username"].ToString();
            context.Response.ContentType = "text/plain";
            if (_UserInfoService.QuerySingle(new { u_loginName = userName }) != null)
            {

                context.Response.Write("0");

            }
            else {
                context.Response.Write("1");

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