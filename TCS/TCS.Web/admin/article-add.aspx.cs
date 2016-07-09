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
    public partial class article_add : AdminAuthBasePage
    {
        BLL.T_ArticleTypeService _ArticleTypeService = new BLL.T_ArticleTypeService();
        BLL.T_ArticleService _ArticleService = new BLL.T_ArticleService();
        public IEnumerable<T_ArticleType> ArticleTypeList { get; set; }

        public T_Article CurrentArticle { get; set; }
        public int count { get; set; }
        public int aid { get; set; }
        public int msg { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            aid = 0;
            msg = 0;
            var CurrentsUser = (T_UserInfo)null;
            count = _ArticleTypeService.QueryCount(null);
            ArticleTypeList = _ArticleTypeService.QueryList(1,count,null, "at_id", false);
            if (Request.IsPostBack()) {
                if (Session["current_admin"] != null)
                {
                    CurrentsUser = Session["current_admin"] as T_UserInfo;
                }
                else {
                    msg = -2;
                    return;
                }
                
                aid = Request["aid"].ToInt32(0);
                string articletitle = Request["articletitle"].ToString();
                int articletype = Request["articletype"].ToInt32(1);
                string articleauthor = Request["articleauthor"].ToString();
                string articleresource = Request["articleresource"].ToString();
                string content = Request["content"].ToString();
                
                
                if (aid == 0)
                {

                    if (CurrentsUser.u_roleId!=4)
                    {
                        msg = -2;
                        return;
                    }
                    T_Article article = new T_Article();
                    article.a_title = articletitle;
                    article.a_type = articletype;
                    article.a_author = articleauthor;
                    article.a_resource = articleresource;
                    article.a_content = content;
                    article.a_publiserId = CurrentsUser.u_id;
                    article.a_createdTime = DateTime.Now;
                    int n =_ArticleService.Insert(article);
                    if (n > 0)
                    {

                        msg = 2;
                    }
                    else {
                        CurrentArticle = article;
                        msg = -2;
                    }


                }
                else {
                    if (CurrentsUser.u_roleId != 4)
                    {
                        msg = -1;
                        return;
                    }
                    CurrentArticle = _ArticleService.QuerySingle(aid);
                    CurrentArticle.a_title = articletitle;
                    CurrentArticle.a_type = articletype;
                    CurrentArticle.a_author = articleauthor;
                    CurrentArticle.a_resource = articleresource;
                    CurrentArticle.a_content = content;
                    CurrentArticle.a_publiserId = CurrentsUser.u_id;
                    CurrentArticle.a_createdTime = DateTime.Now;
                    int n = _ArticleService.Update(CurrentArticle);
                    if (n > 0)
                    {

                        msg = 1;
                    }
                    else
                    {
                        msg = -1;
                    }

                }
            }


            aid = Request["item"].ToInt32(0);
            if (aid > 0) {
                CurrentArticle = _ArticleService.QuerySingle(aid);
            }
            
        }
    }
}