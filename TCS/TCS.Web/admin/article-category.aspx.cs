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
    public partial class article_category : AdminAuthBasePage
    {
        BLL.T_ArticleTypeService _ArticleTypeService = new BLL.T_ArticleTypeService();

        protected BLL.T_UserInfoService _UserInfoService = new BLL.T_UserInfoService();
        public IEnumerable<T_ArticleType> ArticleTypeList { get; set; }

        public int totalcount { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            totalcount = _ArticleTypeService.QueryCount(null);
            ArticleTypeList = _ArticleTypeService.QueryList(1, totalcount, null, "at_id", false);

        }
    }
}