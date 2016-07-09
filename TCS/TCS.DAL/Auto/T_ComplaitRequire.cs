using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using TCS.Model;
using TCS.Common;

namespace TCS.DAL
{
	public partial class T_ComplaitRequireDAO
	{
        #region 向数据库中添加一条记录 +int Insert(T_ComplaitRequire model)
        /// <summary>
        /// 向数据库中添加一条记录
        /// </summary>
        /// <param name="model">要添加的实体</param>
        /// <returns>插入数据的ID</returns>
        public int Insert(T_ComplaitRequire model)
        {
            #region SQL语句
            const string sql = @"
INSERT INTO [dbo].[T_ComplaitRequire] (
	[cr_name]
	,[cr_createTime]
	,[cr_creator]
)
VALUES (
	@cr_name
	,@cr_createTime
	,@cr_creator
);select @@IDENTITY";
            #endregion
            var res = SqlHelper.ExecuteScalar(sql,
					new SqlParameter("@cr_name", model.cr_name),					
					new SqlParameter("@cr_createTime", model.cr_createTime),					
					new SqlParameter("@cr_creator", model.cr_creator)					
                );
            return res == null ? 0 : Convert.ToInt32(res);
        }
        #endregion

        #region 删除一条记录 +int Delete(int cr_id)
        public int Delete(int cr_id)
        {
            const string sql = "DELETE FROM [dbo].[T_ComplaitRequire] WHERE [cr_id] = @cr_id";
            return SqlHelper.ExecuteNonQuery(sql, new SqlParameter("@cr_id", cr_id));
        }
        #endregion

        #region 根据主键ID更新一条记录 +int Update(T_ComplaitRequire model)
        /// <summary>
        /// 根据主键ID更新一条记录
        /// </summary>
        /// <param name="model">更新后的实体</param>
        /// <returns>执行结果受影响行数</returns>
        public int Update(T_ComplaitRequire model)
        {
            #region SQL语句
            const string sql = @"
UPDATE [dbo].[T_ComplaitRequire]
SET 
	[cr_name] = @cr_name
	,[cr_createTime] = @cr_createTime
	,[cr_creator] = @cr_creator
WHERE [cr_id] = @cr_id";
            #endregion
            return SqlHelper.ExecuteNonQuery(sql,
					new SqlParameter("@cr_id", model.cr_id),					
					new SqlParameter("@cr_name", model.cr_name),					
					new SqlParameter("@cr_createTime", model.cr_createTime),					
					new SqlParameter("@cr_creator", model.cr_creator)					
                );
        }
        #endregion

        #region 分页查询一个集合 +IEnumerable<T_ComplaitRequire> QueryList(int index, int size, object wheres, string orderField, bool isDesc = true)
        /// <summary>
        /// 分页查询一个集合
        /// </summary>
        /// <param name="index">页码</param>
        /// <param name="size">页大小</param>
        /// <param name="wheres">条件匿名类</param>
        /// <param name="orderField">排序字段</param>
        /// <param name="isDesc">是否降序排序</param>
        /// <returns>实体集合</returns>
        public IEnumerable<T_ComplaitRequire> QueryList(int index, int size, object wheres, string orderField, bool isDesc = true)
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
            var sql = SqlHelper.GenerateQuerySql("T_ComplaitRequire", new[] { "cr_id", "cr_name", "cr_createTime", "cr_creator" }, index, size, whereBuilder.ToString(), orderField, isDesc);
            using (var reader = SqlHelper.ExecuteReader(sql, parameters.ToArray()))
            {
                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        yield return SqlHelper.MapEntity<T_ComplaitRequire>(reader);
                    }
                }
            }
        }
        #endregion

        #region 查询单个模型实体 +T_ComplaitRequire QuerySingle(object wheres)
        /// <summary>
        /// 查询单个模型实体
        /// </summary>
        /// <param name="wheres">条件匿名类</param>
        /// <returns>实体</returns>
        public T_ComplaitRequire QuerySingle(object wheres)
        {
            var list = QueryList(1, 1, wheres, null);
            return list != null && list.Any() ? list.FirstOrDefault() : null;
        }
        #endregion

        #region 查询单个模型实体 +T_ComplaitRequire QuerySingle(int cr_id)
        /// <summary>
        /// 查询单个模型实体
        /// </summary>
        /// <param name="cr_id">key</param>
        /// <returns>实体</returns>
        public T_ComplaitRequire QuerySingle(int cr_id)
        {
            const string sql = "SELECT TOP 1 [cr_id], [cr_name], [cr_createTime], [cr_creator] FROM [dbo].[T_ComplaitRequire] WHERE [cr_id] = @cr_id";
            using (var reader = SqlHelper.ExecuteReader(sql, new SqlParameter("@cr_id", cr_id)))
            {
                if (reader.HasRows)
                {
                    reader.Read();
                    return SqlHelper.MapEntity<T_ComplaitRequire>(reader);
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
            var sql = SqlHelper.GenerateQuerySql("T_ComplaitRequire", new[] { "COUNT(1)" }, whereBuilder.ToString(), string.Empty);
            var res = SqlHelper.ExecuteScalar(sql, parameters.ToArray());
            return res == null ? 0 : Convert.ToInt32(res);
        }
        #endregion
	}
}