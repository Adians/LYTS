<%@ Page Title="" Language="C#" MasterPageFile="~/share/tousuAdmin.Master" AutoEventWireup="true" CodeBehind="admin-role.aspx.cs" Inherits="TCS.Web.admin.admin_role" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderAdmin1" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderAdminbar" runat="server">
    <li class="active"><span title="角色管理" data-href="admin-role.aspx">角色管理</span><em></em></li>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolderAdmin2" runat="server">

    <nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 管理员管理 <span class="c-gray en">&gt;</span> 角色管理 <a class="btn btn-success radius r mr-20 " style="line-height: 1.6em; margin-top: 3px" href="javascript:location.replace(location.href);" title="刷新"><i class="Hui-iconfont">&#xe68f;</i></a></nav>
    <div class="pd-20">
        <div class="cl pd-5 bg-1 bk-gray">
            <span class="l">
                <%if (Session["current_admin"] != null && (Session["current_admin"] as T_UserInfo).u_roleId == 4)
                    { %> <a href="javascript:;" onclick="datadel()" class="btn btn-danger radius"><i class="Hui-iconfont">&#xe6e2;</i> 批量删除</a> <a class="btn btn-primary radius" href="javascript:;" onclick="admin_role_add('添加角色','admin-role-add.aspx','600','300')"><i class="Hui-iconfont">&#xe600;</i> 添加角色</a> <%} %></span> <span class="r">共有数据：<strong><%=count %></strong> 条</span>
        </div>
        <div class="mt-20">
            <table class="table table-border table-bordered table-hover table-bg  table-sort">
                <thead>
                   
                    <tr class="text-c">
                        <th width="25">
                            <input type="checkbox" value="" name=""></th>
                        <th width="40">ID</th>
                        <th width="200">角色名</th>
                        <th>用户列表</th>
                        <th width="300">描述</th>
                        <th width="70">操作</th>
                    </tr>
                </thead>
                <tbody>
                    <%var i = 0;
                        foreach (var item in RolesList)
                        {
                            i++;

                    %>
                    <tr class="text-c">
                        <td>
                            <input type="checkbox" value="<%=item.r_id %>" name="checklist"></td>
                        <td><%=i %></td>
                        <td><%=item.r_name %></td>
                        <td>
                            <%
                                foreach (var item1 in _UserInfoService.QueryList(1, _UserInfoService.QueryCount(new { u_roleId = item.r_id }), new { u_roleId = item.r_id }, "u_id", false))
                                {%>
                            <a href="javascript:;" onClick="member_show('<%=item1.u_loginName %>','member-show.aspx','<%=item1.u_id %>','360','450')"><%=item1.u_loginName %></a> &nbsp;&nbsp;
                       <% } %>
                    

                        </td>
                        <td><%=item.r_text %></td>
                        <td class="f-14">
                            <%if (Session["current_admin"] != null && (Session["current_admin"] as T_UserInfo).u_roleId == 4)
                                { %>
                            <a title="编辑" href="javascript:;" onclick="admin_role_edit('角色编辑','admin-role-add.aspx','<%=item.r_id %>','<%=item.r_name %>','<%=item.r_text %>','600','300')" style="text-decoration: none"><i class="Hui-iconfont">&#xe6df;</i></a> <a title="删除" href="javascript:;" onclick="admin_role_del(this,'<%=item.r_id %>')" class="ml-5" style="text-decoration: none"><i class="Hui-iconfont">&#xe6e2;</i></a>
                            <%}%>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolderAdmin3" runat="server">
    <script type="text/javascript" src="lib/My97DatePicker/WdatePicker.js"></script>
    <script type="text/javascript" src="lib/datatables/1.10.0/jquery.dataTables.min.js"></script>
    <script type="text/javascript">
        $("#menu-admin dt").addClass("selected");
        $("#menu-admin dd").css("display", "block");
        $("#menu-admin li:eq(0) ").css("background-color", "rgba(171, 166, 166, 0.43)");
        $("#menu-admin li:eq(0) a").css("color", "#06c");
        $('.table-sort').dataTable({
            "aaSorting": [[1, "desc"]],//默认第几个排序
            "bStateSave": true,//状态保存
            "aoColumnDefs": [
              { "orderable": false, "aTargets": [0, 5] }// 制定列不参与排序
            ]
        });
        /*管理员-角色-添加*/
        function admin_role_add(title, url, w, h) {
            layer_show(title, url, w, h);
        }

        /*用户-查看*/
        function member_show(title, url, id, w, h) {
            layer_show(title, url + "?uid=" + id, w, h);
        }
        /*管理员-角色-编辑*/
        function admin_role_edit(title, url, id,name,remark, w, h) {
            layer.open({
                type: 2,
                area: [w + 'px', h + 'px'],
                fix: false, 
                maxmin: true,
                shade: 0.4,
                title: title,
               
                content: url,
                success: function (layero, index) {
                    var body = layer.getChildFrame('body', index);
                    var iframeWin = window[layero.find('iframe')[0]['name']]; 
                    body.find('#rolename').val(name);
                    body.find('#roleremark').val(remark);
                    body.find('#rid').val(id);
                   
                }
            });
           
        }
        /*管理员-角色-删除*/
        function admin_role_del(obj, id) {
            layer.confirm('角色删除须谨慎，确认要删除吗？', function (index) {
                $.post("/handler/RolesOperate.ashx", {action:"del",rid:id},function(data){
                    if (data == "ok") {
                        $(obj).parents("tr").remove();
                        layer.msg('已删除!', { icon: 1, time: 1000 });
                    } else {

                        layer.msg('删除失败!', { icon: 2, time: 1000 });
                    }
                
                });
                
            });
        }

        function refresh() {
            history.go(0);
        }
        function msg(n) {
            if (n == 1) {
                layer.msg('修改成功!', { icon: 1, time: 1000 });
                //history.go(0);
            }
            if (n == -1) {
                layer.msg('修改失败!', { icon: 2, time: 1000 });
            }
            if (n == 2) {
                layer.msg('添加成功!', { icon: 1, time: 1000 });
               // history.go(0);
            }
            if (n == -2) {
                layer.msg('添加失败!', { icon: 2, time: 1000 });
            }
        }
    </script>

</asp:Content>
