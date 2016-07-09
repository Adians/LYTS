using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using TCS.Model;
using TCS.Common;

namespace TCS.DAL
{
	public partial class T_RolesDAO
	{
        #region 向数据库中添加一条记录 +int Insert(T_Roles model)
        /// <summary>
        /// 向数据库中添加一条记录
        /// </summary>
        /// <param name="model">要添加的实体</param>
        /// <returns>插入数据的ID</returns>
        public int Insert(T_Roles model)
        {
            #region SQL语句
            const string sql = @"
INSERT INTO [dbo].[T_Roles] (
	[r_name]
	,[r_text]
	,[r_creatTime]
	,[r_creator]
)
VALUES (
	@r_name
	,@r_text
	,@r_creatTime
	,@r_creator
);select @@IDENTITY";
            #endregion
            var res = SqlHelper.ExecuteScalar(sql,
					new SqlParameter("@r_name", model.r_name),					
					new SqlParameter("@r_text", model.r_text),					
					new SqlParameter("@r_creatTime", model.r_creatTime),					
					new SqlParameter("@r_creator", model.r_creator)					
                );
            return res == null ? 0 : Convert.ToInt32(res);
        }
        #endregion

        #region 删除一条记录 +int Delete(int r_id)
        public int Delete(int r_id)
        {
            const string sql = "DELETE FROM [dbo].[T_Roles] WHERE [r_id] = @r_id";
            return SqlHelper.ExecuteNonQuery(sql, new SqlParameter("@r_id", r_id));
        }
        #endregion

        #region 根据主键ID更新一条记录 +int Update(T_Roles model)
        /// <summary>
        /// 根据主键ID更新一条记录
        /// </summary>
        /// <param name="model">更新后的实体</param>
        /// <returns>执行结果受影响行数</returns>
        public int Update(T_Roles model)
        {
            #region SQL语句
            const string sql = @"
UPDATE [dbo].[T_Roles]
SET 
	[r_name] = @r_name
	,[r_text] = @r_text
	,[r_creatTime] = @r_creatTime
	,[r_creator] = @r_creator
WHERE [r_id] = @r_id";
            #endregion
            return SqlHelper.ExecuteNonQuery(sql,
					new SqlParameter("@r_id", model.r_id),					
					new SqlParameter("@r_name", model.r_name),					
					new SqlParameter("@r_text", model.r_text),					
					new SqlParameter("@r_creatTime", model.r_creatTime),					
					new SqlParameter("@r_creator", model.r_creator)					
                );
        }
        #endregion

        #region 分页查询一个集合 +IEnumerable<T_Roles> QueryList(int index, int size, object wheres, string orderField, bool isDesc = true)
        /// <summary>
        /// 分页查询一个集合
        /// </summary>
        /// <param name="index">页码</param>
        /// <param name="size">页大小</param>
        /// <param name="wheres">条件匿名类</param>
        /// <param name="orderField">排序字段</param>
        /// <param name="isDesc">是否降序排序</param>
        /// <returns>实体集合</returns>
        public IEnumerable<T_Roles> QueryList(int index, int size, object wheres, string orderField, bool isDesc = true)
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
            var sql = SqlHelper.GenerateQuerySql("T_Roles", new[] { "r_id", "r_name", "r_text", "r_creatTime", "r_creator" }, index, size, whereBuilder.ToString(), orderField, isDesc);
            using (var reader = SqlHelper.ExecuteReader(sql, parameters.ToArray()))
            {
                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        yield return SqlHelper.MapEntity<T_Roles>(reader);
                    }
                }
            }
        }
        #endregion

        #region 查询单个模型实体 +T_Roles QuerySingle(object wheres)
        /// <summary>
        /// 查询单个模型实体
        /// </summary>
        /// <param name="wheres">条件匿名类</param>
        /// <returns>实体</returns>
        public T_Roles QuerySingle(object wheres)
        {
            var list = QueryList(1, 1, wheres, null);
            return list != null && list.Any() ? list.FirstOrDefault() : null;
        }
        #endregion

        #region 查询单个模型实体 +T_Roles QuerySingle(int r_id)
        /// <summary>
        /// 查询单个模型实体
        /// </summary>
        /// <param name="r_id">key</param>
        /// <returns>实体</returns>
        public T_Roles QuerySingle(int r_id)
        {
            const string sql = "SELECT TOP 1 [r_id], [r_name], [r_text], [r_creatTime], [r_creator] FROM [dbo].[T_Roles] WHERE [r_id] = @r_id";
            using (var reader = SqlHelper.ExecuteReader(sql, new SqlParameter("@r_id", r_id)))
            {
                if (reader.HasRows)
                {
                    reader.Read();
                    return SqlHelper.MapEntity<T_Roles>(reader);
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
            var sql = SqlHelper.GenerateQuerySql("T_Roles", new[] { "COUNT(1)" }, whereBuilder.ToString(), string.Empty);
            var res = SqlHelper.ExecuteScalar(sql, parameters.ToArray());
            return res == null ? 0 : Convert.ToInt32(res);
        }
        #endregion
	}
}