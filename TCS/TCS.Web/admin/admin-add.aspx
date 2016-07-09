<%@ Page Title="" Language="C#" MasterPageFile="~/share/commonhead.Master" AutoEventWireup="true" CodeBehind="admin-add.aspx.cs" Inherits="TCS.Web.admin.admin_add1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderC1" runat="server">
    <title>添加管理员</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderC2" runat="server">
    <div class="pd-20">
        <form action="/admin/admin-add.aspx" method="post" class="form form-horizontal" id="form-admin-add">
            <div class="row cl">
                <label class="form-label col-3"><span class="c-red">*</span>管理员：</label>
                <div class="formControls col-5">
                    <input type="text" class="input-text" value="<%=UserInfo!=null?UserInfo.u_loginName:string.Empty %>" placeholder="" id="adminName" name="adminName" datatype="*2-16" nullmsg="用户名不能为空">
                </div>
                <div class="col-4"></div>
            </div>
            <div class="row cl">
                <label class="form-label col-3"><span class="c-red">*</span>昵称：</label>
                <div class="formControls col-5">
                    <input type="text" class="input-text" value="<%=UserInfo!=null?UserInfo.u_nickName:string.Empty %>" placeholder="" id="adminNickame" name="adminNickame" datatype="*2-16" nullmsg="昵称不能为空">
                </div>
                <div class="col-4"></div>
            </div>
            <div class="row cl">
                <label class="form-label col-3"><span class="c-red">*</span>真实姓名：</label>
                <div class="formControls col-5">
                    <input type="text" class="input-text" value="<%=UserInfo!=null?UserInfo.u_realName:string.Empty %>" placeholder="" id="adminRealame" name="adminRealame" datatype="*2-16" nullmsg="真实姓名不能为空">
                </div>
                <div class="col-4"></div>
            </div>
            <div class="row cl">
                <label class="form-label col-3"><span class="c-red">*</span>初始密码：</label>
                <div class="formControls col-5">
                    <input type="password" placeholder="密码" autocomplete="off" id="password" name="password" value="" class="input-text" datatype="*6-20" nullmsg="密码不能为空">
                </div>
                <div class="col-4"></div>
            </div>
            <div class="row cl">
                <label class="form-label col-3"><span class="c-red">*</span>确认密码：</label>
                <div class="formControls col-5">
                    <input type="password" placeholder="确认新密码" autocomplete="off" class="input-text Validform_error" errormsg="您两次输入的新密码不一致！" datatype="*" nullmsg="请再输入一次新密码！" recheck="password" id="cpassword" name="cpassword">
                </div>
                <div class="col-4"></div>
            </div>
            <div class="row cl">
                <label class="form-label col-3"><span class="c-red">*</span>性别：</label>
                <div class="formControls col-5 skin-minimal">
                    <div class="radio-box">
                        <input type="radio" id="sex-1"  <%=UserInfo!=null?(UserInfo.u_sex=="男"?"checked=\"checked\"":string.Empty):string.Empty %> name="sex" value="男" datatype="*" nullmsg="请选择性别！">
                        <label for="sex-1">男</label>
                    </div>
                    <div class="radio-box">
                        <input type="radio" id="sex-2" <%=UserInfo!=null?(UserInfo.u_sex=="女"?"checked=\"checked\"":string.Empty):string.Empty %> value="女" name="sex">
                        <label for="sex-2">女</label>
                    </div>
                </div>
                <div class="col-4"></div>
            </div>
            <div class="row cl">
                <label class="form-label col-3">角色：</label>
                <div class="formControls col-5">
                    <span class="select-box" style="width: 150px;">
                        <select class="select" name="adminRole" size="1">
                            <%foreach (var item in RolesList)
                                {%>
                             <option  <%=UserInfo!=null?(UserInfo.u_roleId==item.r_id?"selected=\"selected\"":string.Empty):string.Empty %> value="<%=item.r_id %>"><%=item.r_name %></option>
                              <%  } %>
                            
                        </select>
                    </span>
                </div>
            </div>
            <div class="row cl">
                <label class="form-label col-3"><span class="c-red">*</span>手机：</label>
                <div class="formControls col-5">
                    <input type="text" class="input-text" value="<%=UserInfo!=null?UserInfo.u_phoneNo:string.Empty %>" placeholder="" id="adminTel" name="adminTel" datatype="m" nullmsg="手机不能为空">
                </div>
                <div class="col-4"></div>
            </div>
            <div class="row cl">
                <label class="form-label col-3"><span class="c-red">*</span>邮箱：</label>
                <div class="formControls col-5">
                    <input type="text" class="input-text" value="<%=UserInfo!=null?UserInfo.u_email:string.Empty %>" placeholder="@" name="adminEmail" id="adminEmail" datatype="e" nullmsg="请输入邮箱！">
                </div>
                <div class="col-4"></div>
            </div>
            
           
            <div class="row cl">
                <div class="col-9 col-offset-3">
                    <input type="hidden" name="aid" value="<%=aid %>" />
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
	
	$("#form-admin-add").Validform({
		tiptype:2,
		callback:function(form){
		    $("#form-admin-add").submit();
			var index = parent.layer.getFrameIndex(window.name);
			
		}
	});
	var index = parent.layer.getFrameIndex(window.name);

	if (parseInt($("#msg").val()) == 1) {
	    parent.msg(1);
	    parent.layer.close(index);
	} else if (parseInt($("#msg").val()) == -1) {
	    parent.msg(-1);
	    parent.layer.close(index);

	}
	else if (parseInt($("#msg").val()) == 2) {
	    parent.msg(2);
	    parent.layer.close(index);
	} else if (parseInt($("#msg").val()) == -2) {
	    parent.msg(-2);
	    parent.layer.close(index);

	} 
});
</script>

</asp:Content>
