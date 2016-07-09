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
    public partial class member_show : AdminAuthBasePage
    {
        BLL.T_UserInfoService _UserInfoService = new BLL.T_UserInfoService();
        protected BLL.T_RolesService _RolesService = new BLL.T_RolesService();
        public T_UserInfo userInfo { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            userInfo = null;
            int uid =Request["uid"].ToInt32(0);
            if (uid>0) {

                userInfo = _UserInfoService.QuerySingle(uid);
            }
        }
    }
}