<%@ Page Title="" Language="C#" MasterPageFile="~/share/tousu.Master" AutoEventWireup="true" CodeBehind="tousu-statistics.aspx.cs" Inherits="TCS.Web.tousu_statistics" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">

    <div class=" col-md-offset-1">
        <!-- Left Sidebar Start -->
        <div class="sidebar" style="margin-left: 5%; margin-right: 5%;">

            <!-- Row Start -->
            <div class="row ">
                <div class="col-lg-11 col-md-11 "><a href="#"><%=language!="zh_us"?zh_us.index:zh_us.index_us %></a> > <a href="#"><%=language!="zh_us"?zh_us.statistics:zh_us.statistics_us %></a></div>
                <div class="col-lg-11 col-md-11">
                    <div class="widget no-margin">
                        <div class="widget-header">
                            <div class="title">
                               <%=language!="zh_us"?zh_us.statistics:zh_us.statistics_us %>
                            </div>
                        </div>
                        <div class="widget-body" style="">
                            <div class="panel-group" id="accordion">
                                

                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <h4 class="panel-title">
                                            <a data-toggle="collapse" data-parent="#accordion" href="#collapse1" data-original-title="" title="" aria-expanded="false" class="collapsed">
                                                2016年1月至5月七星景区旅游投诉分布示意图
                                            </a>
                                        </h4>
                                    </div>
                                    <div id="collapse1" class="panel-collapse collapse" aria-expanded="false" style="height: 0px;">
                                        <div class="panel-body" >
                                           <div id="container1" style=" width:100%; height:400px"></div>

                                        </div>
                                    </div>
                                </div>



                                
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <h4 class="panel-title">
                                            <a data-toggle="collapse" data-parent="#accordion" href="#collapse2" data-original-title="" title="" aria-expanded="false" class="collapsed">
                                                2016年1月至今七星景区旅游投诉曲线图
                                            </a>
                                        </h4>
                                    </div>
                                    <div id="collapse2" class="panel-collapse collapse" aria-expanded="false" style="height: 0px;">
                                        <div class="panel-body" >
                                           
                                            <div id="container2" style=" width:100%; height: 400px"></div>
                                           
                                        </div>
                                    </div>
                                </div>

<%--                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <h4 class="panel-title">
                                            <a data-toggle="collapse" data-parent="#accordion3" href="#collapse3" data-original-title="" title="" aria-expanded="false" class="collapsed">
                                            </a>
                                        </h4>
                                    </div>
                                    <div id="collapse3" class="panel-collapse collapse" aria-expanded="false" style="height: 0px;">
                                        <div class="panel-body" >
                                            <h3 style="text-align:center;"></h3>
                                            <p style="text-align:center;">
                                              
                                            </p>
                                        </div>
                                    </div>
                                </div>--%>
                            </div>
                           
                        </div>
                    </div>
                </div>

            </div>
            <!-- Row End -->

        </div>
        <!-- Left Sidebar End -->


    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="foot" runat="server">
    <script type="text/javascript" src="admin/lib/Highcharts/4.1.7/js/highcharts.js"></script>
<script type="text/javascript" src="admin/lib/Highcharts/4.1.7/js/highcharts-3d.js"></script>

    <script type="text/javascript">
        $(function () {


            $.post("/handler/tousuStatistics.ashx", { type: "typerate", mindate: "2016-01-01", maxdate: "2016-05-28" }, function (data) {
                var listObj = $.parseJSON(data);
                //alert(listObj[0].month + "," + listObj.length);
                var datalength = listObj.length;
                var ratedata = new Array();
                for (var i = 0; i < datalength; i++) {
                    ratedata[i] = new Array();

                    //cate += "'"+listObj[i].month+"',";
                    //data += parseInt(listObj[i].sum)+", ";
                    ratedata[i][0] = listObj[i].typename;
                    ratedata[i][1] = parseFloat(listObj[i].rate);
                }
                //alert(ratedata[0]);
                $('#container1').highcharts({
                    chart: {
                        type: 'pie',
                        options3d: {
                            enabled: true,
                            alpha: 45,
                            beta: 0
                        }
                    },
                    title: {
                        text: '2016年1月至5月七星景区旅游投诉分布示意图'
                    },
                    tooltip: {
                        pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
                    },
                    plotOptions: {
                        pie: {
                            allowPointSelect: true,
                            cursor: 'pointer',
                            depth: 35,
                            dataLabels: {
                                enabled: true,
                                format: '{point.name}: <b>{point.percentage:.1f}%</b>'
                            }
                        }
                    },
                    series: [{
                        type: 'pie',
                        name: '投诉分布比率',
                        /*data: [
                            ['门票问题', 15.0],
                            ['服务问题', 16.8],
                            {
                                name: '购物问题',
                                y: 12.8,
                                sliced: true,
                                selected: true
                            },
                            ['环境问题', 8.5],
                            ['安全问题', 6.2],
                            ['餐饮问题', 10.7],
                            ['停车问题', 6.2],
                            ['设施问题', 0.7],
                            ['娱乐问题', 16.2],
                            ['导游问题', 1.7],
                            ['其他问题', 10.7]
                        ]*/
                        data: ratedata
                    }]
                });
            });


            ////////////////////////////////////////////

            $.post("/handler/tousuStatistics.ashx", { type: "all", date: "2016" }, function (data) {
                var listObj = $.parseJSON(data);
                //alert(listObj[0].month + "," + listObj.length);
                var datalength = listObj.length;
                var cate = new Array();
                var data = new Array();
                for (var i = 0; i < datalength; i++) {
                    //cate += "'"+listObj[i].month+"',";
                    //data += parseInt(listObj[i].sum)+", ";
                    cate[i] = listObj[i].month;
                    data[i] = parseInt(listObj[i].sum);
                }
                //alert(cate);
                //alert(data);
                $('#container2').highcharts({
                    chart: {
                        type: 'line'
                    },
                    title: {
                        text: '2016年1月至今七星景区旅游投诉曲线图'
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
</asp:Content>
