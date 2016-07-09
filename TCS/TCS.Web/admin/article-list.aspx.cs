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
    public partial class article_list : AdminAuthBasePage
    {
        BLL.T_ArticleService _ArticleService = new BLL.T_ArticleService();
        protected BLL.T_UserInfoService _UserInfoService = new BLL.T_UserInfoService();
        protected BLL.T_ArticleTypeService _ArticleTypeService = new BLL.T_ArticleTypeService();
        public IEnumerable<T_Article> ArticleList { get; set; }
        public int count { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            count = _ArticleService.QueryCount(null);
            ArticleList = _ArticleService.QueryList(1, count, null, "a_id", false);
        }
    }
}