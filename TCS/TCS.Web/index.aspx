<%@ Page Title="" Language="C#" MasterPageFile="~/share/tousu.Master" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="TCS.Web.index" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     
   
    <style>
        .box {
            margin: 20px;
            height: 205px;
            padding: 10px;
            overflow: hidden;
            margin: 0;
            padding: 0;
            color:black;
            font-weight:bold;
        }

            .box ul li {
                list-style: none;
                line-height: 25px;
            }
        #layui-layer2 {
            left:380px;
        
        }
        #layui-layer4 {
            left:380px;
        }
        #layui-layer6 {
            left:380px;
        
        }
        #layui-layer8 {
            left:380px;
        }
        #layui-layer10 {
            left:380px;
        }
        #layui-layer12 {
            left:380px;
        }
        #layui-layer14 {
            left:380px;
        }

        #layui-layer1 {
            left:380px;
        
        }
        #layui-layer3 {
            left:380px;
        }
        #layui-layer5 {
            left:380px;
        
        }
        #layui-layer7 {
            left:380px;
        }
        #layui-layer9 {
            left:380px;
        }
        #layui-layer11 {
            left:380px;
        }
        #layui-layer13 {
            left:380px;
        }

       
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">

    <div class=" col-md-offset-1" >
      
        <!-- Left Sidebar Start -->
        <div class="left-sidebar" style="margin-left: 5%; min-height:550px;">

            <!-- Row Start -->
            <div class="row">
                <div class="col-lg-4 col-md-4 " style="padding-right: 0px;">
                    <div class="widget">
                        <div class="widget-header">
                            <div class="title">
                                <%=language!="zh_us"?zh_us.latestnotice:zh_us.latestnotice_us %>
                            </div>
                            <span class="tools">
                                <a href="/notice.aspx"><%=language!="zh_us"?zh_us.more:zh_us.more_us %><i class="fa fa-angle-double-right"></i></a>
                            </span>
                        </div>
                        <div class="widget-body" style="padding-bottom: 3px;">
                            <div class="todo-container">
                                <ul class="todo-list">
                                    <%foreach (var item in NoticeArticleList)
                                    {%>
                                    <li class="">
                                        <label for="1">
                                             <a href="/notice.aspx?type=<%=item.a_type %>" title="<%=item.a_title %>"><%=item.a_title.Length>15?item.a_title.Substring(0,15)+"...":item.a_title %>
                                </a>
                                        </label>
                                        <span style=" float:right; margin-right:3px; color:#bfbfbf;"><%=language!="zh_us"?TimeFormat.GetTimeSpan(DateTime.Now-item.a_createdTime):TimeFormat.GetTimeSpan_us(DateTime.Now-item.a_createdTime) %></span>
                                    </li>
                                      <%  } %>
                                    
                                </ul>

                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6 col-md-6 " style="padding-right: 0px;">
                    <div class="widget">
                        <div class="widget-header">
                            <div class="title">
                                <%=language!="zh_us"?zh_us.cmpldynamics:zh_us.cmpltdynamics_us %>
                            </div>
                            <span class="tools">
                                <a href="/tousulist.aspx"><%=language!="zh_us"?zh_us.more:zh_us.more_us %><i class="fa fa-angle-double-right"></i></a>
                            </span>
                        </div>
                        <div class="widget-body">
                            <div class="box">
                                <ul>
                                    <%foreach (var item in DynamicComplaintFormList)
                                        {%>
                                    <li>
                                        <div class="message-container">
                                            <div class="message">
                                                <div class="img-container">
                                                    <img src="<%=_UserInfoService.QuerySingle(item.c_uId).u_pic %>" alt="">
                                                </div>
                                                <article>
                                                    <h6 class="no-margin">
                                                        <a href="#">@<%=string.IsNullOrEmpty(_UserInfoService.QuerySingle(item.c_uId).u_nickName)?_UserInfoService.QuerySingle(item.c_uId).u_loginName:_UserInfoService.QuerySingle(item.c_uId).u_nickName %></a>
                                                        
                                                    </h6>
                                                    <p class="no-margin">
                                                       <%=item.c_title %>
                                                    </p>
                                                </article>
                                                <div class="icons-nav">
                                                    <ul>
                                                        <li class="time"><%=language!="zh_us"?TimeFormat.GetTimeSpan(DateTime.Now-item.c_submitTime):TimeFormat.GetTimeSpan_us(DateTime.Now-item.c_submitTime) %></li>
                                                        <li>
                                                            <a href="/tousudetail.aspx?item=<%=item.c_id %>"><i class="fa fa-file-text-o"></i></a>
                                                        </li>
                                                    </ul>
                                                </div>
                                            </div>

                                        </div>


                                    </li>
                                       <% } %>
                                    
                                   
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Row End -->



            <!-- Row Start -->
            <div class="row">
                <div class="col-lg-10 col-md-10 " style="padding-right: 0px;">
                    <div class="widget">
                        <div class="widget-header">
                            <div class="title">
                                <%=language!="zh_us"?zh_us.hotcomplaint:zh_us.hotcomplaint_us %>
                     
                            </div>
                            <span class="tools">
                                <a href="/tousulist.aspx"><%=language!="zh_us"?zh_us.more:zh_us.more_us %><i class="fa fa-angle-double-right"></i></a>
                            </span>
                        </div>
                        <div class="widget-body" style="padding-top: 0px;padding-bottom: 7px; min-height: 180px;">

                            <table class="table table-condensed table-striped table-hover no-margin">
                                <thead>
                                    <tr>

                                        <th style="width: 17%"><%=language!="zh_us"?zh_us.user:zh_us.user_us %>
                                        </th>
                                        <th style="width: 56%" class="hidden-phone"><%=language!="zh_us"?zh_us.title:zh_us.title_us %>
                                        </th>
                                        <th style="width: 12%" class="right-align-text hidden-phone"><%=language!="zh_us"?zh_us.type:zh_us.type_us %>
                                        </th>
                                        <th style="width: 15%" class="right-align-text hidden-phone"><%=language!="zh_us"?zh_us.time:zh_us.time_us %>
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%foreach (var item in HotComplaintFormList)
                                        {%>
                                    <tr>

                                        <td><%=_UserInfoService.QuerySingle(item.c_uId).u_nickName %>
                                        </td>
                                        <td class="hidden-phone">
                                            <a href="/tousudetail.aspx?item=<%=item.c_id %>">
                                                <strong><%=item.c_title %>
                                                </strong>
                                            </a>
                                        </td>
                                        <td class="right-align-text hidden-phone">
                                            <span class="label label-info"><%=_ComplaintTypeService.QuerySingle(item.c_typeId).ct_name %>
                                            </span>
                                        </td>
                                        <td class="right-align-text hidden-phone"><%=item.c_submitTime.ToString("yyyy-MM-dd") %>
                                        </td>
                                    </tr>
                                      <%  } %>
                                    
                                </tbody>
                            </table>

                        </div>
                    </div>
                </div>
            </div>
            <!-- Row End -->




        </div>
        <!-- Left Sidebar End -->

        <!-- Right Sidebar Start -->
        <div class="right-sidebar" style="margin-right: 11%;">

            <div class="wrapper">
                <ul class="stats" style="line-height: 50px; text-align: center;">
                    <li>
                        <div class="left">
                            <h4 style="line-height: 50px; margin: 0px; text-align: center;"><%=language!="zh_us"?zh_us.today:zh_us.cmplttoday_us %>
                            </h4>

                        </div>
                        <div>
                            <span><%=todayCount %>
                            </span>
                        </div>
                    </li>
                    <li>
                        <div class="left">
                            <h4 style="line-height: 50px; margin: 0px; text-align: center;"><%=language!="zh_us"?zh_us.cmplttotal:zh_us.cmplttotal_us %>
                            </h4>

                        </div>
                        <div>
                            <span><%=allCount %>
                            </span>
                        </div>
                    </li>
                    <li>
                        <div class="left">
                            <h4 style="line-height: 50px; margin: 0px; text-align: center;"><%=language!="zh_us"?zh_us.cmpltresolved:zh_us.cmpltresolved_us %>
                            </h4>

                        </div>
                        <div>
                            <span><%=replyCount %>
                            </span>
                        </div>
                    </li>
                    <li>
                        <div class="left">
                            <h4 style="line-height: 50px; margin: 0px; text-align: center;"><%=language!="zh_us"?zh_us.satisfaction:zh_us.satisfaction_us %>
                            </h4>

                        </div>
                        <div>
                            <span><%=satisfaction %>%
                            </span>
                        </div>
                    </li>

                </ul>
            </div>



            <hr class="hr-stylish-1" style="margin-bottom: 10px;">

            <div class="wrapper">

                <div class="viewport">
                    <div class="overview">
                        <div class="featured-articles-container">
                            <h5 class=" heading" style="color: black; font-weight: bold;">
                                <%=language!="zh_us"?zh_us.article:zh_us.article_us %>
                            </h5>
                            <div class="articles">
                                <%foreach (var item in NewsArticleList)
                                    {%>
                                <a href="/notice.aspx?type=<%=item.a_type %>" title="<%=item.a_title %>"><%=item.a_title.Length>14?item.a_title.Substring(0,14)+"...":item.a_title %>
                                </a>
                                 <%   } %>
                                
                            </div>

                        </div>

                    </div>
                </div>
            </div>
        </div>
        
        <div style="clear:both;"></div>
        <!-- Row Start -->
        <div class="row" style="margin-left: 3.7%; margin-right: 4.9%;">
            <div class="col-lg-11 col-md-11 " style="padding-right: 0px;">
                <div class="widget no-margin">
                    <div class="widget-header">
                        <div class="title">
                            <%=language!="zh_us"?zh_us.statistics:zh_us.statistics_us %>
                        </div>
                        <span class="tools">
                            <a href="/tousu-statistics.aspx"><%=language!="zh_us"?zh_us.more:zh_us.more_us %><i class="fa fa-angle-double-right"></i></a>
                        </span>
                    </div>
                    <div class="widget-body">

                        <div id="container" style= "width:100%; height: 400px"></div>

                    </div>
                </div>
            </div>
        </div>
        <!-- Row End -->
    </div>
    <!-- Right Sidebar End -->


