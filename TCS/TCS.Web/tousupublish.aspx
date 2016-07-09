<%@ Page Title="" Language="C#" MasterPageFile="~/share/tousu.Master" AutoEventWireup="true" CodeBehind="tousupublish.aspx.cs" Inherits="TCS.Web.tousupublish" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <link href="img/webload/webuploader.css" rel="stylesheet" />
    <link href="img/webload/style.css" rel="stylesheet" />
    <link href="admin/lib/layer/1.9.3/skin/layer.css" rel="stylesheet" />
    <style>
        #uploader .queueList {
            margin: 0px;
        }

        .uploadBtn, .submitform {
            background: #00b7ee;
            color: #fff;
            border-color: transparent;
            padding: 10px;
            height: 40px;
            line-height: 40px;
            /*background: #ffffff;*/
            border: 1px solid #cfcfcf;
            /*color: #565656;*/
            padding: 0 18px;
            display: inline-block;
            border-radius: 3px;
            margin-left: 10px;
            cursor: pointer;
            font-size: 14px;
            float: left;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">

    <!-- Left Sidebar Start -->

    <div class="row" style="margin-left: 4%; margin-right: 4%;">
        <div class="col-lg-10 col-md-10 col-md-offset-1">
            <div class="widget">
                <div class="">
                    <div class="row" style="margin-top: 15px;">
                        <div class="col-md-10 col-lg-10 col-md-offset-1">
                            <h3><%=language!="zh_us"?zh_us.publish:zh_us.publish_us %></h3>
                            <p></p>
                        </div>
                    </div>

                </div>
                <div class="widget-body">
                    <form class="form-horizontal row-border" style="margin-left: 10%;" id="tousupublishform" name="tousupublishform" action="tousupublish.aspx" method="post">
                        <div class="form-group">
                            <label for="pwd" class="col-sm-2 control-label"><%=language!="zh_us"?zh_us.cmplttype:zh_us.cmplttype_us %></label>
                            <div class="col-sm-10">
                                <div class="row">
                                    <div class="col-md-4 col-sm-4 col-xs-4">
                                        <select id="tousuType" name="tousuType" class="form-control">
                                            <option value="0">- 请选择投诉类型 -
                                            </option>
                                            <%foreach (var item in CurrentComplaintType)
                                                {%>
                                            <option value="<%=item.ct_id %>"><%=item.ct_name %>
                                            </option>
                                            <%} %>
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="pwd" class="col-sm-2 control-label">投诉诉求</label>
                            <div class="col-sm-10">
                                <div class="row">
                                    <div class="col-md-4 col-sm-4 col-xs-4">
                                        <select id="tousuRequire" name="tousuRequire" class="form-control">
                                            <option value="0">- 请选择投诉诉求 -
                                            </option>
                                            <% foreach (var item in ComplaitRequireList)
                                                {%>
                                            <option value="<%=item.cr_id %>">
                                                <%=item.cr_name %>
                                            </option>
                                            <% } %>
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-md-2 control-label">投诉标题</label>
                            <div class="col-md-6">
                                <input type="text" id="tousuTitle" name="tousuTitle" placeholder="标题：不少于10个字，不超过50个字" class="form-control">
                            </div>
                        </div>


                        <div class="form-group">
                            <label class="col-sm-2 control-label">投诉内容</label>
                            <div class="col-sm-6">
                                <textarea class="form-control" id="tousuContent" name="tousuContent" placeholder="内容：时间、地点、事件（不少于10个字，不超过5000个字）" rows="5"></textarea>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-md-2 control-label">上传图片</label>
                            <div class="col-md-8">
                                <div id="uploader">
                                    <div class="queueList">
                                        <div id="dndArea" class="placeholder">
                                            <div id="filePicker"></div>
                                            <p>或将照片拖到这里，单次最多可选10张</p>
                                        </div>
                                    </div>
                                    <div class="statusBar" style="display: none;">
                                        <div class="progress">
                                            <span class="text">0%</span>
                                            <span class="percentage"></span>
                                        </div>
                                        <div class="info"></div>
                                        <div class="btns">
                                            <div id="filePicker2"></div>

                                        </div>
                                    </div>
                                </div>
                            </div>


                        </div>

                        <%--<div class="form-group">
                            <label class="col-md-2 control-label">分类标签</label>
                            <div class="col-md-6">
                                <input class="form-control" type="text" name="placeholder" placeholder="placeholder">
                            </div>
                        </div>--%>

                        <div class="form-group">
                            <div class="col-sm-offset-2 col-sm-10">
                                <div class="uploadBtn">提交投诉</div>
                                <div id="submitform" class="submitform">提交投诉</div>
                            </div>
                        </div>

                    </form>
                    <input type="hidden" id="msg" name="msg" value="<%=msg %>" />
                </div>
            </div>
        </div>
    </div>

    <!-- Row End -->
    <!-- Left Sidebar End -->

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="foot" runat="server">
    <script src="js/webupload/jquery.js"></script>
    <script src="js/jquery.scrollUp.js"></script>
    <script src="js/webupload/webuploader.js"></script>
    <script src="js/webupload/upload.js"></script>
    <script src="admin/lib/layer/1.9.3/layer.js"></script>
    <script src="admin/lib/layer/1.9.3/extend/layer.ext.js"></script>
    <script type="text/javascript">

        /* var applicationPath = window.applicationPath === "" ? "" : window.applicationPath || "../../";
         $(function () {
             var $ = jQuery,
             $list = $('#fileList'),
             // 优化retina, 在retina下这个值是2
             ratio = window.devicePixelRatio || 1,
             // 缩略图大小
             thumbnailWidth = 90 * ratio,
             thumbnailHeight = 90 * ratio,
     
             // Web Uploader实例
             uploader;
             uploader = WebUploader.create({
                 // 选完文件后，是否自动上传。
                 auto: false,
                 chunked: false,
     
                 disableGlobalDnd: true,
                 // swf文件路径
                 swf: applicationPath + '/js/Uploader.swf',
     
                 // 文件接收服务端。
                 server: applicationPath + '/handler/fileupload.ashx',
     
                 // 选择文件的按钮。可选。
                 // 内部根据当前运行是创建，可能是input元素，也可能是flash.
                 pick: '#filePicker',
     
                 //只允许选择图片
                 accept: {
                     title: 'Images',
                     extensions: 'gif,jpg,jpeg,bmp,png',
                     mimeTypes: 'image/*'
                 }
             });
            
             // 当有文件添加进来的时候
             uploader.on('fileQueued', function (file) {
                 var $li = $(
                         '<div id="' + file.id + '" class="cp_img">' +
                             '<img>' +
                         '<div class="cp_img_jian"></div></div>'
                         ),
                     $img = $li.find('img');
     
     
                 // $list为容器jQuery实例
                 $list.append($li);
     
                 // 创建缩略图
                 // 如果为非图片文件，可以不用调用此方法。
                 // thumbnailWidth x thumbnailHeight 为 100 x 100
                 uploader.makeThumb(file, function (error, src) {
                     if (error) {
                         $img.replaceWith('<span>不能预览</span>');
                         return;
                     }
     
                     $img.attr('src', src);
                 }, thumbnailWidth, thumbnailHeight);
             });
     
             // 文件上传过程中创建进度条实时显示。
             uploader.on('uploadProgress', function (file, percentage) {
                 var $li = $('#' + file.id),
                     $percent = $li.find('.progress span');
     
                 // 避免重复创建
                 if (!$percent.length) {
                     $percent = $('<p class="progress"><span></span></p>')
                             .appendTo($li)
                             .find('span');
                 }
     
                 $percent.css('width', percentage * 100 + '%');
             });
     
             // 文件上传成功，给item添加成功class, 用样式标记上传成功。
             uploader.on('uploadSuccess', function (file, response) {
                 
                 $('#' + file.id).addClass('upload-state-done');
             });
     
             // 文件上传失败，显示上传出错。
             uploader.on('uploadError', function (file) {
                 var $li = $('#' + file.id),
                     $error = $li.find('div.error');
     
                 // 避免重复创建
                 if (!$error.length) {
                     $error = $('<div class="error"></div>').appendTo($li);
                 }
     
                 $error.text('上传失败');
             });
     
             // 完成上传完了，成功或者失败，先删除进度条。
             uploader.on('uploadComplete', function (file) {
                 $('#' + file.id).find('.progress').remove();
             });
     
             //所有文件上传完毕
             uploader.on("uploadFinished", function ()
             {
                //提交表单
     
             });
     
             //开始上传
             $("#ctlBtn").click(function () {
                 uploader.upload();
     
             });
     
             //显示删除按钮
             $(".cp_img").live("mouseover", function ()
             {
                 $(this).children(".cp_img_jian").css('display', 'block');
     
             });
             //隐藏删除按钮
             $(".cp_img").live("mouseout", function () {
                 $(this).children(".cp_img_jian").css('display', 'none');
     
             });
             //执行删除方法
             $list.on("click", ".cp_img_jian", function ()
             {
                 var Id = $(this).parent().attr("id");
                 uploader.removeFile(uploader.getFile(Id,true));
                 $(this).parent().remove();
             });
           
         });*/
        $(document).ready(function () {
            var $uploadBtn = $('#tousupublishform').find('.state-pedding');
            $uploadBtn.css('display', 'none');
            /*if($uploadBtn.hasClass('pedding')){
                $uploadBtn.addClass('element - invisible');
            
            }*/

        });

        $('#submitform').click(function () {
           
            if ($("#tousuType").val() == 0) {

                layer.msg('您还没有选择投诉类型哦！', { icon: 2, time: 1000 });
            } else if ($("#tousuRequire").val() == 0) {
                layer.msg('您还没有选择投诉诉求哦！', { icon: 2, time: 1000 });
            }
            else if ($("#tousuTitle").val().length < 10 || $("#tousuTitle").val().length>50) {
                layer.msg('请您正确填写标题哦！', { icon: 2, time: 1000 });
            } else if ($("#tousuContent").val().length < 10 || $("#tousuContent").val().length > 5000) {
                //alert($("#tousuContent").val().length);
                layer.msg('请您正确填写投诉内容哦！', { icon: 2, time: 1000 });
            } else {
                $("#tousupublishform").submit();
        
            }

        });



        function msg(n) {

            if (n == 1) {
                layer.msg('修改成功!', { icon: 1, time: 1000 });
                history.go(0);
            }
            if (n == -1) {
                layer.msg('修改失败!', { icon: 2, time: 1000 });
            }
            if (n == 2) {


                layer.msg('添加成功!', { icon: 1, time: 1000 });
                history.go(0);
            }
            if (n == -2) {


                layer.msg('添加失败!', { icon: 2, time: 1000 });
            }
        }


        if (parseInt($("#msg").val()) == 1) {

        } else if (parseInt($("#msg").val()) == -1) {

            layer.msg('发布失败!', { icon: 2, time: 1000 });
        }
        else if (parseInt($("#msg").val()) == 2) {

        } else if (parseInt($("#msg").val()) == -2) {

        }
    </script>
</asp:Content>
