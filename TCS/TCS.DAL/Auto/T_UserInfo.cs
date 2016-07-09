using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using TCS.Model;
using TCS.Common;

namespace TCS.DAL
{
    public partial class T_UserInfoDAO
    {
        #region 向数据库中添加一条记录 +int Insert(T_UserInfo model)
        /// <summary>
        /// 向数据库中添加一条记录
        /// </summary>
        /// <param name="model">要添加的实体</param>
        /// <returns>插入数据的ID</returns>
        public int Insert(T_UserInfo model)
        {
            #region SQL语句
            const string sql = @"
INSERT INTO [dbo].[T_UserInfo] (
	[u_sex]
	,[u_phoneNo]
	,[u_realName]
	,[u_status]
	,[u_pic]
	,[u_loginName]
	,[u_password]
	,[u_nickName]
	,[u_roleId]
	,[u_regTime]
	,[u_email]
	,[u_loginTime]
	,[u_lastLoginTime]
)
VALUES (
	@u_sex
	,@u_phoneNo
	,@u_realName
	,@u_status
	,@u_pic
	,@u_loginName
	,@u_password
	,@u_nickName
	,@u_roleId
	,@u_regTime
	,@u_email
	,@u_loginTime
	,@u_lastLoginTime
);select @@IDENTITY";
            #endregion
            var res = SqlHelper.ExecuteScalar(sql,
                    new SqlParameter("@u_sex", model.u_sex),
                    new SqlParameter("@u_phoneNo", model.u_phoneNo),
                    new SqlParameter("@u_realName", model.u_realName),
                    new SqlParameter("@u_status", model.u_status),
                    new SqlParameter("@u_pic", model.u_pic),
                    new SqlParameter("@u_loginName", model.u_loginName),
                    new SqlParameter("@u_password", model.u_password),
                    new SqlParameter("@u_nickName", model.u_nickName),
                    new SqlParameter("@u_roleId", model.u_roleId),
                    new SqlParameter("@u_regTime", model.u_regTime),
                    new SqlParameter("@u_email", model.u_email),
                    new SqlParameter("@u_loginTime", model.u_loginTime),
                    new SqlParameter("@u_lastLoginTime", model.u_lastLoginTime)
                );
            return res == null ? 0 : Convert.ToInt32(res);
        }
        #endregion

        #region 删除一条记录 +int Delete(int u_id)
        public int Delete(int u_id)
        {
            const string sql = "DELETE FROM [dbo].[T_UserInfo] WHERE [u_id] = @u_id";
            return SqlHelper.ExecuteNonQuery(sql, new SqlParameter("@u_id", u_id));
        }
        #endregion

        #region 根据主键ID更新一条记录 +int Update(T_UserInfo model)
        /// <summary>
        /// 根据主键ID更新一条记录
        /// </summary>
        /// <param name="model">更新后的实体</param>
        /// <returns>执行结果受影响行数</returns>
        public int Update(T_UserInfo model)
        {
            #region SQL语句
            const string sql = @"
UPDATE [dbo].[T_UserInfo]
SET 
	[u_sex] = @u_sex
	,[u_phoneNo] = @u_phoneNo
	,[u_realName] = @u_realName
	,[u_status] = @u_status
	,[u_pic] = @u_pic
	,[u_loginName] = @u_loginName
	,[u_password] = @u_password
	,[u_nickName] = @u_nickName
	,[u_roleId] = @u_roleId
	,[u_regTime] = @u_regTime
	,[u_email] = @u_email
	,[u_loginTime] = @u_loginTime
	,[u_lastLoginTime] = @u_lastLoginTime
WHERE [u_id] = @u_id";
            #endregion
            return SqlHelper.ExecuteNonQuery(sql,
                    new SqlParameter("@u_id", model.u_id),
                    new SqlParameter("@u_sex", model.u_sex),
                    new SqlParameter("@u_phoneNo", model.u_phoneNo),
                    new SqlParameter("@u_realName", model.u_realName),
                    new SqlParameter("@u_status", model.u_status),
                    new SqlParameter("@u_pic", model.u_pic),
                    new SqlParameter("@u_loginName", model.u_loginName),
                    new SqlParameter("@u_password", model.u_password),
                    new SqlParameter("@u_nickName", model.u_nickName),
                    new SqlParameter("@u_roleId", model.u_roleId),
                    new SqlParameter("@u_regTime", model.u_regTime),
                    new SqlParameter("@u_email", model.u_email),
                    new SqlParameter("@u_loginTime", model.u_loginTime),
                    new SqlParameter("@u_lastLoginTime", model.u_lastLoginTime)
                );
        }
        #endregion

        #region 分页查询一个集合 +IEnumerable<T_UserInfo> QueryList(int index, int size, object wheres, string orderField, bool isDesc = true)
        /// <summary>
        /// 分页查询一个集合
        /// </summary>
        /// <param name="index">页码</param>
        /// <param name="size">页大小</param>
        /// <param name="wheres">条件匿名类</param>
        /// <param name="orderField">排序字段</param>
        /// <param name="isDesc">是否降序排序</param>
        /// <returns>实体集合</returns>
        public IEnumerable<T_UserInfo> QueryList(int index, int size, object wheres, string orderField, bool isDesc = true)
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
            var sql = SqlHelper.GenerateQuerySql("T_UserInfo", new[] { "u_id", "u_sex", "u_phoneNo", "u_realName", "u_status", "u_pic", "u_loginName", "u_password", "u_nickName", "u_roleId", "u_regTime", "u_email", "u_loginTime", "u_lastLoginTime" }, index, size, whereBuilder.ToString(), orderField, isDesc);
            using (var reader = SqlHelper.ExecuteReader(sql, parameters.ToArray()))
            {
                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        yield return SqlHelper.MapEntity<T_UserInfo>(reader);
                    }
                }
            }
        }
        #endregion

        #region 查询单个模型实体 +T_UserInfo QuerySingle(object wheres)
        /// <summary>
        /// 查询单个模型实体
        /// </summary>
        /// <param name="wheres">条件匿名类</param>
        /// <returns>实体</returns>
        public T_UserInfo QuerySingle(object wheres)
        {
            var list = QueryList(1, 1, wheres, null);
            return list != null && list.Any() ? list.FirstOrDefault() : null;
        }
        #endregion

        #region 查询单个模型实体 +T_UserInfo QuerySingle(int u_id)
        /// <summary>
        /// 查询单个模型实体
        /// </summary>
        /// <param name="u_id">key</param>
        /// <returns>实体</returns>
        public T_UserInfo QuerySingle(int u_id)
        {
            const string sql = "SELECT TOP 1 [u_id], [u_sex], [u_phoneNo], [u_realName], [u_status], [u_pic], [u_loginName], [u_password], [u_nickName], [u_roleId], [u_regTime], [u_email], [u_loginTime], [u_lastLoginTime] FROM [dbo].[T_UserInfo] WHERE [u_id] = @u_id";
            using (var reader = SqlHelper.ExecuteReader(sql, new SqlParameter("@u_id", u_id)))
            {
                if (reader.HasRows)
                {
                    reader.Read();
                    return SqlHelper.MapEntity<T_UserInfo>(reader);
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
            var sql = SqlHelper.GenerateQuerySql("T_UserInfo", new[] { "COUNT(1)" }, whereBuilder.ToString(), string.Empty);
            var res = SqlHelper.ExecuteScalar(sql, parameters.ToArray());
            return res == null ? 0 : Convert.ToInt32(res);
        }
        #endregion
    }
}