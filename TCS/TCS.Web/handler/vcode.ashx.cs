using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Web;
using TCS.Common;

namespace TCS.Web.handler
{
    /// <summary>
    /// vcode 的摘要说明
    /// </summary>
    public class vcode : IHttpHandler, System.Web.SessionState.IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            //context.Response.ContentType = "text/plain";
            //context.Response.Write("Hello World");

            // GDI+ 三部 画布 2为画布创建一个画笔  3你需要绘制的素材

            // 创建验证码字符串
            var code = CaptchaHelper.CreateRandomCode(4);
            // 将验证码放到Session中保存
            context.Session["user_vcode"] = code;
            var img = CaptchaHelper.DrawImage(code, 20, background: Color.White);
            context.Response.ContentType = "image/gif";
            context.Response.BinaryWrite(img);
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