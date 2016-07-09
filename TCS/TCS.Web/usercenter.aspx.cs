using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TCS.Model;
using TCS.Model.Enums;
using TCS.Web.PageBase;

namespace TCS.Web
{
    public partial class usercenter : AuthBasePage
    {
        protected BLL.T_ComplaintFormService _ComplaintFormService = new BLL.T_ComplaintFormService();
        protected BLL.T_ComplaintDiscussService _ComplaintDiscussService = new BLL.T_ComplaintDiscussService();
        protected BLL.T_ComplaintTypeService _ComplaintTypeService = new BLL.T_ComplaintTypeService();
        protected BLL.T_UserInfoService _UserInfoService = new BLL.T_UserInfoService();

        public IEnumerable<T_ComplaintForm> complaintFormList { get; set; }
        public IEnumerable<T_ComplaintDiscuss> complaintDiscussList { get; set; }
        public IEnumerable<T_ComplaintDiscuss> complaintDiscussList1 { get; set; }
        public T_UserInfo userInfo { get; set; }
        public c_statusType statusType { get; set; }
        public int PageIndex { get; set; }
        public int TotalCount { get; set; }
        public int TotalPages { get; set; }

       
        public int type { get; set; }
        public int size { get; set; }

        public int TotalCount1 { get; set; }
        public int TotalCount2 { get; set; }
        public int TotalCount3 { get; set; }
        public int TotalCountall { get; set; }
        public int TotalCount5 { get; set; }
        public int TotalCount6 { get; set; }

