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
    public partial class feedback_list : AdminAuthBasePage
    {
        BLL.T_FeedBackService _FeedBackService = new BLL.T_FeedBackService();
        protected BLL.T_UserInfoService _UserInfoService = new BLL.T_UserInfoService();
        public IEnumerable<T_FeedBack> FeedBackList { get; set; }
        public int count { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            count = _FeedBackService.QueryCount(null);
            FeedBackList = _FeedBackService.QueryList(1,count,null, "f_id");
        }
    }
}