<%@ Page Title="" Language="C#" MasterPageFile="~/share/commonhead.Master" AutoEventWireup="true" CodeBehind="member-show.aspx.cs" Inherits="TCS.Web.admin.member_show" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderC1" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderC2" runat="server">

<div class="cl pd-20" style=" background-color:#5bacb6">
  <img class="avatar size-XL l" src="<%=userInfo.u_pic %>">
  <dl style="margin-left:80px; color:#fff">
    <dt><span class="f-18"><%=userInfo.u_loginName %></span> <span class="pl-10 f-12"></span></dt>
    <dd class="pt-10 f-12" style="margin-left:0">这家伙很懒，什么也没有留下</dd>
  </dl>
</div>
<div class="pd-20">
  <table class="table">
    <tbody>
        <tr>
        <th class="text-r" width="80">角色：</th>
        <td><%=_RolesService.QuerySingle(userInfo.u_roleId).r_name %></td>
      </tr>
        <tr>
        <th class="text-r" width="80">真实姓名：</th>
        <td><%=userInfo.u_realName %></td>
      </tr>
        <tr>
        <th class="text-r" width="80">账号昵称：</th>
        <td><%=userInfo.u_nickName %></td>
      </tr>
      <tr>
        <th class="text-r" width="80">性别：</th>
        <td><%=userInfo.u_sex %></td>
      </tr>
      <tr>
        <th class="text-r">手机：</th>
        <td><%=userInfo.u_phoneNo %></td>
      </tr>
      <tr>
        <th class="text-r">邮箱：</th>
        <td><%=userInfo.u_email %></td>
      </tr>
      <tr>
        <th class="text-r">注册时间：</th>
        <td><%=userInfo.u_regTime.ToString("yyyy-MM-dd HH:mm:ss") %></td>
      </tr>
    </tbody>
  </table>
</div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolderC3" runat="server">
</asp:Content>
