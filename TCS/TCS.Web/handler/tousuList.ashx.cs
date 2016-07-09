using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using TCS.Model;
using TCS.Model.Enums;
using TCS.Web.viewModel;
using Newtonsoft.Json;
using System.Text;
using System.IO;
using System.Web.SessionState;

namespace TCS.Web.handler
{
    /// <summary>
    /// tousuList 的摘要说明
    /// </summary>
    public class tousuList : IHttpHandler, IRequiresSessionState
    {

        IEnumerable<T_ComplaintForm> CurrentComplaintForm { get; set; }

        BLL.T_ComplaintFormService _ComplaintFormService = new BLL.T_ComplaintFormService();
        BLL.T_ComplaintTypeService _ComplaintTypeService = new BLL.T_ComplaintTypeService();
        BLL.T_UserInfoService _UserInfoService = new BLL.T_UserInfoService();
        BLL.T_ComplaintDiscussService _ComplaintDiscussService = new BLL.T_ComplaintDiscussService();
        public c_statusType statusType { get; set; }
        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            int role = 1;
            role = context.Request["role"].ToInt32(1);
            //if (HttpContext.Current.Session["current_admin"] != null)
            //{
            //    var currentAdmin = HttpContext.Current.Session["current_admin"] as T_UserInfo;
            //    role = currentAdmin.u_roleId;
            //}
                //context.Response.ContentType = "xml/json";
                //string StrJson = context.Request["aoData"];
                //StrJson = StrJson.Substring(2, StrJson.Length - 4);
                //StrJson = StrJson.Replace("},{", "|");

                //string[] strList = StrJson.Split('|');
                //for (int n = 0; n < strList.Length; n++)
                //{
                //    string a = strList[n];
                //}
                String sEcho = "";// 记录操作的次数  每次加1
            //String iDisplayStart = "";// 起始
            //String iDisplayLength = "";// size
            //String sSearch = "";// 搜索的关键字
            int allcount = 0;  //查询出来的数量
            //StringBuilder sb = new StringBuilder();

             //Newtonsoft.Json.Linq.JArray ja = (Newtonsoft.Json.Linq.JArray)Newtonsoft.Json.JsonConvert.DeserializeObject(context.Request["aoData"]);
             //foreach (Newtonsoft.Json.Linq.JObject item in ja)
             //{

             //    if (item["name"].ToString().Equals("sEcho"))
             //    {
             //        sEcho = item["value"].ToString();
             //    }
             //    if (item["name"].ToString().Equals("iDisplayStart"))
             //    {
             //        iDisplayStart = item["value"].ToString();
             //    }
             //    if (item["name"].ToString().Equals("iDisplayLength"))
             //    {
             //        iDisplayLength = item["value"].ToString();
             //    }
             //    if (item["name"].ToString().Equals("sSearch"))
             //    {
             //        sSearch = item["value"].ToString();
             //    }


             //}
            allcount = _ComplaintFormService.QueryCount(null);
            
            //int indexPage = 1;
            //int totalPage = 0;
            //if (iDisplayStart.ToInt32() >= iDisplayLength.ToInt32()) {
            //    indexPage = (int)Math.Ceiling(iDisplayStart.ToInt32()/ (double)iDisplayLength.ToInt32());
            //}

            int initEcho = sEcho.ToInt32() + 1;
            //totalPage = (int)Math.Ceiling(allcount / (double)iDisplayLength.ToInt32());
             
            CurrentComplaintForm = _ComplaintFormService.QueryList(1, allcount, null, "c_id");
           
            

           // List<tousuListViewModel> newList = new List<tousuListViewModel>();
            
