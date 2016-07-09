using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using TCS.Model;

namespace TCS.Web.handler
{
    /// <summary>
    /// UserOperate 的摘要说明
    /// </summary>
    public class UserOperate : IHttpHandler
    {

        BLL.T_UserInfoService _UserInfoService = new BLL.T_UserInfoService();
        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";

            var uid = context.Request["uid"].ToInt32(0);
            string act = context.Request["action"].ToString();
            if (act == "del")
            {

                if (uid == 0)
                {
                    context.Response.Write("false");
                    //context.Response.End();
                }
                else
                {
                    T_UserInfo user = new T_UserInfo();

                    user = _UserInfoService.QuerySingle(uid);
                    user.u_status = 3;
                    if (_UserInfoService.Update(user) > 0)
                    {

                        context.Response.Write("true");
                        //context.Response.End();
                    }
                    else
                    {
                        context.Response.Write("false");
                        //context.Response.End();
                    }
                }

            }
            else if (act == "restore")
            {

                if (uid == 0)
                {
                    context.Response.Write("false");
                    //context.Response.End();
                }
                else
                {
                    T_UserInfo user = new T_UserInfo();

                    user = _UserInfoService.QuerySingle(uid);
                    user.u_status = 1;
                    if (_UserInfoService.Update(user) > 0)
                    {

                        context.Response.Write("true");
                        //context.Response.End();
                    }
                    else
                    {
                        context.Response.Write("false");
                        //context.Response.End();
                    }
                }

            }
            else if (act == "open")
            {

                if (uid == 0)
                {
                    context.Response.Write("false");
                    //context.Response.End();
                }
                else
                {
                    T_UserInfo user = new T_UserInfo();

                    user = _UserInfoService.QuerySingle(uid);
                    user.u_status = 1;
                    if (_UserInfoService.Update(user) > 0)
                    {

                        context.Response.Write("true");
                        //context.Response.End();
                    }
                    else
                    {
                        context.Response.Write("false");
                        // context.Response.End();
                    }
                }

            }
            else if (act == "close")
            {

                if (uid == 0)
                {
                    context.Response.Write("false");
                    //context.Response.End();
                }
                else
                {
                    T_UserInfo user = new T_UserInfo();

                    user = _UserInfoService.QuerySingle(uid);
                    user.u_status = 2;
                    if (_UserInfoService.Update(user) > 0)
                    {

                        context.Response.Write("true");
                        //context.Response.End();
                    }
                    else
                    {
                        context.Response.Write("false");
                        // context.Response.End();
                    }
                }

            }
            else
            {

                context.Response.Write("false");
                //context.Response.End();
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