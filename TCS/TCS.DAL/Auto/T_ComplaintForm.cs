using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using TCS.Model;
using TCS.Common;

namespace TCS.DAL
{
    public partial class T_ComplaintFormDAO
    {
        #region 向数据库中添加一条记录 +int Insert(T_ComplaintForm model)
        /// <summary>
        /// 向数据库中添加一条记录
        /// </summary>
        /// <param name="model">要添加的实体</param>
        /// <returns>插入数据的ID</returns>
        public int Insert(T_ComplaintForm model)
        {
            #region SQL语句
            const string sql = @"
INSERT INTO [dbo].[T_ComplaintForm] (
	[c_inspectResult]
	,[c_inspectRemark]
	,[c_inspectTime]
	,[c_status]
	,[c_commentScore]
	,[c_commentTime]
	,[c_title]
	,[c_requireId]
	,[c_picPath]
	,[c_commentText]
	,[c_uId]
	,[c_responderId]
	,[c_content]
	,[c_responseContent]
	,[c_typeId]
	,[c_submitTime]
	,[c_responseTime]
	,[c_inspectorId]
)
VALUES (
	@c_inspectResult
	,@c_inspectRemark
	,@c_inspectTime
	,@c_status
	,@c_commentScore
	,@c_commentTime
	,@c_title
	,@c_requireId
	,@c_picPath
	,@c_commentText
	,@c_uId
	,@c_responderId
	,@c_content
	,@c_responseContent
	,@c_typeId
	,@c_submitTime
	,@c_responseTime
	,@c_inspectorId
);select @@IDENTITY";
            #endregion
            var res = SqlHelper.ExecuteScalar(sql,
                    new SqlParameter("@c_inspectResult", model.c_inspectResult),
                    new SqlParameter("@c_inspectRemark", model.c_inspectRemark),
                    new SqlParameter("@c_inspectTime", model.c_inspectTime),
                    new SqlParameter("@c_status", model.c_status),
                    new SqlParameter("@c_commentScore", model.c_commentScore),
                    new SqlParameter("@c_commentTime", model.c_commentTime),
                    new SqlParameter("@c_title", model.c_title),
                    new SqlParameter("@c_requireId", model.c_requireId),
                    new SqlParameter("@c_picPath", model.c_picPath),
                    new SqlParameter("@c_commentText", model.c_commentText),
                    new SqlParameter("@c_uId", model.c_uId),
                    new SqlParameter("@c_responderId", model.c_responderId),
                    new SqlParameter("@c_content", model.c_content),
                    new SqlParameter("@c_responseContent", model.c_responseContent),
                    new SqlParameter("@c_typeId", model.c_typeId),
                    new SqlParameter("@c_submitTime", model.c_submitTime),
                    new SqlParameter("@c_responseTime", model.c_responseTime),
                    new SqlParameter("@c_inspectorId", model.c_inspectorId)
                );
            return res == null ? 0 : Convert.ToInt32(res);
        }
        #endregion

        #region 删除一条记录 +int Delete(int c_id)
        public int Delete(int c_id)
        {
            const string sql = "DELETE FROM [dbo].[T_ComplaintForm] WHERE [c_id] = @c_id";
            return SqlHelper.ExecuteNonQuery(sql, new SqlParameter("@c_id", c_id));
        }
        #endregion

        #region 根据主键ID更新一条记录 +int Update(T_ComplaintForm model)
        /// <summary>
        /// 根据主键ID更新一条记录
        /// </summary>
        /// <param name="model">更新后的实体</param>
        /// <returns>执行结果受影响行数</returns>
        public int Update(T_ComplaintForm model)
        {
            #region SQL语句
            const string sql = @"
UPDATE [dbo].[T_ComplaintForm]
SET 
	[c_inspectResult] = @c_inspectResult
	,[c_inspectRemark] = @c_inspectRemark
	,[c_inspectTime] = @c_inspectTime
	,[c_status] = @c_status
	,[c_commentScore] = @c_commentScore
	,[c_commentTime] = @c_commentTime
	,[c_title] = @c_title
	,[c_requireId] = @c_requireId
	,[c_picPath] = @c_picPath
	,[c_commentText] = @c_commentText
	,[c_uId] = @c_uId
	,[c_responderId] = @c_responderId
	,[c_content] = @c_content
	,[c_responseContent] = @c_responseContent
	,[c_typeId] = @c_typeId
	,[c_submitTime] = @c_submitTime
	,[c_responseTime] = @c_responseTime
	,[c_inspectorId] = @c_inspectorId
WHERE [c_id] = @c_id";
            #endregion
            return SqlHelper.ExecuteNonQuery(sql,
                    new SqlParameter("@c_id", model.c_id),
                    new SqlParameter("@c_inspectResult", model.c_inspectResult),
                    new SqlParameter("@c_inspectRemark", model.c_inspectRemark),
                    new SqlParameter("@c_inspectTime", model.c_inspectTime),
                    new SqlParameter("@c_status", model.c_status),
                    new SqlParameter("@c_commentScore", model.c_commentScore),
                    new SqlParameter("@c_commentTime", model.c_commentTime),
                    new SqlParameter("@c_title", model.c_title),
                    new SqlParameter("@c_requireId", model.c_requireId),
                    new SqlParameter("@c_picPath", model.c_picPath),
                    new SqlParameter("@c_commentText", model.c_commentText),
                    new SqlParameter("@c_uId", model.c_uId),
                    new SqlParameter("@c_responderId", model.c_responderId),
                    new SqlParameter("@c_content", model.c_content),
                    new SqlParameter("@c_responseContent", model.c_responseContent),
                    new SqlParameter("@c_typeId", model.c_typeId),
                    new SqlParameter("@c_submitTime", model.c_submitTime),
                    new SqlParameter("@c_responseTime", model.c_responseTime),
                    new SqlParameter("@c_inspectorId", model.c_inspectorId)
                );
        }
        #endregion

