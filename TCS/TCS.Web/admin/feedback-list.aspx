<%@ Page Title="" Language="C#" MasterPageFile="~/share/tousuAdmin.Master" AutoEventWireup="true" CodeBehind="feedback-list.aspx.cs" Inherits="TCS.Web.admin.feedback_list" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderAdmin1" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderAdminbar" runat="server">
    <li class="active"><span title="意见反馈" data-href="feedback-list.aspx">意见反馈</span><em></em></li>
 </asp:Content>   

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolderAdmin2" runat="server">

<nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 评论管理 <span class="c-gray en">&gt;</span> 意见反馈 <a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
<div class="pd-20">
	<div class="text-c"> 
	</div>
	<div class="cl pd-5 bg-1 bk-gray mt-20"> <span class="l"><a href="javascript:;" onClick="datadel()" class="btn btn-danger radius"><i class="Hui-iconfont">&#xe6e2;</i> 批量删除</a> </span> <span class="r">共有数据：<strong><%=count %></strong> 条</span> </div>
	<div class="mt-20">
		<table class="table table-border table-bordered table-hover table-bg table-sort">
			<thead>
				<tr class="text-c">
					<th width="25"><input type="checkbox" name="" value=""></th>
					<th width="60">ID</th>
					<th width="80">用户名</th>
					<th>留言内容</th>
                    <th width="180">留言时间</th>
					<th width="60">操作</th>
				</tr>
			</thead>
			<tbody>
                <%
                    var i = 0;
                    foreach (var item in FeedBackList)
                    {
                        i++;
                %>

                <tr class="text-c">
					<td><input type="checkbox" value="<%=item.f_id %>" name="checklist"></td>
					<td><%=i %></td>
					<td><a href="javascript:;" onClick="member_show('<%=_UserInfoService.QuerySingle(item.f_uid).u_loginName  %>','member-show.aspx','<%=item.f_uid %>','360','450')"><%=_UserInfoService.QuerySingle(item.f_uid).u_loginName  %></a></td>
					<td class="text-l">
                        <div>
						<%=item.f_content %>
                        </div>

					</td>
                    <td><%=item.f_createtime.ToString("yyyy-MM-dd HH:mm:ss") %></td>
					<td class="td-manage"> <a title="删除" href="javascript:;" onClick="feedback_del(this,'<%=item.f_id %>')" class="ml-5" style="text-decoration:none"><i class="Hui-iconfont">&#xe6e2;</i></a></td>
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
        $("#menu-comments li:eq(1) ").css("background-color", "rgba(171, 166, 166, 0.43)");
        $("#menu-comments li:eq(1) a").css("color", "#06c");
	$('.table-sort').dataTable({
		"aaSorting": [[ 1, "desc" ]],//默认第几个排序
		"bStateSave": true,//状态保存
		"aoColumnDefs": [
		  //{"bVisible": false, "aTargets": [ 3 ]} //控制列的隐藏显示
		  {"orderable":false,"aTargets":[0,3,5]}// 制定列不参与排序
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
    layer_show(title, url + "?uid=" + id, w, h);
}

</script>

</asp:Content>
