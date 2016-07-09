<%@ Page Title="" Language="C#" MasterPageFile="~/share/tousu.Master" AutoEventWireup="true" CodeBehind="usercenter.aspx.cs" Inherits="TCS.Web.usercenter" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="css/starScore.css" rel="stylesheet" />
    <link href="js/need/laydate.css" rel="stylesheet" />
    <link href="admin/lib/layer/1.9.3/skin/layer.css" rel="stylesheet" />
    <style>
        .nav-tabs > li.active > a, .nav-tabs > li.active > a:focus, .nav-tabs > li.active > a:hover {
            color: white;
            cursor: default;
            background-color: #2D85BE; /*lightsteelblue*/
            border: 1px solid #ddd;
            border-bottom-color: transparent;
        }

        #overlay {
            height: 100%;
            min-width: 1280px;
            width: 100%;
            position: absolute;
            left: 0px;
            top: 0px;
            background-color: #4d4d4d;
            opacity: 0.5; /*设置透明度*/
            z-index: 10;
            display: none;
        }

        .userBox {
            z-index: 100;
            width: 600px;
            height: 300px;
            position: fixed;
            top: 180px;
            left: 30%;
            border: 1px solid #B0C6D9;
            background-color: #EBF3FF;
            /*display:none;*/
        }

        .addTitle {
            height: 25px;
            width: 100%;
        }

        .titleImg {
            float: left;
            padding-left: 10px;
            padding-top: 5px;
            font-size: 12px;
            color: #039;
            font-weight: bold;
        }

            .titleImg img {
                margin-right: 3px;
                height: 12px;
                width: 14px;
            }

        .cancelBtn {
            float: right;
            margin-top: 5px;
            margin-right: 10px;
        }

            .cancelBtn img {
                cursor: pointer;
            }

        .addBody {
            width: 590px;
            margin-left: 5px;
            height: 270px;
            background-color: #FFF;
            border: 1px solid #B0C6D9;
        }

            .addBody table {
                width: 94%;
                border: 1px solid #CCC;
                margin-left: 10px;
                /*height:250px;*/
                margin-top: 10px;
            }

                .addBody table tr {
                    height: 20px;
                }

                    .addBody table tr td {
                        /*width:40px;*/
                        height: 25px;
                        /*line-height:20px;*/
                        border: 1px solid #CCC;
                        display: table-cell;
                        vertical-align: middle; /*设置表格中文字垂直居中*/
                    }

                        .addBody table tr td label {
                            float: right;
                            padding-right: 3px;
                            width:70px;
                            text-align:right;
                        }

                        .addBody table tr td input {
                            border: 1px solid #CCC;
                            /*margin-top:5px;*/
                            margin-left: 5px;
                            float: left;
                        }

        .file {
            position: absolute;
            top: 160px;
            right: 40px;
            height: 24px;
            filter: alpha(opacity:0);
            opacity: 0;
            width: 70px;
            /*cursor:pointer;*/
        }

        .imgBtn {
            /*margin-top:10px;*/
            font-size: 12px;
            width: 70px;
            height: 20px;
            /*line-height:20px;*/
            /*vertical-align:middle;*/
            text-align: center;
            cursor: pointer;
            border-color: #77D1F6;
            border-width: 1px;
            border-style: solid;
            border-radius: 6px 6px;
            -moz-box-shadow: 2px 2px 2px #282828;
            -webkit-box-shadow: 2px 2px 4px #282828;
            background-image: -moz-linear-gradient(top,#EBEBEB, #BFBFBF);
            background-image: -webkit-gradient(linear, left top, left bottom, color-stop(0, #EBEBEB),color-stop(1, #BFBFBF));
        }

        .lableBackColor {
            background-color: #EBF3FF;
        }

        #saveBtn {
            margin-left: 210px;
            margin-bottom: 10px;
        }

        #cancelBtn {
            margin-left: 20px;
        }

        .resBtn {
            margin-top: 10px;
            font-size: 12px;
            width: 40px;
            height: 25px;
            line-height: 20px;
            vertical-align: middle;
            text-align: center;
            cursor: pointer;
            border-color: #77D1F6;
            border-width: 1px;
            border-style: solid;
            border-radius: 6px 6px;
            -moz-box-shadow: 2px 2px 2px #282828;
            -webkit-box-shadow: 2px 2px 4px #282828;
            background-image: -moz-linear-gradient(top,#EBEBEB, #BFBFBF);
            background-image: -webkit-gradient(linear, left top, left bottom, color-stop(0, #EBEBEB),color-stop(1, #BFBFBF));
        }

            .resBtn:hover {
                /*background-image: -moz-linear-gradient(top,#EBEBEB, #BFBFBF);*/
                background-image: -webkit-gradient(linear, left top, left bottom, color-stop(0, #77D1F6),color-stop(1, #77D1F6));
                font-Weight: bold;
            }

            .resBtn:visited, .resBtn:active {
                background-image: -webkit-gradient(linear, left top, left bottom, color-stop(0, #EBEBEB),color-stop(1, #BFBFBF));
            }



        /* star */
        #star {
            position: relative;
            width: 600px;
            margin: 20px auto;
            margin-left: 24%;
            height: 24px;
        }

            #star ul, #star span {
                float: left;
                display: inline;
                height: 19px;
                line-height: 19px;
            }

            #star ul {
                margin: 0 10px;
            }

            #star li {
                float: left;
                width: 24px;
                cursor: pointer;
                text-indent: -9999px;
                background: url(/img/star.png) no-repeat;
            }

            #star strong {
                color: #f60;
                padding-left: 10px;
            }

            #star li.on {
                background-position: 0 -28px;
            }

            #star p {
                position: absolute;
                top: 20px;
                width: 159px;
                height: 60px;
                display: none;
                //background: url(/img/icon.gif) no-repeat;
                padding: 7px 10px 0;
            }

                #star p em {
                    color: #f60;
                    display: block;
                    font-style: normal;
                }

        #preview img {
            margin-left:5px;
            margin-top:3px;
        vertical-align: initial;
        
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">

    <div class=" col-md-offset-1">
        <!-- Left Sidebar Start -->
        <div class="sidebar" style="margin-left: 5%; margin-right: 5%;">

            <!-- Row Start -->
            <div class="row">
                <div class="col-lg-11 col-md-11 "><a href="#"><%=language!="zh_us"?zh_us.index:zh_us.index_us %></a> > <a href="#"><%=language!="zh_us"?zh_us.usercenter:zh_us.usercenter_us %></a></div>
                <div class="col-lg-11 col-md-11 ">
                    <div class="widget" style="margin-bottom: 5px;">

                        <div class="widget-body" style="padding: 5px;">
                            <div style="float: left; width: 225px;">
                                <div style="float: left; width: 120px;">
                                    <img  src="<%=userInfo.u_pic %>" width="120px" height="120px" />
                                </div>
                                <div style="float: left;">
                                    <p style="margin-left: 10px;"><b><%=userInfo.u_nickName %></b></p>
                                </div>
                            </div>

                            <div style="float: left;">
                                <div style="height: 78px;" class="hidden-sm hidden-xs ">
                                    <p><%=language!="zh_us"?zh_us.logontime:zh_us.logontime_us %>：<%=userInfo.u_lastLoginTime.ToString("yyyy-MM-dd HH:mm:ss") %></p>
                                </div>

                                <div id="mycenter">
                                    <ul class="nav nav-tabs" style="padding: 0px; height: 42px;">
                                        <li class="active" onclick="actionTag(0)"><a href="#allTousuInfo" data-toggle="tab"><%=language!="zh_us"?zh_us.mycmplt:zh_us.mycmplt_us %>（<%=TotalCountall %>）</a></li>
                                        <li class="" onclick="actionTag(1)"><a href="#nohandle" data-toggle="tab"><%=language!="zh_us"?zh_us.processing:zh_us.processing_us %>（<%=TotalCount1 %>）</a></li>
                                        <li class="" onclick="actionTag(2)"><a href="#nocomment" data-toggle="tab"><%=language!="zh_us"?zh_us.comment:zh_us.comment_us %>（<%=TotalCount2 %>）</a></li>
                                        <li class="" onclick="actionTag(3)"><a href="#havecomment" data-toggle="tab"><%=language!="zh_us"?zh_us.finished:zh_us.finished_us %>（<%=TotalCount3 %>）</a></li>
                                        <li class="" onclick="actionTag(4)"><a href="#mytalk" data-toggle="tab"><%=language!="zh_us"?zh_us.discuss:zh_us.discuss_us %></a></li>
                                        <li class="" onclick="actionTag(5)"><a href="#mytalkreturn" data-toggle="tab"><%=language!="zh_us"?zh_us.reply:zh_us.reply_us %></a></li>
                                    </ul>
                                </div>
                            </div>

                            <div style="clear: both;"></div>
                        </div>

                    </div>
                </div>
            </div>
            <!-- Row End -->

            <!-- Row Start -->
            <div class="row ">

                <div class="col-lg-2 col-md-2 hidden-sm hidden-xs " style="padding-right: 0px;">
                    <div class="widget" style="margin-bottom: 5px;">
                        <div class="widget-header">
                            <div class="title">
                                <%=language!="zh_us"?zh_us.personalinfo:zh_us.personalinfo_us %>
                            </div>

                        </div>
                        <div class="widget-body" style="min-height: 200px; padding-right: 5px;">
                            <p><%=language!="zh_us"?zh_us.nickname:zh_us.nickname_us %>：<%=userInfo.u_nickName %></p>
                            <p><%=language!="zh_us"?zh_us.realname:zh_us.realname_us %>：<%=userInfo.u_realName %></p>
                            <p><%=language!="zh_us"?zh_us.sex:zh_us.sex_us %>：<%=userInfo.u_sex %></p>
                            <p><%=language!="zh_us"?zh_us.tel:zh_us.tel_us %>：<%=userInfo.u_phoneNo %></p>
                            <p><%=language!="zh_us"?zh_us.email:zh_us.email_us %>：<%=userInfo.u_email %></p>

                        </div>
                    </div>
                    <hr class="hr-stylish-1" style="margin: 5px;">
                    <div class="widget">
                        <div class="widget-header">
                            <div class="title">
                                <%=language!="zh_us"?zh_us.accountcenter:zh_us.accountcenter_us %>
                            </div>

                        </div>
                        <div class="widget-body" style="min-height: 200px;">
                            <p><a href="javascript:editInfo();"><%=language!="zh_us"?zh_us.editinfo:zh_us.editinfo_us %></a></p>

                           <%-- <p>修改密码</p>--%>

                        </div>
                    </div>
                </div>

                <div class="col-lg-9 col-md-9 " style="">

                    <div class="row p30" style="">

                        <div class="col-lg-12" style="">
                            <!-- Nav tabs -->
                            <!-- Tab panes -->
                            <div class="tab-content" style="border: 1px solid #ddd; border-radius: 2px 2px 2px 2px; min-height: 400px; padding-left: 0px;">

                                <div class="tab-pane fade active in" id="allTousuInfo">
                                    <div class="p30 tc">
                                        <%if (type == 0)
                                            {
                                                foreach (var all in complaintFormList)
                                                {

                                        %>
                                        <div style="">

                                            <div style="width: 90%; float: left; border: 1px solid #d0e4c2; margin-bottom: 15px; margin-top: 2px; margin-left: 6%">
                                                <div style="width: 100%; height: 30px; background-color: #fcfffa; font-size: 14px; color: rgb(99, 109, 160); line-height: 30px; border-bottom: 1px solid #d0e4c2; padding-left: 10px;">
                                                    <a href="tousudetail.aspx?item=<%=all.c_id %>"><b><%=language!="zh_us"?zh_us.title:zh_us.title_us %>：<%=all.c_title %></b></a><span style="float: right;"></span>
                                                </div>
                                                <div style="width: 100%; padding: 10px;">
                                                    <p style="text-indent: 2em;">
                                                        <%if (all.c_content.Length > 150)
                                                            {%>
                                                        <%=all.c_content.Substring(0, 150) %>...<a href="tousudetail.aspx?item=<%=all.c_id %>"><b><%=language!="zh_us"?zh_us.viewdetails:zh_us.viewdetails_us %></b></a>
                                                        <%}
                                                            else
                                                            {%>
                                                        <%=all.c_content %>
                                                        <%} %>
                                                    </p>
                                                    <p><%=language!="zh_us"?zh_us.cmplttime:zh_us.cmplttime_us %>：<%=all.c_submitTime.ToString("yyyy-MM-dd HH:mm") %>  | <%=language!="zh_us"?zh_us.cmplttype:zh_us.cmplttype_us %>：<b><%=_ComplaintTypeService.QuerySingle(new { ct_id =all.c_typeId}).ct_name %></b>  | <%=language!="zh_us"?zh_us.cmpltstatus:zh_us.cmpltstatus_us %>：<b><%=tousuStatusHelper.tousuStatusFormat(all.c_status) %></b> |  <a href="tousudetail.aspx?item=<%=all.c_id %>"><b><%=language!="zh_us"?zh_us.comments:zh_us.comments_us %>（<%=_ComplaintDiscussService.QueryCount(new {cd_cid=all.c_id }) %>）</b></a></p>
                                                </div>
                                            </div>
                                        </div>
                                        <div style="clear: both;"></div>
                                        <%}
                                            }%>

                                        <%if (TotalPages > 1)
                                            {
                                        %>
                                        <div style="width: 80%; height: 50px; float: right; margin-right: 6%; line-height: 50px;">
                                            <div class="list-pagination pull-right">

                                                <%= PagerHelper.RenderPager("/usercenter.aspx?type=" + type + "&page=@1", TotalPages, PageIndex, size) %>
                                            </div>
                                        </div>
                                        <%} %>
                                        <div style="clear: both;"></div>
                                    </div>
                                </div>

                                <div class="tab-pane fade " id="nohandle">
                                    <div class="p30 tc">
                                        <%if (type == 1)
                                            {
                                                foreach (var nohandle in complaintFormList)
                                                {

                                        %>
                                        <div style="">

                                            <div style="width: 90%; float: left; border: 1px solid #d0e4c2; margin-top: 2px; margin-bottom: 15px; margin-left: 6%">
                                                <div style="width: 100%; height: 30px; background-color: #fcfffa; font-size: 14px; color: rgb(99, 109, 160); line-height: 30px; border-bottom: 1px solid #d0e4c2; padding-left: 10px;">
                                                    <a href="tousudetail.aspx?item=<%=nohandle.c_id %>"><b><%=language!="zh_us"?zh_us.title:zh_us.title_us %>：<%=nohandle.c_title %></b></a><span style="float: right;"></span>
                                                </div>
                                                <div style="width: 100%; padding: 10px;">
                                                    <p style="text-indent: 2em;">
                                                        <%if (nohandle.c_content.Length > 150)
                                                            {%>
                                                        <%=nohandle.c_content.Substring(0, 150) %>...<a href="tousudetail.aspx?item=<%=nohandle.c_id %>"><b><%=language!="zh_us"?zh_us.viewdetails:zh_us.viewdetails_us %></b></a>
                                                        <%}
                                                            else
                                                            {%>
                                                        <%=nohandle.c_content %>
                                                        <%} %>
                                                    </p>
                                                    <p>
                                                        <%=language!="zh_us"?zh_us.cmplttime:zh_us.cmplttime_us %>：<%=nohandle.c_submitTime.ToString("yyyy-MM-dd HH:mm") %>  | <%=language!="zh_us"?zh_us.cmplttype:zh_us.cmplttype_us %>：<b><%=_ComplaintTypeService.QuerySingle(new { ct_id =nohandle.c_typeId}).ct_name %></b>  | <%=language!="zh_us"?zh_us.cmpltstatus:zh_us.cmpltstatus_us %>：<b><%=tousuStatusHelper.tousuStatusFormat(nohandle.c_status) %></b> |  <a href="tousudetail.aspx?item=<%=nohandle.c_id %>">
                                                            <b><%=language!="zh_us"?zh_us.comments:zh_us.comments_us %>（<%=_ComplaintDiscussService.QueryCount(new {cd_cid=nohandle.c_id }) %>）
                                                            </b>
                                                        </a>

                                                    </p>
                                                </div>
                                            </div>
                                        </div>
                                        <div style="clear: both;"></div>
                                        <%}
                                            }%>

                                        <%if (TotalPages > 1)
                                            {
                                        %>
                                        <div style="width: 80%; height: 50px; float: right; margin-right: 6%; line-height: 50px;">
                                            <div class="list-pagination pull-right">

                                                <%= PagerHelper.RenderPager("/usercenter.aspx?type=" + type + "&page=@1", TotalPages, PageIndex, size) %>
                                            </div>
                                        </div>
                                        <%} %>
                                        <div style="clear: both;"></div>
                                    </div>

                                </div>

                                <div class="tab-pane fade " id="nocomment">
                                    <div class="p30 tc">
                                        <%if (type == 2)
                                            {
                                                foreach (var nocomment in complaintFormList)
                                                {

                                        %>
                                        <div style="">

                                            <div style="width: 90%; float: left; border: 1px solid #d0e4c2; margin-top: 2px; margin-bottom: 15px; margin-left: 6%">
                                                <div style="width: 100%; height: 30px; background-color: #fcfffa; font-size: 14px; color: rgb(99, 109, 160); line-height: 30px; border-bottom: 1px solid #d0e4c2; padding-left: 10px;">
                                                    <a href="tousudetail.aspx?item=<%=nocomment.c_id %>">
                                                        <b>
                                                            <%=language!="zh_us"?zh_us.title:zh_us.title_us %>：<%=nocomment.c_title %>
                                                        </b>

                                                    </a>
                                                    <span style="float: right; margin-right: 10px; font-size: 12px; font-weight: bold; color: white;">
                                                        <a href="javascript:commentAction(<%=nocomment.c_id %>);"><b><%=language!="zh_us"?zh_us.tocomment:zh_us.tocomment_us %></b>
                                                            </a>

                                                    </span>
                                                </div>
                                                <div style="width: 100%; padding: 10px;">
                                                    <p style="text-indent: 2em;">
                                                        <%if (nocomment.c_content.Length > 150)
                                                            {%>
                                                        <%=nocomment.c_content.Substring(0, 150) %>...<a href="tousudetail.aspx?item=<%=nocomment.c_id %>"><b><%=language!="zh_us"?zh_us.viewdetails:zh_us.viewdetails_us %></b></a>
                                                        <%}
                                                            else
                                                            {%>
                                                        <%=nocomment.c_content %>
                                                        <%} %>
                                                    </p>
                                                    <p><b><%=language!="zh_us"?zh_us.officalresponse:zh_us.officalresponse_us %>：</b><%=nocomment.c_responseContent %>  <span style="margin-left: 20px"><%=language!="zh_us"?zh_us.responsetime:zh_us.responsetime_us %>：<%=nocomment.c_responseTime.ToString("yyyy-MM-dd hh:mm") %></span></p>
                                                    <p><%=language!="zh_us"?zh_us.cmplttime:zh_us.cmplttime_us %>：<%=nocomment.c_submitTime.ToString("yyyy-MM-dd HH:mm") %>  | <%=language!="zh_us"?zh_us.cmplttype:zh_us.cmplttype_us %>：<b><%=_ComplaintTypeService.QuerySingle(new { ct_id =nocomment.c_typeId}).ct_name %></b>  | <%=language!="zh_us"?zh_us.cmpltstatus:zh_us.cmpltstatus_us %>：<b><%=tousuStatusHelper.tousuStatusFormat(nocomment.c_status) %></b> |  <a href="tousudetail.aspx?item=<%=nocomment.c_id %>"><b><%=language!="zh_us"?zh_us.comments:zh_us.comments_us %>（<%=_ComplaintDiscussService.QueryCount(new {cd_cid=nocomment.c_id }) %>）</b></a></p>
                                                </div>
                                            </div>
                                        </div>
                                        <div style="clear: both;"></div>
                                        <%}
                                            }%>

                                        <%if (TotalPages > 1)
                                            {
                                        %>
                                        <div style="width: 80%; height: 50px; float: right; margin-right: 6%; line-height: 50px;">
                                            <div class="list-pagination pull-right">

                                                <%= PagerHelper.RenderPager("/usercenter.aspx?type=" + type + "&page=@1", TotalPages, PageIndex, size) %>
                                            </div>
                                        </div>
                                        <%} %>
                                        <div style="clear: both;"></div>
                                    </div>
                                </div>

                                <div class="tab-pane fade " id="havecomment">
                                    <div class="p30 tc">
                                        <%if (type == 3)
                                            {
                                                foreach (var havecomment in complaintFormList)
                                                {

                                        %>
                                        <div style="">

                                            <div style="width: 90%; float: left; border: 1px solid #d0e4c2; margin-top: 2px; margin-bottom: 15px; margin-left: 6%">
                                                <div style="width: 100%; height: 30px; background-color: #fcfffa; font-size: 14px; color: rgb(99, 109, 160); line-height: 30px; border-bottom: 1px solid #d0e4c2; padding-left: 10px;">
                                                    <a href="tousudetail.aspx?item=<%=havecomment.c_id %>"><b><%=language!="zh_us"?zh_us.title:zh_us.title_us %>：<%=havecomment.c_title %></b></a><span style="float: right; margin-right: 10px;"><%=language!="zh_us"?zh_us.score:zh_us.score_us %>：<i class="rev-star icon-main icon-eva-<%=havecomment.c_commentScore+1 %>"></i></span>
                                                </div>
                                                <div style="width: 100%; padding: 10px;">
                                                    <p style="text-indent: 2em;">
                                                        <%if (havecomment.c_content.Length > 150)
                                                            {%>
                                                        <%=havecomment.c_content.Substring(0, 150) %>...<a href="tousudetail.aspx?item=<%=havecomment.c_id %>"><b><%=language!="zh_us"?zh_us.viewdetails:zh_us.viewdetails_us %></b></a>
                                                        <%}
                                                            else
                                                            {%>
                                                        <%=havecomment.c_content %>
                                                        <%} %>
                                                    </p>
                                                    <p><b><%=language!="zh_us"?zh_us.officalresponse:zh_us.officalresponse_us %>：</b><%=havecomment.c_responseContent %>  <span style="margin-left: 20px"><%=language!="zh_us"?zh_us.responsetime:zh_us.responsetime_us %>：<%=havecomment.c_responseTime.ToString("yyyy-MM-dd hh:mm") %></span></p>
                                                    <p><b><%=language!="zh_us"?zh_us.myfeedback:zh_us.myfeedback_us %>：</b><%=havecomment.c_commentText %>  <span style="margin-left: 20px"><%=language!="zh_us"?zh_us.feedtime:zh_us.feedtime_us %>：<%=havecomment.c_commentTime.ToString("yyyy-MM-dd hh:mm") %></span></p>
                                                    <p><%=language!="zh_us"?zh_us.cmplttime:zh_us.cmplttime_us %>：<%=havecomment.c_submitTime.ToString("yyyy-MM-dd HH:mm") %>  | <%=language!="zh_us"?zh_us.cmplttype:zh_us.cmplttype_us %>：<b><%=_ComplaintTypeService.QuerySingle(new { ct_id =havecomment.c_typeId}).ct_name %></b>  | <%=language!="zh_us"?zh_us.cmpltstatus:zh_us.cmpltstatus_us %>：<b><%=tousuStatusHelper.tousuStatusFormat(havecomment.c_status) %></b> |  <a href="tousudetail.aspx?item=<%=havecomment.c_id %>"><b><%=language!="zh_us"?zh_us.comments:zh_us.comments_us %>（<%=_ComplaintDiscussService.QueryCount(new {cd_cid=havecomment.c_id }) %>）</b></a></p>
                                                </div>
                                            </div>
                                        </div>
                                        <div style="clear: both;"></div>
                                        <%}
                                            }%>

                                        <%if (TotalPages > 1)
                                            {
                                        %>
                                        <div style="width: 80%; height: 50px; float: right; margin-right: 6%; line-height: 50px;">
                                            <div class="list-pagination pull-right">

                                                <%= PagerHelper.RenderPager("/usercenter.aspx?type=" + type + "&page=@1", TotalPages, PageIndex, size) %>
                                            </div>
                                        </div>
                                        <%} %>
                                        <div style="clear: both;"></div>
                                    </div>
                                </div>

                                <div class="tab-pane fade " id="mytalk">
                                    <div class="p30 tc">
                                        <%if (type == 4&&complaintDiscussList!=null)
                                            {
                                                foreach (var myDisc in complaintDiscussList)
                                                {


                                        %>
                                        <div style="">

                                            <div style="width: 90%; float: left; border: 1px solid #d0e4c2; margin-top: 2px; margin-bottom: 15px; margin-left: 6%">
                                                <div style="width: 100%; height: 30px; background-color: #fcfffa; font-size: 14px; color: rgb(99, 109, 160); line-height: 30px; border-bottom: 1px solid #d0e4c2; padding-left: 10px;">
                                                    <a href="tousudetail.aspx?item=<%=myDisc.cd_cid %>"><b><%=language!="zh_us"?zh_us.title:zh_us.title_us %>：<%=_ComplaintFormService.QuerySingle(myDisc.cd_cid).c_title %></b></a><span style="float: right; margin-right: 10px;"><%=myDisc.cd_discOrder %> <%=language!="zh_us"?zh_us.floor:zh_us.floor_us %></span>
                                                </div>
                                                <div style="width: 100%; padding: 10px;">
                                                    <p style="text-indent: 2em;">
                                                        <%=myDisc.cd_discContent %>
                                                    </p>
                                                    <p><%=language!="zh_us"?zh_us.disctime:zh_us.disctime_us %>：<%=myDisc.cd_discTime.ToString("yyyy-MM-dd HH:mm") %>  </p>
                                                </div>
                                            </div>
                                        </div>
                                        <div style="clear: both;"></div>
                                        <%}
                                            }%>

                                        <%if (TotalPages > 1)
                                            {
                                        %>
                                        <div style="width: 80%; height: 50px; float: right; margin-right: 6%; line-height: 50px;">
                                            <div class="list-pagination pull-right">

                                                <%= PagerHelper.RenderPager("/usercenter.aspx?type=" + type + "&page=@1", TotalPages, PageIndex, size) %>
                                            </div>
                                        </div>
                                        <%} %>
                                        <div style="clear: both;"></div>
                                    </div>
                                </div>

                                <div class="tab-pane fade " id="mytalkreturn">
                                    <div class="p30 tc">
                                        <%if (type == 5&&complaintDiscussList!=null)
                                            {
                                                foreach (var myDiscReturn in complaintDiscussList)
                                                {


                                        %>
                                        <div style="">

                                            <div style="width: 90%; float: left; border: 1px solid #d0e4c2; margin-top: 2px; margin-bottom: 15px; margin-left: 6%">
                                                <div style="width: 100%; height: 30px; background-color: #fcfffa; font-size: 14px; color: rgb(99, 109, 160); line-height: 30px; border-bottom: 1px solid #d0e4c2; padding-left: 10px;">
                                                    <a href="tousudetail.aspx?item=<%=myDiscReturn.cd_cid %>">
                                                        <b>
                                                            <%=language!="zh_us"?zh_us.title:zh_us.title_us %>：<%=_ComplaintFormService.QuerySingle(myDiscReturn.cd_cid).c_title %>
                                                        </b>
                                                    </a><span style="float: right; margin-right: 10px;">
                                                        <%=myDiscReturn.cd_discOrder %> <%=language!="zh_us"?zh_us.floor:zh_us.floor_us %>

                                                        </span>
                                                </div>
                                                <div style="width: 100%; padding: 10px;">

                                                    <div style="float: left; width: 35px; height: 50px;">
                                                        <img src="img/user3.jpg" width="35px" height="35px" style="float: left;" />
                                                    </div>
                                                    <div style="float: left; width: 93%;">
                                                        <p style="margin-left: 10px;">
                                                            <span style="float: left; margin-right: 3px;">
                                                                <b style="color: #8cc6ff;">
                                                                    <%=_UserInfoService.QuerySingle(myDiscReturn.cd_uid).u_nickName %> 

                                                                </b>：</span> 
                                                            <%=myDiscReturn.cd_discContent %>
                                                        </p>
                                                    </div>

                                                    <div style="clear: both;"></div>
                                                    <p>
                                                        <%=language!="zh_us"?zh_us.disctime:zh_us.disctime_us %>：<%=myDiscReturn.cd_discTime.ToString("yyyy-MM-dd HH:mm") %>  

                                                    </p>
                                                </div>
                                            </div>
                                        </div>
                                        <div style="clear: both;"></div>
                                        <%}
                                            }%>

                                        <%if (TotalPages > 1)
                                            {
                                        %>
                                        <div style="width: 80%; height: 50px; float: right; margin-right: 6%; line-height: 50px;">
                                            <div class="list-pagination pull-right">

                                                <%= PagerHelper.RenderPager("/usercenter.aspx?type=" + type + "&page=@1", TotalPages, PageIndex, size) %>
                                            </div>
                                        </div>
                                        <%} %>
                                        <div style="clear: both;"></div>
                                    </div>
                                </div>

                            </div>


                        </div>
                    </div>

                </div>
            </div>
            <!-- Row End -->

        </div>
        <!-- Left Sidebar End -->
        <div id="overlay">
        </div>
        <div id="editUser" class="userBox" style="display: none;">
            <div class="addTitle">
                <div class="titleImg">
                    <img src="css/images/edit.png" />编辑个人信息
                </div>
                <div class="cancelBtn">
                    <img src="css/images/cancel.png" />
                </div>

            </div>
            <div class="addBody">
                <form id="editUserForm" action="/usercenter.aspx" method="post" enctype="multipart/form-data">
                    <input type="hidden" id="e_u_id" name="u_id" />
                    <input type="hidden" id="e_currentPage" name="e_currentPage" />
                    <table border="0" cellpadding="0" cellspacing="0" style="font-size: 12px;">
                        <tr>
                            <td class="lableBackColor">
                                <label>账号名：</label></td>
                            <td style="padding-left:3px;">
                               <%=userInfo.u_loginName %>
                            </td>
                            <td class="lableBackColor">
                                <label>真实姓名：</label></td>
                            <td>
                                <input type="text" id="realName" value="<%=userInfo.u_realName %>" name="realName" /></td>
                           
                            <td colspan="2" rowspan="4" width="80px" id="preview">
                                <img  src="<%=userInfo.u_pic %>" width="80px" height="100px" />
                            </td>
                        </tr>

                        <tr>
                            <td class="lableBackColor">
                                <label>账号昵称：</label></td>
                            <td>
                                <input type="text" id="nickName" value="<%=userInfo.u_nickName %>" name="nickName" /></td>

                            <%--<td class="lableBackColor">
                                <label>生日：</label></td>
                            <td>
                                <input type="text" size="17" readonly class="layinput laydate-icon" id="e_u_birthday" name="u_birthday" onclick="laydate({ elem: '#e_u_birthday' });" />

                            </td>--%>
                            <td class="lableBackColor">
                                <label>性别：</label></td>
                            <td style="text-align: left;">
                                <input type="radio"  <%=userInfo.u_sex=="男"?"checked=\"checked\"":"" %> style="float: none; margin-right: 3px;" name="sex" id="man" value="男" />男
                                <input type="radio" <%=userInfo.u_sex=="女"?"checked=\"checked\"":"" %> style="margin-left: 10px; margin-right: 3px; float: none;" id="woman" name="sex" value="女" />女
                            </td>
                        </tr>
                        <tr>
                            
                            <td class="lableBackColor">
                                <label>联系电话：</label></td>
                            <td>
                                <input type="text" value="<%=userInfo.u_phoneNo %>"  id="tel" name="tel" /></td>

                            <td class="lableBackColor">
                                <label>邮箱：</label></td>
                            <td>
                                <input type="text" value="<%=userInfo.u_email %>"  id="email" name="email" /></td>

                        </tr>
                        <tr>
                            
                            <td class="lableBackColor">
                                <label>注册时间：</label></td>
                            <td style="padding-left:3px;"><%=userInfo.u_regTime.ToString("yyyy-MM-dd HH:mm") %></td>

                            <td class="lableBackColor">
                                <label>账号状态：</label></td>
                            <td></td>
                            
                        </tr>
                        <tr>
                            <td class="lableBackColor">
                                <label></label></td>
                            <td></td>
                            <td class="lableBackColor">
                                <label></label>
                            </td>
                            <td></td>
                            <td colspan="2" rowspan="2" width="80px" class="lableBackColor">
                                <input type='button' class='imgBtn' id="imgBtn" value='头像选择' />
                                <!--<input type="file" name="fileField" class="file" id="fileField" size="28" />-->
                                <input type="file" name="fileField" class="file" id="fileField" size="28" onchange="previewImage(this, 'preview', 'imgId')" />
                            </td>
                        </tr>
                        <tr>
                            <td class="lableBackColor"></td>
                            <td></td>
                            <td class="lableBackColor"></td>
                            <td></td>

                        </tr>
                        <tr>
                            <td rowspan="2" colspan="6" class="lableBackColor">
                                <input type="hidden" name="res" value="editUserInfo" />
                                <input type='submit' class='resBtn' id="saveBtn" value='保存' />
                                <input type='button' class='resBtn' id="cancelBtn" value='取消' />
                            </td>
                        </tr>
                    </table>
                </form>
            </div>
        </div>


        <div id="commentBox" class="userBox" style="display: none;">
            <div class="addTitle">
                <div class="titleImg">
                    <img src="css/images/edit.png" />投诉评价
                </div>
                <div class="cancelBtn">
                    <img src="css/images/cancel.png" />
                </div>

            </div>
            <div class="addBody">
                <form id="commentform" action="/usercenter.aspx?res=comment" method="post">

                    <div>
                        <div id="star">
                            <span>投诉评分</span>
                            <ul>
                                <li><a href="javascript:;">1</a></li>
                                <li><a href="javascript:;">2</a></li>
                                <li><a href="javascript:;">3</a></li>
                                <li><a href="javascript:;">4</a></li>
                                <li><a href="javascript:;">5</a></li>
                            </ul>
                            <span></span>
                            <p></p>
                        </div>
                        <!--star end-->
                        <div style="margin-left: 24%; font-size: 14px;">
                            <textarea cols="50" name="commentContent" id="commentContent" placeholder="反馈内容10到140个字哦~" rows="5"></textarea>

                        </div>
                        <div class="" style="margin-left: 24%;">
                            <input type="hidden" id="score" name="score" value="0" />
                            <input type="hidden" id="itemno" name="itemno" value="0" />
                            <button type="button" id="scoreSubmit" class="btn btn-info btn-lg mr20">提交</button>
                        </div>
                    </div>

                </form>
            </div>
        </div>

    </div>
    <input type="hidden" id="msg" value="<%=msg %>" />
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="foot" runat="server">
    <script src="js/laydate.js"></script>
    <script src="js/jquery.js"></script>
    <%--<script src="js/jquery.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/jquery.scrollUp.js"></script>

    <!-- jQuery UI JS -->
    <script src="js/jquery-ui-v1.10.3.js"></script>

    <!-- Custom JS -->
    <script src="js/menu.js"></script>
    <script src="js/custom-index2.js"></script>--%>
    <script src="admin/lib/layer/1.9.3/layer.js"></script>
    <script src="admin/lib/layer/1.9.3/extend/layer.ext.js"></script>
    <script>
        $(document).ready(function () {

            var msg = $("#msg").val();
            if (msg!=""&&msg != null) {
                if (msg == "ok") {
                    layer.msg('操作成功!', { icon: 1, time: 1000 });
                    document.location.href = "/usercenter.aspx";
                } else {

                    layer.msg(msg, { icon: 2, time: 1000 });
                }
               
            }
            var t = parseInt(<%=type%>);
            if (t == 1) {
                $("#mycenter li:eq(0)").removeClass("active");
                $("#mycenter li:eq(1)").addClass("active");
                $("#allTousuInfo").removeClass("active in");
                $("#nohandle").addClass("active in");
            }
            else if (t == 2) {
                $("#mycenter li:eq(0)").removeClass("active");
                $("#mycenter li:eq(2)").addClass("active");
                $("#allTousuInfo").removeClass("active in");
                $("#nocomment").addClass("active in");
            }
            else if (t == 3) {
                $("#mycenter li:eq(0)").removeClass("active");
                $("#mycenter li:eq(3)").addClass("active");
                $("#allTousuInfo").removeClass("active in");
                $("#havecomment").addClass("active in");
            }
            else if (t == 4) {
                $("#mycenter li:eq(0)").removeClass("active");
                $("#mycenter li:eq(4)").addClass("active");
                $("#allTousuInfo").removeClass("active in");
                $("#mytalk").addClass("active in");
            }
            else if (t == 5) {
                $("#mycenter li:eq(0)").removeClass("active");
                $("#mycenter li:eq(5)").addClass("active");
                $("#allTousuInfo").removeClass("active in");
                $("#mytalkreturn").addClass("active in");
            }


        });
        function actionTag(n) {

            document.location.href = "/usercenter.aspx?type=" + n;
        }

        $("#addBtn").click(function () {
            document.getElementById("overlay").style.display = 'block';
            document.getElementById("addUser").style.display = 'block';
        });

        $(".cancelBtn").click(function () {
            $("#overlay").fadeOut();
            $(".userBox").fadeOut();
        });

        function editInfo() {
            document.getElementById("overlay").style.display = 'block';
            document.getElementById("editUser").style.display = 'block';
        }

        function commentAction(item) {

            document.getElementById("overlay").style.display = 'block';
            document.getElementById("commentBox").style.display = 'block';
            //alert(item);
            $("#itemno").val(item);
        }

        $("#scoreSubmit").click(function () {
            if (parseInt($("#score").val()) == 0) {
                alert("还没有打分哦！");
            } else if ($("#commentContent").val().length < 10) {
                alert($("#commentContent").val().length);
                alert("反馈内容不少于10个字哦！");
            } else if ($("#commentContent").val().length > 140) {
                alert("反馈内容不超过140个字哦！");
            }
            else {
                $("#commentform").submit();
            }

        });
    </script>


    <!----------------------图片预览功能实现js代码开始--------------------------->
    <script type="text/javascript">


        //图片上传预览    IE是用了滤镜。
        function previewImage(file, preview, imgId) {
            var MAXWIDTH = 80;
            var MAXHEIGHT = 100;
            var div = document.getElementById(preview);
            if (file.files && file.files[0]) {
                div.innerHTML = "";
                div.innerHTML = '<img id=' + imgId + ' style="width:80px; height:100px; margin-top:3px; border:1px solid #CCC;">';
                var img = document.getElementById(imgId);
                /*img.onload = function(){
                  var rect = clacImgZoomParam(MAXWIDTH, MAXHEIGHT, img.offsetWidth, img.offsetHeight);
                  img.width  =  rect.width;
                  img.height =  rect.height;
  //                 img.style.marginLeft = rect.left+'px';
                  //img.style.marginTop = rect.top+'px';
                }*/
                var reader = new FileReader();
                reader.onload = function (evt) { img.src = evt.target.result; }
                reader.readAsDataURL(file.files[0]);
            }
            else //兼容IE
            {
                var sFilter = 'filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale,src="';
                file.select();
                var src = document.selection.createRange().text;
                div.innerHTML = '<img id=' + imgId + '>';
                var img = document.getElementById(imgId);
                img.filters.item('DXImageTransform.Microsoft.AlphaImageLoader').src = src;
                var rect = clacImgZoomParam(MAXWIDTH, MAXHEIGHT, img.offsetWidth, img.offsetHeight);
                status = ('rect:' + rect.top + ',' + rect.left + ',' + rect.width + ',' + rect.height);
                div.innerHTML = "<div id=divhead style='width:" + rect.width + "px;height:" + rect.height + "px;margin-top:" + rect.top + "px;" + sFilter + src + "\"'></div>";
            }
        }
        function clacImgZoomParam(maxWidth, maxHeight, width, height) {
            var param = { top: 0, left: 0, width: width, height: height };
            if (width > maxWidth || height > maxHeight) {
                rateWidth = width / maxWidth;
                rateHeight = height / maxHeight;

                if (rateWidth > rateHeight) {
                    param.width = maxWidth;
                    param.height = Math.round(height / rateWidth);
                } else {
                    param.width = Math.round(width / rateHeight);
                    param.height = maxHeight;
                }
            }
            param.left = Math.round((maxWidth - param.width) / 2);
            param.top = Math.round((maxHeight - param.height) / 2);
            return param;
        }

    </script>

    <!----------------------日期控件代码开始--------------------------->
    <script type="text/javascript">
        !function () {
            laydate.skin('molv');//切换皮肤，请查看skins下面皮肤库
            laydate({ elem: '#demo' });//绑定元素
        }();

        //日期范围限制
        var start = {
            elem: '#start',
            format: 'YYYY-MM-DD',
            min: laydate.now(), //设定最小日期为当前日期
            max: '2099-06-16', //最大日期
            istime: true,
            istoday: false,
            choose: function (datas) {
                end.min = datas; //开始日选好后，重置结束日的最小日期
                end.start = datas //将结束日的初始值设定为开始日
            }
        };

        var end = {
            elem: '#end',
            format: 'YYYY-MM-DD',
            min: laydate.now(),
            max: '2099-06-16',
            istime: true,
            istoday: false,
            choose: function (datas) {
                start.max = datas; //结束日选好后，充值开始日的最大日期
            }
        };
        laydate(start);
        laydate(end);

    </script>
    <!----------------------日期控件代码结束--------------------------->
    <script type="text/javascript">
        window.onload = function () {

            var oStar = document.getElementById("star");
            var aLi = oStar.getElementsByTagName("li");
            var oUl = oStar.getElementsByTagName("ul")[0];
            var oSpan = oStar.getElementsByTagName("span")[1];
            var oP = oStar.getElementsByTagName("p")[0];
            var i = iScore = iStar = 0;
            var aMsg = [
                        "很不满意|非常不满",
                        "不满意|不满意",
                        "一般|一般",
                        "满意|满意",
                        "非常满意|非常满意"
            ]

            for (i = 1; i <= aLi.length; i++) {
                aLi[i - 1].index = i;

                //鼠标移过显示分数
                aLi[i - 1].onmouseover = function () {
                    fnPoint(this.index);
                    //浮动层显示
                    oP.style.display = "block";
                    //计算浮动层位置
                    oP.style.left = oUl.offsetLeft + this.index * this.offsetWidth - 104 + "px";
                    //匹配浮动层文字内容
                    oP.innerHTML = "<em><b>" + this.index + "</b> 分 " + aMsg[this.index - 1].match(/(.+)\|/)[1] + "</em>"
                };

                //鼠标离开后恢复上次评分
                aLi[i - 1].onmouseout = function () {
                    fnPoint();
                    //关闭浮动层
                    oP.style.display = "none"
                };

                //点击后进行评分处理
                aLi[i - 1].onclick = function () {
                    iStar = this.index;
                    oP.style.display = "none";
                    oSpan.innerHTML = "<strong>" + (this.index) + " 分</strong> (" + aMsg[this.index - 1].match(/\|(.+)/)[1] + ")";
                    $("#score").val(iScore);
                    //alert($("#score").val());

                }
            }

            //评分处理
            function fnPoint(iArg) {
                //分数赋值
                iScore = iArg || iStar;
                for (i = 0; i < aLi.length; i++) aLi[i].className = i < iScore ? "on" : "";
            }



        };
    </script>
</asp:Content>
