using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using TCS.Model;

namespace TCS.Web.handler
{
    /// <summary>
    /// MultiDelete 的摘要说明
    /// </summary>
    public class MultiDelete : IHttpHandler
    {
        BLL.T_UserInfoService _UserInfoService = new BLL.T_UserInfoService();
        BLL.T_ComplaintFormService _ComplaintFormService = new BLL.T_ComplaintFormService();
        BLL.T_ComplaintDiscussService _ComplaintDiscussService = new BLL.T_ComplaintDiscussService();
        public string msg { get; set; }
        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            string action = context.Request["action"].ToString();
            if (action == "member")
            {
                string str = context.Request["strid"].ToString();
                if (!string.IsNullOrEmpty(str))
                {
                    if (str.IndexOf('|') > 0)
                    {
                        var res = str.Split('|');
                        msg = "删除成功";
                        for (int i = 0; i < res.Length - 1; i++)
                        {
                            T_UserInfo user = new T_UserInfo();

                            user = _UserInfoService.QuerySingle(res[i].ToInt32(0));
                            user.u_status = 3;
                            int n = _UserInfoService.Update(user);
                            if (n <= 0)
                            {

                                msg = "删除失败，已成功删除" + i + "条数据！";
                                break;
                            }

                        }

                    }
                    else
                    {
                        T_UserInfo user = new T_UserInfo();

                        user = _UserInfoService.QuerySingle(str.ToInt32(0));
                        user.u_status = 3;
                        int n = _UserInfoService.Update(user);
                        //int n = _UserInfoService.Delete(str.ToInt32(0));
                        if (n <= 0)
                        {
                            msg = "删除失败！";
                        }

                    }

                }
                else
                {
                    msg = "未选中数据！";

                }

                context.Response.Write(msg);
            }
            else if (action == "tousuinfo")
            {
                string str = context.Request["strid"].ToString();
                if (!string.IsNullOrEmpty(str))
                {
                    if (str.IndexOf('|') > 0)
                    {
                        var res = str.Split('|');
                        msg = "删除成功";
                        for (int i = 0; i < res.Length - 1; i++)
                        {
                            if (_ComplaintDiscussService.QueryCount(new { cd_cid = res[i].ToInt32(0) }) > 0)
                            {
                                msg = "删除失败，已成功删除" + i + "条数据！ 请删除所选中投诉单下所有评论信息，再重新操作！";
                                break;

                            }
                            int n = _ComplaintFormService.Delete(res[i].ToInt32(0));
                            if (n <= 0)
                            {

                                msg = "删除失败，已成功删除" + i + "条数据！";
                                break;
                            }

                        }

                    }
                    else
                    {
                        if (_ComplaintDiscussService.QueryCount(new { cd_cid = str.ToInt32(0) }) > 0)
                        {
                            msg = "请删除该投诉单下所有评论信息，再重新操作！";

                        }
                        else
                        {
                            int n = _ComplaintFormService.Delete(str.ToInt32(0));
                           
                            if (n <= 0)
                            {
                                msg = "删除失败！";
                            }
                        }
                    }

                }
                else
                {
                    msg = "未选中数据！";
                }

                context.Response.Write(msg);
            }
            else if (action == "comment")
            {
                string str = context.Request["strid"].ToString();
                if (!string.IsNullOrEmpty(str))
                {
                    if (str.IndexOf('|') > 0)
                    {
                        var res = str.Split('|');
                        msg = "删除成功";
                        for (int i = 0; i < res.Length - 1; i++)
                        {
                            if (_ComplaintDiscussService.QueryCount(new { cd_parentId = res[i].ToInt32(0) }) > 0)
                            {
                                msg = "删除失败，已成功删除" + i + "条数据！ 请删除所选中评论下所有评论信息，再重新操作！";
                                break;

                            }
                            int n = _ComplaintDiscussService.Delete(res[i].ToInt32(0));
                            if (n <= 0)
                            {

                                msg = "删除失败，已成功删除" + i + "条数据！";
                                break;
                            }

                        }

                    }
                    else
                    {
                        if (_ComplaintDiscussService.QueryCount(new { cd_parentId = str.ToInt32(0) }) > 0)
                        {
                            msg = "请删除该评论下所有评论信息，再重新操作！";

                        }
                        else
                        {
                            int n = _ComplaintDiscussService.Delete(str.ToInt32(0));

                            if (n <= 0)
                            {
                                msg = "删除失败！";
                            }
                        }
                    }

                }
                else
                {
                    msg = "未选中数据！";
                }

                context.Response.Write(msg);
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