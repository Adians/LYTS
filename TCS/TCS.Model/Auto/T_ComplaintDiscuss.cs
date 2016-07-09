using System; 
namespace TCS.Model
{
	public class T_ComplaintDiscuss
	{
   		     
      	/// <summary>
		/// cd_id
        /// </summary>
        public int cd_id { get; set; }
		/// <summary>
		/// cd_cid
        /// </summary>
        public int cd_cid { get; set; }
		/// <summary>
		/// cd_uid
        /// </summary>
        public int cd_uid { get; set; }
		/// <summary>
		/// cd_discOrder
        /// </summary>
        public int cd_discOrder { get; set; }
		/// <summary>
		/// cd_parentId
        /// </summary>
        public int cd_parentId { get; set; }
		/// <summary>
		/// cd_discContent
        /// </summary>
        public string cd_discContent { get; set; }
		/// <summary>
		/// cd_discTime
        /// </summary>
        public DateTime cd_discTime { get; set; }
		   
	}
}

