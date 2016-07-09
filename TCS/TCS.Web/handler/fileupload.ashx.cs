using Itcast.Mall.Utility;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.SessionState;

namespace TCS.Web.handler
{
    /// <summary>
    /// fileupload 的摘要说明
    /// </summary>
    public class fileupload : IHttpHandler, IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            
            context.Response.ContentType = "text/plain";
            if (context.Request.IsPostBack()) // IsPostBack 是基于__VIEWSTATE
            {
                //string urlPath = string.Empty;
                //var applicationPath = VirtualPathUtility.ToAbsolute("~") == "/" ? "" : VirtualPathUtility.ToAbsolute("~");
                //urlPath = applicationPath + "/Upload";
                //string id = context.Request["id"].ToString();
                //string name = context.Request["name"].ToString();
                //string type = context.Request["type"].ToString();
                //string lastModifiedDate = context.Request["lastModifiedDate"].ToString();
                //int size = context.Request["size"].ToInt32();
                //var file = context.Request.Files[0];
                ////HttpPostedFileBase files  = context.Request;
                ////HttpPostedFileBase files = context.Request.Files;


                //string filePathName = string.Empty;
                ////HttpPostedFile file = files[i];

                ///*if (file.ContentLength > 0)
                //{
                //    //全路径  
                //    string FullFullName = file.FileName;
                //    //获取图片的名称  
                //    String fileName = FullFullName.Substring(FullFullName.LastIndexOf("\\") + 1);
                //    //保存路径D:\GoodCommunitySystem2.0 - 副本\GoodCommunitySystem\Paint\img\  
                //    string path = "~/Paint/img";
                //    file.SaveAs(System.Web.HttpContext.Current.Server.MapPath(path) + "\\" + fileName);
                //}*/

                //string localPath = Path.Combine(HttpRuntime.AppDomainAppPath, "Upload");
                //if (context.Request.Files.Count == 0)
                //{
                //    StringWriter sw = new StringWriter();
                //    JsonWriter writer = new JsonTextWriter(sw);

                //    writer.WriteStartObject();
                //    writer.WritePropertyName("jsonrpc");
                //    writer.WriteValue(2.0);
                //    writer.WriteEndObject();

                //    writer.WriteStartObject();
                //    writer.WritePropertyName("error");
                //    writer.WriteValue(new { code = 102, message = "保存失败" });
                //    writer.WriteEndObject();

                //    writer.WriteStartObject();
                //    writer.WritePropertyName("id");
                //    writer.WriteValue("id");
                //    writer.WriteEndObject();


                //    writer.Flush();
                //    string jsonText = sw.GetStringBuilder().ToString();
                //    context.Response.Write(jsonText);

                //    //return Json(new { jsonrpc = 2.0, error = new { code = 102, message = "保存失败" }, id = "id" });
                //}

                //else
                //{

                //    string ex = Path.GetExtension(file.FileName);
                //    filePathName = Guid.NewGuid().ToString("N") + ex;
                //    if (!System.IO.Directory.Exists(localPath))
                //    {
                //        System.IO.Directory.CreateDirectory(localPath);
                //    }
                //    file.SaveAs(Path.Combine(localPath, filePathName));

                //    StringWriter sw = new StringWriter();
                //    JsonWriter writer = new JsonTextWriter(sw);

                //    writer.WriteStartObject();
                //    writer.WritePropertyName("jsonrpc");
                //    writer.WriteValue(2.0);
                //    writer.WriteEndObject();

                //    writer.WriteStartObject();
                //    writer.WritePropertyName("id");
                //    writer.WriteValue(id);
                //    writer.WriteEndObject();

                //    writer.WriteStartObject();
                //    writer.WritePropertyName("filePath");
                //    writer.WriteValue(urlPath + "/" + filePathName);
                //    writer.WriteEndObject();


                //    writer.Flush();
                //    string jsonText = sw.GetStringBuilder().ToString();
                //    context.Response.Write(jsonText);
                //    /*return Json(new
                //  {
                //      jsonrpc = "2.0",
                //      id = id,
                //      filePath = urlPath + "/" + filePathName
                //  });*/
                //}






                //如果进行了分片
                 if (context.Request.Form.AllKeys.Any(m => m == "chunk"))
                 {
                     //取得chunk和chunks
                     int chunk = Convert.ToInt32(context.Request.Form["chunk"]);//当前分片在上传分片中的顺序（从0开始）
                     int chunks = Convert.ToInt32(context.Request.Form["chunks"]);//总分片数
                                                                                  //根据GUID创建用该GUID命名的临时文件夹
                     string folder = context.Server.MapPath("/Upload/" + context.Request["guid"] + "/");
                     string path = folder + chunk;

                     //建立临时传输文件夹
                     if (!Directory.Exists(Path.GetDirectoryName(folder)))
                     {
                         Directory.CreateDirectory(folder);
                     }

                     FileStream addFile = new FileStream(path, FileMode.Append, FileAccess.Write);
                     BinaryWriter AddWriter = new BinaryWriter(addFile);
                     //获得上传的分片数据流
                     HttpPostedFile file = context.Request.Files[0];
                     Stream stream = file.InputStream;

                     BinaryReader TempReader = new BinaryReader(stream);
                     //将上传的分片追加到临时文件末尾
                     AddWriter.Write(TempReader.ReadBytes((int)stream.Length));
                     //关闭BinaryReader文件阅读器
                     TempReader.Close();
                     stream.Close();
                     AddWriter.Close();
                     addFile.Close();

                     TempReader.Dispose();
                     stream.Dispose();
                     AddWriter.Dispose();
                     addFile.Dispose();

                     context.Response.Write("{\"chunked\" : true, \"hasError\" : false, \"f_ext\" : \"" + Path.GetExtension(file.FileName) + "\"}");
                 }
                 else//没有分片直接保存
                 {
                    string path = "/Upload/" + DateTime.Now.ToFileTime() + Path.GetExtension(context.Request.Files[0].FileName);
                    try
                    {
                        
                        if (HttpContext.Current.Session["uploadPath"] == null)
                        {

                            //SessionHelper.Set("uploadPath", path);
                            HttpContext.Current.Session["uploadPath"] = path;
                        }
                        else
                        {
                            //string str = HttpContext.Current.Session["uploadPath"].ToString();
                            HttpContext.Current.Session["uploadPath"] = HttpContext.Current.Session["uploadPath"].ToString()+";"+ path;
                            //SessionHelper.Set("uploadPath", SessionHelper.Get("uploadPath").ToString() + ";" + path);
                        }
                    }
                    catch (Exception)
                    {
                        //HttpContext.Current.Session["uploadPath"] = path;
                        //SessionHelper.Set("uploadPath", path);

                    }
                    finally {
                        context.Request.Files[0].SaveAs(context.Server.MapPath(path));
                        context.Response.Write("{\"chunked\" : false, \"hasError\" : false}");
                    }
                     
                 }
            }
                
        }
               

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}