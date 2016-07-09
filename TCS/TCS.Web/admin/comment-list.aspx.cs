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
    public partial class comment_list : AdminAuthBasePage
    {
        BLL.T_ComplaintDiscussService _ComplaintDiscussService = new BLL.T_ComplaintDiscussService();
        public IEnumerable<T_ComplaintDiscuss> ComplaintDiscussList { get; set; }
        protected BLL.T_UserInfoService _UserInfoService = new BLL.T_UserInfoService();
        public int count { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            count = _ComplaintDiscussService.QueryCount(null);
            ComplaintDiscussList = _ComplaintDiscussService.QueryList(1,count,null,"cd_id",false);
        }
    }
}