            int i = 0;
            string tousuStrList = "{\"iTotalRecords\":" + allcount + ",\"sEcho\":" + initEcho + ",\"iTotalDisplayRecords\":" + allcount + ",\"aaData\":[";
            foreach (var item in CurrentComplaintForm)
            {
                i++;
                tousuListViewModel viewmodel = new tousuListViewModel();
                viewmodel.ID = item.c_id;
                viewmodel.ORDERNO = i;
                viewmodel.SUBMITTIME = item.c_submitTime.ToString("yyyy-MM-dd");
                viewmodel.UNAME = (_UserInfoService.QuerySingle(new { u_id = item.c_uId })).u_nickName;
                viewmodel.UID = item.c_uId;
                viewmodel.TITLE = item.c_title;
                viewmodel.TYPENAME = _ComplaintTypeService.QuerySingle(new { ct_id = item.c_typeId }).ct_name;
                viewmodel.RESPONDER = item.c_responderId>0?(_UserInfoService.QuerySingle(item.c_responderId)).u_realName : string.Empty;
                viewmodel.INSPECTOR = item.c_inspectorId>0?(_UserInfoService.QuerySingle(item.c_inspectorId)).u_realName : string.Empty;
                viewmodel.RESPONSECONTENT = (item.c_responseContent!=null? item.c_responseContent:string.Empty);
                viewmodel.RESPONSETIME = (item.c_responseTime!=null?item.c_responseTime.ToString("yyyy-MM-dd HH:mm:ss"):string.Empty);
                viewmodel.INSPECTTIME = (item.c_inspectTime!=null?item.c_inspectTime.ToString("yyyy-MM-dd HH:mm:ss") : string.Empty); 
                viewmodel.INSPECTRESULT = item.c_inspectResult!=null? item.c_inspectResult:string.Empty ;
                viewmodel.INSPECTREMARK = item.c_inspectRemark!=null? item.c_inspectRemark : string.Empty;
                statusType = (c_statusType)item.c_status;
                if (role == 1) {
                    switch (statusType)
                    {
                        case c_statusType.处理中:
                            viewmodel.STATUSNAME = "处理中";
                            break;
                        case c_statusType.已处理待反馈:
                            viewmodel.STATUSNAME = "已处理/待反馈";
                            break;
                        case c_statusType.已完结:
                            viewmodel.STATUSNAME = "已完结";
                            break;
                        default:
                            viewmodel.STATUSNAME = "处理中";
                            break;
                    }
                    int comments = 0;
                    comments = _ComplaintDiscussService.QueryCount(new { cd_cid= item.c_id });
                    tousuStrList += "{\"ID\":" + viewmodel.ID + ",\"ORDERNO\":" + viewmodel.ORDERNO + ",\"COMMENTS\":" + comments + ",\"SUBMITTIME\":\"" + viewmodel.SUBMITTIME.Trim() +
                  "\",\"UNAME\":\"" + viewmodel.UNAME.Trim() + "\",\"TITLE\":\"" + viewmodel.TITLE.Trim() + "\",\"TYPENAME\":\"" + viewmodel.TYPENAME.Trim() + "\",\"STATUSNAME\":\"" + viewmodel.STATUSNAME.Trim() + "\"},";

                } else if (role >1) {
                    switch (statusType)
                    {
                        case c_statusType.处理中:
                            viewmodel.STATUSNAME = "待回复";
                            break;
                        case c_statusType.已处理待反馈:
                            viewmodel.STATUSNAME = "通过审核/待反馈";
                            break;
                        case c_statusType.已完结:
                            viewmodel.STATUSNAME = "已完结";
                            break;
                        case c_statusType.待审核:
                            viewmodel.STATUSNAME = "待审核";
                            break;
                        case c_statusType.审核不通过:
                            viewmodel.STATUSNAME = "审核不通过";
                            break;
                        case c_statusType.申请审核中:
                            viewmodel.STATUSNAME = "申请审核中";
                            break;
                        default:
                            break;
                    }
                    tousuStrList += "{\"ID\":" + viewmodel.ID +",\"UID\":" + viewmodel.UID + ",\"ORDERNO\":" + viewmodel.ORDERNO + ",\"SUBMITTIME\":\"" + viewmodel.SUBMITTIME.Trim() +
                  "\",\"UNAME\":\"" + viewmodel.UNAME.Trim() + "\",\"TITLE\":\"" + viewmodel.TITLE.Trim() + "\",\"TYPENAME\":\"" + viewmodel.TYPENAME.Trim() + "\",\"STATUSNAME\":\"" + viewmodel.STATUSNAME.Trim() + "\",\"RESPONDER\":\"" + viewmodel.RESPONDER + "\",\"RESPONSECONTENT\":\"" + viewmodel.RESPONSECONTENT + "\",\"RESPONSETIME\":\"" + viewmodel.RESPONSETIME.Trim() +
                  "\",\"INSPECTOR\":\"" + viewmodel.INSPECTOR.Trim() + "\",\"INSPECTRESULT\":\"" + viewmodel.INSPECTRESULT.Trim() + "\",\"INSPECTREMARK\":\"" + viewmodel.INSPECTREMARK.Trim() + "\",\"INSPECTTIME\":\"" + viewmodel.INSPECTTIME.Trim() + "\"},";
                }
                
              

                //newList.Add(viewmodel);
            }
            tousuStrList = tousuStrList.Substring(0, tousuStrList.Length - 1) + "]}";
            //System.Web.Script.Serialization.JavaScriptSerializer js = new System.Web.Script.Serialization.JavaScriptSerializer();

           
            //StringWriter sw1 = new StringWriter();
            //JsonWriter writer1 = new JsonTextWriter(sw1);
            //writer1.WriteStartArray();

