<%@ Page Title="" Language="C#" MasterPageFile="~/share/tousu.Master" AutoEventWireup="true" CodeBehind="register.aspx.cs" Inherits="TCS.Web.register" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

 
    <style>
        .content img {
            width: 100px;
            max-width: 100px;
        }

        .Validform_wrong {
    background: url(admin/images/icon_error_s.png) no-repeat 0 center;
    color: #ef392b;
}
.Validform_wrong, .Validform_right, .Validform_warning {
    display: inline-block;
    height: 20px;
    font-size: 12px;
    vertical-align: middle;
    padding-left: 25px;
}
.Validform_right {
    background: url(admin/images/icon_right_s.png) no-repeat 0 center;
}

    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">

    <!-- Left Sidebar Start -->

    <div class="row" style="margin-left: 4%; margin-right: 4%;">
        <div class="col-lg-10 col-md-10 col-md-offset-1">
            <div class="sign-in-container" style="margin-top: 0px;">
                <form action="register.aspx" class="login-wrapper" id="userregister" method="post">
                    <div class="header">
                        <div class="row">
                            <div class="col-md-12 col-lg-12 col-md-offset-1">
                                <h3><%=language!="zh_us"?zh_us.userrigister:zh_us.userrigister_us %></h3>
                                <p></p>
                            </div>
                        </div>
                    </div>
                    <div class="content" style="width: 50%; margin-left: 17%; float: left; font-size: 14px;">
                        <div class="form-group">
                            <%--<label for="userName">常用邮箱</label>
                            <input type="text" class="input-text form-control" datatype="*2-16" datatype="e" nullmsg="用户名不能为空" name="userName" id="userName" placeholder="example@qq.com">--%>
                            <div>
                                <label for="userName"><%=language!="zh_us"?"常用邮箱":zh_us.email_us %></label>
                                <div class="formControls">
                                    <input type="text"  style=" width:250px; float:left;" class="form-control"  placeholder="example@qq.com" name="userName" id="userName" datatype="e" nullmsg="请输入邮箱！">
                                </div>
                                <div class="col-3" style=" float:left;margin-left:5px;" ></div>
                            </div>

                        </div>
                        <div style="clear:both; margin-bottom:15px;"></div>
                        <div class="form-group">
                            
                                <label for="Password"><%=language!="zh_us"?zh_us.password:zh_us.password_us %></label>
                           
                            <div class="formControls " >
                                <input type="password"  style=" width:250px; float:left;" class="form-control" autocomplete="off" value="" datatype="*6-20" nullmsg="密码不能为空"name="password" id="password" placeholder="<%=language!="zh_us"?zh_us.password:zh_us.password_us %>">
                            </div>
                            <div class="col-3" style=" float:left; margin-left:5px;" ></div>
                          
                        </div>
                        <div style="clear:both;margin-bottom:15px;"></div>
                        <div class="form-group">
                            <label for="cPassword"><%=language!="zh_us"?zh_us.cpassword:zh_us.cpassword_us %></label>
                            <div class="formControls ">
                            <input type="password" style=" width:250px; float:left;" class="form-control Validform_error" name="cPassword" id="cPassword" placeholder="<%=language!="zh_us"?zh_us.cpassword:zh_us.cpassword_us %>" autocomplete="off"  errormsg="您两次输入的新密码不一致！" datatype="*" nullmsg="请再输入一次新密码！" recheck="password">
                                </div>
                            <div class="col-3" style=" float:left; margin-left:5px;" ></div>
                        </div>
                         <div style="clear:both;margin-bottom:15px;"></div>
                        <div class="form-group">
                            <label for="viCode"><%=language!="zh_us"?zh_us.validcode:zh_us.validcode_us %></label><br />
                            <div class="formControls"style=" width:250px;" >
                                <input type="text" class="form-control" style="clear: both; margin-top: 1px; border-radius: 4px 0px 0px 4px; width: 150px; float: left;" name="viCode" id="viCode" placeholder="<%=language!="zh_us"?zh_us.validcode:zh_us.validcode_us %>" datatype="*" nullmsg="验证码不能为空">
                                <span class="input-group-addon" style="padding: 0 0 0 1px; float: left; cursor: pointer">
                                    <img id="vcode_img" src="handler/vcode.ashx" data-src="handler/vcode.ashx" style="border: 1px solid #ccc; border-radius: 0px 4px 4px 0px;" float: left;  width="100" height="34" alt="<%=language!="zh_us"?zh_us.validcode:zh_us.validcode_us %>" title="点击切换验证码">
                                </span>
                            </div>
                            <div class="col-3" style=" float:left; margin-left:103px;" ></div>
                        </div>
                         <div style="clear:both;margin-bottom:20px;"></div>
                        <div class="form-group">
                            <%if (!string.IsNullOrEmpty(Message))
                                {%>
                            <div class="alert alert-dismissable alert-danger" style="width:250px;">
                                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                                <i class="glyphicon glyphicon-remove"></i><%=Message %>
                            </div>
                            <%}%>
                        </div>
                    </div>
                    <div class="hidden-sm hidden-xs" style="width: 25%; float: left; margin-top:20px;">
                        <div style=" line-height: 40px; font-size: 14px;">
                            <ul>
                                <li><%=language!="zh_us"?zh_us.exist:zh_us.exist_us %>
										<a href="/login.aspx"><b><%=language!="zh_us"?zh_us.login:zh_us.login_us %></b></a>
                                </li>
                                <li><%=language!="zh_us"?zh_us.loginway:zh_us.loginway_us %>
                                </li>
                                <li>
                                    <span class="qq"><a href="#"></a></span>
                                    <span class="weibo"><a href="#"></a></span>
                                </li>
                            </ul>
                        </div>
                    </div>

                    <div class="clearfix"></div>
                    <div style="margin-left: 19%;">
                        <input type="checkbox" name="checked" value="true" />
                        <%=language!="zh_us"?zh_us.agree:zh_us.agree_us %><a href="#"><%=language!="zh_us"?zh_us.agreement:zh_us.agreement_us %></a>
                    </div>
                    <div class="actions" style="width: 43%; margin-bottom: 50px;">
                        <input type="hidden" name="redirect" value="<%=Request.QueryString["redirect"] %>" />
                        <input class="btn btn-success" style="width: 50%; margin-left: 5%;" name="Register" type="submit" value="<%=language!="zh_us"?"立即注册":zh_us.register_us %>">

                        <div class="clearfix"></div>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <!-- Row End -->
    <!-- Left Sidebar End -->

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="foot" runat="server">
    <script src="admin/lib/Validform/5.3.2/Validform.min.js"></script>

    <script>
        $(function () {

            $("#userregister").Validform({
                tiptype: 2,
                callback: function (form) {
                    $("#userregister").submit();
                    //var index = parent.layer.getFrameIndex(window.name);
                    //parent.$('.btn-refresh').click();
                    //parent.layer.close(index);
                }
            });


        });
    </script>
    <script>
        $(document).ready(function () {
            scroll(0, 120);

        });


        $('#vcode_img').on('click', function () {
            $(this).attr('src', $(this).data('src') + '?' + Math.random());
        });


    </script>
</asp:Content>