        public string msg { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {

            userInfo = _UserInfoService.QuerySingle(CurrentUser.u_id) ;
            msg = string.Empty;
            if (Request.IsPostBack()) {

                string res = Request["res"].ToString();
                if (res == "comment")
                {
                    int score = Request["score"].ToInt32(0);
                    int itemno = Request["itemno"].ToInt32();
                    string comment = Request["commentContent"].ToString();

                    if (score == 0 || comment.Length < 10 || comment.Length > 140|| itemno==0)
                    {
                        msg = "评分失败！请重新操作。";

                    }
                    else
                    {
                        if (userInfo == null)
                        {
                            msg = "评分失败！请重新登陆操作。";
                        }
                        else
                        {
                            T_ComplaintForm cf = new T_ComplaintForm();
                            cf = _ComplaintFormService.QuerySingle(itemno);
                           /* cf.c_id = cf.c_id;
                            cf.c_inspectorId = cf.c_inspectorId;
                            cf.c_inspectRemark = cf.c_inspectRemark;
                            cf.c_inspectResult = cf.c_inspectResult;
                            cf.c_inspectTime = cf.c_inspectTime;
                            cf.c_picPath = cf.c_picPath;
                            cf.c_requireId = cf.c_requireId;
                            cf.c_responderId = cf.c_responderId;
                            cf.c_responseContent = cf.c_responseContent;*/
                            cf.c_commentScore = score;
                            cf.c_commentText = comment;
                            cf.c_commentTime = DateTime.Now;
                            cf.c_status = 3;
                            int n = _ComplaintFormService.Update(cf);
                            if (n > 0)
                            {
                                Response.Redirect("/usercenter.aspx?type=3");
                            }
                            else {
                                msg = "评分失败！请重新操作。";

                            }

                        }

                    }
                }
                else if (res == "editUserInfo")
                {
                    string realName = Request["realName"].ToString();
                    string nickName = Request["nickName"].ToString();
                    string sex = Request["sex"].ToString();
                    string tel = Request["tel"].ToString();
                    string email = Request["email"].ToString();
                    string path = string.Empty;
                    string oldpath = string.Empty;
                    if (Request.Files[0]!=null&&Request.Files[0].ContentLength > 0) {
                        path = "/Upload/" + DateTime.Now.ToFileTime() + Path.GetExtension(Request.Files[0].FileName);
                        Request.Files[0].SaveAs(Server.MapPath(path));
                    }
                    T_UserInfo uinfo = new T_UserInfo();
                    uinfo = _UserInfoService.QuerySingle(userInfo.u_id);
                    uinfo.u_nickName = nickName;
                    uinfo.u_phoneNo = tel;
                    uinfo.u_email = email;
                    uinfo.u_sex = sex;
                    oldpath = uinfo.u_pic;
                    if (!string.IsNullOrEmpty(path)) {
                        uinfo.u_pic = path;
                    }
                   
                    var n = _UserInfoService.Update(uinfo);
                    if (n <= 0)
                    {

                        if (!string.IsNullOrEmpty(path))
                        {
                            string imgPath = Server.MapPath(path);
                            if (System.IO.File.Exists(imgPath))
                            {
                                System.IO.File.Delete(imgPath);
                            }
                        }
                        msg = "修改失败！";
                    }
                    else {
                        if (!string.IsNullOrEmpty(oldpath) && oldpath != "/admin/images/user.png")
                        {
                            string imgPath = Server.MapPath(oldpath);
                            if (System.IO.File.Exists(imgPath))
                            {
                                System.IO.File.Delete(imgPath);
                            }
                        }
                        
                        msg = "ok";

                    }

                }
                else {

                    msg = "参数错误！请重新登陆操作。";
                }
            }
            TotalCount1 =_ComplaintFormService.QueryCount(new { c_uId = userInfo.u_id, __o = "and", c_status = 1 });
            TotalCount2 = _ComplaintFormService.QueryCount(new { c_uId = userInfo.u_id, __o = "and", c_status = 2 });
            TotalCount3 = _ComplaintFormService.QueryCount(new { c_uId = userInfo.u_id, __o = "and", c_status = 3 });
            TotalCountall = _ComplaintFormService.QueryCount(new { c_uId = userInfo.u_id });
            PageIndex = Request["page"].ToInt32(1);
            type = Request["type"].ToInt32(0);

            if (Session["lastType"] == null)
            {
                PageIndex = 1;
            }
            else {
                if (Session["lastType"].ToString() != type.ToString()) {
                    PageIndex = 1;
                }

            }
            Session["lastType"] = type.ToString();

            var orderField = "c_id";
            var isDesc = true;
            size = 5; 
            
            if (type < 4 && type >= 0)
            {
                
                TotalCount = _ComplaintFormService.QueryCount(new { c_uId = CurrentUser.u_id });
                complaintFormList = _ComplaintFormService.QueryList(1, TotalCount, new { c_uId = CurrentUser.u_id }, orderField, isDesc);
                TotalPages = (int)Math.Ceiling(TotalCount / (double)size);

                statusType = (c_statusType)type;
                switch (statusType)
                {
                    case c_statusType.处理中:
                        complaintFormList = complaintFormList.Where(c=>c.c_status==1);
                        TotalCount = complaintFormList.Count();
                        TotalPages = (int)Math.Ceiling(TotalCount / (double)size);
                        break;
                    case c_statusType.已处理待反馈:
                        complaintFormList = complaintFormList.Where(c => c.c_status == 2);
                        TotalCount = complaintFormList.Count();
                        TotalPages = (int)Math.Ceiling(TotalCount / (double)size);
                        break;
                    case c_statusType.已完结:
                        complaintFormList = complaintFormList.Where(c => c.c_status == 3);
                        TotalCount = complaintFormList.Count();
                        TotalPages = (int)Math.Ceiling(TotalCount / (double)size);
                        break;
                    default:
                        break;
                }

                complaintFormList = complaintFormList.Skip((PageIndex - 1) * size).Take(size);
            }
            else {
                orderField = "cd_id";
                TotalCount = _ComplaintDiscussService.QueryCount(null);
                if (TotalCount > 0)
                {
                    complaintDiscussList = _ComplaintDiscussService.QueryList(1, TotalCount, null, orderField, isDesc);
                    if (complaintDiscussList==null) {
                        type = -1;
                    }
                    switch (type)
                    {
                        case 4:
                            complaintDiscussList = complaintDiscussList.Where(c => c.cd_uid == CurrentUser.u_id);
                            if (complaintDiscussList != null)
                            {
                                TotalCount = complaintDiscussList.Count();
                                TotalPages = (int)Math.Ceiling(TotalCount / (double)size);
                            }
                            else {
                                complaintDiscussList = null;
                                TotalCount = 0;
                                TotalPages = 0;
                            }
                            
                            break;
                        case 5:
                            complaintDiscussList1 = complaintDiscussList.Where(c => c.cd_uid == CurrentUser.u_id);
                            
                            if (complaintDiscussList1!=null)
                            {

                                int[] discId = new int[complaintDiscussList1.Count()];
                                int i = 0;
                                foreach (var item in complaintDiscussList1)
                                {
                                    discId[i] = item.cd_id;
                                    i++;
                                }
                                complaintDiscussList = complaintDiscussList.Where(d => discId.Contains(d.cd_parentId)); 
                                TotalCount = complaintDiscussList.Count();
                                TotalPages = (int)Math.Ceiling(TotalCount / (double)size);
                            }
                            else
                            {
                                complaintDiscussList = null;
                                TotalCount = 0;
                                TotalPages = 0;
                            }
                            break;

                        default:
                            complaintDiscussList = null;
                            TotalCount = 0;
                            TotalPages = 0;
                            break;
                    }
                }
                else {

                    complaintDiscussList = null;
                    TotalCount = 0;
                    TotalPages = 0;
                }


                if (complaintDiscussList!=null) {
                    complaintDiscussList = complaintDiscussList.Skip((PageIndex - 1) * size).Take(size);
                }
                else
                {

                    complaintDiscussList = null;
                    TotalCount = 0;
                    TotalPages = 0;
                }

            }
            
        }
    }
}