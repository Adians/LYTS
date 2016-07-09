using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TCS.Model;
using TCS.Model.Enums;
using TCS.Common;
using TCS.Web.viewModel;

namespace TCS.Web
{
    public partial class tousudetail : TCS.Web.PageBase.PageBase
    {
        BLL.T_ComplaintFormService _ComplaintFormService = new BLL.T_ComplaintFormService();
        BLL.T_ComplaintDiscussService _ComplaintDiscussService = new BLL.T_ComplaintDiscussService();
        protected BLL.T_ComplaintTypeService _ComplaintTypeServic = new BLL.T_ComplaintTypeService();
        protected BLL.T_UserInfoService _UserInfoService = new BLL.T_UserInfoService();
        BLL.T_ComplaitRequireService _ComplaitRequireService = new BLL.T_ComplaitRequireService();
        public T_ComplaintForm CurentComplaintForm { get; set; }
        public IEnumerable<tousuDiscussViewModel> tousuDiscuss { get; set; }
        public IEnumerable<T_ComplaintDiscuss> ComplaintDiscussList { get; set; }
        public IEnumerable<T_ComplaintForm> HotComplaintFormList { get; set; }
        public IEnumerable<T_ComplaintForm> RelatedComplaintFormList { get; set; }
        protected T_UserInfo CurrentUser;
        public string tousuType { get; set; }
        public string tousuRequire { get; set; }
        public string tousuStatus { get; set; }
        public c_statusType cstatus { get; set; }
        public int discCount { get; set; }
        public int PageIndex { get; set; }
        public int TotalCount { get; set; }
        public int TotalPages { get; set; }

        public string msg { get; set; }
        public string[] picstr;

        public int  item { get; set; }
        public int size { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            item = Request["item"].ToInt32(0);
            
           
            if (Request.IsPostBack()) {

               
                int resplyId =Request["resplyId"].ToInt32(0);
                int itemId = Request["itemId"].ToInt32(0);
                string resplyName = Request["resplyName_hidden"].ToString();
                string text= Request["myCommontArea"].ToString();
                if (Session["current_user"] == null)
                {
                    // Session中没有用户信息
                    Response.Redirect("/login.aspx?redirect=" + HttpUtility.UrlEncode(Request.Url.ToString()) + "?item=" + itemId);
                }
                if (string.IsNullOrEmpty(text.Trim()))
                {

                    msg = "发表内容不能为空！";
                }
                else {
                    if (resplyName != "false")
                    {
                        text = "<b style=\"font-size:14px; margin-right:5px; color: #ed6d49;\"> " + resplyName + "</b>" + text;
                    }

                    T_ComplaintDiscuss disc = new T_ComplaintDiscuss();
                    disc.cd_cid = itemId;
                    disc.cd_discContent = text;
                    disc.cd_discTime = DateTime.Now;
                    disc.cd_parentId = resplyId;
                    var c = _ComplaintDiscussService.QueryCount(new { cd_cid = itemId });
                    if (c == 0)
                    {
                        disc.cd_discOrder = 1;
                    }
                    else {
                        disc.cd_discOrder = _ComplaintDiscussService.QueryList(1, c, new { cd_cid = itemId }, "cd_id").First().cd_discOrder + 1;
                    }
                    
                    CurrentUser = Session["current_user"] as T_UserInfo;
                    disc.cd_uid = CurrentUser.u_id;
                    
                    int  res =_ComplaintDiscussService.Insert(disc);
                    if (res < 0) {

                        msg = "发表失败！";
                    }
                    else
                    {

                        Response.Redirect("tousudetail.aspx?item="+ itemId);
                    }


                }



            }
            if (item<=0) {
                Response.Redirect("index.aspx");

            }

            CurentComplaintForm = _ComplaintFormService.QuerySingle(item);
            tousuType =_ComplaintTypeServic.QuerySingle(new { ct_id= CurentComplaintForm .c_typeId}).ct_name;
            tousuRequire= _ComplaitRequireService.QuerySingle(new { cr_id = CurentComplaintForm.c_requireId }).cr_name;
            cstatus =(c_statusType) CurentComplaintForm.c_status;
            switch (cstatus)
            {
                case c_statusType.处理中:
                    tousuStatus = "处理中";

                    break;
                case c_statusType.已处理待反馈:
                    tousuStatus = "已处理/待反馈";
                    break;
                case c_statusType.已完结:
                    tousuStatus = "已完结";
                    break;
                default:
                    tousuStatus = "处理中";
                    break;
            }
            if (!string.IsNullOrEmpty(CurentComplaintForm.c_picPath))
            {

                string str = CurentComplaintForm.c_picPath;
                if (str.IndexOf(';') > 0)
                {
                    picstr = str.Split(';');
                }
                else
                {
                    picstr = new string[] { str };

                }
            }
            else {

                picstr = new string[] { "false" };
            }


            //获取评论信息
            var where = new { cd_cid= item };
            size = 8;
            string orderFeild = "cd_discOrder";
            PageIndex = Request["page"].ToInt32(1);
            TotalCount = _ComplaintDiscussService.QueryCount(where);
            TotalPages = (int)Math.Ceiling(TotalCount / (double)size);
            ComplaintDiscussList = _ComplaintDiscussService.QueryList(PageIndex, size,where, orderFeild,false);

            int n = _ComplaintFormService.QueryCount(new { c_typeId = _ComplaintFormService.QuerySingle(item).c_typeId });
            RelatedComplaintFormList = _ComplaintFormService.QueryList(1, n>7?7:n, new { c_typeId = _ComplaintFormService.QuerySingle(item).c_typeId }, "c_id");
            RelatedComplaintFormList = RelatedComplaintFormList.Where(r=>r.c_id!=item);

            /*foreach (var cd in ComplaintDiscussList)
            {
                tousuDiscussViewModel tousuDiscussViewModel = new tousuDiscussViewModel { };

                tousuDiscussViewModel.cd_id = cd.cd_id;
                tousuDiscussViewModel.cd_uname = _UserInfoService.QuerySingle(new { u_id = cd.cd_uid }).u_nickName;
                tousuDiscussViewModel.cd_discOrder = cd.cd_discOrder;
                tousuDiscussViewModel.cd_discContent = cd.cd_discContent;
                //tousuDiscussViewModel.cd_discTime = TimeFormat.GetTimeSpan(DateTime.Now-cd.cd_discTime);
            }*/

            int count = _ComplaintFormService.QueryCount(null);
            discCount = _ComplaintDiscussService.QueryCount(null);
            var list = _ComplaintDiscussService.QueryList(1, discCount, null, "cd_id").GroupBy(m => m.cd_cid);
            list = list.OrderByDescending(l => l.Count()).Skip(0).Take(7);

            List<T_ComplaintForm> newlist = new List<T_ComplaintForm>();
            foreach (var item in list)
            {
                newlist.Add(_ComplaintFormService.QuerySingle(item.Key));
            }
            if (list.Count() < 7)
            {

                if (count >= (7 - list.Count()))
                {
                    count = 7 - list.Count();
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