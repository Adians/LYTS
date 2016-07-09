using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using TCS.Model;
using TCS.Common;

namespace TCS.DAL
{
	public partial class T_ArticleDAO
	{
        #region 向数据库中添加一条记录 +int Insert(T_Article model)
        /// <summary>
        /// 向数据库中添加一条记录
        /// </summary>
        /// <param name="model">要添加的实体</param>
        /// <returns>插入数据的ID</returns>
        public int Insert(T_Article model)
        {
            #region SQL语句
            const string sql = @"
INSERT INTO [dbo].[T_Article] (
	[a_title]
	,[a_content]
	,[a_createdTime]
	,[a_type]
	,[a_author]
	,[a_resource]
	,[a_publiserId]
)
VALUES (
	@a_title
	,@a_content
	,@a_createdTime
	,@a_type
	,@a_author
	,@a_resource
	,@a_publiserId
);select @@IDENTITY";
            #endregion
            var res = SqlHelper.ExecuteScalar(sql,
					new SqlParameter("@a_title", model.a_title),					
					new SqlParameter("@a_content", model.a_content),					
					new SqlParameter("@a_createdTime", model.a_createdTime),					
					new SqlParameter("@a_type", model.a_type),					
					new SqlParameter("@a_author", model.a_author),					
					new SqlParameter("@a_resource", model.a_resource),					
					new SqlParameter("@a_publiserId", model.a_publiserId)					
                );
            return res == null ? 0 : Convert.ToInt32(res);
        }
        #endregion

        #region 删除一条记录 +int Delete(int a_id)
        public int Delete(int a_id)
        {
            const string sql = "DELETE FROM [dbo].[T_Article] WHERE [a_id] = @a_id";
            return SqlHelper.ExecuteNonQuery(sql, new SqlParameter("@a_id", a_id));
        }
        #endregion

        #region 根据主键ID更新一条记录 +int Update(T_Article model)
        /// <summary>
        /// 根据主键ID更新一条记录
        /// </summary>
        /// <param name="model">更新后的实体</param>
        /// <returns>执行结果受影响行数</returns>
        public int Update(T_Article model)
        {
            #region SQL语句
            const string sql = @"
UPDATE [dbo].[T_Article]
SET 
	[a_title] = @a_title
	,[a_content] = @a_content
	,[a_createdTime] = @a_createdTime
	,[a_type] = @a_type
	,[a_author] = @a_author
	,[a_resource] = @a_resource
	,[a_publiserId] = @a_publiserId
WHERE [a_id] = @a_id";
            #endregion
            return SqlHelper.ExecuteNonQuery(sql,
					new SqlParameter("@a_id", model.a_id),					
					new SqlParameter("@a_title", model.a_title),					
					new SqlParameter("@a_content", model.a_content),					
					new SqlParameter("@a_createdTime", model.a_createdTime),					
					new SqlParameter("@a_type", model.a_type),					
					new SqlParameter("@a_author", model.a_author),					
					new SqlParameter("@a_resource", model.a_resource),					
					new SqlParameter("@a_publiserId", model.a_publiserId)					
                );
        }
        #endregion

        #region 分页查询一个集合 +IEnumerable<T_Article> QueryList(int index, int size, object wheres, string orderField, bool isDesc = true)
        /// <summary>
        /// 分页查询一个集合
        /// </summary>
        /// <param name="index">页码</param>
        /// <param name="size">页大小</param>
        /// <param name="wheres">条件匿名类</param>
        /// <param name="orderField">排序字段</param>
        /// <param name="isDesc">是否降序排序</param>
        /// <returns>实体集合</returns>
        public IEnumerable<T_Article> QueryList(int index, int size, object wheres, string orderField, bool isDesc = true)
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
            var sql = SqlHelper.GenerateQuerySql("T_Article", new[] { "a_id", "a_title", "a_content", "a_createdTime", "a_type", "a_author", "a_resource", "a_publiserId" }, index, size, whereBuilder.ToString(), orderField, isDesc);
            using (var reader = SqlHelper.ExecuteReader(sql, parameters.ToArray()))
            {
                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        yield return SqlHelper.MapEntity<T_Article>(reader);
                    }
                }
            }
        }
        #endregion

        #region 查询单个模型实体 +T_Article QuerySingle(object wheres)
        /// <summary>
        /// 查询单个模型实体
        /// </summary>
        /// <param name="wheres">条件匿名类</param>
        /// <returns>实体</returns>
        public T_Article QuerySingle(object wheres)
        {
            var list = QueryList(1, 1, wheres, null);
            return list != null && list.Any() ? list.FirstOrDefault() : null;
        }
        #endregion

        #region 查询单个模型实体 +T_Article QuerySingle(int a_id)
        /// <summary>
        /// 查询单个模型实体
        /// </summary>
        /// <param name="a_id">key</param>
        /// <returns>实体</returns>
        public T_Article QuerySingle(int a_id)
        {
            const string sql = "SELECT TOP 1 [a_id], [a_title], [a_content], [a_createdTime], [a_type], [a_author], [a_resource], [a_publiserId] FROM [dbo].[T_Article] WHERE [a_id] = @a_id";
            using (var reader = SqlHelper.ExecuteReader(sql, new SqlParameter("@a_id", a_id)))
            {
                if (reader.HasRows)
                {
                    reader.Read();
                    return SqlHelper.MapEntity<T_Article>(reader);
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
            var sql = SqlHelper.GenerateQuerySql("T_Article", new[] { "COUNT(1)" }, whereBuilder.ToString(), string.Empty);
            var res = SqlHelper.ExecuteScalar(sql, parameters.ToArray());
            return res == null ? 0 : Convert.ToInt32(res);
        }
        #endregion
	}
}