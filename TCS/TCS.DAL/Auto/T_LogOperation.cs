using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using TCS.Model;
using TCS.Common;

namespace TCS.DAL
{
    public partial class T_LogOperationDAO
    {
        #region 向数据库中添加一条记录 +int Insert(T_LogOperation model)
        /// <summary>
        /// 向数据库中添加一条记录
        /// </summary>
        /// <param name="model">要添加的实体</param>
        /// <returns>插入数据的ID</returns>
        public int Insert(T_LogOperation model)
        {
            #region SQL语句
            const string sql = @"
INSERT INTO [dbo].[T_LogOperation] (
	[lo_operationTypeId]
	,[lo_operatorId]
	,[lo_createTime]
	,[lo_context]
)
VALUES (
	@lo_operationTypeId
	,@lo_operatorId
	,@lo_createTime
	,@lo_context
);select @@IDENTITY";
            #endregion
            var res = SqlHelper.ExecuteScalar(sql,
                    new SqlParameter("@lo_operationTypeId", model.lo_operationTypeId),
                    new SqlParameter("@lo_operatorId", model.lo_operatorId),
                    new SqlParameter("@lo_createTime", model.lo_createTime),
                    new SqlParameter("@lo_context", model.lo_context)
                );
            return res == null ? 0 : Convert.ToInt32(res);
        }
        #endregion

        #region 删除一条记录 +int Delete(int lo_id)
        public int Delete(int lo_id)
        {
            const string sql = "DELETE FROM [dbo].[T_LogOperation] WHERE [lo_id] = @lo_id";
            return SqlHelper.ExecuteNonQuery(sql, new SqlParameter("@lo_id", lo_id));
        }
        #endregion

        #region 根据主键ID更新一条记录 +int Update(T_LogOperation model)
        /// <summary>
        /// 根据主键ID更新一条记录
        /// </summary>
        /// <param name="model">更新后的实体</param>
        /// <returns>执行结果受影响行数</returns>
        public int Update(T_LogOperation model)
        {
            #region SQL语句
            const string sql = @"
UPDATE [dbo].[T_LogOperation]
SET 
	[lo_operationTypeId] = @lo_operationTypeId
	,[lo_operatorId] = @lo_operatorId
	,[lo_createTime] = @lo_createTime
	,[lo_context] = @lo_context
WHERE [lo_id] = @lo_id";
            #endregion
            return SqlHelper.ExecuteNonQuery(sql,
                    new SqlParameter("@lo_id", model.lo_id),
                    new SqlParameter("@lo_operationTypeId", model.lo_operationTypeId),
                    new SqlParameter("@lo_operatorId", model.lo_operatorId),
                    new SqlParameter("@lo_createTime", model.lo_createTime),
                    new SqlParameter("@lo_context", model.lo_context)
                );
        }
        #endregion

        #region 分页查询一个集合 +IEnumerable<T_LogOperation> QueryList(int index, int size, object wheres, string orderField, bool isDesc = true)
        /// <summary>
        /// 分页查询一个集合
        /// </summary>
        /// <param name="index">页码</param>
        /// <param name="size">页大小</param>
        /// <param name="wheres">条件匿名类</param>
        /// <param name="orderField">排序字段</param>
        /// <param name="isDesc">是否降序排序</param>
        /// <returns>实体集合</returns>
        public IEnumerable<T_LogOperation> QueryList(int index, int size, object wheres, string orderField, bool isDesc = true)
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
            var sql = SqlHelper.GenerateQuerySql("T_LogOperation", new[] { "lo_id", "lo_operationTypeId", "lo_operatorId", "lo_createTime", "lo_context" }, index, size, whereBuilder.ToString(), orderField, isDesc);
            using (var reader = SqlHelper.ExecuteReader(sql, parameters.ToArray()))
            {
                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        yield return SqlHelper.MapEntity<T_LogOperation>(reader);
                    }
                }
            }
        }
        #endregion

        #region 查询单个模型实体 +T_LogOperation QuerySingle(object wheres)
        /// <summary>
        /// 查询单个模型实体
        /// </summary>
        /// <param name="wheres">条件匿名类</param>
        /// <returns>实体</returns>
        public T_LogOperation QuerySingle(object wheres)
        {
            var list = QueryList(1, 1, wheres, null);
            return list != null && list.Any() ? list.FirstOrDefault() : null;
        }
        #endregion

        #region 查询单个模型实体 +T_LogOperation QuerySingle(int lo_id)
        /// <summary>
        /// 查询单个模型实体
        /// </summary>
        /// <param name="lo_id">key</param>
        /// <returns>实体</returns>
        public T_LogOperation QuerySingle(int lo_id)
        {
            const string sql = "SELECT TOP 1 [lo_id], [lo_operationTypeId], [lo_operatorId], [lo_createTime], [lo_context] FROM [dbo].[T_LogOperation] WHERE [lo_id] = @lo_id";
            using (var reader = SqlHelper.ExecuteReader(sql, new SqlParameter("@lo_id", lo_id)))
            {
                if (reader.HasRows)
                {
                    reader.Read();
                    return SqlHelper.MapEntity<T_LogOperation>(reader);
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
            var sql = SqlHelper.GenerateQuerySql("T_LogOperation", new[] { "COUNT(1)" }, whereBuilder.ToString(), string.Empty);
            var res = SqlHelper.ExecuteScalar(sql, parameters.ToArray());
            return res == null ? 0 : Convert.ToInt32(res);
        }
        #endregion
    }
}