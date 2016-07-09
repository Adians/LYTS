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
    public partial class system_log : AdminAuthBasePage
    {
        BLL.T_LogOperationService _LogOperationService = new BLL.T_LogOperationService();
        protected BLL.T_OperationTypeService _OperationTypeService = new BLL.T_OperationTypeService();
        protected BLL.T_UserInfoService _UserInfoService = new BLL.T_UserInfoService();

        public IEnumerable<T_LogOperation> LogOperationList { get; set; }
        public int count { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            count = _LogOperationService.QueryCount(null);
            LogOperationList = _LogOperationService.QueryList(1,count,null,"lo_id");
        }
    }
}