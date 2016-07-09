<%@ Page Title="" Language="C#" MasterPageFile="~/share/tousu.Master" AutoEventWireup="true" CodeBehind="tousudetail.aspx.cs" Inherits="TCS.Web.tousudetail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <link href="css/starScore.css" rel="stylesheet" />
    <link href="js/layer-v2.3/layer/skin/layer.css" rel="stylesheet" />
    <style>

        #layer-photos-demo img:hover{
            cursor:pointer;
        }
        .dashboard-wrapper {
            min-height:750px;
        } 
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">

    <div class="dashboard-wrapper">

        <!-- Left Sidebar Start -->
        <div class="left-sidebar " style="        margin-left: 6%;">


            <!-- Row Start -->
            <div class="row">
                <div class="col-lg-9 col-md-9 col-md-offset-1"><a href="#"><%=language!="zh_us"?zh_us.index:zh_us.index_us %></a> > <a href="#"><%=language!="zh_us"?zh_us.complaint:zh_us.complaint_us %></a>>信息详情</div>
                <div class="col-lg-9 col-md-9 col-md-offset-1">
                    <div class="widget">

                        <div class="widget-body">
                            <div style="">
                                <div style="">
                                    <div class="userImage" style="width: 10%; min-width: 68px; height: 68px; float: left;">
                                        <img src="<%=_UserInfoService.QuerySingle(CurentComplaintForm.c_uId).u_pic %>" width="56px" height="56px" style="margin: 2px; border: 1px solid grey;" />
                                    </div>
                                    <div style="width: 89%; float: left; margin-top: 2px;">
                                        <div style="width: 100%; height: 25px; background-color: #DEDCDA; color: #211DB6; line-height: 25px; padding-left: 10px;"><b><%=_UserInfoService.QuerySingle(CurentComplaintForm.c_uId).u_nickName %></b></div>
                                        <div style="width: 100%;text-align: center; font-size:16px; line-height:35px;">
                                            <b style="text-align: center;"><%=CurentComplaintForm.c_title %></b>
                                        </div>
                                    </div>
                                </div>
                                <div style="clear: both;"></div>
                                <div style="">
                                    <div style="margin-left: 68px; margin-top: 0; padding: 0;">

                                        <p style="text-indent:2em;">
                                            <%=CurentComplaintForm.c_content %>
                                        </p>
                                        <div style="clear: both;"></div>
                                        <div style="margin-bottom: 10px;">
                                             <% if (picstr !=null&& picstr[0].ToString()!="false"&&!string.IsNullOrEmpty(picstr[0])) { %>
                                            <div style="margin-left: 2px;" id="layer-photos-demo" class="layer-photos-demo">
                                               
                                               <% for (int i = 0; i < picstr.Length; i++)
                                                {
                                                %>
                                                <img src="<%=picstr[i] %>"  layer-src="<%=picstr[i] %>" alt="图片" width="94px" height="94px" layer-index="<%=i %>" style="margin: 2px; border: 1px solid grey;" />

                                                <% } %>
                                            </div>
                                        <%} %>
                                        </div>
                                    </div>
                                </div>

                            </div>
                            <div style="clear: both;"></div>
                            <div style="height: 30px; line-height: 30px;">
                                <span style="float: left;">提交时间：<%=CurentComplaintForm.c_submitTime.ToString("yyyy-MM-dd") %></span>
                                <span style="margin-left: 20px;">投诉处理状态：<b><%=tousuStatus %></b></span>
                                <span style="margin-left: 20px;">投诉类型：<b><%=tousuType%></b></span>
                                <span style="margin-left: 20px;">诉求：<b><%=tousuRequire%></b></span>
                                <span style="float: right;"><a href="#">评论（<%=TotalCount %>）</a></span>
                            </div>
                            <div style="clear: both;"></div>
                            <hr class="hr-stylish-1">
                            <%if (!string.IsNullOrEmpty(CurentComplaintForm.c_responseContent)&&(CurentComplaintForm.c_status==2||CurentComplaintForm.c_status==3))
                          { %>
                            <div style="margin-bottom: 25px; border: 1px solid white;">
                                <div style="">
                                    <div class="userImage" style="width: 10%; min-width: 68px; height: 68px; float: left;">
                                        <img src="img/4.jpg" width="56px" height="58px" style="margin: 2px; border: 1px solid grey;" />
                                    </div>
                                    <div style="width: 89%; float: left; padding-left: 10px; margin-top: 2px;">
                                        <div style="width: 100%; height: 25px; background-color: #FF9966; color: #211DB6; line-height: 25px; padding-left: 10px;">
                                            <b>景区</b><span style="float: right; margin-right:3px;">官方回复</span>
                                        </div>
                                        <div style="width: 100%;">
                                            <p style="text-indent:2em;"><%=CurentComplaintForm.c_responseContent %></p>
                                            <p>回复时间：<%=CurentComplaintForm.c_responseTime.ToString("yyyy-MM-dd") %> </p>
                                        </div>
                                    </div>
                                </div>
                                <div style="clear: both;"></div>
                                <%if (!string.IsNullOrEmpty(CurentComplaintForm.c_commentText))
                                             { %>
                                <div style="">
                                    <div class="userImage" style="width: 10%; min-width: 68px; height: 68px; float: left;">
                                        <img src="<%=_UserInfoService.QuerySingle(CurentComplaintForm.c_uId).u_pic %>" width="56px" height="58px" style="margin: 2px; border: 1px solid grey;" />
                                    </div>
                                    <div style="width: 89%; float: left; padding-left: 10px; margin-top: 2px;">
                                        <div style="width: 100%; height: 25px; background-color: #fcfffa; color: #211DB6; line-height: 25px; border: 1px solid #d0e4c2; padding-left: 10px;">
                                            <b><%=_UserInfoService.QuerySingle(new {u_id =CurentComplaintForm.c_uId }).u_nickName %></b>
                                            <span style="margin-left: 20px;">满意度评分：<i class="rev-star icon-main icon-eva-<%=CurentComplaintForm.c_commentScore+1 %>"></i></span>
                                            <span style="float: right;margin-right:3px;">反馈</span>
                                        </div>
                                        <div style="width: 100%;">
                                            <p style="text-indent:2em;"><%=CurentComplaintForm.c_commentText %></p>
                                            <p>反馈时间：<%=CurentComplaintForm.c_commentTime.ToString("yyyy-MM-dd") %> </p>
                                        </div>
                                    </div>
                                </div>
                                <%} %>
                            </div>
                            <div style="clear: both;"></div>
                            <hr class="hr-stylish-1">
                            <%} %>
                            <%if (TotalCount > 0)
                                {%>
                            <div id="tousuCommentList" style="margin-bottom: 25px; border: 1px solid white;">

                                <%foreach (var item in ComplaintDiscussList)
                                    {%>

                                   
                                <div style="">
                                    <div class="userImage" style="width: 10%; min-width: 68px; height: 68px; float: left;">
                                        <img src="<%=_UserInfoService.QuerySingle(item.cd_uid).u_pic %>" width="56px" height="58px" style="margin: 2px; border: 1px solid grey;" />
                                    </div>
                                    <div style="width: 89%; float: left; padding-left: 10px; margin-top: 2px;">
                                        <div style="width: 100%; height: 25px; background-color: #DEDCDA; color: #211DB6; line-height: 25px; padding-left: 10px;">
                                            <b><%=_UserInfoService.QuerySingle(new {u_id =item.cd_uid }).u_nickName %></b><span style="float: right;margin-right:3px;"><%=item.cd_discOrder %>楼</span>
                                        </div>
                                        <div style="width: 100%;">
                                            <p style="text-indent:2em;"><%=item.cd_discContent %></p>
                                            <p><%=TimeFormat.GetTimeSpan(DateTime.Now-item.cd_discTime) %>  |  <a href="javascript:resplyAction('<%=_UserInfoService.QuerySingle(new {u_id =item.cd_uid }).u_nickName %>','<%=item.cd_id %>');"><b>回应</b></a></p>
                                        </div>
                                    </div>
                                </div>
                                <div style="clear: both;"></div>
                                <%} %>
                                <%if (TotalPages > 1)
                                        { %>
                                <div style="width: 80%; height: 50px;  float: right; line-height: 50px;">
                                    <div class="list-pagination pull-right">
               
                <%= PagerHelper.RenderPager("/tousudetail.aspx?item=" + item + "&page=@1", TotalPages, PageIndex, size) %>
            </div>
                                </div>
                                <%} %>
                                <div style="clear: both;"></div>
                            </div>
                            <hr class="hr-stylish-1">
                            <%} %>
                            
                            <form action="tousudetail.aspx" id="discForm" method="post">
                                <div style="height: 230px;">
                                    <div style="width: 89%; float: left; margin-top: 2px;">
                                        <div style="float: left; height: 150px;">我的回应：</div>
                                        <div style="float: left; width: 80%; line-height: 25px; padding-left: 10px;">
                                            <span id="resplyName" style="font-size:14px; color:cornflowerblue; border:1px solid grey; margin-bottom:3px; float:left; border-radius:3px;display:none; background:rgba(114, 128, 197, 0.18); padding:3px; font-weight:bold;"></span>
                                            <a id="resplyIcon" style="display:none;" href="javascript:close();"><i class="fa fa-times" style="font-size:14px;" ></i></a>
                                            <input type="hidden" id="resplyId" name="resplyId" value="0" />
                                            <input type="hidden" id="resplyName_hidden" name="resplyName_hidden" value="false" />
                                            <input type="hidden" id="itemId" name="itemId" value="<%=CurentComplaintForm.c_id %>" />
                                            <textarea maxlength="140" id="myCommontArea" name="myCommontArea" style="width: 100%; height: 150px; font-size: 16px;"></textarea>
                                            
                                            <input type="button" id="submitBtn" value="发表" />
                                            (最多只能发表140字 )
									<div style="clear: both;"></div>
                                        </div>

                                    </div>

                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Row End -->





        </div>
        <!-- Left Sidebar End -->

        <!-- Right Sidebar Start -->
        <div class="right-sidebar" style="margin-right: 12%; margin-top: 20px;">

            <%--<div class="wrapper">
                <ul class="stats">
                    <li>
                        <div class="left">
                            <h4>
                            </h4>
                            <p>
                                
                            </p>
                        </div>
                        <div class="chart">
                            <span id="unique-visitors">
                            </span>
                        </div>
                    </li>
                    <li>
                        <div class="left">
                            <h4>
                            </h4>
                            <p>
                                
                            </p>
                        </div>
                        <div class="chart">
                            <span id="monthly-sales">
                            </span>
                        </div>
                    </li>
                    <li>
                        <div class="left">
                            <h4>
                            </h4>
                            <p>
                               
                            </p>
                        </div>
                        <div class="chart">
                            <span id="current-balance">
                            </span>
                        </div>
                    </li>
                    <li>
                        <div class="left">
                            <h4>
                            </h4>
                            <p>
                               
                            </p>
                        </div>
                        <div class="chart">
                            <span id="registrations">
                            </span>
                        </div>
                    </li>
                    <li>
                        <div class="left">
                            <h4>
                            </h4>
                            <p>
                                
                            </p>
                        </div>
                        <div class="chart">
                            <span id="site-visits">
                            </span>
                        </div>
                    </li>
                </ul>
            </div>--%>

            
            <div class="wrapper">
                <div id="scrollbar-two">
                    
                    <div class="viewport" style="width:100%;">
                        <div class="overview">
                            <div class="featured-articles-container">
                                <h5 class="heading-blue">热点投诉
                                </h5>
                                <div class="articles">
                                    <%foreach (var item in HotComplaintFormList)
                                        {%>
                                    <a href="/tousudetail.aspx?item=<%=item.c_id %>">
                                        
                                        <%=item.c_title.Length>12?item.c_title.Substring(0,12)+"...":item.c_title %>
                                    </a>
                                       <% } %>
                                    
                                </div>

                            </div>

                        </div>
                    </div>
                </div>
            </div>

            <hr class="hr-stylish-1">

            <div class="wrapper">
                <div id="scrollbar-two">
                    
                    <div class="viewport" style="width:100%;">
                        <div class="overview">
                            <div class="featured-articles-container">
                                <h5 class="heading-blue">相关投诉
                                </h5>
                                <div class="articles">
                                    <%foreach (var item in RelatedComplaintFormList)
                                        {%>
                                    <a href="/tousudetail.aspx?item=<%=item.c_id %>">
                                        <span class="label-bullet-blue">&nbsp;
                                        </span>
                                        <%=item.c_title.Length>12?item.c_title.Substring(0,12)+"...":item.c_title %>
                                    </a>
                                       <% } %>
                                    
                                </div>

                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Right Sidebar End -->

    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="foot" runat="server">

    <script src="js/layer-v2.3/layer/layer.js"></script>
    <script src="js/jquery.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/jquery.scrollUp.js"></script>
    <script src="js/jquery.dataTables.js"></script>

    <!-- Custom JS -->
    <script src="js/menu.js"></script>

    <script type="text/javascript">

        layer.ready(function () { //为了layer.ext.js加载完毕再执行
            layer.photos({
                photos: '#layer-photos-demo'
            });
        });

	 //Data Tables
        $(document).ready(function () {

       

        $('#data-table').dataTable({
          "sPaginationType": "full_numbers",
		  //"sDom": "<>lfrtip<>",
		  "bLengthChange": true,
		  "bPaginate": true,
		  //"bLengthChange": false,
		  "iDisplayLength": 10,
		  "aLengthMenu": [[10, 25, 50, -1], [10, 25, 50, "显示所有"]],
		 "oLanguage": {
		 
						
		 "sSearch": "搜索：",
		 "sLengthMenu": "每页显示 _MENU_ 条记录",
		 "sZeroRecords": "抱歉， 没有找到",
		 "sInfo": "从 _START_ 到 _END_ /共 _TOTAL_ 条数据",
		 "sInfoEmpty": "没有数据",
		 "sInfoFiltered": "(从 _MAX_ 条数据中检索)",
		 "oPaginate": {
		 "sFirst": "首页",
		 "sPrevious": "前一页",
		 "sNext": "后一页",
		 "sLast": "尾页"
		 
		 },
		 
		 "sZeroRecords": "没有检索到数据",
		 "sProcessing": "<img src='/img/loading-blue.gif' />"
		 }
        });
		
      });

	function filter(){
		var oTable = $('#data-table').dataTable();
		//oTable.fnFilter('33',1);
		scroll(0,460);
		//oTable.fnFilter('');
	
	}
	$("#submitBtn").click(function () {
	   
	    if ($("#myCommontArea").val() == "") {
	        alert("内容不能为空");

	    } else {
	        $("#discForm").submit();

	    }

	});
	function close() {
	    $("#resplyName").css("display","none");
	    $("#resplyIcon").css("display", "none");
	    $("#resplyName_hidden").val("false");
	}

	function resplyAction(n, i) {
	    $("#resplyName").css("display", "block");
	    $("#resplyIcon").css("display", "block");
	    $("#resplyName").text("@" + n);
	    $("#resplyName_hidden").val("@" + n);
	    $("#resplyId").val(i);
	    document.getElementsByTagName('BODY')[0].scrollTop = document.getElementsByTagName('body')[0].scrollHeight;
	    
	   // scrollTo(0,window.event.clientY);
	}
    </script>
</asp:Content>
