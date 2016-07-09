<%@ Page Title="" Language="C#" MasterPageFile="~/share/tousuAdmin.Master" AutoEventWireup="true" CodeBehind="admin-list.aspx.cs" Inherits="TCS.Web.admin.admin_list" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderAdmin1" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderAdminbar" runat="server">
    <li class="active"><span title="管理员列表" data-href="admin-list.aspx">管理员列表</span><em></em></li>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolderAdmin2" runat="server">

    <nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 管理员管理 <span class="c-gray en">&gt;</span> 管理员列表 <a class="btn btn-success radius r mr-20" style="line-height: 1.6em; margin-top: 3px" href="javascript:location.replace(location.href);" title="刷新"><i class="Hui-iconfont">&#xe68f;</i></a></nav>
    <div class="pd-20">
        <div class="text-c">
        </div>
        <div class="cl pd-5 bg-1 bk-gray mt-20">
            <span class="l">
                <%if (Session["current_admin"] != null && (Session["current_admin"] as T_UserInfo).u_roleId == 4)
                    { %>
                <a href="javascript:;" onclick="datadel()" class="btn btn-danger radius"><i class="Hui-iconfont">&#xe6e2;</i> 批量删除</a> <a href="javascript:;" onclick="admin_add('添加管理员','admin-add.aspx','800','550')" class="btn btn-primary radius"><i class="Hui-iconfont">&#xe600;</i> 添加管理员</a>
                <%} %>
            </span><span class="r">共有数据：<strong><%=count %></strong> 条</span>
        </div>
        <div class="mt-20">
            <table class="table table-border table-bordered table-bg table-hover table-sort">
                <thead>

                    <tr class="text-c">
                        <th width="25">
                            <input type="checkbox" name="" value=""></th>
                        <th width="40">序号</th>
                        <th width="150">登录名</th>
                        <th width="90">手机</th>
                        <th width="150">邮箱</th>
                        <th>角色</th>
                        <th width="180">加入时间</th>
                        <th width="100">是否已启用</th>
                        <th width="100">操作</th>
                    </tr>
                </thead>
                <tbody>
                    <%var i = 0;
                        foreach (var item in AdminUserInfoList)
                        {
                            i++;
                    %>
                    <tr class="text-c">
                        <td>
                            <input type="checkbox" value="<%=item.u_id %>" name="checklist"></td>
                        <td><%=i %></td>
                        <td><%=item.u_loginName %></td>
                        <td><%=item.u_phoneNo %></td>
                        <td><%=item.u_email %></td>
                        <td><%=_RolesService.QuerySingle(item.u_roleId).r_name %></td>
                        <td><%=item.u_regTime.ToString("yyyy-MM-dd HH:mm:ss") %></td>
                        <td class="td-status"><span class="label label-success radius">已启用</span></td>
                        <td class="td-manage">
                            <%if (Session["current_admin"] != null && (Session["current_admin"] as T_UserInfo).u_roleId == 4)
                                { %>
                            <a style="text-decoration: none" onclick="admin_stop(this,'<%=item.u_id %>')" href="javascript:;" title="停用"><i class="Hui-iconfont">&#xe631;</i></a> <a title="编辑" href="javascript:;" onclick="admin_edit('管理员编辑','admin-add.aspx','<%=item.u_id %>','800','550')" class="ml-5" style="text-decoration: none"><i class="Hui-iconfont">&#xe6df;</i></a> <a title="删除" href="javascript:;" onclick="admin_del(this,'<%=item.u_id %>')" class="ml-5" style="text-decoration: none"><i class="Hui-iconfont">&#xe6e2;</i></a>
                            <%}
                            else
                            { %>
                            <a title="详情" href="javascript:;" onclick="member_show('用户信息','member-show.aspx','<%=item.u_id %>','360','450')" class="ml-5" style="text-decoration: none"><i class="Hui-iconfont">&#xe665;</i></a>
                            <%} %>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>


</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolderAdmin3" runat="server">

    <script type="text/javascript" src="lib/laypage/1.2/laypage.js"></script>
    <script type="text/javascript" src="lib/My97DatePicker/WdatePicker.js"></script>
    <script type="text/javascript" src="lib/datatables/1.10.0/jquery.dataTables.min.js"></script>
    <script type="text/javascript">
        $("#menu-admin dt").addClass("selected");
        $("#menu-admin dd").css("display", "block");
        $("#menu-admin li:eq(1) ").css("background-color", "rgba(171, 166, 166, 0.43)");
        $("#menu-admin li:eq(1) a").css("color", "#06c");
        $('.table-sort').dataTable({
            "aaSorting": [[1, "desc"]],//默认第几个排序
            "bStateSave": true,//状态保存
            "aoColumnDefs": [
              //{"bVisible": false, "aTargets": [ 3 ]} //控制列的隐藏显示
              { "orderable": false, "aTargets": [0, 8] }// 制定列不参与排序
            ]
        });
        /*
            参数解释：
            title	标题
            url		请求的url
            id		需要操作的数据id
            w		弹出层宽度（缺省调默认值）
            h		弹出层高度（缺省调默认值）
        */
        /*管理员-增加*/
        function admin_add(title, url, w, h) {
            layer_show(title, url, w, h);
        }

        /*用户-查看*/
        function member_show(title, url, id, w, h) {
            layer_show(title, url + "?uid=" + id, w, h);
        }
        /*管理员-删除*/
        function admin_del(obj, id) {
            layer.confirm('确认要删除吗？', function (index) {
                //此处请求后台程序，下方是成功后的前台处理……

                $(obj).parents("tr").remove();
                layer.msg('已删除!', { icon: 1, time: 1000 });
            });
        }
        /*管理员-编辑*/
        function admin_edit(title, url, id, w, h) {
            layer_show(title, url+"?aid="+id, w, h);
        }
        /*管理员-停用*/
        function admin_stop(obj, id) {
            layer.confirm('确认要停用吗？', function (index) {
                //此处请求后台程序，下方是成功后的前台处理……

                $(obj).parents("tr").find(".td-manage").prepend('<a onClick="admin_start(this,id)" href="javascript:;" title="启用" style="text-decoration:none"><i class="Hui-iconfont">&#xe615;</i></a>');
                $(obj).parents("tr").find(".td-status").html('<span class="label label-default radius">已禁用</span>');
                $(obj).remove();
                layer.msg('已停用!', { icon: 5, time: 1000 });
            });
        }

        /*管理员-启用*/
        function admin_start(obj, id) {
            layer.confirm('确认要启用吗？', function (index) {
                //此处请求后台程序，下方是成功后的前台处理……


                $(obj).parents("tr").find(".td-manage").prepend('<a onClick="admin_stop(this,id)" href="javascript:;" title="停用" style="text-decoration:none"><i class="Hui-iconfont">&#xe631;</i></a>');
                $(obj).parents("tr").find(".td-status").html('<span class="label label-success radius">已启用</span>');
                $(obj).remove();
                layer.msg('已启用!', { icon: 6, time: 1000 });
            });
        }


        function msg(n) {

            if (n == 1) {
                
                layer.msg('修改成功!', { icon: 1, time: 1000 });
                history.go(0);
            }
            if (n == -1) {


                layer.msg('修改失败!', { icon: 2, time: 1000 });
            }
            if (n == 2) {


                layer.msg('添加成功!', { icon: 1, time: 1000 });
                history.go(0);
            }
            if (n == -2) {


                layer.msg('添加失败!', { icon: 2, time: 1000 });
            }
        }
    </script>

</asp:Content>
