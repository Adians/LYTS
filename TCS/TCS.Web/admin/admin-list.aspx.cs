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
    public partial class admin_list : AdminAuthBasePage
    {
        BLL.T_UserInfoService _UserInfoService = new BLL.T_UserInfoService();
        protected BLL.T_RolesService _RolesService = new BLL.T_RolesService();
        public IEnumerable<T_UserInfo> AdminUserInfoList { get; set; }

        public int count { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            count = _UserInfoService.QueryCount(null);
            AdminUserInfoList = _UserInfoService.QueryList(1,count,null,"u_id",false);
            AdminUserInfoList = AdminUserInfoList.Where(a=>a.u_roleId>1);
            count = AdminUserInfoList.Count();
        }
    }
}