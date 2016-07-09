using System;
using System.Collections.Generic;
using System.Linq;
using System.Resources;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TCS.Model;


namespace TCS.Web
{
    public partial class tousulist : TCS.Web.PageBase.PageBase
    {
        public int allCount { get; set; }
        public IEnumerable<T_ComplaintType> CurrentComplaintType { get; set; }
        BLL.T_ComplaintTypeService _ComplaintTypeService = new BLL.T_ComplaintTypeService();
        protected BLL.T_ComplaintFormService _ComplaintFormService = new BLL.T_ComplaintFormService();
        protected void Page_Load(object sender, EventArgs e)
        {
            
            allCount = _ComplaintTypeService.QueryCount(null);
            CurrentComplaintType = _ComplaintTypeService.QueryList(1, allCount, null, "ct_id", false);

        }
    }
}