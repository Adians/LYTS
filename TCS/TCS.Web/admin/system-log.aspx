<%@ Page Title="" Language="C#" MasterPageFile="~/share/tousuAdmin.Master" AutoEventWireup="true" CodeBehind="system-log.aspx.cs" Inherits="TCS.Web.admin.system_log" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderAdmin1" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderAdminbar" runat="server">
    <li class="active"><span title="系统日志" data-href="system-log.aspx">系统日志</span><em></em></li>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolderAdmin2" runat="server">

    <nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 系统管理 <span class="c-gray en">&gt;</span> 系统日志 <a class="btn btn-success radius r mr-20" style="line-height: 1.6em; margin-top: 3px" href="javascript:location.replace(location.href);" title="刷新"><i class="Hui-iconfont">&#xe68f;</i></a></nav>
    <div class="pd-20">
        <div class="text-c">
        </div>
        <div class="cl pd-5 bg-1 bk-gray mt-20">
            <span class="l">
                <%if (Session["current_admin"] != null && (Session["current_admin"] as T_UserInfo).u_roleId == 4)
                    {%>
                <a href="javascript:;" onclick="datadel()" class="btn btn-danger radius"><i class="Hui-iconfont">&#xe6e2;</i> 批量删除</a>
                <%} %>
            </span><span class="r">共有数据：<strong>54</strong> 条</span>
        </div>
        <div class="mt-20">
            <table class="table table-border table-bordered table-hover table-bg table-sort">
                <thead>
                    <tr class="text-c">
                        <th width="25">
                            <input type="checkbox" name="" value=""></th>
                        <th width="80">序号</th>
                        <th width="100">类型</th>
                        <th>内容</th>
                        <th width="17%">用户名</th>
                        <th width="120">时间</th>
                        <th width="70">操作</th>
                    </tr>
                </thead>
                <tbody>
                    <%var i = 0;
                        foreach (var item in LogOperationList)
                        {
                            i++;
                    %>
                    <tr class="text-c">
                        <td>
                            <input type="checkbox" value="" name="checklist"></td>
                        <td><%=i %></td>
                        <td><%=_OperationTypeService.QuerySingle(item.lo_operationTypeId).ot_name %></td>
                        <td><%=item.lo_context %></td>
                        <td><%=_UserInfoService.QuerySingle(item.lo_operatorId).u_loginName %></td>
                        <td><%=item.lo_createTime.ToString("yyyy-MM-dd HH:mm:ss") %></td>
                        <td><a title="详情" href="javascript:;" onclick="system_log_show(this,'10001')" class="ml-5" style="text-decoration: none"><i class="Hui-iconfont">&#xe665;</i></a>
                            <%if (Session["current_admin"] != null && (Session["current_admin"] as T_UserInfo).u_roleId == 4)
                                {%> 
                            <a title="删除" href="javascript:;" onclick="system_log_del(this,'10001')" class="ml-5" style="text-decoration: none"><i class="Hui-iconfont">&#xe6e2;</i></a>
                            <%} %>
                        </td>
                    </tr>
                    <%  } %>
                </tbody>
            </table>
        </div>
        <%--<div id="pageNav" class="pageNav"></div>--%>
    </div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolderAdmin3" runat="server">


    <script type="text/javascript" src="lib/Validform/5.3.2/Validform.min.js"></script>
    <script type="text/javascript" src="lib/laypage/1.2/laypage.js"></script>
    <script type="text/javascript" src="lib/datatables/1.10.0/jquery.dataTables.min.js"></script>
    <script type="text/javascript" src="js/H-ui.admin.system.js"></script>
    <script type="text/javascript">
        $("#menu-system dt").addClass("selected");
        $("#menu-system dd").css("display", "block");
        $("#menu-system li:eq(0) ").css("background-color", "rgba(171, 166, 166, 0.43)");
        $("#menu-system li:eq(0) a").css("color", "#06c");

        //$('.table-sort').dataTable({
        //	"lengthMenu":true,//显示数量选择 
        //	"bFilter": true,//过滤功能
        //	"bPaginate": true,//翻页信息
        //	"bInfo": true,//数量信息
        //	//"aaSorting": [[ 1, "desc" ]],//默认第几个排序
        //	"bStateSave": true,//状态保存
        //	"aoColumnDefs": [
        //	  //{"bVisible": false, "aTargets": [ 3 ]} //控制列的隐藏显示
        //	  {"orderable":false,"aTargets":[0,6]}// 制定列不参与排序
        //	]
        //});

        $('.table-sort').dataTable({
            //"aaSorting": [[1, "asc"]],//默认第几个排序
            "bStateSave": true,//状态保存
            "aoColumnDefs": [
              //{"bVisible": false, "aTargets": [ 3 ]} //控制列的隐藏显示
              { "orderable": false, "aTargets": [0, 6] }// 制定列不参与排序
            ]
        });
    </script>
</asp:Content>
