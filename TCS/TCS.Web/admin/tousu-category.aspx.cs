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
    public partial class tousu_category : AdminAuthBasePage
    {
        BLL.T_ComplaintTypeService _ComplaintTypeService = new BLL.T_ComplaintTypeService();

        protected BLL.T_UserInfoService _UserInfoService = new BLL.T_UserInfoService();
        public IEnumerable<T_ComplaintType> ComplaintTypeList { get; set; }

        public int totalcount { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            totalcount = _ComplaintTypeService.QueryCount(null);
            ComplaintTypeList = _ComplaintTypeService.QueryList(1,totalcount,null, "ct_id", false);
            
        }
    }
}