<%@ Page Title="" Language="C#" MasterPageFile="~/share/tousuAdmin.Master" AutoEventWireup="true" CodeBehind="member-del.aspx.cs" Inherits="TCS.Web.admin.member_del" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderAdmin1" runat="server">

    <style>
        .center {
            text-align: center;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderAdminbar" runat="server">
    <li class="active"><span title="删除的用户" data-href="member-del.aspx">删除的用户</span><em></em></li>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolderAdmin2" runat="server">

    <nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 用户中心 <span class="c-gray en">&gt;</span> 删除的用户<a class="btn btn-success radius r mr-20" style="line-height: 1.6em; margin-top: 3px" href="javascript:location.replace(location.href);" title="刷新"><i class="Hui-iconfont">&#xe68f;</i></a></nav>
    <div class="pd-20">
        <div class="text-c">
        </div>
        <div class="cl pd-5 bg-1 bk-gray mt-20">
            <span class="l">
                <%if (Session["current_admin"] != null && (Session["current_admin"] as T_UserInfo).u_roleId == 4)
                    {%><a href="javascript:;" onclick="datadel()" class="btn btn-danger radius"><i class="Hui-iconfont">&#xe6e2;</i> 批量删除</a> <%} %></span> <span class="r"></span>
        </div>
        <div class="mt-20">
            <table class="table table-border table-bordered table-hover table-bg table-sort">
                <thead>
                    <tr class="text-c">
                        <th width="25">
                            <input type="checkbox" name="" value=""></th>
                        <th style="width: 5%">序号
                        </th>
                        <th style="width: 13%">用户名
                        </th>
                        <th style="width: 13%">用户昵称
                        </th>
                        <th style="width: 6%">真实姓名
                        </th>
                        <th style="width: 5%">性别
                        </th>
                        <th style="width: 15%">邮箱
                        </th>
                        <th style="width: 10%">联系电话
                        </th>
                        <th style="width: 11%">注册时间
                        </th>
                        <th style="width: 8%">状态
                        </th>

                        <th width="150">操作</th>
                    </tr>
                </thead>
                <tbody>
                   
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

        $(function () {

            $("#menu-member dt").addClass("selected");
            $("#menu-member dd").css("display", "block");
            $("#menu-member li:eq(1) ").css("background-color", "rgba(171, 166, 166, 0.43)");
            $("#menu-member li:eq(1) a").css("color", "#06c");

            $('.table-sort').dataTable({
                "aaSorting": [[1, "desc"]],//默认第几个排序
                "bStateSave": true,//状态保存
                "iDisplayLength": 10,
                "aLengthMenu": [[10, 25, 50, -1], [10, 25, 50, "显示所有"]],
                "sAjaxSource": '../handler/userList.ashx?status=3',
                //"sAjaxSource": '/test1.js',
                "sAjaxDataProp": "aaData",
                "aoColumns": [{
                    "mDataProp": "ID",
                    "sClass": "center",
                    "fnCreatedCell": function (nTd, sData, oData, iRow, iCol) {
                        $(nTd).html("<input type='checkbox' name='checkList' value='" + sData + "'>");

                    },

                    //"sDefaultContent": 1, //此列默认值为""，以防数据中没有此值，DataTables加载数据的时候报错  
                    //"bVisible": false,//此列不显示  
                    "bSearchable": false,
                    "sClass": "center"

                }, {
                    "mDataProp": "ORDERNO",
                    "sTitle": "序号",
                    //"sDefaultContent": 1,
                    "sClass": "center"

                    //"sClass": "center"
                }, {
                    "mDataProp": "LOGINNAME",
                    "sTitle": "用户名",
                    //"sDefaultContent": "",
                    "sClass": "center",
                    //"sClass": "width3",
                    "bSearchable": true,
                    "bFilter": true
                }, {
                    "mDataProp": "NICKNAME",
                    "sTitle": "用户昵称",
                    //"sDefaultContent": "",
                    "sClass": "center"
                    //"sClass": "width3"
                }, {
                    "mDataProp": "REALNAME",
                    "sTitle": "真实姓名",
                    //"sDefaultContent": "",
                    "sClass": "center"
                }, {
                    "mDataProp": "SEX",
                    "sTitle": "性别",
                    //"sDefaultContent": "",
                    "sClass": "center"
                }, {
                    "mDataProp": "EMAIL",
                    "sTitle": "邮箱",
                    //"sDefaultContent": "",
                    "sClass": "center"
                }, {
                    "mDataProp": "PHONE",
                    "sTitle": "联系电话",
                    //"sDefaultContent": "",
                    "sClass": "center"
                    //"sClass": "width3",
                }, {
                    "mDataProp": "REGTIME",
                    "sTitle": "注册时间",
                    //"sDefaultContent": "",
                    //"sClass": "center"
                    //"sClass": "width3",
                }, {
                    "mDataProp": "STATUE",
                    "sTitle": "状态",
                    //"sDefaultContent": "",
                    "sClass": "td-status center",
                    "fnCreatedCell": function (nTd, sData, oData, iRow, iCol) {

                        $(nTd).html("<span class=\"label label-danger radius\">已删除</span>");
                    }

                }, {
                    "mDataProp": "ID",
                    "sClass": "td-manage center",
                    "fnCreatedCell": function (nTd, sData, oData, iRow, iCol) {
                        <%if (Session["current_admin"] != null && (Session["current_admin"] as T_UserInfo).u_roleId == 4)
                         {%>
                        str = "<a style=\"text-decoration:none\" href=\"javascript:;\" onClick=\"member_huanyuan(this,'" + sData + "')\" title=\"还原\"><i class=\"Hui-iconfont\">&#xe66b;</i></a> <a title=\"删除\" href=\"javascript:;\" onClick=\"member_del(this,'" + sData + "')\" class=\"ml-5\" style=\"text-decoration:none\"><i class=\"Hui-iconfont\">&#xe6e2;</i></a>"
                        $(nTd).html(str);<%}else {%>
                        $(nTd).html("<a title=\"详情\" href=\"javascript:;\" onclick=\"member_show('用户信息','member-show.aspx','" + sData + "','360','450')\" class=\"ml-5\" style=\"text-decoration: none\"><i class=\"Hui-iconfont\">&#xe665;</i></a>");
                        <%}%>
                    }
                }
                ],
                "aoColumnDefs": [
                  //{"bVisible": false, "aTargets": [ 3 ]} //控制列的隐藏显示
                  { "orderable": false, "aTargets": [0, 10] }// 制定列不参与排序

                ]
            });
            $('.table-sort tbody').on('click', 'tr', function () {
                if ($(this).hasClass('selected')) {
                    $(this).removeClass('selected');
                }
                else {
                    table.$('tr.selected').removeClass('selected');
                    $(this).addClass('selected');
                }
            });
        });

        /*用户-停用*/
        function member_stop(obj, id) {
            layer.confirm('确认要停用吗？', function (index) {

                $.post("/handler/UserOperate.ashx", { uid: parseInt(id), action: "close" }, function (data) {
                    //alert(data);
                    if (data) {
                        $(obj).parents("tr").find(".td-manage").prepend('<a style="text-decoration:none" onClick="member_start(this,id)" href="javascript:;" title="启用"><i class="Hui-iconfont">&#xe6e1;</i></a>');
                        $(obj).parents("tr").find(".td-status").html('<span class="label label-defaunt radius">已停用</span>');
                        $(obj).remove();
                        layer.msg('已停用!', { icon: 5, time: 1000 });

                    } else {
                        layer.msg('停用失败!', { icon: 5, time: 1000 });

                    }

                });

            });
        }

        /*用户-启用*/
        function member_start(obj, id) {
            layer.confirm('确认要启用吗？', function (index) {
                $.post("/handler/UserOperate.ashx", { uid: parseInt(id), action: "open" }, function (data) {
                    //alert(data);
                    if (data) {
                        $(obj).parents("tr").find(".td-manage").prepend('<a style="text-decoration:none" onClick="member_stop(this,id)" href="javascript:;" title="停用"><i class="Hui-iconfont">&#xe631;</i></a>');
                        $(obj).parents("tr").find(".td-status").html('<span class="label label-success radius">已启用</span>');
                        $(obj).remove();
                        layer.msg('已启用!', { icon: 6, time: 1000 });

                    } else {
                        layer.msg('启动失败!', { icon: 5, time: 1000 });

                    }

                });

            });
        }
        /*用户-编辑*/
        function member_edit(title, url, id, name, nickname, phone, realname, email, sex, w, h) {

            //layer_show(title, url, w, h);

            if (title == null || title == '') {
                title = false;
            };
            if (url == null || url == '') {
                url = "404.aspx";
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
                //zIndex:99999999,
                content: url,
                //content: $("#editPasswordBox"),
                success: function (layero, index) {
                    var body = layer.getChildFrame('body', index);
                    var iframeWin = window[layero.find('iframe')[0]['name']]; //得到iframe页的窗口对象，执行iframe页的方法：iframeWin.method();
                    //console.log(body.html()) //得到iframe页的body内容
                    body.find('#member-name').val(name);
                    body.find('#member-nickname').val(nickname);
                    body.find('#member-realname').val(realname);
                    body.find('#member-tel').val(phone);
                    body.find('#email').val(email);
                    body.find('#eUserId').val(id);
                    //if (sex == "男") {
                    //    //document.getElementById("sex-1").setAttribute("checked", "checked");
                    //    //$('#sex-1')("checked", "checked");
                    //    //location.replace(location.href);
                    //    body.find('#nan div:eq(0)').addClass("checked");
                    //} else if (sex == "女") {
                    //    body.find('#nv div:eq(0)').addClass("checked");
                    //} else {
                    //    body.find('#baomi div:eq(0)').addClass("checked");
                    //}
                }
            });


        }


        /*用户-删除*/
        function member_del(obj, id) {
            layer.confirm('确认要删除吗？', function (index) {
                $.post("/handler/UserOperate.ashx", { uid: parseInt(id), action: "del" }, function (data) {
                    //alert(data);
                    if (data) {
                        $(obj).parents("tr").remove();
                        layer.msg('已删除!', { icon: 1, time: 1000 });

                    } else {
                        layer.msg('删除失败!', { icon: 2, time: 1000 });

                    }

                });
                //layer.close(index);

            });
        }


        function msg(n) {

            if (n == 1) {
                layer.msg('修改成功!', { icon: 1, time: 1000 });
            }
            if (n == -1) {


                layer.msg('修改失败!', { icon: 2, time: 1000 });
            }
            if (n == 2) {


                layer.msg('添加成功!', { icon: 1, time: 1000 });
            }
            if (n == -2) {


                layer.msg('添加失败!', { icon: 2, time: 1000 });
            }
        }

        /*用户-还原*/
        function member_huanyuan(obj, id) {

            layer.confirm('确认要还原吗？', function (index) {
                $.post("/handler/UserOperate.ashx", { uid: parseInt(id), action: "restore" }, function (data) {
                    //alert(data);
                    if (data) {
                        $(obj).parents("tr").remove();
                        layer.msg('已还原!', { icon: 6, time: 1000 });

                    } else {
                        layer.msg('还原失败!', { icon: 2, time: 1000 });

                    }

                });
                //layer.close(index);

            });
        }

        /*用户-查看*/
        function member_show(title, url, id, w, h) {
            layer_show(title, url + "?uid=" + id, w, h);
        }
        ///*用户-删除*/
        //function member_del(obj, id) {
        //    layer.confirm('确认要删除吗？', function (index) {
        //        $(obj).parents("tr").remove();
        //        layer.msg('已删除!', { icon: 1, time: 1000 });
        //    });
        //}

        //$("#deleteBtn").click(function () {
        function datadel() {
            //alert("4444"+document.getElementsByName("childChecked").item(2).checked);
            var value = "";
            var count = 0;
            var len = document.getElementsByName("checkList").length;
            for (var i = 0; i < len; i++) {
                if (document.getElementsByName("checkList").item(i).checked) { //判断复选框是否选中
                    value = value + document.getElementsByName("checkList").item(i).value + "|"; //值的拼凑 
                    count = count + 1;
                }
            }
            if (count == 0) {
                alert("请选择一条数据进行操作！");
            }
            else {

                var r = confirm("您确认要删除选中的" + count + "条数据吗？")
                if (r == true) {

                    // window.location.href = "/admin/deleteUserInfo?pageno=" + p + "&str=" + value;
                    $.post("/handler/MultiDelete.ashx", { strid: value, action: "member" }, function (data) {
                        if (data == "删除成功") {
                            layer.msg('已删除!', { icon: 1, time: 1000 });
                            history.go(0);

                        } else {
                            layer.msg(data, { icon: 2, time: 1000 });
                        }

                    });
                }

            }
        }
        //});

        //    $(function(){
        //    $('.table-sort').dataTable({
        //        "aaSorting": [[ 1, "desc" ]],//默认第几个排序
        //        "bStateSave": true,//状态保存
        //        "aoColumnDefs": [
        //          //{"bVisible": false, "aTargets": [ 3 ]} //控制列的隐藏显示
        //          {"orderable":false,"aTargets":[0,8,9]}// 制定列不参与排序
        //        ]
        //    });
        //    $('.table-sort tbody').on( 'click', 'tr', function () {
        //        if ( $(this).hasClass('selected') ) {
        //            $(this).removeClass('selected');
        //        }
        //        else {
        //            table.$('tr.selected').removeClass('selected');
        //            $(this).addClass('selected');
        //        }
        //    });
        //});

        ///*用户-还原*/
        //    function member_huanyuan(obj,id){
        //        layer.confirm('确认要还原吗？',function(index){

        //            $(obj).remove();
        //            layer.msg('已还原!',{icon: 6,time:1000});
        //        });
        //    }

        //    /*用户-删除*/
        //    function member_del(obj,id){
        //        layer.confirm('确认要删除吗？',function(index){
        //            $(obj).parents("tr").remove();
        //            layer.msg('已删除!',{icon:1,time:1000});
        //        });
        //    }

    </script>

</asp:Content>
