<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="TCS.Web.admin.login" %>

<!DOCTYPE HTML>
<html>
<head>
    <meta charset="utf-8">
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <!--[if lt IE 9]>
<script type="text/javascript" src="lib/html5.js"></script>
<script type="text/javascript" src="lib/respond.min.js"></script>
<script type="text/javascript" src="lib/PIE_IE678.js"></script>
<![endif]-->
    <link href="css/H-ui.min.css" rel="stylesheet" type="text/css" />
    <link href="css/H-ui.login.css" rel="stylesheet" type="text/css" />
    <link href="css/style.css" rel="stylesheet" type="text/css" />
    <link href="lib/Hui-iconfont/1.0.1/iconfont.css" rel="stylesheet" type="text/css" />
    <!--[if IE 6]>
<script type="text/javascript" src="http://lib.h-ui.net/DD_belatedPNG_0.0.8a-min.js" ></script>
<script>DD_belatedPNG.fix('*');</script>
<![endif]-->
    <title>后台登录</title>

</head>
<body>
    <input type="hidden" id="TenantId" name="TenantId" value="" />
    <div class="header"></div>
    <div class="loginWraper">
        <div id="loginform" class="loginBox">
            <form class="form form-horizontal" action="login.aspx" method="post">
                <div class="row cl">
                    <label class="form-label col-3"><i class="Hui-iconfont">&#xe60d;</i></label>
                    <div class="formControls col-8">
                        <input id="userName" name="userName" type="text" placeholder="账户" class="input-text size-L">
                    </div>
                </div>
                <div class="row cl">
                    <label class="form-label col-3"><i class="Hui-iconfont">&#xe60e;</i></label>
                    <div class="formControls col-8">
                        <input id="Password" name="Password" type="password" placeholder="密码" class="input-text size-L">
                    </div>
                </div>
                <div class="row cl">
                    <div class="formControls col-8 col-offset-3">
                        <input class="input-text size-L" id="viCode" name="viCode" type="text" placeholder="验证码" <%--onBlur="if(this.value==''){this.value='验证码:'}" onClick="if(this.value=='验证码:'){this.value='';}" value="验证码:"--%> style="width: 150px;">
                        <img class="vcode_img" id="vcode_img" src="/handler/vcode.ashx" data-src="/handler/vcode.ashx" style="border: 1px solid #ccc; border-radius: 0px 4px 4px 0px;" width="100" height="39" alt="验证码" title="点击切换验证码">
                        <a class="vcode_img" href="javascript:;">看不清，换一张</a>
                    </div>
                </div>
                <div class="row">
                    <div class="formControls col-8 col-offset-3">
                        <label for="online">
                            <input type="checkbox" name="checked" id="checked" value="true">
                            使我保持登录状态</label>
                    </div>
                </div>
                <div class="row">
                    <div class="formControls col-8 col-offset-3">
                        <input name="" type="submit" class="btn btn-success radius size-L" value="&nbsp;登&nbsp;&nbsp;&nbsp;&nbsp;录&nbsp;">
                        <input name="" type="reset" class="btn btn-default radius size-L" value="&nbsp;取&nbsp;&nbsp;&nbsp;&nbsp;消&nbsp;">
                        <%if (!string.IsNullOrEmpty(Message))
                            {%>
                        <div id="msgBox"  style=" background-color:#5a98de; line-height:40px; padding-left:15px; border-radius:5px; height:41px; color:white; width:145px; margin-right:40px; float:right;">
                            <button type="button" class="close" id="closebtn" data-dismiss="alert" style="float:right;margin-top:5px; color:darkblue; margin-right:3px;" aria-hidden="true">&times;</button>
                            <%=Message %>
                        </div>
                        <%}%>
                    </div>
                </div>
            </form>
        </div>
    </div>
    <div class="footer">Copyright © 2015 - 2016 旅游投诉网 ALL RIGHTS RESERVED　桂ICP备8888888888号</div>
    <script type="text/javascript" src="lib/jquery/1.9.1/jquery.min.js"></script>
    <script type="text/javascript" src="js/H-ui.js"></script>
    <script>
        $('.vcode_img').on('click', function () {
            var $this = $("#vcode_img");
            $this.attr('src', $this.data('src') + '?' + Math.random());
        });

        $("#closebtn").click(function () {
            $("#msgBox").css("display", "none");

        });
    </script>


</body>
</html>
