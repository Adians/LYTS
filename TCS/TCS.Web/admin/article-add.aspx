<%@ Page Title="" Language="C#" MasterPageFile="~/share/tousuAdmin.Master" AutoEventWireup="true" CodeBehind="article-add.aspx.cs" Inherits="TCS.Web.admin.article_add" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderAdmin1" runat="server">
    <link href="lib/icheck/icheck.css" rel="stylesheet" type="text/css" />
    <style>
        
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderAdminbar" runat="server">
    <li class="active"><span title="添加资讯" >添加资讯</span><em></em></li>
 </asp:Content>  
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolderAdmin2" runat="server">
    <nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 资讯管理 <span class="c-gray en">&gt;</span> 添加资讯 <a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
    <div class="pd-20">
	<form action="/admin/article-add.aspx" method="post" class="form form-horizontal" name="form1" id="form-article-add">
		<div class="row cl">
			<label class="form-label col-2"><span class="c-red">*</span>文章标题：</label>
			<div class="formControls col-7">
				<input type="text" class="input-text" value="<%=CurrentArticle!=null?CurrentArticle.a_title:string.Empty %>" datatype="*5-50" dragonfly="true" nullmsg="标题不能为空！"  placeholder="" id="articletitle" name="articletitle">
			</div>
            <div class="col-3"> </div>
		</div>
		
		<div class="row cl">
			<label class="form-label col-2"><span class="c-red">*</span>分类栏目：</label>
			<div class="formControls col-2"> <span class="select-box">
				<select name="articletype" class="select">
                    <%foreach (var item in ArticleTypeList)
                        {%>
                    <option  value="<%=item.at_id %>" <%=CurrentArticle!=null?(CurrentArticle.a_type==item.at_id?"selected=\"selected\"":""):string.Empty %>><%=item.at_name %></option>
                       <% } %>
				</select>
				</span> </div>
			
		</div>
		
		
		<div class="row cl">
			<label class="form-label col-2"><span class="c-red">*</span>文章作者：</label>
			<div class="formControls col-2">
				<input type="text" class="input-text" value="<%=CurrentArticle!=null?CurrentArticle.a_author:string.Empty %>" datatype="*2-10" dragonfly="true" nullmsg="文章作者不能为空！"   placeholder="" id="" name="articleauthor">
			</div>
			<div class="col-3"> </div>
		</div>
        
        <div class="row cl">
			
			<label class="form-label col-2"><span class="c-red">*</span>文章来源：</label>
			<div class="formControls col-2">
				<input type="text" class="input-text" value="<%=CurrentArticle!=null?CurrentArticle.a_resource:string.Empty %>" datatype="*2-20" dragonfly="true" nullmsg="文章来源不能为空！"  placeholder="" id="" name="articleresource">
			</div>
            <div class="col-3"> </div>
		</div>
		<div class="row cl">
			<label class="form-label col-2"><span class="c-red">*</span>文章内容：</label>
			<div class="formControls col-9"> 
				<!-- KindEditor -->
                            <link rel="stylesheet" href="/admin/js/kindeditor/themes/default/default.css" />
                            <link rel="stylesheet" href="/admin/js/kindeditor/plugins/code/prettify.css" />
                            <script charset="utf-8" src="/admin/js/kindeditor/kindeditor.js"></script>
                            <script charset="utf-8" src="/admin/js/kindeditor/lang/zh_CN.js"></script>
                            <script charset="utf-8" src="/admin/js/kindeditor/plugins/code/prettify.js"></script>
                            <script>
                                KindEditor.ready(function (K) {
                                    var editor1 = K.create('textarea[name="content"]', {
                                        cssPath: '../plugins/code/prettify.css',
                                        uploadJson: '/upload_json.ashx',
                                        fileManagerJson: '../asp.net/file_manager_json.ashx',
                                        allowFileManager: true,
                                        afterCreate: function () {
                                            var self = this;
                                            K.ctrl(document, 13, function () {
                                                self.sync();
                                                K('form[name=form1]')[0].submit();
                                            });
                                            K.ctrl(self.edit.doc, 13, function () {
                                                self.sync();
                                                K('form[name=form1]')[0].submit();
                                            });
                                        }
                                    });
                                    prettyPrint();
                                    
                                });
                            </script>
                            <!-- /KindEditor -->
                            <textarea id="content" name="content"  style="width: 830px; height: 400px;" class="textArea"><%=CurrentArticle!=null?CurrentArticle.a_content:string.Empty %></textarea>
               
			</div>
		</div>
		<div class="row cl">
			<div class="col-10 col-offset-2">
                <input type="hidden" name="aid" value="<%=aid %>" />
				<button onClick="article_save_submit();" class="btn btn-primary radius" type="submit"><i class="Hui-iconfont">&#xe632;</i> 提交发布</button>
				<button onClick="layer_close();" class="btn btn-default radius" type="button">&nbsp;&nbsp;取消&nbsp;&nbsp;</button>
			</div>
		</div>
	</form>
        <input type="hidden" name="msg" id="msg" value="<%=msg %>" />
</div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolderAdmin3" runat="server">
<script type="text/javascript" src="lib/laypage/1.2/laypage.js"></script>
<script type="text/javascript" src="lib/icheck/jquery.icheck.min.js"></script> 
<script type="text/javascript" src="lib/Validform/5.3.2/Validform.min.js"></script> 
    <script type="text/javascript">
        $(function () {
            $(".ke-edit-iframe").css("margin-bottom", "12px");
            $("#menu-article dt").addClass("selected");
            $("#menu-article dd").css("display", "block");
            $("#menu-article li:eq(0) ").css("background-color", "rgba(171, 166, 166, 0.43)");
            $("#menu-article li:eq(0) a").css("color", "#06c");
    $('.skin-minimal input').iCheck({
		checkboxClass: 'icheckbox-blue',
		radioClass: 'iradio-blue',
		increaseArea: '20%'
    });

    $("#form-article-add").Validform({
        tiptype: 2,
        callback: function (form) {

            $("#form-article-add").submit();
            //form[0].submit();
            //var index = parent.layer.getFrameIndex(window.name);
            //parent.$('.btn-refresh').click();
            //parent.layer.close(index);
            //parent.$('.btn-refresh').click();
            //document.getElementById("submitPocess").innerHTML = "正在上传数据";

        }
    });


    if (parseInt($("#msg").val()) == 1) {

        layer.msg('修改成功!', { icon: 1, time: 1000 });
       
    } else if (parseInt($("#msg").val()) == -1) {
        layer.msg('修改失败!', { icon: 2, time: 1000 });
    }
    else if (parseInt($("#msg").val()) == 2) {
        layer.msg('添加成功!', { icon: 1, time: 1000 });
    } else if (parseInt($("#msg").val()) == -2) {
        layer.msg('添加失败!', { icon: 2, time: 1000 });

    }

 
});


</script>
</asp:Content>
