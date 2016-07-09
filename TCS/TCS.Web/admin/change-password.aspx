<%@ Page Title="" Language="C#" MasterPageFile="~/share/commonhead.Master" AutoEventWireup="true" CodeBehind="change-password.aspx.cs" Inherits="TCS.Web.admin.change_password" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderC1" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderC2" runat="server">

<div class="pd-20">
	<form action="/admin/change-password.aspx" method="post" class="form form-horizontal" id="form-change-password">
		<div class="row cl">
			<label class="form-label col-4"><span class="c-red">*</span>账户：</label>
			<div class="formControls col-4" id="epUserName"> 张三 </div>
			<div class="col-4"> </div>
		</div>
		<div class="row cl">
			<label class="form-label col-4"><span class="c-red">*</span>新密码：</label>
			<div class="formControls col-4">
				<input type="password" class="input-text" autocomplete="off" placeholder="不修改请留空" name="new-password" id="new-password" datatype="*6-18" ignore="ignore" >
			</div>
			<div class="col-4"> </div>
		</div>
		<div class="row cl">
			<label class="form-label col-4"><span class="c-red">*</span>确认密码：</label>
			<div class="formControls col-4">
				<input type="password" class="input-text" autocomplete="off" placeholder="不修改请留空" name="new-password2" id="new-password2" recheck="new-password" datatype="*6-18" errormsg="您两次输入的密码不一致！" ignore="ignore" >
			</div>
			<div class="col-4"> </div>
		</div>
		<div class="row cl">
			<div class="col-8 col-offset-4">
				<input class="btn btn-primary radius" type="submit" value="&nbsp;&nbsp;保存&nbsp;&nbsp;">
			</div>
		</div>
        <input type="hidden" id="epUserId" name="epUserId" value="" />
	</form>
    
    <input  type="hidden" id="msg" value="<%=msg %>" />
</div>



</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolderC3" runat="server">

    <script type="text/javascript" src="lib/Validform/5.3.2/Validform.min.js"></script> 

<script>
$(function(){
	$("#form-change-password").Validform({
		tiptype:2,
		callback:function(form){
		    //form[0].submit();
		    $("#form-change-password").submit();
			
		    //parent.$("#handle_status").val('1');
			
		}
	});
	var index = parent.layer.getFrameIndex(window.name);
	if (parseInt($("#msg").val())==1) {
	    
			parent.msg(1);
            parent.layer.close(index);
	} else if (parseInt($("#msg").val()) == -1)
	{
	   
	    parent.msg(-1);
	    parent.layer.close(index);

	} else if (parseInt($("#msg").val()) == 2) {
	    
	    parent.layer.close(index);

	}
});


</script>
</asp:Content>
