<%@ Page Title="" Language="C#" MasterPageFile="~/share/tousuAdmin.Master" AutoEventWireup="true" CodeBehind="comment-list.aspx.cs" Inherits="TCS.Web.admin.comment_list" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderAdmin1" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderAdminbar" runat="server">
     <li class="active"><span title="投诉评论" data-href="feedback-list.aspx">投诉评论</span><em></em></li>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolderAdmin2" runat="server"><nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 评论管理 <span class="c-gray en">&gt;</span> 评论列表 <a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
<div class="pd-20">
	<div class="text-c">
	</div>
	<div class="cl pd-5 bg-1 bk-gray mt-20"> <span class="l">
        <%if (Session["current_admin"] != null && (Session["current_admin"] as T_UserInfo).u_roleId == 4)
            {%><a href="javascript:;" onClick="datadel()" class="btn btn-danger radius"><i class="Hui-iconfont">&#xe6e2;</i> 批量删除</a> <%} %></span> <span class="r">共有数据：<strong><%=count %></strong> 条</span> </div>
	<div class="mt-20">
		<table class="table table-border table-bordered table-hover table-bg table-sort">
			<thead>
				<tr class="text-c">
					<th width="25"><input type="checkbox" name="" value=""></th>
					<th width="40">编号</th>
					<th width="60">用户名</th>
					<th width="60">投诉单号</th>
                    <th>评论内容</th>
                    <th width="40">序号</th>
                    <th width="180">评论时间</th>
					<th width="100">操作</th>
				</tr>
			</thead>
			<tbody>
                <%var i = 0;
                    foreach (var item in ComplaintDiscussList)
                    {
                        i++;
                        %>
                <tr class="text-c">
					<td><input type="checkbox" value="<%=item.cd_id %>" name="checkList"></td>
					<td><%=i %></td>
                    <td><u style="cursor:pointer" class="text-primary" title="查看" onclick="member_show('用户信息','member-show.aspx','<%=item.cd_uid %>','360','450')"><%=_UserInfoService.QuerySingle(item.cd_uid).u_loginName  %></u></td>
                    <td><u style="cursor:pointer" class="text-primary" title="查看" onclick="tousu_show('查看投诉详情','/tousudetail.aspx','<%=item.cd_cid %>')">TS<%=item.cd_cid %></u></td>
                    <td class="text-l"><%=item.cd_discContent %></td>
					<td><%=item.cd_discOrder %>楼</td>
					<td><%=item.cd_discTime.ToString("yyyy-MM-dd HH:mm:ss") %></td>
					<td class="td-manage">
                         <%if (Session["current_admin"] != null && (Session["current_admin"] as T_UserInfo).u_roleId == 4)
                             {%><a title="删除" href="javascript:;" onClick="comment_del(this,'<%=item.cd_id %>')" class="ml-5" style="text-decoration:none"><i class="Hui-iconfont">&#xe6e2;</i></a><%} %></td>
				</tr>

                  <%  } %>
				
				
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
        $("#menu-comments dt").addClass("selected");
        $("#menu-comments dd").css("display", "block");
        $("#menu-comments li:eq(0) ").css("background-color", "rgba(171, 166, 166, 0.43)");
        $("#menu-comments li:eq(0) a").css("color", "#06c");
	$('.table-sort').dataTable({
		"aaSorting": [[ 1, "desc" ]],//默认第几个排序
		"bStateSave": true,//状态保存
		"aoColumnDefs": [
		  //{"bVisible": false, "aTargets": [ 3 ]} //控制列的隐藏显示
		  {"orderable":false,"aTargets":[0,4,7]}// 制定列不参与排序
		]
	});
	$('.table-sort tbody').on( 'click', 'tr', function () {
		if ( $(this).hasClass('selected') ) {
			$(this).removeClass('selected');
		}
		else {
			table.$('tr.selected').removeClass('selected');
			$(this).addClass('selected');
		}
	});
});
/*用户-添加*/
function member_add(title,url,w,h){
	layer_show(title,url,w,h);
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
        content: url + "?item=" + parseInt(id)
    });
    layer.full(index);
}


/*删除*/
function comment_del(obj, id) {
    layer.confirm('确认要删除吗？', function (index) {

        $.post("/handler/commentOperate.ashx", { cid: parseInt(id), action: "del" }, function (data) {
            //alert(data);
            if (data == "true") {
                $(obj).parents("tr").remove();
                layer.msg('已删除!', { icon: 1, time: 1000 });

            } else {
                layer.msg('删除失败!', { icon: 2, time: 1000 });

            }

        });

    });
}

function datadel() {
   
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

            
            $.post("/handler/MultiDelete.ashx", { strid: value, action: "comment" }, function (data) {
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
