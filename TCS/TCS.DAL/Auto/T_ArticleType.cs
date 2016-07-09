using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using TCS.Model;
using TCS.Common;

namespace TCS.DAL
{
	public partial class T_ArticleTypeDAO
	{
        #region 向数据库中添加一条记录 +int Insert(T_ArticleType model)
        /// <summary>
        /// 向数据库中添加一条记录
        /// </summary>
        /// <param name="model">要添加的实体</param>
        /// <returns>插入数据的ID</returns>
        public int Insert(T_ArticleType model)
        {
            #region SQL语句
            const string sql = @"
INSERT INTO [dbo].[T_ArticleType] (
	[at_name]
	,[at_createTime]
	,[at_creator]
)
VALUES (
	@at_name
	,@at_createTime
	,@at_creator
);select @@IDENTITY";
            #endregion
            var res = SqlHelper.ExecuteScalar(sql,
					new SqlParameter("@at_name", model.at_name),					
					new SqlParameter("@at_createTime", model.at_createTime),					
					new SqlParameter("@at_creator", model.at_creator)					
                );
            return res == null ? 0 : Convert.ToInt32(res);
        }
        #endregion

        #region 删除一条记录 +int Delete(int at_id)
        public int Delete(int at_id)
        {
            const string sql = "DELETE FROM [dbo].[T_ArticleType] WHERE [at_id] = @at_id";
            return SqlHelper.ExecuteNonQuery(sql, new SqlParameter("@at_id", at_id));
        }
        #endregion

        #region 根据主键ID更新一条记录 +int Update(T_ArticleType model)
        /// <summary>
        /// 根据主键ID更新一条记录
        /// </summary>
        /// <param name="model">更新后的实体</param>
        /// <returns>执行结果受影响行数</returns>
        public int Update(T_ArticleType model)
        {
            #region SQL语句
            const string sql = @"
UPDATE [dbo].[T_ArticleType]
SET 
	[at_name] = @at_name
	,[at_createTime] = @at_createTime
	,[at_creator] = @at_creator
WHERE [at_id] = @at_id";
            #endregion
            return SqlHelper.ExecuteNonQuery(sql,
					new SqlParameter("@at_id", model.at_id),					
					new SqlParameter("@at_name", model.at_name),					
					new SqlParameter("@at_createTime", model.at_createTime),					
					new SqlParameter("@at_creator", model.at_creator)					
                );
        }
        #endregion

        #region 分页查询一个集合 +IEnumerable<T_ArticleType> QueryList(int index, int size, object wheres, string orderField, bool isDesc = true)
        /// <summary>
        /// 分页查询一个集合
        /// </summary>
        /// <param name="index">页码</param>
        /// <param name="size">页大小</param>
        /// <param name="wheres">条件匿名类</param>
        /// <param name="orderField">排序字段</param>
        /// <param name="isDesc">是否降序排序</param>
        /// <returns>实体集合</returns>
        public IEnumerable<T_ArticleType> QueryList(int index, int size, object wheres, string orderField, bool isDesc = true)
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
            var sql = SqlHelper.GenerateQuerySql("T_ArticleType", new[] { "at_id", "at_name", "at_createTime", "at_creator" }, index, size, whereBuilder.ToString(), orderField, isDesc);
            using (var reader = SqlHelper.ExecuteReader(sql, parameters.ToArray()))
            {
                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        yield return SqlHelper.MapEntity<T_ArticleType>(reader);
                    }
                }
            }
        }
        #endregion

        #region 查询单个模型实体 +T_ArticleType QuerySingle(object wheres)
        /// <summary>
        /// 查询单个模型实体
        /// </summary>
        /// <param name="wheres">条件匿名类</param>
        /// <returns>实体</returns>
        public T_ArticleType QuerySingle(object wheres)
        {
            var list = QueryList(1, 1, wheres, null);
            return list != null && list.Any() ? list.FirstOrDefault() : null;
        }
        #endregion

        #region 查询单个模型实体 +T_ArticleType QuerySingle(int at_id)
        /// <summary>
        /// 查询单个模型实体
        /// </summary>
        /// <param name="at_id">key</param>
        /// <returns>实体</returns>
        public T_ArticleType QuerySingle(int at_id)
        {
            const string sql = "SELECT TOP 1 [at_id], [at_name], [at_createTime], [at_creator] FROM [dbo].[T_ArticleType] WHERE [at_id] = @at_id";
            using (var reader = SqlHelper.ExecuteReader(sql, new SqlParameter("@at_id", at_id)))
            {
                if (reader.HasRows)
                {
                    reader.Read();
                    return SqlHelper.MapEntity<T_ArticleType>(reader);
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
            var sql = SqlHelper.GenerateQuerySql("T_ArticleType", new[] { "COUNT(1)" }, whereBuilder.ToString(), string.Empty);
            var res = SqlHelper.ExecuteScalar(sql, parameters.ToArray());
            return res == null ? 0 : Convert.ToInt32(res);
        }
        #endregion
	}
}