        #region 分页查询一个集合 +IEnumerable<T_ComplaintForm> QueryList(int index, int size, object wheres, string orderField, bool isDesc = true)
        /// <summary>
        /// 分页查询一个集合
        /// </summary>
        /// <param name="index">页码</param>
        /// <param name="size">页大小</param>
        /// <param name="wheres">条件匿名类</param>
        /// <param name="orderField">排序字段</param>
        /// <param name="isDesc">是否降序排序</param>
        /// <returns>实体集合</returns>
        public IEnumerable<T_ComplaintForm> QueryList(int index, int size, object wheres, string orderField, bool isDesc = true)
        {
            var parameters = new List<SqlParameter>();
            var whereBuilder = new System.Text.StringBuilder();
            if (wheres != null)
            {
                var props = wheres.GetType().GetProperties();
                foreach (var prop in props)
                {
                    if (prop.Name.Equals("__o", StringComparison.InvariantCultureIgnoreCase))
                    {
                        // 操作符
                        whereBuilder.AppendFormat(" {0} ", prop.GetValue(wheres, null).ToString());
                    }
                    else
                    {
                        var val = prop.GetValue(wheres, null).ToString();
                        whereBuilder.AppendFormat(" [{0}] = @{0} ", prop.Name);
                        parameters.Add(new SqlParameter("@" + prop.Name, val));
                    }
                }
            }
            var sql = SqlHelper.GenerateQuerySql("T_ComplaintForm", new[] { "c_id", "c_inspectResult", "c_inspectRemark", "c_inspectTime", "c_status", "c_commentScore", "c_commentTime", "c_title", "c_requireId", "c_picPath", "c_commentText", "c_uId", "c_responderId", "c_content", "c_responseContent", "c_typeId", "c_submitTime", "c_responseTime", "c_inspectorId" }, index, size, whereBuilder.ToString(), orderField, isDesc);
            using (var reader = SqlHelper.ExecuteReader(sql, parameters.ToArray()))
            {
                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        yield return SqlHelper.MapEntity<T_ComplaintForm>(reader);
                    }
                }
            }
        }
        #endregion

        #region 查询单个模型实体 +T_ComplaintForm QuerySingle(object wheres)
        /// <summary>
        /// 查询单个模型实体
        /// </summary>
        /// <param name="wheres">条件匿名类</param>
        /// <returns>实体</returns>
        public T_ComplaintForm QuerySingle(object wheres)
        {
            var list = QueryList(1, 1, wheres, null);
            return list != null && list.Any() ? list.FirstOrDefault() : null;
        }
        #endregion

        #region 查询单个模型实体 +T_ComplaintForm QuerySingle(int c_id)
        /// <summary>
        /// 查询单个模型实体
        /// </summary>
        /// <param name="c_id">key</param>
        /// <returns>实体</returns>
        public T_ComplaintForm QuerySingle(int c_id)
        {
            const string sql = "SELECT TOP 1 [c_id], [c_inspectResult], [c_inspectRemark], [c_inspectTime], [c_status], [c_commentScore], [c_commentTime], [c_title], [c_requireId], [c_picPath], [c_commentText], [c_uId], [c_responderId], [c_content], [c_responseContent], [c_typeId], [c_submitTime], [c_responseTime], [c_inspectorId] FROM [dbo].[T_ComplaintForm] WHERE [c_id] = @c_id";
            using (var reader = SqlHelper.ExecuteReader(sql, new SqlParameter("@c_id", c_id)))
            {
                if (reader.HasRows)
                {
                    reader.Read();
                    return SqlHelper.MapEntity<T_ComplaintForm>(reader);
                }
                else
                {
                    return null;
                }
            }
        }
        #endregion

        #region 查询条数 +int QueryCount(object wheres)
        /// <summary>
        /// 查询条数
        /// </summary>
        /// <param name="wheres">查询条件</param>
        /// <returns>条数</returns>
        public int QueryCount(object wheres)
        {
            var parameters = new List<SqlParameter>();
            var whereBuilder = new System.Text.StringBuilder();
            if (wheres != null)
            {
                var props = wheres.GetType().GetProperties();
                foreach (var prop in props)
                {
                    if (prop.Name.Equals("__o", StringComparison.InvariantCultureIgnoreCase))
                    {
                        // 操作符
                        whereBuilder.AppendFormat(" {0} ", prop.GetValue(wheres, null).ToString());
                    }
                    else
                    {
                        var val = prop.GetValue(wheres, null).ToString();
                        whereBuilder.AppendFormat(" [{0}] = @{0} ", prop.Name);
                        parameters.Add(new SqlParameter("@" + prop.Name, val));
                    }
                }
            }
            var sql = SqlHelper.GenerateQuerySql("T_ComplaintForm", new[] { "COUNT(1)" }, whereBuilder.ToString(), string.Empty);
            var res = SqlHelper.ExecuteScalar(sql, parameters.ToArray());
            return res == null ? 0 : Convert.ToInt32(res);
        }
        #endregion
    }
}