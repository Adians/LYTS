using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.SessionState;
using TCS.Model;

namespace TCS.Web.handler
{
    /// <summary>
    /// TousuCategoryOperate 的摘要说明
    /// </summary>
    public class TousuCategoryOperate : IHttpHandler, IRequiresSessionState
    {
        BLL.T_ComplaintTypeService _ComplaintTypeService = new BLL.T_ComplaintTypeService();
        BLL.T_ComplaintFormService _ComplaintFormService = new BLL.T_ComplaintFormService();
        public void ProcessRequest(HttpContext context)
        {
            int role = 1;
            if (HttpContext.Current.Session["current_admin"] != null)
            {
                var currentAdmin = HttpContext.Current.Session["current_admin"] as T_UserInfo;
                role = currentAdmin.u_roleId;
            }
            var tid = context.Request["tid"].ToInt32(0);
            string act = context.Request["action"].ToString();
            if (act == "del")
            {
                if (tid == 0|| _ComplaintFormService.QueryCount(new { c_typeId= tid })>0|| role!=4)
                {
                    context.Response.Write("false");
                    //context.Response.End();
                }
                else
                {
                    //T_ComplaintType complaintType = new T_ComplaintType();

                    //complaintType = _ComplaintTypeService.QuerySingle(tid);
                    
                    if (_ComplaintTypeService.Delete(tid) > 0)
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