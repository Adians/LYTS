using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using TCS.Model;
using TCS.Common;

namespace TCS.DAL
{
	public partial class T_ComplaintDiscussDAO
	{
        #region 向数据库中添加一条记录 +int Insert(T_ComplaintDiscuss model)
        /// <summary>
        /// 向数据库中添加一条记录
        /// </summary>
        /// <param name="model">要添加的实体</param>
        /// <returns>插入数据的ID</returns>
        public int Insert(T_ComplaintDiscuss model)
        {
            #region SQL语句
            const string sql = @"
INSERT INTO [dbo].[T_ComplaintDiscuss] (
	[cd_cid]
	,[cd_uid]
	,[cd_discOrder]
	,[cd_parentId]
	,[cd_discContent]
	,[cd_discTime]
)
VALUES (
	@cd_cid
	,@cd_uid
	,@cd_discOrder
	,@cd_parentId
	,@cd_discContent
	,@cd_discTime
);select @@IDENTITY";
            #endregion
            var res = SqlHelper.ExecuteScalar(sql,
					new SqlParameter("@cd_cid", model.cd_cid),					
					new SqlParameter("@cd_uid", model.cd_uid),					
					new SqlParameter("@cd_discOrder", model.cd_discOrder),					
					new SqlParameter("@cd_parentId", model.cd_parentId),					
					new SqlParameter("@cd_discContent", model.cd_discContent),					
					new SqlParameter("@cd_discTime", model.cd_discTime)					
                );
            return res == null ? 0 : Convert.ToInt32(res);
        }
        #endregion

        #region 删除一条记录 +int Delete(int cd_id)
        public int Delete(int cd_id)
        {
            const string sql = "DELETE FROM [dbo].[T_ComplaintDiscuss] WHERE [cd_id] = @cd_id";
            return SqlHelper.ExecuteNonQuery(sql, new SqlParameter("@cd_id", cd_id));
        }
        #endregion

        #region 根据主键ID更新一条记录 +int Update(T_ComplaintDiscuss model)
        /// <summary>
        /// 根据主键ID更新一条记录
        /// </summary>
        /// <param name="model">更新后的实体</param>
        /// <returns>执行结果受影响行数</returns>
        public int Update(T_ComplaintDiscuss model)
        {
            #region SQL语句
            const string sql = @"
UPDATE [dbo].[T_ComplaintDiscuss]
SET 
	[cd_cid] = @cd_cid
	,[cd_uid] = @cd_uid
	,[cd_discOrder] = @cd_discOrder
	,[cd_parentId] = @cd_parentId
	,[cd_discContent] = @cd_discContent
	,[cd_discTime] = @cd_discTime
WHERE [cd_id] = @cd_id";
            #endregion
            return SqlHelper.ExecuteNonQuery(sql,
					new SqlParameter("@cd_id", model.cd_id),					
					new SqlParameter("@cd_cid", model.cd_cid),					
					new SqlParameter("@cd_uid", model.cd_uid),					
					new SqlParameter("@cd_discOrder", model.cd_discOrder),					
					new SqlParameter("@cd_parentId", model.cd_parentId),					
					new SqlParameter("@cd_discContent", model.cd_discContent),					
					new SqlParameter("@cd_discTime", model.cd_discTime)					
                );
        }
        #endregion

        #region 分页查询一个集合 +IEnumerable<T_ComplaintDiscuss> QueryList(int index, int size, object wheres, string orderField, bool isDesc = true)
        /// <summary>
        /// 分页查询一个集合
        /// </summary>
        /// <param name="index">页码</param>
        /// <param name="size">页大小</param>
        /// <param name="wheres">条件匿名类</param>
        /// <param name="orderField">排序字段</param>
        /// <param name="isDesc">是否降序排序</param>
        /// <returns>实体集合</returns>
        public IEnumerable<T_ComplaintDiscuss> QueryList(int index, int size, object wheres, string orderField, bool isDesc = true)
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
            var sql = SqlHelper.GenerateQuerySql("T_ComplaintDiscuss", new[] { "cd_id", "cd_cid", "cd_uid", "cd_discOrder", "cd_parentId", "cd_discContent", "cd_discTime" }, index, size, whereBuilder.ToString(), orderField, isDesc);
            using (var reader = SqlHelper.ExecuteReader(sql, parameters.ToArray()))
            {
                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        yield return SqlHelper.MapEntity<T_ComplaintDiscuss>(reader);
                    }
                }
            }
        }
        #endregion

        #region 查询单个模型实体 +T_ComplaintDiscuss QuerySingle(object wheres)
        /// <summary>
        /// 查询单个模型实体
        /// </summary>
        /// <param name="wheres">条件匿名类</param>
        /// <returns>实体</returns>
        public T_ComplaintDiscuss QuerySingle(object wheres)
        {
            var list = QueryList(1, 1, wheres, null);
            return list != null && list.Any() ? list.FirstOrDefault() : null;
        }
        #endregion

        #region 查询单个模型实体 +T_ComplaintDiscuss QuerySingle(int cd_id)
        /// <summary>
        /// 查询单个模型实体
        /// </summary>
        /// <param name="cd_id">key</param>
        /// <returns>实体</returns>
        public T_ComplaintDiscuss QuerySingle(int cd_id)
        {
            const string sql = "SELECT TOP 1 [cd_id], [cd_cid], [cd_uid], [cd_discOrder], [cd_parentId], [cd_discContent], [cd_discTime] FROM [dbo].[T_ComplaintDiscuss] WHERE [cd_id] = @cd_id";
            using (var reader = SqlHelper.ExecuteReader(sql, new SqlParameter("@cd_id", cd_id)))
            {
                if (reader.HasRows)
                {
                    reader.Read();
                    return SqlHelper.MapEntity<T_ComplaintDiscuss>(reader);
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
            var sql = SqlHelper.GenerateQuerySql("T_ComplaintDiscuss", new[] { "COUNT(1)" }, whereBuilder.ToString(), string.Empty);
            var res = SqlHelper.ExecuteScalar(sql, parameters.ToArray());
            return res == null ? 0 : Convert.ToInt32(res);
        }
        #endregion
	}
}