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
    public partial class change_password : AdminAuthBasePage
    {
        BLL.T_UserInfoService _userInfoService = new BLL.T_UserInfoService();


        public int msg { get;  set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.IsPostBack()) {
            string password = Request["new-password"].ToString();
            string cpassword = Request["new-password"].ToString();
            int id = Request["epUserId"].ToInt32(0);
            if (string.IsNullOrEmpty(password)||string.IsNullOrEmpty(cpassword)) {
                msg = 2;
                return;
            }
            if (password != cpassword || id==0)
            {
                msg = -1;
            }
            else {
                T_UserInfo user = new T_UserInfo();
                user = _userInfoService.QuerySingle(id);
                user.u_password = password.Md5();
                var res = _userInfoService.Update(user);
                if (res > 0)
                {
                    msg = 1;
                }
                else {
                    msg = -1;
                }
               
            }


            }

        }
    }
}