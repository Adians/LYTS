using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TCS.Web.viewModel
{
    public class tousuDiscussViewModel
    {
        /// <summary>
		/// cd_id
        /// </summary>
        public int cd_id { get; set; }
        
        /// <summary>
        /// cd_uid
        /// </summary>
        public string cd_uname { get; set; }
        /// <summary>
        /// cd_discOrder
        /// </summary>
        public int cd_discOrder { get; set; }
        
        /// <summary>
        /// cd_discContent
        /// </summary>
        public string cd_discContent { get; set; }
        /// <summary>
        /// cd_discTime
        /// </summary>
        public string cd_discTime { get; set; }
    }
}