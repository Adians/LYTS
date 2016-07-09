using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TCS.Model;
using TCS.Web.PageBase;

namespace TCS.Web.admin
{
    public partial class member_add : AdminAuthBasePage
    {
        BLL.T_UserInfoService _UserInfoService = new BLL.T_UserInfoService();
        public int msg { get; set; }
       
        protected void Page_Load(object sender, EventArgs e)
        {
            
            if (Request.IsPostBack()) {

                int uid = Request["eUserId"].ToInt32(0);
                string name = Request["member-name"].ToString();
                string email = Request["email"].ToString();
                string tel = Request["member-tel"].ToString();
                string sex = Request["sex"].ToString();
                string realname = Request["member-realname"].ToString();
                string nickname = Request["member-nickname"].ToString();

                T_UserInfo user = new T_UserInfo();
                if (uid == 0) {
                    if (_UserInfoService.QuerySingle(new { u_loginName = name }) != null)
                    {
                        msg = -2;
                    }
                    else
                    {
                        user.u_loginName = name;
                        user.u_nickName = nickname;
                        user.u_phoneNo = tel;
                        user.u_email = email;
                        user.u_realName = realname;
                        user.u_regTime = DateTime.Now;
                        user.u_sex = sex;
                        user.u_roleId = 1;
                        user.u_status = 1;
                        user.u_loginTime = DateTime.Now;
                        user.u_lastLoginTime = DateTime.Now;
                        user.u_password = "123456".Md5();
                        user.u_pic = "/admin/images/user.png";
                        //数据库还差头像字段
                        int res = _UserInfoService.Insert(user);
                        if (res > 0)
                        {

                            msg = 2;
                        }
                        else
                        {
                            msg = -2;
                        }

                    }
                    
                    
                }
                else {
                    user = _UserInfoService.QuerySingle(uid);
                    user.u_email = email;
                    user.u_loginName = name;
                    user.u_nickName = nickname;
                    user.u_phoneNo = tel;
                    user.u_sex = sex;
                    user.u_email = email;
                    user.u_realName = realname;
                    int res = _UserInfoService.Update(user);
                    if (res > 0)
                    {

                        msg = 1;
                    }
                    else {
                        msg = -1;
                    }

                }
            }
        }
    }
}