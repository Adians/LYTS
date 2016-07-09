<%@ Page Title="" Language="C#" MasterPageFile="~/share/tousu.Master" AutoEventWireup="true" CodeBehind="tousulist.aspx.cs" Inherits="TCS.Web.tousulist" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .table-striped > tbody > tr:nth-of-type(odd) {
            background-color: rgba(142, 193, 197, 0.23);
        }

        .table-striped > tbody > tr:nth-of-type(even):hover {
            cursor: pointer;
            background-color: rgba(226, 216, 216, 0.55);
        }

        .table-striped > tbody > tr:nth-of-type(odd):hover {
            cursor: pointer;
            background-color: rgba(54, 147, 207, 0.5);
        }

        #data-table_processing {
            z-index: 99999999;
            top: 150px;
            left: 50%;
            position: relative;
            width: 20%;
        }


        #msgBox {
            position: relative;
            background-color: rgba(58, 16, 18, 0.37);
            width: 30%;
            color: white;
            font-size: 16px;
            font-weight: bold;
            padding: 10px;
            border-radius: 6px;
        }

            #msgBox p {
                margin: 10px;
            }

        .width0 {
            width: 1%;
        }

        .width1 {
            width: 40%;
        }

        .width2 {
            width: 15%;
        }

        .width3 {
            width: 9%;
        }

        .width4 {
            width: 6%;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">

    <!-- Left Sidebar Start -->
    <div style="margin-left: 5%; margin-right: 5%;">


        <!-- Row Start -->
        <div class="row">
            <div class="col-lg-10 col-md-10 col-md-offset-1"><a href="#"><%=language!="zh_us"?zh_us.index:zh_us.index_us %></a> > <a href="#"><%=language!="zh_us"?zh_us.complaint:zh_us.complaint_us %></a></div>
            <div class="col-lg-10 col-md-10 col-md-offset-1">
                <div class="widget">
                    <div class="widget-header">
                        <div class="title">
                            <%=language!="zh_us"?zh_us.complaintlabel:zh_us.complaintlabel_us %>
                        </div>
                        <span class="tools">
                            <a class="btn btn-info btn-sm" href="#">
                                <%=language!="zh_us"?zh_us.month:zh_us.month_us %>

                            </a>
                            <a class="btn btn-info btn-sm" href="#">
                                <%=language!="zh_us"?zh_us.year:zh_us.year_us %>

                            </a>
                            <a class="btn btn-danger btn-sm" href="#">
                                <%=language!="zh_us"?zh_us.total:zh_us.total_us %>
                            </a>
                        </span>
                    </div>
                    <div class="widget-body">
                        <div class="metro-nav">
                            <div class="metro-nav-block nav-block-blue double ">
                                <a href="javascript:filter('all')">
                                    <i class="fa fa-map-marker"></i>
                                    <div class="info"><%=_ComplaintFormService.QueryCount(null) %></div>
                                    <div class="brand">全部</div>
                                </a>
                            </div>
                            <%foreach (var item in CurrentComplaintType)
                                {
                                    var count = _ComplaintFormService.QueryCount(new { c_typeId = item.ct_id });
                            %>
                            <div class="metro-nav-block <%=item.ct_style %>">
                                <a href="javascript:filter('<%=item.ct_name %>')">
                                    <i class="<%=item.ct_icon %>"></i>
                                    <div class="info"><%=count %></div>
                                    <div class="brand"><%=item.ct_name %></div>
                                </a>
                            </div>
                            <%} %>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Row End -->


        <!-- Row Start -->
        <div class="row">
            <div class="col-lg-10 col-md-10 col-md-offset-1">
                <div class="widget">
                    <div class="widget-header">
                        <div class="title" >
                            <span id="tousulistSearchType" class="btn btn-info btn-sm">全部</span>
                        </div>
                    </div>
                    <div class="widget-body">
                        <div id="dt_example" class="example_alt_pagination">
                            <table class="table table-condensed table-striped table-hover table-bordered pull-left" id="data-table" style="width: 100%;">

                                <thead>
                                    <tr>

                                        <th style="width: 0%">序号
                                        </th>
                                        <th style="width: 5%">序号
                                        </th>
                                        <th style="width: 10%">提交时间
                                        </th>
                                        <th style="width: 10%">提交人
                                        </th>
                                        <th style=" class="hidden-phone">主题
                                        </th>
                                        <th style="width: 10%" class="hidden-phone">类型
                                        </th>
                                        <th style="width: 15%" class="hidden-phone">状态
                                        </th>
                                        <th style="width: 10%" class="hidden-phone">评论数
                                        </th>
                                    </tr>
                                </thead>

                            </table>
                            <div class="clearfix">
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Row End -->
        <!-- Left Sidebar End -->
        <div id="msgBox" style="display: none;">
            
        </div>
        <input type="hidden" id="language" value="<%=language %>" />
    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="foot" runat="server">


    <script src="js/jquery.dataTables.js"></script>

    <script type="text/javascript">
        //Data Tables
        $(document).ready(function () {
            var language = $("#language").val();
            var docrTable = $('#data-table').dataTable({
                "sPaginationType": "full_numbers",
                //"sDom": "<>lfrtip<>",
                "bLengthChange": true,
                "bPaginate": true,
                "bRedraw": true,
                
                "bProcessing": true,
                "aaSorting": [[1, "asc"]],
                
                "iDisplayLength": 10,
                "aLengthMenu": [[10, 25, 50, -1], [10, 25, 50, "显示所有"]],
                "sAjaxSource": '/handler/tousuList.ashx',
                
                "sAjaxDataProp": "aaData",
                "aoColumns": [{
                    "mDataProp": "ID",
                    "sDefaultContent": 1, //此列默认值为""，以防数据中没有此值，DataTables加载数据的时候报错  
                    "bVisible": false,//此列不显示  
                    "bSearchable": false
                   

                }, {
                    "mDataProp": "ORDERNO",
                    "sTitle": language != "zh_cn" ? "No" : "序号",
                    "sDefaultContent": 1,
                    "sClass": "width4"
                   
                }, {
                    "mDataProp": "SUBMITTIME",
                    "sTitle": language != "zh_cn" ? "TIME" : "提交日期",
                    "sDefaultContent": "aa",
                    //"sClass": "center"
                    "sClass": "width3",
                    "bSearchable": true,
                    "bFilter": true
                }, {
                    "mDataProp": "UNAME",
                    "sTitle": language != "zh_cn" ? "USER" : "提交人",
                    "sDefaultContent": "aa",
                    //"sClass": "center"
                    "sClass": "width3"
                }, {
                    "mDataProp": "TITLE",
                    "sTitle": language != "zh_cn" ? "TITLE" : "主题",
                    "sDefaultContent": "aa",
                    //"sClass": "width1",

                    "sClass": "center"
                }, {
                    "mDataProp": "TYPENAME",
                    "sTitle": language != "zh_cn" ? "TYPE" : "类型",
                    "sDefaultContent": "aa",
                    //"sClass": "center"
                    "sClass": "width3",
                }, {
                    "mDataProp": "STATUSNAME",
                    "sTitle": language != "zh_cn" ? "STATUS" : "状态",
                    "sDefaultContent": "aa",
                    //"sClass": "center"
                    "sClass": "width2"
                }, {
                    "mDataProp": "COMMENTS",
                    "sTitle": language != "zh_cn" ? "COMMENTS" : "评论数",
                    "sDefaultContent": "aa",
                    //"sClass": "center"
                    "sClass": "width3"
                }],
                
                "oLanguage": {


                    "sSearch": language != "zh_cn" ? "Search:" : "搜索：",
                    "sLengthMenu": language != "zh_cn" ? "display _MENU_ per page" : "每页显示 _MENU_ 条记录",
                    "sZeroRecords": language != "zh_cn" ? "sorry,no search" : "抱歉， 没有找到",
                    "sInfo": language != "zh_cn" ? "From _START_to _END_ / total _TOTAL_ data" : "从 _START_ 到 _END_ /共 _TOTAL_ 条数据",
                    "sInfoEmpty": language != "zh_cn" ? "No Data:" : "没有数据",
                    "sInfoFiltered": language != "zh_cn" ? "(search from _MAX_ data)" : "(从 _MAX_ 条数据中检索)",
                    "oPaginate": {
                        "sFirst":language != "zh_cn" ? "First" : "首页",
                        "sPrevious": language != "zh_cn" ? "PrePage" : "前一页",
                        "sNext": language != "zh_cn" ? "NextPage" : "后一页",
                        "sLast": language != "zh_cn" ? "LastPage" : "尾页"

                    },

                    "sZeroRecords": language != "zh_cn" ? "No search data" : "没有检索到数据",
                    "sProcessing": "<img src='/img/loading-blue.gif' />"
                }

            });

           

            $("#data-table tbody").click(function (event) {
                $(docrTable.fnSettings().aoData).each(function () {
                    
                });
               
                var aData = docrTable.fnGetData(event.target.parentNode);
                document.location.href = "tousudetail.aspx?item=" + aData.ID;

             
            });



            $("#data-table tbody").mouseover(
                function (event) {
                   
                    $("#data-table").css("width", 100 + "%");
                    $(event.target.parentNode).attr("title", "点击查看");
                    var aData = docrTable.fnGetData(event.target.parentNode);
                   
                });

           

        });


        function filter(name) {
           
            var oTable = $('#data-table').dataTable();
            if (name == 'all') {
                //oTable.fnDraw(true);
                oTable.fnFilter('问题',5);
                $("#tousulistSearchType").text("全部");
               
                oTable.fnFilter("");
               
                
            }
            else {
                //oTable.fnFilter("");
              
                oTable.fnFilter(name, 5);
                $("#tousulistSearchType").text(name);
                oTable.fnFilter("");
            }
            
            scroll(0, 460);
            //oTable.fnFilter("");

        }






    </script>
</asp:Content>
