<%@ Page Title="" Language="C#" MasterPageFile="~/share/tousu.Master" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="TCS.Web.login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">

    <!-- Left Sidebar Start -->

    <div class="row" style="margin-left: 4%; margin-right: 4%;">
        <div class="col-lg-10 col-md-10 col-md-offset-1">
            <div class="sign-in-container" style="margin-top: 0px;">
                <form action="login.aspx" class="login-wrapper" method="post">
                    <div class="header">
                        <div class="row">
                            <div class="col-md-10 col-lg-10 col-md-offset-1">
                                <h3><%=language!="zh_us"?zh_us.userlogin:zh_us.userlogin_us %></h3>
                                <p></p>
                            </div>
                        </div>
                    </div>
                    <div class="content" style="width: 30%; margin-left: 17%; float: left; font-size: 14px;">
                        <div class="form-group">
                            <label for="userName"><%=language!="zh_us"?zh_us.username:zh_us.username_us %>：</label>
                            <input type="text" class="form-control" id="userName" name="userName" placeholder="<%=language!="zh_us"?zh_us.email:zh_us.email_us %>">
                        </div>
                        <div class="form-group">
                            <label for="Password"><%=language!="zh_us"?zh_us.password:zh_us.password_us %>：</label>
                            <input type="password" class="form-control" id="Password" name="Password" placeholder="<%=language!="zh_us"?zh_us.password:zh_us.password_us %>">
                        </div>
                        <div class="form-group">
                            <label for="viCode"><%=language!="zh_us"?zh_us.validcode:zh_us.validcode_us %></label><br />
                            <div class="input-group">
                                <input type="text" class="form-control" style="clear: both; margin-top: 1px; border-radius: 4px 0px 0px 4px; width: 60%; float: left;" name="viCode" id="viCode" placeholder="<%=language!="zh_us"?zh_us.validcode:zh_us.validcode_us %>">
                                <span class="input-group-addon" style="padding: 0 0 0 1px; float: left; cursor: pointer">
                                    <img id="vcode_img" src="handler/vcode.ashx" data-src="handler/vcode.ashx" style="border: 1px solid #ccc; border-radius: 0px 4px 4px 0px;" width="100" height="34" alt="<%=language!="zh_us"?zh_us.validcode:zh_us.validcode_us %>" title="点击切换验证码">
                                </span>
                            </div>
                        </div>
                        <div class="form-group">
                            <%if (!string.IsNullOrEmpty(Message))
                                {%>
                            <div class="alert alert-dismissable alert-danger">
                                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                                <i class="glyphicon glyphicon-remove"></i><%=Message %>
                            </div>
                            <%}%>
                        </div>
                    </div>
                    <div class="hidden-sm hidden-xs" style="width: 42%; float: left;margin-top:20px;">
                        <div style=" margin-left:40%; line-height: 40px; font-size: 14px;">
                            <ul>
                                <li><%=language!="zh_us"?zh_us.noexist:zh_us.noexist_us %>
										<a href="register.aspx"><b><%=language!="zh_us"?zh_us.register:zh_us.register_us %></b></a>
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
                    <div style="margin-left: 19%; width: 26%;">
                        <input type="checkbox" name="checked" value="true" />
                        <%=language!="zh_us"?zh_us.remember:zh_us.remember_us %><a style="float:right; " class="link" href="#"><%=language!="zh_us"?zh_us.forgetpwd:zh_us.forgetpwd_us %>？</a>
                    </div>
                    <div class="content" style="width: 30%; margin-left: 17%; float: left; font-size: 14px;">
                    <div class="form-group" style="margin-bottom:50px;">
                       
                            <input class="btn btn-info" name="Login" style="padding: 6px 44%;" type="submit" value="<%=language!="zh_us"?zh_us.login:zh_us.login_us %>">

                            <div class="clearfix"></div>
                        </div>
                    
                        </div>
                    <div class="clearfix"></div>
                    <input type="hidden" name="redirect" value="<%=Request.QueryString["redirect"] %>" />
                </form>
            </div>
        </div>
    </div>
    <!-- Row End -->
    <!-- Left Sidebar End -->

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="foot" runat="server">
    <script>
        $('#vcode_img').on('click', function () {
            var $this = $(this);
            $this.attr('src', $this.data('src') + '?' + Math.random());
        });
    </script>
</asp:Content>
