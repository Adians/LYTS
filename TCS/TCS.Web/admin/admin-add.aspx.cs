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
    public partial class admin_add1 : AdminAuthBasePage
    {
        BLL.T_RolesService _RolesService = new BLL.T_RolesService();
        BLL.T_UserInfoService _UserInfoService = new BLL.T_UserInfoService();
        public IEnumerable<T_Roles> RolesList { get; set; }
        public T_UserInfo UserInfo { get; set; }
        public int count { get; set; }
        public int aid { get; set; }
        public int msg { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            UserInfo = null;
            count = _RolesService.QueryCount(null);
            RolesList = _RolesService.QueryList(1,count,null,"r_id");
            RolesList = RolesList.Where(r=>r.r_id>1);
            count =  RolesList.Count();
            aid = Request["aid"].ToInt32(0);
            if (aid>0) {
                UserInfo =  _UserInfoService.QuerySingle(aid);
            }
            if (Request.IsPostBack()) {
                aid = Request["aid"].ToInt32(0);
                T_UserInfo user = new T_UserInfo();
                string adminName = Request["adminName"].ToString();
                string adminNickame = Request["adminNickame"].ToString();
                string adminRealame = Request["adminRealame"].ToString();
                string password = Request["password"].ToString();
                string sex = Request["sex"].ToString();
                int adminRole = Request["adminRole"].ToInt32();
                string adminTel = Request["adminTel"].ToString();
                string adminEmail = Request["adminEmail"].ToString();
                if (aid == 0)
                {
                    if (_UserInfoService.QuerySingle(new { u_loginName = adminName }) != null)
                    {
                        msg = -2;
                        return;
                    }
                    user.u_email = adminEmail;
                    user.u_loginName = adminName;
                    user.u_nickName = adminNickame;
                    user.u_phoneNo = adminTel;
                    user.u_realName = adminRealame;
                    user.u_regTime = DateTime.Now;
                    user.u_sex = sex;
                    user.u_roleId = adminRole;
                    user.u_status = 1;
                    user.u_loginTime = DateTime.Now;
                    user.u_lastLoginTime = DateTime.Now;
                    user.u_password = password.Md5();
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
                else {
                    user.u_email = adminEmail;
                    user.u_loginName = adminName;
                    user.u_nickName = adminNickame;
                    user.u_phoneNo = adminTel;
                    user.u_realName = adminRealame;
                    user.u_sex = sex;
                    user.u_roleId = adminRole;
                    user.u_password = password.Md5();
                    user.u_pic = "/admin/images/user.png";
                    int res = _UserInfoService.Update(user);
                    if (res > 0)
                    {

                        msg = 1;
                    }
                    else
                    {
                        msg = -1;
                    }

                }
                
            }
        }
    }
}