using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TCS.Web.PageBase;

namespace TCS.Web
{
    public partial class logout : AuthBasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["current_user"] =null;
            Response.Redirect("index.aspx");
        }
    }
}