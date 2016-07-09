using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TCS.Model;
using TCS.Web.PageBase;

namespace TCS.Web
{
   
    public partial class feedbackbox : TCS.Web.PageBase.PageBase
    {
        BLL.T_FeedBackService _FeedBackService = new BLL.T_FeedBackService();
        public int msg { get; set; }
        public T_UserInfo userInfo { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            msg = 0;
            userInfo = null;
            if (Session["current_user"] == null)
            {
                msg = 1;
            }
            else {
                userInfo = Session["current_user"] as T_UserInfo;
                if (Request.IsPostBack())
                {

                    string feedbackcontent = Request["feedbackcontent"].ToString();
                    T_FeedBack feedback =new  T_FeedBack();
                    feedback.f_uid = userInfo.u_id;
                    feedback.f_createtime = DateTime.Now;
                    feedback.f_content = feedbackcontent;
                    int res = _FeedBackService.Insert(feedback);
                    if (res > 0)
                    {
                        msg = 2;
                    }
                    else {
                        msg = 3;
                    }
                }
            }
            
        }
    }
}