</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="foot" runat="server">
    
    <script src="admin/lib/Highcharts/4.1.7/js/highcharts.js"></script>
   
    <script type="text/javascript">
       
        $(function () {
            
            $.post("/handler/tousuStatistics.ashx", { type: "all", date: "2016" }, function (data) {
                var listObj = $.parseJSON(data);
                //alert(listObj[0].month + "," + listObj.length);
                var datalength = listObj.length;
                var cate = new Array() ;
                var data = new Array();
                for (var i = 0; i < datalength; i++) {
                    //cate += "'"+listObj[i].month+"',";
                    //data += parseInt(listObj[i].sum)+", ";
                    cate[i] = listObj[i].month;
                    data[i] = parseInt(listObj[i].sum);
                }
                //alert(cate);
                //alert(data);
                $('#container').highcharts({
                    chart: {
                        type: 'line'
                    },
                    title: {
                        text: '七星景区旅游投诉曲线图'
                    },
                    subtitle: {
                        text: '来源: 旅游投诉网'
                    },
                    xAxis: {
                        //categories: ['一月', '二月', '三月', '四月', '五月', '六月', '七月', '八月', '九月', '十月', '十一月', '十二月']
                        categories: cate
                    },
                    yAxis: {
                        title: {
                            text: '投诉数量（例）'
                        },
                        labels: {
                            formatter: function () {
                                return this.value;
                            }
                        }
                    },
                    tooltip: {
                        crosshairs: true,
                        shared: true
                    },
                    plotOptions: {
                        line: {
                            dataLabels: {
                                enabled: true
                            },
                            enableMouseTracking: false
                        }
                    },
                    series: [{
                        name: '2016年七星景区投诉数量',

                        //data: [39, 42, 47, 45, 49, 52, 47, 46, 44, 40, 46, 48]
                        data: data
                    }]
                });
                
             });
            
        });
    </script>


    <script>

        $(function ($) {
           
            $.fn.scrollTop = function (options) {
                var defaults = {
                    speed: 30
                }
                var opts = $.extend(defaults, options);
                this.each(function () {
                    var $timer;
                    var scroll_top = 0;
                    var obj = $(this);
                    var $height = obj.find("ul").height();
                    obj.find("ul").clone().appendTo(obj);
                    obj.hover(function () {
                        clearInterval($timer);
                    }, function () {
                        $timer = setInterval(function () {
                            scroll_top++;
                            if (scroll_top > $height) {
                                scroll_top = 0;
                            }
                            obj.find("ul").first().css("margin-top", -scroll_top);
                        }, opts.speed);
                    }).trigger("mouseleave");
                })
            }
        })
    </script>
    <script>
        $(function () {
            $(".box").scrollTop({
                speed: 30 //数值越大 速度越慢
            });
        })
    </script>
   
</asp:Content>
