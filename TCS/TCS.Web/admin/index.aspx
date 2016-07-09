<%@ Page Title="" Language="C#" MasterPageFile="~/share/tousuAdmin.Master" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="TCS.Web.admin.index" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderAdmin1" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderAdminbar" runat="server">
    <li class="active"><span title="我的首页" data-href="index.aspx">我的首页</span><em></em></li>
 </asp:Content>   

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolderAdmin2" runat="server">

    
			<%--<iframe scrolling="yes" frameborder="0" src="welcome.html"></iframe>--%>
            <div class="pd-20" style="padding-top:20px; min-height:450px;">
  <p class="f-20 text-success"><span class="f-14"></span></p>
  <p>欢迎进入旅游投诉信息管理系统 </p>
  <p>您上次登录时间：<%=CurrentUser.u_lastLoginTime.ToString("yyyy-MM-dd HH:mm:ss") %></p>
  <table class="table table-border table-bordered table-bg">
    <thead>
      <tr>
        <th colspan="7" scope="col">信息统计</th>
      </tr>
      <tr class="text-c">
        <th>统计</th>
        <th>资讯库</th>
        <th>投诉评论库</th>
        <th>投诉信息库</th>
        <th>用户</th>
        <th>管理员</th>
      </tr>
    </thead>
    <tbody>
      <tr class="text-c">
        <td>总数</td>
        <td>92</td>
        <td>9</td>
        <td>0</td>
        <td>8</td>
        <td>20</td>
      </tr>
      <tr class="text-c">
        <td>今日</td>
        <td>0</td>
        <td>0</td>
        <td>0</td>
        <td>0</td>
        <td>0</td>
      </tr>
      <tr class="text-c">
        <td>昨日</td>
        <td>0</td>
        <td>0</td>
        <td>0</td>
        <td>0</td>
        <td>0</td>
      </tr>
      <tr class="text-c">
        <td>本周</td>
        <td>2</td>
        <td>0</td>
        <td>0</td>
        <td>0</td>
        <td>0</td>
      </tr>
      <tr class="text-c">
        <td>本月</td>
        <td>2</td>
        <td>0</td>
        <td>0</td>
        <td>0</td>
        <td>0</td>
      </tr>
    </tbody>
  </table>
  <div style="width:100%; height:180px;"></div>
</div>
	<footer class="footer">
                    <p>
                        
                        Copyright © 2015 - 2016 旅游投诉网 ALL RIGHTS RESERVED　桂ICP备8888888888号<br>
                        
                    </p>
                </footer>	
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolderAdmin3" runat="server">
</asp:Content>
