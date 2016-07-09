using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TCS.Web.PageBase;

namespace TCS.Web.admin
{
    public partial class member_list : AdminAuthBasePage
    {
        BLL.T_UserInfoService _UserInfoService = new BLL.T_UserInfoService();
        public int totalcount { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            totalcount =_UserInfoService.QueryCount(new { u_roleId=1 });
        }
    }
}