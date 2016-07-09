﻿using System.Collections.Generic;
using System.Linq;
using TCS.DAL;
using TCS.Model;

namespace TCS.BLL 
{
	public partial class T_ComplaitRequireService
	{
   		     
		/// <summary>
        /// 数据库操作对象
        /// </summary>
        private T_ComplaitRequireDAO _dao = new T_ComplaitRequireDAO();

        #region 向数据库中添加一条记录 +int Insert(T_ComplaitRequire model)
        /// <summary>
        /// 向数据库中添加一条记录
        /// </summary>
        /// <param name="model">要添加的实体</param>
        /// <returns>插入数据的ID</returns>
        public int Insert(T_ComplaitRequire model)
        {
            return _dao.Insert(model);
        }
        #endregion

        #region 删除一条记录 +int Delete(int cr_id)
        public int Delete(int cr_id)
        {
            return _dao.Delete(cr_id);
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
            return _dao.Update(model);
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
            return _dao.QueryList(index, size, wheres, orderField, isDesc);
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
            return _dao.QuerySingle(wheres);
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
            return _dao.QuerySingle(cr_id);
        }
        #endregion

        #region 查询条数 +int QueryCount(object wheres)
        /// <summary>
        /// 查询条数
        /// </summary>
        /// <param name="wheres">查询条件</param>
        /// <returns>实体</returns>
        public int QueryCount(object wheres)
        {
            return _dao.QueryCount(wheres);
        }
        #endregion
	}
}