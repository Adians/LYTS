using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TCS.Model;
using TCS.Web.PageBase;

namespace TCS.Web
{
    public partial class tousupublish : AuthBasePage
    {
        string urlPath = string.Empty;
        public IEnumerable<T_ComplaintType> CurrentComplaintType { get; set; }
        public IEnumerable<T_ComplaitRequire> ComplaitRequireList { get; set; }
        BLL.T_ComplaitRequireService _ComplaitRequireService = new BLL.T_ComplaitRequireService();
        BLL.T_ComplaintTypeService _ComplaintTypeService = new BLL.T_ComplaintTypeService();
        BLL.T_ComplaintFormService _ComplaintFormService = new BLL.T_ComplaintFormService();
        T_UserInfo currentUser = new T_UserInfo();
        public int msg { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            //var applicationPath = VirtualPathUtility.ToAbsolute("~") == "/" ? "" : VirtualPathUtility.ToAbsolute("~");
            //urlPath = applicationPath + "/Upload";
            msg = 0;
            
            if (Request.IsPostBack()) 
            {
                
                if (Session["uploadPath"] != null)
                {
                    urlPath = Session["uploadPath"].ToString();
                    Session["uploadPath"] = null;
                }

                int tousuType = Request["tousuType"].ToInt32(0);
                int tousuRequire = Request["tousuRequire"].ToInt32(0);
                string tousuTitle = Request["tousuTitle"].ToString();
                string tousuContent = Request["tousuContent"].ToString();

                if (tousuType == 0 || tousuRequire == 0 || string.IsNullOrEmpty(tousuTitle) || string.IsNullOrEmpty(tousuContent)|| CurrentUser==null)
                {

                    msg = -1;//发表失败
                }
                else {
                    T_ComplaintForm currentComplaintForm = new T_ComplaintForm();
                    currentComplaintForm.c_uId = CurrentUser.u_id;//用户暂时设置为1
                    currentComplaintForm.c_typeId = tousuType;
                    currentComplaintForm.c_requireId = tousuRequire;
                    currentComplaintForm.c_title = tousuTitle;
                    currentComplaintForm.c_content = tousuContent;
                    currentComplaintForm.c_submitTime = DateTime.Now;
                    currentComplaintForm.c_status = 1;
                    currentComplaintForm.c_commentTime = DateTime.Now;
                    currentComplaintForm.c_inspectTime = DateTime.Now;
                    currentComplaintForm.c_responseTime = DateTime.Now;
                    currentComplaintForm.c_commentScore = 0;
                    currentComplaintForm.c_inspectorId = 0;
                    currentComplaintForm.c_inspectRemark = string.Empty;
                    currentComplaintForm.c_inspectResult = string.Empty;
                    currentComplaintForm.c_responderId = 0;
                    currentComplaintForm.c_responseContent = string.Empty;
                    currentComplaintForm.c_picPath = urlPath;
                    currentComplaintForm.c_commentText = string.Empty;

                    int res = _ComplaintFormService.Insert(currentComplaintForm);
                    if (res > 0)
                    {
                        msg = 1;
                        Response.Redirect("/tousudetail.aspx?item=" + res);
                    }
                    else
                    {

                        msg = -1;//发表失败
                    }

                }
                
                
                //string id = Request["id"].ToString();
                //string name = Request["name"].ToString();
                //string type = Request["type"].ToString();
                //string lastModifiedDate = Request["lastModifiedDate"].ToString();
                //int size = Request["size"].ToInt32();
                //HttpFileCollection files = Request.Files;
                ////HttpPostedFileBase file =Request["file"];


                //string filePathName = string.Empty;
                //HttpFileCollection fileCollection = Request.Files;

                //foreach (File item in fileCollection)
                //{
                //    //File file = item[];
                //}

                //HttpPostedFile file = fileCollection.Get("00000000");
                //context.Server.MapPath(file)

                /*foreach (string fn in Request.Files)
                {
                    HttpFileCollection hpf = Request.Files[fn];
                    if (hpf != null && hpf.ContentLength > 0)  //判断上传的文件是否为空
                    {
                        int idx = hpf.FileName.LastIndexOf(".");
                        string suffix = hpf.FileName.Substring(idx);//获得上传的图片的后缀名 
                        pictureName = DateTime.Now.Ticks.ToString() + suffix;

                        string path = Server.MapPath("/facePic/");     //设置文件保存的虚拟路径
                        hpf.SaveAs(path + pictureName);
                        string imgPath = Server.MapPath(u.u_facePic);
                        if (System.IO.File.Exists(imgPath))
                        {
                            System.IO.File.Delete(imgPath);
                        }
                    }*/

                //string localPath = Path.Combine(HttpRuntime.AppDomainAppPath, "Upload");
                //if (Request.Files.Count == 0)
                //{
                //    //return Json(new { jsonrpc = 2.0, error = new { code = 102, message = "保存失败" }, id = "id" });
                //}

                //string ex = Path.GetExtension("llllllllllllllllll");
                //filePathName = Guid.NewGuid().ToString("N") + ex;
                //if (!System.IO.Directory.Exists(localPath))
                //{
                //    System.IO.Directory.CreateDirectory(localPath);
                //}
                //file.SaveAs(Path.Combine(localPath, filePathName));

                /*return Json(new
                {
                    jsonrpc = "2.0",
                    id = id,
                    filePath = urlPath + "/" + filePathName
                });*/

            }
            
                int count = _ComplaintTypeService.QueryCount(null);
                CurrentComplaintType = _ComplaintTypeService.QueryList(1,count,null,"ct_id",false);
                int rcount = _ComplaitRequireService.QueryCount(null);
                ComplaitRequireList = _ComplaitRequireService.QueryList(1, rcount, null, "cr_id", false);

           
        }
    }
}