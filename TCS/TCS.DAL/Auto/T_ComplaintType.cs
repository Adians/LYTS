using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using TCS.Model;
using TCS.Common;

namespace TCS.DAL
{
    public partial class T_ComplaintTypeDAO
    {
        #region 向数据库中添加一条记录 +int Insert(T_ComplaintType model)
        /// <summary>
        /// 向数据库中添加一条记录
        /// </summary>
        /// <param name="model">要添加的实体</param>
        /// <returns>插入数据的ID</returns>
        public int Insert(T_ComplaintType model)
        {
            #region SQL语句
            const string sql = @"
INSERT INTO [dbo].[T_ComplaintType] (
	[ct_name]
	,[ct_creatorId]
	,[ct_createTime]
	,[ct_style]
	,[ct_icon]
)
VALUES (
	@ct_name
	,@ct_creatorId
	,@ct_createTime
	,@ct_style
	,@ct_icon
);select @@IDENTITY";
            #endregion
            var res = SqlHelper.ExecuteScalar(sql,
                    new SqlParameter("@ct_name", model.ct_name),
                    new SqlParameter("@ct_creatorId", model.ct_creatorId),
                    new SqlParameter("@ct_createTime", model.ct_createTime),
                    new SqlParameter("@ct_style", model.ct_style),
                    new SqlParameter("@ct_icon", model.ct_icon)
                );
            return res == null ? 0 : Convert.ToInt32(res);
        }
        #endregion

        #region 删除一条记录 +int Delete(int ct_id)
        public int Delete(int ct_id)
        {
            const string sql = "DELETE FROM [dbo].[T_ComplaintType] WHERE [ct_id] = @ct_id";
            return SqlHelper.ExecuteNonQuery(sql, new SqlParameter("@ct_id", ct_id));
        }
        #endregion

        #region 根据主键ID更新一条记录 +int Update(T_ComplaintType model)
        /// <summary>
        /// 根据主键ID更新一条记录
        /// </summary>
        /// <param name="model">更新后的实体</param>
        /// <returns>执行结果受影响行数</returns>
        public int Update(T_ComplaintType model)
        {
            #region SQL语句
            const string sql = @"
UPDATE [dbo].[T_ComplaintType]
SET 
	[ct_name] = @ct_name
	,[ct_creatorId] = @ct_creatorId
	,[ct_createTime] = @ct_createTime
	,[ct_style] = @ct_style
	,[ct_icon] = @ct_icon
WHERE [ct_id] = @ct_id";
            #endregion
            return SqlHelper.ExecuteNonQuery(sql,
                    new SqlParameter("@ct_id", model.ct_id),
                    new SqlParameter("@ct_name", model.ct_name),
                    new SqlParameter("@ct_creatorId", model.ct_creatorId),
                    new SqlParameter("@ct_createTime", model.ct_createTime),
                    new SqlParameter("@ct_style", model.ct_style),
                    new SqlParameter("@ct_icon", model.ct_icon)
                );
        }
        #endregion

        #region 分页查询一个集合 +IEnumerable<T_ComplaintType> QueryList(int index, int size, object wheres, string orderField, bool isDesc = true)
        /// <summary>
        /// 分页查询一个集合
        /// </summary>
        /// <param name="index">页码</param>
        /// <param name="size">页大小</param>
        /// <param name="wheres">条件匿名类</param>
        /// <param name="orderField">排序字段</param>
        /// <param name="isDesc">是否降序排序</param>
        /// <returns>实体集合</returns>
        public IEnumerable<T_ComplaintType> QueryList(int index, int size, object wheres, string orderField, bool isDesc = true)
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
            var sql = SqlHelper.GenerateQuerySql("T_ComplaintType", new[] { "ct_id", "ct_name", "ct_creatorId", "ct_createTime", "ct_style", "ct_icon" }, index, size, whereBuilder.ToString(), orderField, isDesc);
            using (var reader = SqlHelper.ExecuteReader(sql, parameters.ToArray()))
            {
                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        yield return SqlHelper.MapEntity<T_ComplaintType>(reader);
                    }
                }
            }
        }
        #endregion

        #region 查询单个模型实体 +T_ComplaintType QuerySingle(object wheres)
        /// <summary>
        /// 查询单个模型实体
        /// </summary>
        /// <param name="wheres">条件匿名类</param>
        /// <returns>实体</returns>
        public T_ComplaintType QuerySingle(object wheres)
        {
            var list = QueryList(1, 1, wheres, null);
            return list != null && list.Any() ? list.FirstOrDefault() : null;
        }
        #endregion

        #region 查询单个模型实体 +T_ComplaintType QuerySingle(int ct_id)
        /// <summary>
        /// 查询单个模型实体
        /// </summary>
        /// <param name="ct_id">key</param>
        /// <returns>实体</returns>
        public T_ComplaintType QuerySingle(int ct_id)
        {
            const string sql = "SELECT TOP 1 [ct_id], [ct_name], [ct_creatorId], [ct_createTime], [ct_style], [ct_icon] FROM [dbo].[T_ComplaintType] WHERE [ct_id] = @ct_id";
            using (var reader = SqlHelper.ExecuteReader(sql, new SqlParameter("@ct_id", ct_id)))
            {
                if (reader.HasRows)
                {
                    reader.Read();
                    return SqlHelper.MapEntity<T_ComplaintType>(reader);
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
            var sql = SqlHelper.GenerateQuerySql("T_ComplaintType", new[] { "COUNT(1)" }, whereBuilder.ToString(), string.Empty);
            var res = SqlHelper.ExecuteScalar(sql, parameters.ToArray());
            return res == null ? 0 : Convert.ToInt32(res);
        }
        #endregion
    }
}