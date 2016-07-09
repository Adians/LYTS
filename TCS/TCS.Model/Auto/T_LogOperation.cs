using System;
namespace TCS.Model
{
    public class T_LogOperation
    {

        /// <summary>
        /// lo_id
        /// </summary>
        public int lo_id { get; set; }
        /// <summary>
        /// lo_operationTypeId
        /// </summary>
        public int lo_operationTypeId { get; set; }
        /// <summary>
        /// lo_operatorId
        /// </summary>
        public int lo_operatorId { get; set; }
        /// <summary>
        /// lo_createTime
        /// </summary>
        public DateTime lo_createTime { get; set; }
        /// <summary>
        /// lo_context
        /// </summary>
        public string lo_context { get; set; }

    }
}

