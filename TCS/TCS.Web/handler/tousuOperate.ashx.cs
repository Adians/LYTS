using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.SessionState;
using TCS.Model;

namespace TCS.Web.handler
{
    /// <summary>
    /// tousuOperate 的摘要说明
    /// </summary>
    public class tousuOperate : IHttpHandler, IRequiresSessionState
    {
        BLL.T_ComplaintFormService _ComplaintFormService = new BLL.T_ComplaintFormService();
        BLL.T_ComplaintDiscussService _ComplaintDiscussService = new BLL.T_ComplaintDiscussService();
        public void ProcessRequest(HttpContext context)
        {
            var cid = context.Request["cid"].ToInt32(0);
            string act = context.Request["action"].ToString();
            var uid = 0;
            var currentAdmin =(T_UserInfo)null ;
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
                T_ComplaintForm tousuform = new T_ComplaintForm();
                if (act == "shpass")
                {

                    if (cid == 0)
                    {
                        context.Response.Write("false");
                        //context.Response.End();
                    }
                    else
                    {

                        tousuform = _ComplaintFormService.QuerySingle(cid);
                        tousuform.c_status = 2;
                        tousuform.c_inspectorId = uid;
                        tousuform.c_inspectResult = "通过";
                        tousuform.c_inspectTime = DateTime.Now;
                        if (_ComplaintFormService.Update(tousuform) > 0)
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
                
                else if (act == "shenqing")
                {

                    if (cid == 0)
                    {
                        context.Response.Write("false");
                        //context.Response.End();
                    }
                    else
                    {

                        tousuform = _ComplaintFormService.QuerySingle(cid);
                        tousuform.c_status = 6;
                        if (_ComplaintFormService.Update(tousuform) > 0)
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
                else if (act == "del"&& currentAdmin.u_roleId==4)
                {
                    if (_ComplaintDiscussService.QueryCount(new { cd_cid = cid }) > 0)
                    {
                        context.Response.Write("false");

                    }
                    else {
                        if (_ComplaintFormService.Delete(cid) > 0)
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
                else
                {

                    context.Response.Write("false");
                    //context.Response.End();
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