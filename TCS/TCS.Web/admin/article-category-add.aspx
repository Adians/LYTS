<%@ Page Title="" Language="C#" MasterPageFile="~/share/commonhead.Master" AutoEventWireup="true" CodeBehind="article-category-add.aspx.cs" Inherits="TCS.Web.admin.article_category_add" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderC1" runat="server">
       <link href="lib/icheck/icheck.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderC2" runat="server"><div class="pd-20">
  <form action="/admin/article-category-add.aspx" method="post" class="form form-horizontal" id="article-category-add">
    <div class="row cl">
      <label class="form-label col-3"><span class="c-red">*</span>类型名称：</label>
      <div class="formControls col-5">
        <input type="text" class="input-text" value="" datatype="*2-20" dragonfly="true" nullmsg="类型名不能为空！" placeholder="" id="article-category-name" name="article-category-name">
      </div>
      <div class="col-3"> </div>
    </div>
     
    <div class="row cl">
      <div class="col-9 col-offset-3">
          <input type="hidden" id="atid" name="atid" value="0" />
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
	
	$("#article-category-add").Validform({
		tiptype:2,
		callback:function(form){
		    $("#article-category-add").submit();
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

