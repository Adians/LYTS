﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace TCS.Common
{
    using System;
    using System.Text;
    /// <summary>
    /// 分页助手类
    /// </summary>
    public static class PagerHelper
    {
        #region 生成分页HTML代码 +static string GetPager(string format, int totalPages, int current = 1, int showCount = 9)
        /// <summary>
        /// 生成分页HTML代码
        /// </summary>
        /// <remarks>
        /// 2012年10月30日 18:02:07 创建方法 汪磊
        /// </remarks>
        /// <param name="format">当前URL格式其中分页位置用@代替</param>
        /// <param name="totalPages">总页数</param>
        /// <param name="current">当前页码</param>
        /// <param name="showCount">显示几个页码</param>
        /// <example>
        /// <code>
        ///     <div><%=PagerHelper.RenderPager("http://www.wedn.net/479-489-497-0-0-0-0-0-0-0-0-6-@-0-0-0-0-0-0/",10,1,11)%></div>
        /// </code>
        /// </example>
        /// <returns>分页HTML代码</returns>
        public static string RenderPager(string format, int totalPages, int current = 1, int showCount = 9, string ulContainerClass = "pagination", string activeLiClass = "active", char separator = '@')
        {
            var tempFormats = format.Split(separator);
            // url 前缀
            var prefix = tempFormats[0];
            // url 后缀
            var suffix = tempFormats.Length > 1 ? tempFormats[1] : string.Empty;
            // var totalPages = Math.Max((totalCount + pageSize - 1) / pageSize, 1); //总页数
            // 左右区间
            var region = (int)Math.Floor(showCount / 2.0);
            // 开始页码数
            var beginNum = current - region <= 0 ? 1 : current - region;
            // 结束页码数
            var endNum = beginNum + showCount;
            if (endNum > totalPages)
            {
                endNum = totalPages + 1;
                beginNum = endNum - showCount;
                beginNum = beginNum < 1 ? 1 : beginNum;
            }
            var pager = new StringBuilder(string.Format("<ul class=\"{0}\">\r\n", ulContainerClass));
            if (current != 1)
            {
                pager.AppendFormat("\t<li><a href=\"{1}{0}\">上一页</a></li>\r\n", current - 1, prefix);
            }
            if (beginNum != 1)
            {
                pager.Append("\t<li><span>&hellip;</span></li>\r\n");
            }
            for (var i = beginNum; i < endNum; i++)
            {
                if (i != current)
                {
                    pager.AppendFormat("\t<li><a href=\"{1}{0}\">{0}</a></li>\r\n", i, prefix);
                }
                else
                {
                    pager.AppendFormat("\t<li class=\"active\"><span>{0}</span></li>\r\n", current);
                }
            }
            if (endNum != totalPages + 1)
            {
                pager.Append("\t<li><span>&hellip;</span></li>\r\n");
            }
            if (current != totalPages)
            {
                pager.AppendFormat("\t<li><a href=\"{1}{0}\">下一页</a></li>\r\n", current + 1, prefix);
            }
            pager.Append("</ul>");
            return pager.ToString();
        }
        #endregion
    }

}
