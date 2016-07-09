<%@ Page Title="" Language="C#" MasterPageFile="~/share/commonhead.Master" AutoEventWireup="true" CodeBehind="member-add.aspx.cs" Inherits="TCS.Web.admin.member_add" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderC1" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderC2" runat="server">
    <div class="pd-20">
  <form action="/admin/member-add.aspx" method="post" class="form form-horizontal" id="form-member-add">
    <div class="row cl">
      <label class="form-label col-3"><span class="c-red">*</span>用户名：</label>
      <div class="formControls col-5">
        <input type="text" class="input-text" value="" placeholder="" id="member-name" name="member-name" datatype="*2-16" nullmsg="用户名不能为空">
      </div>
      <div class="col-4" id="usercheckbox"> </div>
    </div>
      <div class="row cl">
      <label class="form-label col-3"><span class="c-red">*</span>用户昵称：</label>
      <div class="formControls col-5">
        <input type="text" class="input-text" value="" placeholder="" id="member-nickname" name="member-nickname" datatype="*2-16" nullmsg="用户昵称不能为空">
      </div>
      <div class="col-4"> </div>
    </div>
      <div class="row cl">
      <label class="form-label col-3"><span class="c-red">*</span>真实姓名：</label>
      <div class="formControls col-5">
        <input type="text" class="input-text" value="" placeholder="" id="member-realname" name="member-realname" datatype="*2-16" nullmsg="真实姓名不能为空">
      </div>
      <div class="col-4"> </div>
    </div>
    <div class="row cl">
      <label class="form-label col-3"><span class="c-red">*</span>性别：</label>
      <div class="formControls col-5 skin-minimal">
        <div class="radio-box" id="nan">
          <input type="radio" id="sex-1"  name="sex" value="男" datatype="*" nullmsg="请选择性别！">
          <label for="sex-1">男</label>
        </div>
        <div class="radio-box" id="nv">
          <input type="radio" id="sex-2" value="女" name="sex">
          <label for="sex-2">女</label>
        </div>
        <div class="radio-box" id="baomi">
          <input type="radio" id="sex-3"  value="保密" name="sex">
          <label for="sex-3">保密</label>
        </div>
      </div>
      <div class="col-4"> </div>
    </div>
    <div class="row cl">
      <label class="form-label col-3"><span class="c-red">*</span>手机：</label>
      <div class="formControls col-5">
        <input type="text" class="input-text" value="" placeholder="" id="member-tel" name="member-tel"  datatype="m" nullmsg="手机不能为空">
      </div>
      <div class="col-4"> </div>
    </div>
    <div class="row cl">
      <label class="form-label col-3"><span class="c-red">*</span>邮箱：</label>
      <div class="formControls col-5">
        <input type="text" class="input-text" placeholder="@" name="email" id="email" datatype="e" nullmsg="请输入邮箱！">
      </div>
      <div class="col-4"> </div>
    </div>
    
   
    <div class="row cl">
      <div class="col-9 col-offset-3">
          <input type="hidden" id="eUserId" name="eUserId" value="0" />
          <input type="hidden" id="sex" value="保密" />
        <input class="btn btn-primary radius" type="submit"  value="&nbsp;&nbsp;提交&nbsp;&nbsp;">
      </div>
      <div class="col-4" id="submitPocess"></div>
    </div>
  </form>
        <input  type="hidden" id="msg" value="<%=msg %>" />
</div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolderC3" runat="server">

    <script type="text/javascript">
$(function () {
            
	$('.skin-minimal input').iCheck({
		checkboxClass: 'icheckbox-blue',
		radioClass: 'iradio-blue',
		increaseArea: '20%'
	});
	

	$("#form-member-add").Validform({
		tiptype:2,
		callback: function (form) {

		    $("#form-member-add").submit();
			//form[0].submit();
			//var index = parent.layer.getFrameIndex(window.name);
			//parent.$('.btn-refresh').click();
		    //parent.layer.close(index);
		    //parent.$('.btn-refresh').click();
		    //document.getElementById("submitPocess").innerHTML = "正在上传数据";

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
function sex() {
    var sex = $("#sex").val();
    //alert(sex);
    if (sex == "男") {
        //document.getElementById("sex-1").setAttribute("checked", "checked");
        //$('#sex-1')("checked", "checked");
        //location.replace(location.href);
    } else if (sex == "女") {
        $('#sex-2').attr("checked", "checked");
    } else {
        $('#sex-3').attr("checked", "checked");
    }
    //if (location.href.indexOf("?xyz=") < 0) {
    //    location.href = location.href + "?xyz=" + Math.random();
    //}
}


    $("#member-name").blur(function () {
        if (parseInt($("#eUserId").val()) == 0) {

            $.post("/handler/UserExistCheck.ashx", { username: $("#member-name").val() }, function (data) {

                if (parseInt(data) == 0) {
                    //$("#usercheckbox").remove("span");
                    document.getElementById("usercheckbox").innerHTML = "<span class=\"Validform_checktip Validform_wrong\">用户已存在</span>";
                    //$("<span class=\"Validform_checktip Validform_wrong\">用户已存在</span>").appendTo("#usercheckbox");
                    //<span class="Validform_checktip Validform_right"></span>
                }

            });
        }
    });


</script>
</asp:Content>
