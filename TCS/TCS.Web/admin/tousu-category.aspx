<%@ Page Title="" Language="C#" MasterPageFile="~/share/tousuAdmin.Master" AutoEventWireup="true" CodeBehind="tousu-category.aspx.cs" Inherits="TCS.Web.admin.tousu_category" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderAdmin1" runat="server">
    <link href="../fonts/font-awesome.min.css" rel="stylesheet" />
    <link href="../css/bootstrap.min.css" rel="stylesheet" />
    <link href="../css/new.css" rel="stylesheet" />
    <style>
        body {
            font-size: 14px;
            font-family: "Microsoft Yahei","Hiragino Sans GB","Helvetica Neue",Helvetica,tahoma,arial,"WenQuanYi Micro Hei",Verdana,sans-serif,"\5B8B\4F53";
        }

        .breadcrumb {
            padding: 0px;
            padding-left: 18px;
            margin-bottom: 0px;
        }


        .nav-block-orange {
            background: #ed6d49;
        }

        .nav-block-green {
            background: #74b749;
        }

        .nav-block-yellow {
            background: #ffb400;
        }

        .nav-block-blue {
            background: #3693cf;
        }

        .nav-block-red {
            background: #f63131;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderAdminbar" runat="server">
    <li class="active"><span title="投诉分类" data-href="tousu-category.aspx">投诉分类</span><em></em></li>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolderAdmin2" runat="server">

    <nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 投诉管理 <span class="c-gray en">&gt;</span> 投诉分类 <a class="btn btn-success radius r mr-20" style="line-height: 1.6em; margin-top: 3px" href="javascript:location.replace(location.href);" title="刷新"><i class="Hui-iconfont">&#xe68f;</i></a></nav>
    <div class="pd-20 text-c">
        <div class="text-c">
           
        </div>
        <div class="cl pd-5 bg-1 bk-gray mt-20"><span class="l">
            <%if (Session["current_admin"] != null && (Session["current_admin"] as T_UserInfo).u_roleId == 4)
                {%><a class="btn btn-primary radius" onclick="tousu_category_add('添加分类','tousu-category-add.aspx','600','380')" href="javascript:;"><i class="Hui-iconfont">&#xe600;</i> 添加分类</a><%} %></span> <span class="r">共有数据：<strong><%=totalcount %></strong> 条</span> </div>
        <div class="mt-20">
            <table class="table table-border table-bordered table-hover table-bg table-sort">
                <thead>
                    <tr class="text-c">
                        <th width="80">序号</th>
                        <th>类型名称</th>
                        <th>风格</th>
                        <th>图标</th>
                        <th>创建者</th>
                        <th>创建时间</th>
                        <th width="100">操作</th>
                    </tr>
                </thead>
                <tbody>
                    <%int i = 0;
                        foreach (var item in ComplaintTypeList)
                        {
                            i++;
                    %>
                    <tr class="text-c">
                        <td><%=i %></td>
                        <td><%=item.ct_name %></td>
                        <td><span class="<%=item.ct_style %>" style="height: 25px; margin-left: 32%; width: 60px; display: block;"></span></td>
                        <td style="font-size: 16px; color: white;"><span class="<%=item.ct_style %> <%=item.ct_icon %>" style="width: 30px; height: 25px; line-height: 25px;"></span></td>
                        <td><%=(_UserInfoService.QuerySingle(item.ct_creatorId).u_realName) %></td>
                        <td><%=item.ct_createTime.ToString("yyyy-MM-dd HH:mm") %></td>

                        <td class="f-14">
                            <%if (Session["current_admin"] != null && (Session["current_admin"] as T_UserInfo).u_roleId == 4)
                                {%>
                            <a title="编辑" href="javascript:;" onclick="tousu_category_edit('投诉类型编辑','tousu-category-add.aspx','<%=item.ct_id %>','<%=item.ct_name %>','<%=item.ct_icon %>','600','380')" style="text-decoration: none"><i class="Hui-iconfont">&#xe6df;</i></a> <a title="删除" href="javascript:;" onclick="tousu_category_del(this,'<%=item.ct_id %>')" class="ml-5" style="text-decoration: none"><i class="Hui-iconfont">&#xe6e2;</i></a>
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
        $("#menu-product dt").addClass("selected");
        $("#menu-product dd").css("display", "block");
        $("#menu-product li:eq(1) ").css("background-color", "rgba(171, 166, 166, 0.43)");
        $("#menu-product li:eq(1) a").css("color", "#06c");
        $('.table-sort').dataTable({
            "aaSorting": [[1, "desc"]],//默认第几个排序
            "bStateSave": true,//状态保存
            "aoColumnDefs": [
              //{"bVisible": false, "aTargets": [ 3 ]} //控制列的隐藏显示
              { "orderable": false, "aTargets": [2, 3, 5] }// 制定列不参与排序
            ]
        });
        /*投诉类型-添加*/
        function tousu_category_add(title, url, w, h) {
            layer_show(title, url, w, h);
        }
        /*投诉类型-编辑*/
        function tousu_category_edit(title, url, id, name, icon, w, h) {
            if (title == null || title == '') {
                title = false;
            };
            if (url == null || url == '') {
                url = "";
            };
            if (w == null || w == '') {
                w = 800;
            };
            if (h == null || h == '') {
                h = ($(window).height() - 50);
            };
            layer.open({
                type: 2,
                area: [w + 'px', h + 'px'],
                fix: false, //不固定
                maxmin: true,
                shade: 0.4,
                title: title,
                content: url,
                success: function (layero, index) {
                    var body = layer.getChildFrame('body', index);
                    var iframeWin = window[layero.find('iframe')[0]['name']]; //得到iframe页的窗口对象，执行iframe页的方法：iframeWin.method();
                    //console.log(body.html()) //得到iframe页的body内容
                    body.find('#tousu-category-name').val(name);
                    body.find('#tousu-category-icon').val(icon);
                    body.find('#tid').val(id);

                }
            });
        }
        /*投诉类型-删除*/
        function tousu_category_del(obj, id) {
            layer.confirm('确认要删除吗？', function (index) {
                $.post("/handler/TousuCategoryOperate.ashx", { tid: parseInt(id), action: "del" }, function (data) {
                    //alert(data);
                    if (data=="true") {
                        $(obj).parents("tr").remove();
                        layer.msg('已删除!', { icon: 1, time: 1000 });

                    } else {
                        layer.msg('删除失败!', { icon: 2, time: 1000 });

                    }

                });
                //$(obj).parents("tr").remove();
                //layer.msg('已删除!', { icon: 1, time: 1000 });
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

