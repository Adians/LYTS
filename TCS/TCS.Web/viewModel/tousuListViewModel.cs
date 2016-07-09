using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TCS.Web.viewModel
{
    public class tousuListViewModel
    {
        /// <summary>
        /// c_id
        /// </summary>
        public int ID { get; set; }
        /// <summary>
        /// u_id
        /// </summary>
        public int UID { get; set; }
        /// <summary>
        /// orderNo 序号
        /// </summary>
        public int ORDERNO { get; set; }
        /// <summary>
        /// c_submitTime
        /// </summary>
        public string SUBMITTIME { get; set; }
        /// <summary>
        /// c_uId
        /// </summary>
        public string UNAME{ get; set; }
        /// <summary>
        /// c_title
        /// </summary>
        public string TITLE { get; set; }

        /// <summary>
        /// c_typeId
        /// </summary>
        public string TYPENAME { get; set; }
        /// <summary>
        /// c_status
        /// </summary>
        public string STATUSNAME { get; set; }
        /// <summary>
        /// c_responderId
        /// </summary>
        public string RESPONDER { get; set; }
        /// <summary>
        /// c_responseContent
        /// </summary>
        public string RESPONSECONTENT { get; set; }
        /// <summary>
        /// c_responseTime
        /// </summary>
        public string RESPONSETIME { get; set; }
        /// <summary>
        /// c_inspectorId
        /// </summary>
        public string INSPECTOR { get; set; }
        /// <summary>
        /// c_inspectResult
        /// </summary>
        public string INSPECTRESULT { get; set; }
        /// <summary>
        /// c_inspectRemark
        /// </summary>
        public string INSPECTREMARK { get; set; }
        /// <summary>
        /// c_inspectTime
        /// </summary>
        public string INSPECTTIME { get; set; }

    }
}