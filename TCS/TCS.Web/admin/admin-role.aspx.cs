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
    public partial class admin_role : AdminAuthBasePage
    {
        BLL.T_RolesService _RolesService = new BLL.T_RolesService();
        protected BLL.T_UserInfoService _UserInfoService = new BLL.T_UserInfoService();
        public IEnumerable<T_Roles> RolesList { get; set; }
        public int count { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            count = _RolesService.QueryCount(null);
            RolesList = _RolesService.QueryList(1,count,null,"r_id",false);
            RolesList =RolesList.Where(r=>r.r_id>1);
            count = RolesList.Count();
        }

    }
}