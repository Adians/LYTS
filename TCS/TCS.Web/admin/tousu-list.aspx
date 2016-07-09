<%@ Page Title="" Language="C#" MasterPageFile="~/share/tousuAdmin.Master" AutoEventWireup="true" CodeBehind="tousu-list.aspx.cs" Inherits="TCS.Web.admin.tousu_list" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderAdmin1" runat="server">
    <style>
        .center {
            text-align: center;
        }
    </style>
    <link href="lib/icheck/icheck.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderAdminbar" runat="server">
    <li class="active"><span title="投诉列表" data-href="tousu-list.aspx">投诉列表</span><em></em></li>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolderAdmin2" runat="server">

    <div style="">
        <nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 投诉管理 <span class="c-gray en">&gt;</span> 投诉列表 <a class="btn btn-success radius r mr-20" style="line-height: 1.6em; margin-top: 3px" href="javascript:location.replace(location.href);" title="刷新"><i class="Hui-iconfont">&#xe68f;</i></a></nav>
        <div class="pd-20">
            <div class="text-c">
               
            </div>
            <div class="cl pd-5 bg-1 bk-gray mt-20">
                <span class="l"><%if (Session["current_admin"] != null && (Session["current_admin"] as T_UserInfo).u_roleId == 4)
                                    {%>
                    <a href="javascript:;" onclick="datadel()" class="btn btn-danger radius"><i class="Hui-iconfont">&#xe6e2;</i> 批量删除</a>
                    <% } %></span><span class="r">共有数据：<strong><%=totalcount %></strong> 条</span>
            </div>
            <div class="mt-20">
                <table class="table table-border table-bordered table-bg table-hover table-sort">
                    <thead>
                        <tr class="text-c">
                            <th width="40">
                                <input name="" type="checkbox" value="">
                            </th>
                            <th style="width: 5%">序号
                            </th>
                            <th style="width: 10%">提交时间
                            </th>
                            <th style="width: 10%">提交人
                            </th>
                            <th style="width: 40%">主题
                            </th>
                            <th style="width: 10%">类型
                            </th>
                            <th style="width: 10%">状态
                            </th>
                            <th width="150">操作</th>
                        </tr>
                    </thead>
                    <tbody>
                       
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <%--   编辑投诉回复信息--%>
    <div id="tousureply" style="display: none;">

        <div class="pd-20">
            <form action="/admin/tousu-list.aspx" method="post" class="form form-horizontal" id="form-admin-tousureply">
                <div class="row cl">
                    <label class="form-label col-2">投诉标题：</label>
                    <div class="formControls col-7">
                        <span id="etousuTitle"></span>

                    </div>
                    <div class="col-4"></div>
                </div>
                <div class="row cl">
                    <label class="form-label col-2">投诉回复内容：</label>
                    <div class="formControls col-7">
                        <textarea name="tousureplycontent" id="tousureplycontent" cols="" rows="" style="height: 150px;" class="textarea" placeholder="说点什么...至少10个字符，300个字符以内" datatype="*10-300" dragonfly="true" nullmsg="内容不能为空！" onkeyup="textarealength(this,200)"></textarea>
                        <p class="textarea-numberbar"><em class="textarea-length">0</em>/300</p>
                    </div>
                    <div class="col-3"></div>
                </div>
                <div class="row cl">
                    <div class="col-9 col-offset-2">
                        <input type="hidden" id="tid" name="tid" value="0" />
                        <input type="hidden"  name="rec" value="tousureply" />
                        <input class="btn btn-primary radius" type="submit" value="&nbsp;&nbsp;提交&nbsp;&nbsp;">
                    </div>
                </div>
            </form>
        </div>
    </div>
    <%--   编辑审核备注--%>
    <div id="tousuremark" style="display: none;">

        <div class="pd-20">
            <form action="/admin/tousu-list.aspx" method="post" class="form form-horizontal" id="form-admin-tousuremark">
                
                <div class="row cl">
                    <label class="form-label col-2">备注内容：</label>
                    <div class="formControls col-7">
                        <textarea name="tousuremarktext" id="tousuremarktext" cols="" rows="" style="height: 150px;" class="textarea" placeholder="说点什么...至少10个字符，300个字符以内" datatype="*10-300" dragonfly="true" nullmsg="内容不能为空！" onkeyup="textarealength(this,200)"></textarea>
                        <p class="textarea-numberbar"><em class="textarea-length">0</em>/300</p>
                    </div>
                    <div class="col-3"></div>
                </div>
                <div class="row cl">
                    <div class="col-9 col-offset-2">
                        <input type="hidden" id="rcid" name="rcid" value="0" />
                        <input type="hidden"  name="rec" value="tousuremark" />
                        <input class="btn btn-primary radius" type="submit" value="&nbsp;&nbsp;提交&nbsp;&nbsp;">
                    </div>
                </div>
            </form>
        </div>
    </div>
    <%--查看投诉回复信息--%>
    <div id="tousureplydetail" style="display: none;">

        <div class="pd-20">
          
            <div class="row cl">
                <label class="form-label col-2 col-offset-1">投诉标题：</label>
                <div class="formControls col-7">
                    <span id="vtousuTitle"></span>

                </div>

            </div>
            <div class="row cl">
                <label class="form-label col-2 col-offset-1">投诉回复内容：</label>
                <div class="formControls col-7">
                    <p id="vtousureply" style="text-indent: 2em;">
                    </p>
                </div>

            </div>
            <div class="row cl">
                <label class="form-label col-2 col-offset-1">投诉回复员：</label>
                <div class="formControls col-5">
                    <span id="vtousureplyer"></span> 
                </div>

            </div>
            <div class="row cl">
                <label class="form-label col-2 col-offset-1">投诉回复时间：</label>
                <div class="formControls col-5">
                    <span id="vtousureplytime"> </span>
                </div>

            </div>
            <div class="row cl">
                <label class="form-label col-2 col-offset-1">审核员：</label>
                <div class="formControls col-5">
                    <span id="vtousurinspector"></span> 
                </div>

            </div>
            <div class="row cl">
                <label class="form-label col-2 col-offset-1">审核结果：</label>
                <div class="formControls col-5">
                    <span id="vtousurinspectres"></span>
                </div>

            </div>
            <div class="row cl">
                <label class="form-label col-2 col-offset-1">审核备注：</label>
                <div class="formControls col-5">
                    <span id="vtousurinspectremark"></span>
                </div>

            </div>
            <div class="row cl">
                <label class="form-label col-2 col-offset-1">审核时间：</label>
                <div class="formControls col-5">
                    <span id="vtousurinspecttime"></span>
                </div>

            </div>
           
        </div>
    </div>
    <input type="hidden" id="msg" value="<%=msg %>" />
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolderAdmin3" runat="server">

    <script type="text/javascript" src="lib/laypage/1.2/laypage.js"></script>
    <script type="text/javascript" src="lib/My97DatePicker/WdatePicker.js"></script>
    <script type="text/javascript" src="lib/datatables/1.10.0/jquery.dataTables.min.js"></script>
    <script type="text/javascript" src="lib/icheck/jquery.icheck.min.js"></script>
    <script type="text/javascript" src="lib/Validform/5.3.2/Validform.min.js"></script>

    <script type="text/javascript">
       
 
        $(function () {
            $("#menu-product dt").addClass("selected");
            $("#menu-product dd").css("display", "block");
            $("#menu-product li:eq(0) ").css("background-color", "rgba(171, 166, 166, 0.43)");
            $("#menu-product li:eq(0) a").css("color", "#06c");

            $('.skin-minimal input').iCheck({
                checkboxClass: 'icheckbox-blue',
                radioClass: 'iradio-blue',
                increaseArea: '20%'
            });
            $("#form-admin-tousureply").Validform({
                tiptype: 2,
                callback: function (form) {
                    $("#form-admin-tousureply").submit();
                }
            });

            $("#form-admin-tousuremark").Validform({
                tiptype: 2,
                callback: function (form) {
                    $("#form-admin-tousuremark").submit();
                }
            });

            $('.table-sort').dataTable({
                "aaSorting": [[1, "desc"]],//默认第几个排序
                "bStateSave": true,//状态保存
                "iDisplayLength": 10,
                "aLengthMenu": [[10, 25, 50, -1], [10, 25, 50, "显示所有"]],
                "sAjaxSource": '../handler/tousuList.ashx?role=2',
                //"sAjaxSource": '/test1.js',
                "sAjaxDataProp": "aaData",
                "aoColumns": [{
                    "mDataProp": "ID",
                    "sClass": "center",
                    "fnCreatedCell": function (nTd, sData, oData, iRow, iCol) {
                        $(nTd).html("<input type='checkbox' name='checkList' value='" + sData + "'>");
                    },
                    "bSearchable": false

                }, {
                    "mDataProp": "ORDERNO",
                    "sTitle": "序号",
                    //"sDefaultContent": 1,
                    "sClass": "center"


                    //"sClass": "center"
                }, {
                    "mDataProp": "SUBMITTIME",
                    "sTitle": "提交日期",
                    //"sDefaultContent": "aa",
                    //"sClass": "center"
                    "sClass": "center",
                    "bSearchable": true,
                    "bFilter": true
                }, {
                    "mDataProp": "UNAME",
                    "sTitle": "提交人",
                    //"sDefaultContent": "aa",
                    //"sClass": "center"
                    "sClass": "center",
                    "fnCreatedCell": function (nTd, sData, oData, iRow, iCol) {
                        $(nTd).html("<u style=\"cursor:pointer\" class=\"text-primary\" title=\"查看\" onclick=\"member_show('用户信息','member-show.aspx','"+oData.UID+"','360','450')\">"+sData+"</u>");
                    }
                }, {
                    "mDataProp": "TITLE",
                    "sTitle": "主题",
                    //"sDefaultContent": "aa",
                    //"sClass": "center"
                    "fnCreatedCell": function (nTd, sData, oData, iRow, iCol) {
                        var str;
                        str = "<a style=\"text-decoration:none\" class=\"ml-5\" onClick=\"tousu_show('投诉信息查看','/tousudetail.aspx','" + oData.ID + "')\" href=\"javascript:;\" title=\"查看\">" + sData + "</a> "
                        $(nTd).html(str);
                    }
                }, {
                    "mDataProp": "TYPENAME",
                    "sTitle": "类型",
                    //"sDefaultContent": "aa",
                    "sClass": "center",
                    "fnCreatedCell": function (nTd, sData, oData, iRow, iCol) {
                        var str;
                        if (sData=="安全问题") {
                            str = "<span class=\"label label-danger radius\">" + sData + "</span>";
                        } else if (sData == "环境问题") {

                            str = "<span class=\"label label-success radius\">" + sData + "</span>";
                        } else if (sData == "门票问题") {
                            str = "<span class=\"label label-primary radius\">" + sData + "</span>";
                        } else {
                            str = "<span class=\"label label-secondary radius\">" + sData + "</span>";
                        }
                        
                       
                        $(nTd).html(str);
                    }

                }, {
                    "mDataProp": "STATUSNAME",
                    "sTitle": "状态",
                    "sTitle": "状态",
                    //"sDefaultContent": "",
                    "sClass": "td-status center",
                    "fnCreatedCell": function (nTd, sData, oData, iRow, iCol) {
                        var str;
                        if (sData == "已完结") {
                            str = "<span class=\"label label-success radius\">" + sData + "</span>";
                        }
                        else {
                            str = "<span class=\"label label-danger radius\">" + sData + "</span>";
                        }
                        $(nTd).html(str);
                    }
                }, {
                    "mDataProp": "ID",
                    "sClass": "td-manage center",
                    "fnCreatedCell": function (nTd, sData, oData, iRow, iCol) {
                        var str;
                        var role = <%= (Session["current_admin"]!=null?(Session["current_admin"] as T_UserInfo).u_roleId:2)%>;
                       
                        role = parseInt(role);
                        if(role==2){
                            if(oData.STATUSNAME=="待回复"){
                                str="<a style=\"text-decoration:none\" class=\"ml-5\" onClick=\"tousu_edit('编辑投诉回复','"+oData.TITLE+"','','"+sData+"')\" href=\"javascript:;\" title=\"编辑投诉回复\"><i class=\"Hui-iconfont\">&#xe6df;</i></a> ";
                                str+="<a style=\"text-decoration:none\" class=\"ml-5\" onClick=\"tousu_show('投诉信息查看','/tousudetail.aspx','" + sData + "')\" href=\"javascript:;\" title=\"查看投诉详情\"><i class=\"Hui-iconfont\">&#xe695;</i></a>";
                            }else if(oData.STATUSNAME=="审核不通过"){
                                str='<a class="c-primary" onClick="tousu_shenqing(this,'+sData+')" href="javascript:;" title="申请审核">申请审核</a> ';
                                str +="<a style=\"text-decoration:none\" class=\"ml-5\" onClick=\"tousu_edit('编辑投诉回复','"+oData.TITLE+"','"+oData.RESPONSECONTENT+"','"+sData+"')\" href=\"javascript:;\" title=\"编辑投诉回复\"><i class=\"Hui-iconfont\">&#xe6df;</i></a> ";
                               
                                str +="<a style=\"text-decoration:none\" class=\"ml-5\" onClick=\"tousu_replydetail('投诉回复信息查看','"+oData.TITLE+"','"+oData.RESPONSECONTENT+"','"+oData.RESPONDER+"','"+oData.RESPONSETIME+"','"+oData.INSPECTOR+"','"+oData.INSPECTRESULT+"','"+oData.INSPECTREMARK+"','"+oData.INSPECTTIME+"')\" href=\"javascript:;\" title=\"查看投诉回复信息\"><i class=\"Hui-iconfont\">&#xe6c5;</i></a>";

                                
                            }else{
                                str="<a style=\"text-decoration:none\" class=\"ml-5\" onClick=\"tousu_show('投诉信息查看','/tousudetail.aspx','" + sData + "')\" href=\"javascript:;\" title=\"查看投诉详情\"><i class=\"Hui-iconfont\">&#xe695;</i></a>";
                                str +="<a style=\"text-decoration:none\" class=\"ml-5\" onClick=\"tousu_replydetail('投诉回复信息查看','"+oData.TITLE+"','"+oData.RESPONSECONTENT+"','"+oData.RESPONDER+"','"+oData.RESPONSETIME+"','"+oData.INSPECTOR+"','"+oData.INSPECTRESULT+"','"+oData.INSPECTREMARK+"','"+oData.INSPECTTIME+"')\" href=\"javascript:;\" title=\"查看投诉回复信息\"><i class=\"Hui-iconfont\">&#xe6c5;</i></a>";
                            }
                            
                        }else if(role==3){
                            if(oData.STATUSNAME=="待审核"||oData.STATUSNAME=="审核不通过"||oData.STATUSNAME=="申请审核中"){
                                str = "<a style=\"text-decoration:none\" onClick=\"tousu_shenhe(this,'"+sData+"')\" href=\"javascript:;\" title=\"审核\">审核</a> ";
                                str +="<a style=\"text-decoration:none\" class=\"ml-5\" onClick=\"tousu_replydetail('投诉回复信息查看','"+oData.TITLE+"','"+oData.RESPONSECONTENT+"','"+oData.RESPONDER+"','"+oData.RESPONSETIME+"','"+oData.INSPECTOR+"','"+oData.INSPECTRESULT+"','"+oData.INSPECTREMARK+"','"+oData.INSPECTTIME+"')\" href=\"javascript:;\" title=\"查看投诉回复信息\"><i class=\"Hui-iconfont\">&#xe6c5;</i></a>";
                                str +="<a style=\"text-decoration:none\" class=\"ml-5\" onClick=\"tousu_show('投诉信息查看','/tousudetail.aspx','" + sData + "')\" href=\"javascript:;\" title=\"查看投诉详情\"><i class=\"Hui-iconfont\">&#xe695;</i></a>";
                                
                            }else if(oData.STATUSNAME=="待回复"){
                                str="<a style=\"text-decoration:none\" class=\"ml-5\" onClick=\"tousu_show('投诉信息查看','/tousudetail.aspx','" + sData + "')\" href=\"javascript:;\" title=\"查看投诉详情\"><i class=\"Hui-iconfont\">&#xe695;</i></a>";
                            }else{
                                str ="<a style=\"text-decoration:none\" class=\"ml-5\" onClick=\"tousu_replydetail('投诉回复信息查看','article-add.html','"+sData+"')\" href=\"javascript:;\" title=\"查看投诉回复信息\"><i class=\"Hui-iconfont\">&#xe6c5;</i></a>";
                                str+="<a style=\"text-decoration:none\" class=\"ml-5\" onClick=\"tousu_show('投诉信息查看','/tousudetail.aspx','" + sData + "')\" href=\"javascript:;\" title=\"查看投诉详情\"><i class=\"Hui-iconfont\">&#xe695;</i></a>";
                            }
                            
                        }else if(role==4){
                           
                            str="<a style=\"text-decoration:none\" class=\"ml-5\" onClick=\"tousu_show('投诉信息查看','/tousudetail.aspx','" + sData + "')\" href=\"javascript:;\" title=\"查看投诉详情\"><i class=\"Hui-iconfont\">&#xe695;</i></a>";
                            str+="<a style=\"text-decoration:none\" class=\"ml-5\" onClick=\"tousu_del(this,'"+sData+"')\" href=\"javascript:;\" title=\"删除\"><i class=\"Hui-iconfont\">&#xe6e2;</i></a>";
                        }else{
                            str="<a style=\"text-decoration:none\" class=\"ml-5\" onClick=\"tousu_show('投诉信息查看','/tousudetail.aspx','" + sData + "')\" href=\"javascript:;\" title=\"查看投诉详情\"><i class=\"Hui-iconfont\">&#xe695;</i></a>";
                        
                        }
                        
                        $(nTd).html(str);
                    }
                }],
                "aoColumnDefs": [
                  //{"bVisible": false, "aTargets": [ 3 ]} //控制列的隐藏显示
                  { "orderable": false, "aTargets": [0, 7] }// 制定列不参与排序

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
        /*添加*/
        function tousu_add(title, url) {
            var index = layer.open({
                type: 2,
                title: title,
                content: url
            });
            layer.full(index);
        }
        /*投诉回复信息查看*/
        function tousu_replydetail(title, ctitle,responsecontent, responser,responsetime,inspector,inspectres,inspectremark,inspecttime){
                        
            $("#vtousuTitle").text(ctitle);
            $("#vtousureply").text(responsecontent);
            $("#vtousureplyer").text(responser);
            $("#vtousureplytime").text(responsetime);
             if(inspector==null||inspector==""||inspectres==null||inspectres==""||inspectremark==null||inspectremark==""){
                 $("#vtousurinspector").text("未审核");
                 $("#vtousurinspectres").text("未审核");
                 $("#vtousurinspectremark").text("未审核");
                 $("#vtousurinspecttime").text("未审核");
             }else{
                 $("#vtousurinspector").text(inspector);
                 $("#vtousurinspectres").text(inspectres);
                 $("#vtousurinspectremark").text(inspectremark);
                 $("#vtousurinspecttime").text(inspecttime);
             }
             
            var w=750;
            var h=400;
            if (title == null || title == '') {
                title=false;
            };
            if (w == null || w == '') {
                w=800;
            };
            if (h == null || h == '') {
                h=($(window).height() - 50);
            };
            var index = layer.open({
                type: 1,
                area: [w + 'px', h + 'px'],
                shade:false,
                title: title,
                content: $("#tousureplydetail"),
                
            });
        }

        /*用户-查看*/
        function member_show(title,url,id,w,h){
            layer_show(title,url+"?uid="+id,w,h);
        }

        /*查看  */
        function tousu_show(title, url, id) {
            var index = layer.open({
                type: 2,
                title: title,
                content: url+"?item="+parseInt(id)
            });
            layer.full(index);
        }
        /*审核*/
        function tousu_shenhe(obj, id) {
            layer.confirm('通过审核？', {
                btn: ['通过', '不通过'],
                shade: false
            },
            function () {
                $.post("/handler/tousuOperate.ashx", { cid: parseInt(id), action: "shpass" }, function (data) {
                    //alert(data);
                    if (data) {
                        $(obj).parents("tr").find(".td-status").html('<span class="label label-danger radius">通过审核/待反馈</span>');
                        $(obj).remove();
                        layer.msg('审核成功', { icon: 6, time: 1000 });

                    } else {
                        layer.msg('操作失败!', { icon: 5, time: 1000 });
                    }

                });
            },
            function () {
                
                //$.post("/handler/tousuOperate.ashx", { cid: parseInt(id), action: "shunpass" }, function (data) {
                    //alert(data);
                    //if (data) {
                        //$(obj).parents("tr").find(".td-status").html('<span class="label label-danger radius">审核不通过</span>');
                //layer.msg('审核未通过', { icon: 5, time: 1000 });

                        $("#rcid").val(id);
                        var w=750;
                        var h=400;
                        var title="投诉审核备注";
                        if (title == null || title == '') {
                            title=false;
                        };
                        if (w == null || w == '') {
                            w=800;
                        };
                        if (h == null || h == '') {
                            h=($(window).height() - 50);
                        };
                        layer.open({
                            type: 1,
                            area: [w + 'px', h + 'px'],
                            shade:false,
                            title: title,
                            content: $("#tousuremark"),
                
                        });
                       // layer.msg('审核未通过', { icon: 5, time: 1000 });

                    //} else {
                       // layer.msg('操作失败!', { icon: 5, time: 1000 });
                    //}

               // });
            });
        }
      
      
        
        /*申请审核*/
        function tousu_shenqing(obj, id) {
            $.post("/handler/tousuOperate.ashx", { cid: parseInt(id), action: "shenqing" }, function (data) {
                //alert(data);
                if (data=="true") {
                    $(obj).parents("tr").find(".td-status").html('<span class="label label-danger radius">待审核</span>');
                    $(obj).remove();
                    layer.msg('已提交申请，耐心等待审核!', { icon: 1, time: 2000 });

                } else {
                    layer.msg('申请失败!', { icon: 5, time: 1000 });
                }

            });

        }
        /*编辑*/
        function tousu_edit(title,ctitle, resplycontent, id) {
            $("#tid").val(id);
            $("#etousuTitle").text(ctitle);
            if(resplycontent != null || resplycontent != ''){
                $("#tousureplycontent").val(resplycontent);
            }
            
            var w=750;
            var h=400;
            if (title == null || title == '') {
                title=false;
            };
            if (w == null || w == '') {
                w=800;
            };
            if (h == null || h == '') {
                h=($(window).height() - 50);
            };
            var index = layer.open({
                type: 1,
                area: [w + 'px', h + 'px'],
                shade:false,
                title: title,
                content: $("#tousureply"),
                
            });
            //layer.full(index);
        }


        /*删除*/
        function tousu_del(obj, id) {
            layer.confirm('确认要删除吗？', function (index) {

                $.post("/handler/tousuOperate.ashx", { cid: parseInt(id), action: "del" }, function (data) {
                    //alert(data);
                    if (data=="true") {
                        $(obj).parents("tr").remove();
                        layer.msg('已删除!', { icon: 1, time: 1000 });

                    } else {
                        layer.msg('删除失败!', { icon: 2, time: 1000 });

                    }

                });
                
            });
        }


        if (parseInt($("#msg").val()) == 1) {
            layer.msg('编辑成功!', { icon: 1, time: 1000 });
        } else if (parseInt($("#msg").val()) == -1) {

            layer.msg('编辑失败!', { icon: 2, time: 1000 });

        }
        if (parseInt($("#msg").val()) == 2) {

            layer.msg('审核未通过', { icon: 5, time: 1000 });

        }else if (parseInt($("#msg").val()) == -2) {

            layer.msg('操作失败!', { icon: 2, time: 1000 });

        }



        function datadel(){
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
                    $.post("/handler/MultiDelete.ashx", { strid: value, action: "tousuinfo" }, function (data) {
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
        
    </script>
</asp:Content>
