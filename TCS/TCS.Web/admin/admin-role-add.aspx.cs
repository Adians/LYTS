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
    public partial class admin_role_add : AdminAuthBasePage
    {
        BLL.T_RolesService _RolesService = new BLL.T_RolesService();
        public int msg { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            msg = 0;
            if (Request.IsPostBack()) {
                int rid = Request["rid"].ToInt32(0);
                string name = Request["rolename"].ToString();
                string remark = Request["roleremark"].ToString();
                if (CurrentUser == null || CurrentUser.u_roleId != 4)
                {
                    msg = -2;
                    return;
                }
                if (rid == 0)
                {
                    if (_RolesService.QuerySingle(new { r_name = name }) != null)
                    {
                        msg = -2;
                        return;
                    }
                    T_Roles role = new T_Roles();
                    role.r_name = name;
                    role.r_text = remark;
                    role.r_creator = CurrentUser.u_id;
                    role.r_creatTime = DateTime.Now;
                    int res = _RolesService.Insert(role);
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
                    T_Roles role = _RolesService.QuerySingle(rid);
                    role.r_name = name;
                    role.r_text = remark;
                    role.r_creator = CurrentUser.u_id;
                    role.r_creatTime = DateTime.Now;
                    int res = _RolesService.Update(role);
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