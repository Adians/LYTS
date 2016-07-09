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
    public partial class index : TCS.Web.PageBase.PageBase
    {
        BLL.T_ArticleService _ArticleService = new BLL.T_ArticleService();
        BLL.T_ComplaintFormService _ComplaintFormService = new BLL.T_ComplaintFormService();
        BLL.T_ComplaintDiscussService _ComplaintDiscussService = new BLL.T_ComplaintDiscussService();
        protected BLL.T_UserInfoService _UserInfoService = new BLL.T_UserInfoService();
        protected BLL.T_ComplaintTypeService _ComplaintTypeService = new BLL.T_ComplaintTypeService();
        public IEnumerable<T_ComplaintForm> AllComplaintFormList { get; set; }
        public IEnumerable<T_ComplaintForm> DynamicComplaintFormList { get; set; }
        public IEnumerable<T_ComplaintDiscuss> ComplaintDiscussList { get; set; }
        public IEnumerable<T_ComplaintForm> HotComplaintFormList { get; set; }
        
        public int discCount { get; set; }
        public IEnumerable<T_Article> NoticeArticleList { get; set; }

        public IEnumerable<T_Article> NewsArticleList { get; set; }

        public int todayCount { get; set; }
        public int allCount { get; set; }
        public int replyCount { get; set; }
        public decimal satisfaction { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {

            //ResourceWriter rw = new ResourceWriter(Server.MapPath("/App_GlobalResources/zh_us.resx"));

            //rw.AddResource("Resolved", "Cmplt&Resolved");//不可用！！！！
            //rw.Close();

            // this.UICulture = "";
            //System.Resources.ResourceManager rs = new System.Resources.ResourceManager("TCS.Web.App_GlobalResources.MyResource", typeof(String).Assembly);
            //var indexstr = rs.GetString("index");
            // var indexstr =  GetGlobalResourceObject("MyResource", "index").ToString();
            //var str=TCS.Web.App_GlobalResources.zh_cn.index;

            int count = _ComplaintFormService.QueryCount(null);
            AllComplaintFormList = _ComplaintFormService.QueryList(1,count,null, "c_id");
            todayCount = AllComplaintFormList.Where(c => c.c_submitTime.ToString("yyyy-MM-dd") == DateTime.Now.ToString("yyyy-MM-dd")).Count();
            allCount = count;
            replyCount = AllComplaintFormList.Where(c=>!string.IsNullOrEmpty(c.c_responseContent)).Count();
            AllComplaintFormList = AllComplaintFormList.Where(c=>c.c_commentScore>0);
            satisfaction = AllComplaintFormList.Count() > 0 ? ((decimal)( AllComplaintFormList.Sum(c => c.c_commentScore) /(double) (AllComplaintFormList.Count()*5))*100):0M;


            DynamicComplaintFormList = _ComplaintFormService.QueryList(1,5,null,"c_id");
            HotComplaintFormList = _ComplaintFormService.QueryList(1, 5, null, "c_id");
            NoticeArticleList = _ArticleService.QueryList(1,6,null,"a_id");
            NewsArticleList= _ArticleService.QueryList(1, 5, null, "a_id");
            discCount = _ComplaintDiscussService.QueryCount(null);
            var list= _ComplaintDiscussService.QueryList(1,discCount,null,"cd_id").GroupBy(m=>m.cd_cid);


            list = list.OrderByDescending(l=>l.Count()).Skip(0).Take(5);
            
            List<T_ComplaintForm> newlist = new List<T_ComplaintForm>();
            foreach (var item in list)
            {
                newlist.Add(_ComplaintFormService.QuerySingle(item.Key)); 
            }
            if (list.Count() < 5)
            {
                
                if (count>=( 5 - list.Count()) ) {
                    count = 5 - list.Count();
                }
                
                HotComplaintFormList = _ComplaintFormService.QueryList(1, count, null, "c_id");
                foreach (var item1 in HotComplaintFormList)
                {
                    newlist.Add(item1);
                }
            }
            HotComplaintFormList = newlist;


        }
    }
}