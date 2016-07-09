using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using TCS.Model;
using TCS.Web.viewModel;
using TCS.Common;
using System.IO;
using Newtonsoft.Json;

namespace TCS.Web.handler
{
    /// <summary>
    /// tousuStatistics 的摘要说明
    /// </summary>
    public class tousuStatistics : IHttpHandler
    {

        BLL.T_ComplaintFormService _ComplaintFormService = new BLL.T_ComplaintFormService();
        BLL.T_ComplaintTypeService _ComplaintTypeService = new BLL.T_ComplaintTypeService();
        public IEnumerable<T_ComplaintForm> ComplaintFormList { get; set; }
        public int allcount { get; set; }
        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            string type= context.Request["type"].ToString();
           //string type = "getbymonth_Type";

            allcount = _ComplaintFormService.QueryCount(null);
            ComplaintFormList = _ComplaintFormService.QueryList(1,allcount,null, "c_submitTime", false);
            if (type=="all") {
                string date = context.Request["date"].ToString();
                //string date = "2016";
                var list = ComplaintFormList.Where(c=>c.c_submitTime.ToString("yyyy")== date).GroupBy(b=>b.c_submitTime.ToString("MM"));

                List<StatisticsByYearModel> newlist = new List<StatisticsByYearModel>();
                foreach (var item in list)
                {
                    StatisticsByYearModel model = new StatisticsByYearModel();
                    model.month = MonthFormat.MonthFormatSet(item.Key.ToInt32(0));
                    model.sum = item.Count();
                    newlist.Add(model);
                }
                System.Web.Script.Serialization.JavaScriptSerializer js = new System.Web.Script.Serialization.JavaScriptSerializer();
                context.Response.Write(js.Serialize(newlist));
            }
            else if (type == "getbymonth_Type")
            {
                string date = context.Request["date"].ToString();
                //string date = "2016";
                var listdate = ComplaintFormList.Where(c => c.c_submitTime.ToString("yyyy") == date).GroupBy(b => b.c_submitTime.ToString("MM"));
                var list = ComplaintFormList.Where(c => c.c_submitTime.ToString("yyyy") == date).GroupBy(b => b.c_typeId);
                List<StatisticsByMonthAndType> newlist = new List<StatisticsByMonthAndType>();
               
                foreach (var item in list)
                {
                    StatisticsByMonthAndType model = new StatisticsByMonthAndType();
                    model.name= _ComplaintTypeService.QuerySingle(item.Key).ct_name;
                    model.data = new int[listdate.Count()];
                    int i = 0;
                    foreach (var item1 in listdate)
                    {
                        var list1 = ComplaintFormList.Where(c => c.c_submitTime.ToString("yyyy-MM") == (date + "-" + item1.Key)&&c.c_typeId== item.Key);
                        model.data[i] =list1.Count();
                        i++;
                    }

                    newlist.Add(model);
                }
               
                System.Web.Script.Serialization.JavaScriptSerializer js = new System.Web.Script.Serialization.JavaScriptSerializer();
                context.Response.Write(js.Serialize(newlist));
            }
            else if (type=="typerate") {
                string mindate = context.Request["mindate"].ToString();
                string maxdate = context.Request["maxdate"].ToString();

                var list = ComplaintFormList.Where(c=>c.c_submitTime >= mindate.ToDateTime() && c.c_submitTime <= maxdate.ToDateTime()).GroupBy(b => b.c_typeId);

                List<StatisticsByTypeRateModel> newlist = new List<StatisticsByTypeRateModel>();
                foreach (var item in list)
                {
                    StatisticsByTypeRateModel model = new StatisticsByTypeRateModel();
                    model.typename = _ComplaintTypeService.QuerySingle(item.Key).ct_name;
                    model.rate = (float)(item.Count()/(float)allcount)*100;
                    newlist.Add(model);
                }
                System.Web.Script.Serialization.JavaScriptSerializer js = new System.Web.Script.Serialization.JavaScriptSerializer();
                context.Response.Write(js.Serialize(newlist));

            }

