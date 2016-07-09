<%@ Page Title="" Language="C#" MasterPageFile="~/share/tousuAdmin.Master" AutoEventWireup="true" CodeBehind="article-list.aspx.cs" Inherits="TCS.Web.admin.article_list" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderAdmin1" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderAdminbar" runat="server">
    <li class="active"><span title="资讯列表" data-href="index.aspx">资讯列表</span><em></em></li>
 </asp:Content>   

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolderAdmin2" runat="server">

<nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 资讯管理 <span class="c-gray en">&gt;</span> 资讯列表 <a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
<div class="pd-20">
	<div class="text-c"> 
	</div>
	<div class="cl pd-5 bg-1 bk-gray mt-20"> <span class="l"><%if (Session["current_admin"] != null && (Session["current_admin"] as T_UserInfo).u_roleId == 4)
                                                                 {%><a href="javascript:;" onClick="datadel()" class="btn btn-danger radius"><i class="Hui-iconfont">&#xe6e2;</i> 批量删除</a> <a class="btn btn-primary radius" href="/admin/article-add.aspx""><i class="Hui-iconfont">&#xe600;</i> 添加资讯</a><%} %></span> <span class="r">共有数据：<strong><%=count %></strong> 条</span> </div>
	<div class="mt-20">
		<table class="table table-border table-bordered table-bg table-hover table-sort">
			<thead>
				<tr class="text-c">
					<th width="25"><input type="checkbox" name="" value=""></th>
					<th width="80">编号</th>
					<th>标题</th>
					<th width="80">分类</th>
					<th width="100">来源</th>
					<th width="180">更新时间</th>
					<th width="60">发布状态</th>
					<th width="120">操作</th>
				</tr>
			</thead>
			<tbody>
				
                <%var i = 0;

                    foreach (var item in ArticleList)
                    {
                        i++;

                        %>
                <tr class="text-c">

					<td><input type="checkbox" value="<%=item.a_id %>" name="checkList"></td>
					<td><%=i %></td>
					<td class="text-l"><u style="cursor:pointer" class="text-primary" onClick="article_show('资讯查看','/notice.aspx','<%=item.a_type %>')" title="查看"><%=item.a_title %></u></td>
					<td><%=_ArticleTypeService.QuerySingle(item.a_type).at_name %></td>
					<td><%=item.a_resource %></td>
					<td><%=item.a_createdTime.ToString("yyyy-MM-dd HH:mm:ss") %></td>
					<td class="td-status"><span class="label label-success radius">已发布</span></td>
					<td class="f-14 td-manage">
                        <%if (Session["current_admin"] != null && (Session["current_admin"] as T_UserInfo).u_roleId == 4)
                          {%>
                        <a style="text-decoration:none" class="ml-5"  href="/admin/article-add.aspx?item=<%=item.a_id %>" title="编辑"><i class="Hui-iconfont">&#xe6df;</i></a> <a style="text-decoration:none" class="ml-5" onClick="article_del(this,'<%=item.a_id %>')" href="javascript:;" title="删除"><i class="Hui-iconfont">&#xe6e2;</i></a>
                        <% } %>
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

    $("#menu-article dt").addClass("selected");
    $("#menu-article dd").css("display", "block");
    $("#menu-article li:eq(0) ").css("background-color", "rgba(171, 166, 166, 0.43)");
    $("#menu-article li:eq(0) a").css("color", "#06c");

$('.table-sort').dataTable({
	"aaSorting": [[ 1, "desc" ]],//默认第几个排序
	"bStateSave": true,//状态保存
	"aoColumnDefs": [
	  //{"bVisible": false, "aTargets": [ 3 ]} //控制列的隐藏显示
	  {"orderable":false,"aTargets":[0,7]}// 制定列不参与排序
	]
});

/*资讯-添加*/
function article_add(title,url,w,h){
	var index = layer.open({
		type: 2,
		title: title,
		content: url
	});
	layer.full(index);
}
/*资讯-编辑*/
function article_show(title, url, id) {
	var index = layer.open({
		type: 2,
		title: title,
		content: url+"?type="+parseInt(id)
	});
	layer.full(index);
}
/*资讯-删除*/
function article_del(obj,id){
	layer.confirm('确认要删除吗？',function(index){
	    $.post("/handler/articleOperate.ashx", { aid: parseInt(id), action: "del" }, function (data) {
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
            $.post("/handler/MultiDelete.ashx", { strid: value, action: "article" }, function (data) {
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
