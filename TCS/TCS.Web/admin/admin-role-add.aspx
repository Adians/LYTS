<%@ Page Title="" Language="C#" MasterPageFile="~/share/commonhead.Master" AutoEventWireup="true" CodeBehind="admin-role-add.aspx.cs" Inherits="TCS.Web.admin.admin_role_add" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderC1" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderC2" runat="server">

    <div class="pd-20">
	<form action="/admin/admin-role-add.aspx" method="post" class="form form-horizontal" id="form-role-add">
		<div class="row cl">
			<label class="form-label col-2"><span class="c-red">*</span>角色名称：</label>
			<div class="formControls col-5">
				<input type="text" class="input-text" value="" placeholder="" id="rolename" name="rolename" datatype="*2-16" nullmsg="角色名称不能为空">
			</div>
            <div class="col-4"></div>
		</div>

		<div class="row cl">
			<label class="form-label col-2">备注：</label>
			<div class="formControls col-5">
				<input type="text" class="input-text" value="" placeholder="" id="roleremark" name="roleremark" datatype="*2-50" nullmsg="备注不能为空">
			</div>
            <div class="col-4"></div>
		</div>
		
		<div class="row cl">
			<div class="col-5 col-offset-2">
                <input type="hidden" name="rid" id="rid" value="0" />
				<button type="submit" class="btn btn-success radius" id="admin-role-save" name="admin-role-save"><i class="icon-ok"></i> 确定</button>
			</div>
		</div>
	</form>
         <input  type="hidden" id="msg" value="<%=msg %>" />
</div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolderC3" runat="server">
    
<script type="text/javascript" src="lib/laypage/1.2/laypage.js"></script> 
<script type="text/javascript" src="lib/My97DatePicker/WdatePicker.js"></script> 
    <script type="text/javascript" src="lib/Validform/5.3.2/Validform.min.js"></script> 
    <script>
        $(function () {
            $("#form-role-add").Validform({
                tiptype: 2,
                callback: function (form) {
                    $("#form-role-add").submit();
                }
            });


            var index = parent.layer.getFrameIndex(window.name);

            if (parseInt($("#msg").val()) == 1) {
                parent.refresh();
                parent.msg(1);
                parent.layer.close(index);
            } else if (parseInt($("#msg").val()) == -1) {
                parent.msg(-1);
                parent.layer.close(index);
            }
            else if (parseInt($("#msg").val()) == 2) {
                parent.refresh();
                parent.msg(2);
                parent.layer.close(index);
            } else if (parseInt($("#msg").val()) == -2) {
                parent.msg(-2);
                parent.layer.close(index);
            }
});
</script>
</asp:Content>
