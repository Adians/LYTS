using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TCS.Model;

namespace TCS.Web
{
    public partial class notice : TCS.Web.PageBase.PageBase
    {
        protected BLL.T_ArticleTypeService _ArticleTypeService = new BLL.T_ArticleTypeService();
        BLL.T_ArticleService _ArticleService = new BLL.T_ArticleService();
        public IEnumerable<T_ArticleType> ArticleTypeList { get;set;}
        public IEnumerable<T_Article> ArticleList { get; set; }
        public int typecount { get; set; }
        public int PageIndex { get; set; }
        public int TotalCount { get; set; }
        public int TotalPages { get; set; }
        public int type { get; set; }
        public int size { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            typecount =  _ArticleTypeService.QueryCount(null);
            ArticleTypeList = _ArticleTypeService.QueryList(1,typecount,null,"at_id",false);
            PageIndex = Request["page"].ToInt32(1);
            type = Request["type"].ToInt32(0);
            size = 10;
            if (type==0) {
                type= _ArticleTypeService.QueryList(1,1,null,"at_id",false).First().at_id;
            }
            var where = new { a_type = type };
            TotalCount = _ArticleService.QueryCount(where);

           
            TotalPages = (int)Math.Ceiling(TotalCount / (double)size);

            ArticleList = _ArticleService.QueryList(PageIndex, size, where, "a_id");


        }
    }
}