<%@ Page Title="" Language="C#" MasterPageFile="~/share/commonhead.Master" AutoEventWireup="true" CodeBehind="tousu-category-add.aspx.cs" Inherits="TCS.Web.admin.tousu_category_add" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderC1" runat="server">
    <link href="lib/icheck/icheck.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderC2" runat="server">

    <div class="pd-20">
  <form action="/admin/tousu-category-add.aspx" method="post" class="form form-horizontal" id="tousu-category-add">
    <div class="row cl">
      <label class="form-label col-2"><span class="c-red">*</span>类型名称：</label>
      <div class="formControls col-5">
        <input type="text" class="input-text" value="" datatype="*4-20" dragonfly="true" nullmsg="类型名不能为空！" placeholder="" id="tousu-category-name" name="tousu-category-name">
      </div>
      <div class="col-4"> </div>
    </div>
      <div class="row cl">
			<label class="form-label col-2"><span class="c-red">*</span>风格：</label>
			<div class="formControls col-5"> <span class="select-box">
				<select name="tousu-category-style" class="select">
					<option value="nav-block-green">绿色</option>
					<option value="nav-block-yellow">黄色</option>
					<option value="nav-block-red">红色</option>
					<option value="nav-block-orange">橙色</option>
                    <option value="nav-block-blue">蓝色</option>
                    <option value="nav-block-green double">绿色双倍长度</option>
					<option value="nav-block-yellow double">黄色双倍长度</option>
					<option value="nav-block-red double">红色双倍长度</option>
					<option value="nav-block-orange double">橙色双倍长度</option>
                    <option value="nav-block-blue double">蓝色双倍长度</option>
				</select>
				</span> </div>
			
		</div>
      <div class="row cl">
      <label class="form-label col-2"><span class="c-red">*</span>图标：</label>
      <div class="formControls col-5">
        <input type="text" class="input-text" value="" datatype="*5-30" dragonfly="true" nullmsg="图标不能为空！" placeholder="在图标库中选取" id="tousu-category-icon" name="tousu-category-icon">
      </div>
      <div class="col-4"> </div>
    </div>
    
    <div class="row cl">
      <div class="col-9 col-offset-2">
          <input type="hidden" id="tid" name="tid" value="0" />
        <input class="btn btn-primary radius" type="submit" value="&nbsp;&nbsp;提交&nbsp;&nbsp;">
      </div>
    </div>
  </form>
        <input  type="hidden" id="msg" value="<%=msg %>" />
</div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolderC3" runat="server">
    <script type="text/javascript" src="lib/icheck/jquery.icheck.min.js"></script> 
<script type="text/javascript" src="lib/Validform/5.3.2/Validform.min.js"></script> 

<script type="text/javascript">
$(function(){
	$('.skin-minimal input').iCheck({
		checkboxClass: 'icheckbox-blue',
		radioClass: 'iradio-blue',
		increaseArea: '20%'
	});
	
	$("#tousu-category-add").Validform({
		tiptype:2,
		callback:function(form){
		    $("#tousu-category-add").submit();
			//var index = parent.layer.getFrameIndex(window.name);
			//parent.$('.btn-refresh').click();
			//parent.layer.close(index);
		}
	});

	var index = parent.layer.getFrameIndex(window.name);

	if (parseInt($("#msg").val()) == 1) {
	    //parent.$('.btn-refresh').click();
	    parent.msg(1);
	    parent.layer.close(index);
	} else if (parseInt($("#msg").val()) == -1) {

	    //parent.$('.btn-refresh').click();
	    parent.msg(-1);
	    parent.layer.close(index);

	}
	else if (parseInt($("#msg").val()) == 2) {
	    //parent.$('.btn-refresh').click();
	    parent.msg(2);
	    parent.layer.close(index);
	} else if (parseInt($("#msg").val()) == -2) {
	    // parent.$('.btn-refresh').click();
	    parent.msg(-2);
	    parent.layer.close(index);

	} else if (parseInt($("#msg").val()) == 3) {
	    parent.layer.close(index);

	}
});
</script>
</asp:Content>
