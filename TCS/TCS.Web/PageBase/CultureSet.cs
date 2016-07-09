using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TCS.Web.PageBase
{
    public class CultureSet:System.Web.UI.Page
    {
        protected override void InitializeCulture()
        {
            if (Request.Cookies["Language"] != null && Request.Cookies["Language"].Value !=

    null && Request.Cookies["Language"].Value != "")
            {
                setCulture();
            }
            else
            { //设置Cookie
                //Response.Cookies["Language"].Value =(Request.Headers["accept-language"].Split(",".ToCharArray())[0]);
                Response.Cookies["Language"].Value = "zh-CN";
                Response.Cookies["Language"].Expires = DateTime.Now.AddDays(1000);
                setCulture();
            }
            base.InitializeCulture();
        }
        private void setCulture()
        {
            try
            {
                String selectedLanguage = Request.Cookies["Language"].Value;
                UICulture = selectedLanguage;
                Culture = selectedLanguage;

                System.Threading.Thread.CurrentThread.CurrentCulture =System.Globalization.CultureInfo.CreateSpecificCulture(selectedLanguage);
                System.Threading.Thread.CurrentThread.CurrentUICulture = new System.Globalization.CultureInfo(selectedLanguage);
            }
            catch
            {
                Response.Cookies.Clear();
            }
        }


    }
}