using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TCS.Web.viewModel
{
    public class userListViewModel
    {
        /// <summary>
        /// u_id
        /// </summary>
        public int ID { get; set; }

        /// <summary>
        /// ORDERNO
        /// </summary>
        public int ORDERNO { get; set; }
        /// <summary>
        /// u_loginName
        /// </summary>
        public string LOGINNAME { get; set; }
        /// <summary>
        /// u_password
        /// </summary>
        public string PASSWORD { get; set; }
        /// <summary>
        /// u_nickName
        /// </summary>
        public string NICKNAME { get; set; }
        /// <summary>
        /// u_roleId
        /// </summary>
        public string ROLE { get; set; }
        /// <summary>
        /// u_regTime
        /// </summary>
        public string REGTIME { get; set; }
        /// <summary>
        /// u_email
        /// </summary>
        public string EMAIL { get; set; }
       
        /// <summary>
        /// u_lastLoginTime
        /// </summary>
        public string LASTLOGINTIME { get; set; }
        /// <summary>
        /// u_sex
        /// </summary>
        public string SEX { get; set; }
        /// <summary>
        /// u_phoneNo
        /// </summary>
        public string PHONE { get; set; }
        /// <summary>
        /// u_realName
        /// </summary>
        public string REALNAME { get; set; }
        /// <summary>
        /// u_status
        /// </summary>
        public string STATUE { get; set; }
    }
}