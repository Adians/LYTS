using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using TCS.Common;
using TCS.Model;
using TCS.Model.Enums;
using TCS.Web.viewModel;

namespace TCS.Web.handler
{
    /// <summary>
    /// userList 的摘要说明
    /// </summary>
    public class userList : IHttpHandler
    {
        BLL.T_UserInfoService _UserInfoService = new BLL.T_UserInfoService ();
        public IEnumerable<T_UserInfo> UserInfoList { get; set; }
        public int count { get; set; }
        public c_userRole urole { get; set; }
        public void ProcessRequest(HttpContext context)
        {
            int role = context.Request["role"].ToInt32(1);
            int status = context.Request["status"].ToInt32(1);

            String sEcho = "";// 记录操作的次数  每次加1
            int initEcho = sEcho.ToInt32() + 1;
            if (role == 1)
            {
                count = _UserInfoService.QueryCount(new { u_roleId = role });
                UserInfoList = _UserInfoService.QueryList(1, count, new { u_roleId = role }, "u_id", false);
            }
            else {
                count = _UserInfoService.QueryCount(null);
                UserInfoList = _UserInfoService.QueryList(1, count, null, "u_id", false);
                UserInfoList = UserInfoList.Where(u=>u.u_roleId<1);
                count = UserInfoList.Count();
            }
            if (status == 3)
            {
                UserInfoList = UserInfoList.Where(u => u.u_status == 3);
            }
            else {
                UserInfoList = UserInfoList.Where(u => u.u_status <= 2);
            }
            
            count = UserInfoList.Count();
            List<userListViewModel> newList = new List<userListViewModel>();
            int orderno = 0;
            string userStrList = "{\"iTotalRecords\":" + count + ",\"sEcho\":" + initEcho + ",\"iTotalDisplayRecords\":" + count + ",\"aaData\":[";
            foreach (var item in UserInfoList)
            {
                orderno ++;
                userListViewModel userList = new userListViewModel();
                userList.ID = item.u_id;
                userList.ORDERNO = orderno;
                userList.LOGINNAME = item.u_loginName;
                userList.PASSWORD = item.u_password;
                userList.NICKNAME = item.u_nickName;
                userList.PHONE = item.u_phoneNo; ;
                userList.REALNAME = item.u_realName;
                userList.REGTIME = item.u_regTime.ToString("yyyy-MM-dd HH:mm");
                userList.SEX = item.u_sex;
                userList.EMAIL = item.u_email;
                userList.LASTLOGINTIME = item.u_lastLoginTime.ToString("yyyy-MM-dd HH:mm:ss");
                if (item.u_status == 1)
                {

                    userList.STATUE = "已启用";
                }
                else if (item.u_status == 2)
                {

                    userList.STATUE = "已停用";
                }
                else {
                    userList.STATUE = "已删除";

                }
                
                urole = (c_userRole)item.u_roleId;
                switch (urole)
                {
                    case c_userRole.普通用户:
                        userList.ROLE = "普通用户";
                        break;
                    case c_userRole.投诉处理员:
                        userList.ROLE = "投诉处理员";
                        break;
                    case c_userRole.投诉信息审核员:
                        userList.ROLE = "投诉信息审核员";
                        break;
                    case c_userRole.系统管理员:
                        userList.ROLE = "系统管理员";
                        break;
                    default:
                        break;
                }
                userStrList += "{\"ID\":" + userList.ID + ",\"ORDERNO\":" + userList.ORDERNO + ",\"LOGINNAME\":\"" + userList.LOGINNAME.Trim() +
                    "\",\"NICKNAME\":\"" + userList.NICKNAME.Trim() + "\",\"PASSWORD\":\"" + userList.PASSWORD.Trim() + "\",\"PHONE\":\"" + userList.PHONE.Trim() + "\",\"REGTIME\":\"" + userList.REGTIME.Trim() + "\",\"REALNAME\":\"" + userList.REALNAME.Trim() + "\",\"SEX\":\"" + userList.SEX.Trim() + "\",\"EMAIL\":\"" + userList.EMAIL.Trim() + "\",\"LASTLOGINTIME\":\"" + userList.LASTLOGINTIME.Trim() + "\",\"STATUE\":\"" + userList.STATUE.Trim() + "\",\"ROLE\":\"" + userList.ROLE.Trim() + "\"},";
                //newList.Add(userList);
            }
            userStrList = userStrList.Substring(0, userStrList.Length - 1) + "]}";
            //context.Response.ContentType = "text/plain"; text / xml
            StringWriter sw = new StringWriter();
            JsonWriter writer = new JsonTextWriter(sw);

            //JsonWriter writer = new JsonWriter(sw);
            //如果报错则使用JsonWriter writer = new JsonTextWriter(sw);
            writer.WriteStartArray();
            writer.WriteStartObject();
            writer.WritePropertyName("iTotalRecords");
            writer.WriteValue(count);
            writer.WriteEndObject();
            writer.WriteStartObject();
            writer.WritePropertyName("sEcho");
            writer.WriteValue(1);
            writer.WriteEndObject();
            writer.WriteStartObject();
            writer.WritePropertyName("iTotalDisplayRecords");
            writer.WriteValue(count);
            writer.WriteEndObject();
            writer.WriteStartObject();
            writer.WritePropertyName("aaData");
            writer.WriteValue(JsonHelper.Serialize(newList));
            writer.WriteEndObject();
            //writer.WriteEndArray();
            writer.Flush();
           // var json = JsonHelper.Serialize(sw);
            string jsonText = sw.GetStringBuilder().ToString();
            //context.Response.ContentType = "application/json";
            context.Response.ContentType = "text/plain";
            context.Response.Write(userStrList);
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