﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TCS.Model;
using TCS.Web.PageBase;

namespace TCS.Web.admin
{
    public partial class article_category_add : AdminAuthBasePage
    {
        BLL.T_ComplaintTypeService _ComplaintTypeService = new BLL.T_ComplaintTypeService();
        public int msg { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            CurrentUser = Session["current_admin"] as T_UserInfo;
            if (Request.IsPostBack())
            {

                int tid = Request["atid"].ToInt32(0);
                string name = Request["article-category-name"].ToString();
                
                T_ComplaintType complaintType = new T_ComplaintType();
                if (CurrentUser == null || CurrentUser.u_roleId != 4)
                {
                    msg = -2;
                    return;
                }
                if (tid == 0)
                {
                    if (_ComplaintTypeService.QuerySingle(new { ct_name = name }) != null)
                    {
                        msg = -2;
                    }
                    else
                    {
                        complaintType.ct_name = name;
                        complaintType.ct_creatorId = CurrentUser.u_id;
                        complaintType.ct_createTime = DateTime.Now;
                        int res = _ComplaintTypeService.Insert(complaintType);
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
                else
                {
                    complaintType = _ComplaintTypeService.QuerySingle(tid);
                    complaintType.ct_name = name;
                    complaintType.ct_creatorId = CurrentUser.u_id;
                    complaintType.ct_createTime = DateTime.Now;
                    int res = _ComplaintTypeService.Update(complaintType);
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