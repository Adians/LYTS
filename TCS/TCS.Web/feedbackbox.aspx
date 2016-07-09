<%@ Page Title="" Language="C#" MasterPageFile="~/share/commonhead.Master" AutoEventWireup="true" CodeBehind="feedbackbox.aspx.cs" Inherits="TCS.Web.feedbackbox" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderC1" runat="server">
    <meta charset="utf-8">
<meta name="renderer" content="webkit|ie-comp|ie-stand">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta http-equiv="Cache-Control" content="no-siteapp" />
<!--[if lt IE 9]>
<script type="text/javascript" src="/admin/lib/html5.js"></script>
<script type="text/javascript" src="/admin/lib/respond.min.js"></script>
<script type="text/javascript" src="/admin/lib/PIE_IE678.js"></script>
<![endif]-->
<link href="/admin/css/H-ui.min.css" rel="stylesheet" type="text/css" />
<link href="/admin/css/H-ui.admin.css" rel="stylesheet" type="text/css" />
<link href="/admin/lib/icheck/icheck.css" rel="stylesheet" type="text/css" />
<link href="/admin/lib/Hui-iconfont/1.0.1/iconfont.css" rel="stylesheet" type="text/css" />
<!--[if IE 6]>
<script type="text/javascript" src="admin/lib/DD_belatedPNG_0.0.8a-min.js" >
<script>DD_belatedPNG.fix('*');</script>
<![endif]-->

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderC2" runat="server">
<div class="pd-20">
        <form action="/feedbackbox.aspx" method="post" class="form form-horizontal" id="form-feedback">
            
            <div class="row cl">
                <label class="form-label col-3"><span class="c-red">*</span>联系邮箱：</label>
                <div class="formControls col-5">
                   <span><%=userInfo != null ? userInfo.u_email : string.Empty %></span> 
                </div>
                <div class="col-4"></div>
            </div>
            
            <div class="row cl">
                <label class="form-label col-3">反馈意见：</label>
                <div class="formControls col-5">
                    <textarea name="feedbackcontent" cols="" rows="" datatype="*10-500" nullmsg="内容不能为空" class="textarea" placeholder="说点什么...500个字符以内" dragonfly="true" onkeyup="textarealength(this,500)"></textarea>
                    <p class="textarea-numberbar"><em class="textarea-length">0</em>/500</p>
                </div>
                <div class="col-4"></div>
            </div>
            <div class="row cl">
                <div class="col-9 col-offset-3">
                    <input class="btn btn-primary radius" type="submit" value="&nbsp;&nbsp;提交&nbsp;&nbsp;">
                    <input class="btn btn-primary radius" id="concelbtn" type="button" value="&nbsp;&nbsp;取消&nbsp;&nbsp;">
                </div>
            </div>
        </form>
     <input type="hidden"  id="msg" value="<%=msg %>"/>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolderC3" runat="server">

    <script type="text/javascript" src="admin/lib/jquery/1.9.1/jquery.min.js"></script> 
<script type="text/javascript" src="admin/lib/icheck/jquery.icheck.min.js"></script> 
<script type="text/javascript" src="admin/lib/Validform/5.3.2/Validform.min.js"></script> 
<script type="text/javascript" src="admin/lib/layer/1.9.3/layer.js"></script> 
<script type="text/javascript" src="admin/js/H-ui.js"></script> 
<script type="text/javascript" src="admin/js/H-ui.admin.js"></script> 
<script type="text/javascript" src="admin/lib/icheck/jquery.icheck.min.js"></script> 
<script type="text/javascript">
$(function(){
	$('.skin-minimal input').iCheck({
		checkboxClass: 'icheckbox-blue',
		radioClass: 'iradio-blue',
		increaseArea: '20%'
	});
	var msg = $("#msg").val();
	if(parseInt(msg)>=1){
	    var index = parent.layer.getFrameIndex(window.name);
	    parent.MasterMsg(parseInt(msg));
	    parent.layer.close(index);
	}
	$("#form-feedback").Validform({
		tiptype:2,
		callback:function(form){
		    $("#form-feedback").submit();
			var index = parent.layer.getFrameIndex(window.name);
			parent.$('.btn-refresh').click();
			parent.layer.close(index);
		}
	});

	$("#concelbtn").click(function () {
	   
	    var index = parent.layer.getFrameIndex(window.name);
	    parent.layer.close(index);

	});
});
</script>

</asp:Content>
