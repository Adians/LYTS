using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TCS.Model;
using TCS.Web.PageBase;

namespace TCS.Web.admin
{
    public partial class tousu_list : AdminAuthBasePage
    {
        BLL.T_ComplaintFormService _ComplaintFormService = new BLL.T_ComplaintFormService();
        public int msg { get; set; }
        public int totalcount { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            msg = 0;
            var uid = 0;
            totalcount = _ComplaintFormService.QueryCount(null);
            if (HttpContext.Current.Session["current_admin"] != null)
            {
                var currentAdmin = HttpContext.Current.Session["current_admin"] as T_UserInfo;
                uid = currentAdmin.u_id;
            }
            if (Request.IsPostBack())
            {
                string rec = Request["rec"].ToString();
                if (rec == "tousureply")
                {

                    int rcid = Request["tid"].ToInt32(0);
                    string rcontent = Request["tousureplycontent"].ToString();
                    if (rcid == 0 || uid == 0 || string.IsNullOrEmpty(rcontent))
                    {
                        msg = -1;
                        return;

                    }
                    T_ComplaintForm tousuform = new T_ComplaintForm();
                    tousuform = _ComplaintFormService.QuerySingle(rcid);
                    tousuform.c_status = 4;
                    tousuform.c_responderId = uid;
                    tousuform.c_responseTime = DateTime.Now;
                    tousuform.c_responseContent = rcontent;
                    if (_ComplaintFormService.Update(tousuform) > 0)
                    {
                        msg = 1;
                    }
                    else
                    {
                        msg = -1;
                        return;
                    }
                }

                if (rec == "tousuremark")
                {
                    int rcid = Request["rcid"].ToInt32(0);
                    string rcontent = Request["tousuremarktext"].ToString();
                    if (rcid == 0 || uid == 0 || string.IsNullOrEmpty(rcontent))
                    {
                        msg = -2;
                        return;

                    }
                    T_ComplaintForm tousuform = new T_ComplaintForm();
                    tousuform = _ComplaintFormService.QuerySingle(rcid);
                    tousuform.c_status = 5;
                    tousuform.c_inspectorId = uid;
                    tousuform.c_inspectResult = "不通过";
                    tousuform.c_inspectTime = DateTime.Now;
                    tousuform.c_inspectRemark = rcontent;
                    if (_ComplaintFormService.Update(tousuform) > 0)
                    {
                        msg = 2;
                    }
                    else
                    {
                        msg = -2;
                        return;
                    }


                }

            }
        }
    }
}