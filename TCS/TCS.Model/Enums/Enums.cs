using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace TCS.Model.Enums
{
    public enum LoginResult
    {
        用户名不存在 = 0,
        密码错误 = 1,
        用户已被冻结 = 2,
        登录成功 = 3
    }

    public enum RegisterResult
    {
        用户名已存在 = 0,
        注册成功 = 1,
        注册失败 = 2,
    }

    public enum c_statusType
    {
        处理中 = 1,
        已处理待反馈 = 2,
        已完结 = 3,
        待审核 = 4,
        审核不通过 = 5,
        申请审核中 = 6


    }

    public enum c_userRole
    {
        普通用户 = 1,
        投诉处理员 = 2,
        投诉信息审核员 = 3,
        系统管理员 = 4

    }


}