            else if (type == "typesum")
            {
                string date = context.Request["date"].ToString();
                var list = ComplaintFormList.GroupBy(b => b.c_typeId); ;
                if (date != "all")
                {
                
                    list = ComplaintFormList.Where(c => c.c_submitTime.ToString("yyyy") == date).GroupBy(b => b.c_typeId);
                }
               

                List<StatisticsByTypeSumModel> newlist = new List<StatisticsByTypeSumModel>();
                foreach (var item in list)
                {
                    StatisticsByTypeSumModel model = new StatisticsByTypeSumModel();
                    model.typename = _ComplaintTypeService.QuerySingle(item.Key).ct_name;
                    model.sum = item.Count() ;
                    newlist.Add(model);
                }
                System.Web.Script.Serialization.JavaScriptSerializer js = new System.Web.Script.Serialization.JavaScriptSerializer();
                context.Response.Write(js.Serialize(newlist));

            }
            else if (type == "byMonth")
            {
                //var list = ComplaintFormList.GroupBy(b => b.c_typeId);
                string date = context.Request["date"].ToString();
                //string date = "2016";
                var list = ComplaintFormList.Where(c => c.c_submitTime.ToString("yyyy") == date).GroupBy(b => b.c_submitTime.ToString("MM"));

                List<StatisticsByMonthAndDayModel> newlist = new List<StatisticsByMonthAndDayModel>();
                foreach (var item in list)
                {
                    StatisticsByMonthAndDayModel model = new StatisticsByMonthAndDayModel();
                    model.name = MonthFormat.MonthFormatSet(item.Key.ToInt32(0));
                    model.y = item.Count() ;
                    model.drilldown= MonthFormat.MonthFormatSet(item.Key.ToInt32(0));
                    newlist.Add(model);
                }
                System.Web.Script.Serialization.JavaScriptSerializer js = new System.Web.Script.Serialization.JavaScriptSerializer();
                context.Response.Write(js.Serialize(newlist));

            }
            else if (type == "byTimeRange")
            {
                //var list = ComplaintFormList.GroupBy(b => b.c_typeId);
                string mindate = context.Request["mindate"].ToString();
                string maxdate = context.Request["maxdate"].ToString();
                //string date = "2016";
                var list = ComplaintFormList.Where(c => c.c_submitTime >= mindate.ToDateTime() && c.c_submitTime<= maxdate.ToDateTime()).GroupBy(b =>b.c_typeId);

                List<StatisticsByMonthAndDayModel> newlist = new List<StatisticsByMonthAndDayModel>();
                foreach (var item in list)
                {
                    StatisticsByMonthAndDayModel model = new StatisticsByMonthAndDayModel();
                    model.name = _ComplaintTypeService.QuerySingle(item.Key).ct_name;
                    model.y = item.Count();
                    model.drilldown = _ComplaintTypeService.QuerySingle(item.Key).ct_name;
                    newlist.Add(model);
                }
                System.Web.Script.Serialization.JavaScriptSerializer js = new System.Web.Script.Serialization.JavaScriptSerializer();
                context.Response.Write(js.Serialize(newlist));

            }
            else if (type == "byDay")
            {
                string date = context.Request["date"].ToString();
                //string date = "2016";
                var list = ComplaintFormList.Where(c => c.c_submitTime.ToString("yyyy") == date).GroupBy(b => b.c_submitTime.ToString("MM"));

                List<StatisticsByDayModel> newlist = new List<StatisticsByDayModel>();
                StringWriter sw = new StringWriter();

                //object byday = "[{";
                foreach (var item in list)
                {
                    StatisticsByDayModel model = new StatisticsByDayModel();
                    model.name = MonthFormat.MonthFormatSet(item.Key.ToInt32(0));
                    model.id = MonthFormat.MonthFormatSet(item.Key.ToInt32(0));
                   // model.data = ;
                    var list1 = ComplaintFormList.Where(c => c.c_submitTime.ToString("yyyy-MM") == (date+"-"+ item.Key)).GroupBy(b => b.c_submitTime.ToString("dd"));
                    //byday += "name:" + model.name + ",id:" + model.id + ",data:[";
                    //JsonWriter writer = new JsonTextWriter(sw);
                    //writer.WriteStartArray();
                    //writer.WriteStartObject();
                    //writer.WritePropertyName("name");
                    //writer.WriteValue(model.name);
                    //writer.WriteEndObject();
                    //writer.WriteStartObject();
                    //writer.WritePropertyName("id");
                    //writer.WriteValue(model.id);
                    //writer.WriteEndObject();
                    //writer.WriteStartObject();
                    //writer.WritePropertyName("data");
                    //StringWriter sw1 = new StringWriter();
                    //JsonWriter writer1 = new JsonTextWriter(sw1);
                    //writer1.WriteStartArray();
                    List<DayAndSum> daylist = new List<DayAndSum>();
                    foreach (var item1 in list1)
                    {
                        DayAndSum dmodel = new DayAndSum();
                        dmodel.name = item1.Key+"日";
                        dmodel.y = item1.Count();
                        //byday += "[\"" + item1.Key + "\"," + item1.Count() + "],";
                        //writer1.WriteStartObject();
                        //writer1.WritePropertyName(item1.Key);
                        //writer1.WriteValue(item1.Count());
                        //writer1.WriteEndObject();
                        daylist.Add(dmodel);
                    }
                    model.data = daylist;
                    //byday = byday.ToString().Substring(0, byday.ToString().Length-1)+"]},{";
                    //writer1.WriteEndArray();
                    //writer1.Flush();
                    //string jsonText1 = sw1.GetStringBuilder().ToString();
                    //writer.WriteValue(jsonText1);
                    //writer.WriteEndObject();

                   // writer.WriteEndArray();
                    //writer.Flush();
                    newlist.Add(model);
                }
                //byday = byday.ToString().Substring(0, byday.ToString().Length - 3) + "}]";


                string jsonText = sw.GetStringBuilder().ToString();
                System.Web.Script.Serialization.JavaScriptSerializer js = new System.Web.Script.Serialization.JavaScriptSerializer();
                context.Response.Write(js.Serialize(newlist));
                //context.Response.Write(jsonText);
                //context.Response.Write(js.Serialize(byday));

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