            //foreach (var item in newList)
            //{

            /*writer1.WriteStartObject();
            writer1.WritePropertyName("ID");
            writer1.WriteValue(item.ID);
            writer1.WriteEndObject();

            writer1.WriteStartObject();
            writer1.WritePropertyName("ORDERNO");
            writer1.WriteValue(item.ORDERNO);
            writer1.WriteEndObject();

            writer1.WriteStartObject();
            writer1.WritePropertyName("SUBMITTIME");
            writer1.WriteValue(item.SUBMITTIME);
            writer1.WriteEndObject();

            writer1.WriteStartObject();
            writer1.WritePropertyName("UNAME");
            writer1.WriteValue(item.UNAME);
            writer1.WriteEndObject();

            writer1.WriteStartObject();
            writer1.WritePropertyName("TITLE");
            writer1.WriteValue(item.TITLE);
            writer1.WriteEndObject();

            writer1.WriteStartObject();
            writer1.WritePropertyName("TYPENAME");
            writer1.WriteValue(item.TYPENAME);
            writer1.WriteEndObject();

            writer1.WriteStartObject();
            writer1.WritePropertyName("STATUSNAME");
            writer1.WriteValue(item.STATUSNAME);
            writer1.WriteEndObject();*/
            //}


            // writer1.WriteEndArray();
            //writer1.Flush();
            //writer.WriteValue();
            //writer.WriteEndObject();
            //writer.WriteEndArray();
            //writer.Flush();
            //string jsonText = sw.GetStringBuilder().ToString();
            //Response.Write(jsonText);

            //context.Response.Write(jsonText.Replace("\\\"","\""));
            //context.Response.Write(jsonText);
            //context.Response.End();

            /*string str = "{\"iTotalRecords\":2,\"sEcho\":1,\"iTotalDisplayRecords\":2,\"aaData\":[{" +
        "\"ID\" : 1,\"ORDERNO\" : 1,\"SUBMITTIME\":\"ll\",\"UNAME\" :\"ll\",\"TITLE\" : \"oo\"," +
        "\"TYPENAME\" :\"pp\",\"STATUSNAME\":\"kk\"}," + "{" +
        "\"ID\" : 1,\"ORDERNO\" : 1,\"SUBMITTIME\":\"ll\",\"UNAME\" :\"ll\",\"TITLE\" : \"oo\"," +
        "\"TYPENAME\" :\"pp\",\"STATUSNAME\":\"kk\"}]}";*/

            context.Response.Write(tousuStrList);
            context.Response.End();
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
 