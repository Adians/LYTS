<%@ Page Title="" Language="C#" MasterPageFile="~/share/tousuAdmin.Master" AutoEventWireup="true" CodeBehind="charts-1.aspx.cs" Inherits="TCS.Web.admin.charts_1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderAdmin1" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderAdminbar" runat="server">
    <li class="active"><span title="折线图" data-href="charts-1.aspx">折线图</span><em></em></li>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolderAdmin2" runat="server">


    <nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 统计管理 <span class="c-gray en">&gt;</span> 投诉曲线图（年份） <a class="btn btn-success radius r mr-20" style="line-height: 1.6em; margin-top: 3px" href="javascript:location.replace(location.href);" title="刷新"><i class="Hui-iconfont">&#xe68f;</i></a></nav>
    <div class="pd-20">
        <div class="text-c">
            选择年份：
            <select class="input-text Wdate" style="width: 120px;" id="datebyYears"><%for (int i = 0; i < 5; i++)
                        {%>
                <option value="<%=DateTime.Now.ToString("yyyy").ToInt32()-i %>"><%=DateTime.Now.ToString("yyyy").ToInt32()-i %></option>
                       <% } %>
                
            </select>
		
            <button type="button" class="btn btn-success radius" id="searchBtn" name=""><i class="Hui-iconfont">&#xe665;</i> 查询</button>
        </div>
        <div class="cl pd-5 bg-1 bk-gray mt-20"><span class="l"></span><span class="r"></span></div>
        <div id="container" style="width:100%; height: 400px"></div>
    </div>

</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolderAdmin3" runat="server">
    <script type="text/javascript" src="lib/My97DatePicker/WdatePicker.js"></script>
    <script type="text/javascript" src="lib/Highcharts/4.1.7/js/highcharts.js"></script>
    
    <script type="text/javascript">
        $(function () {
            $("#menu-tongji dt").addClass("selected");
            $("#menu-tongji dd").css("display", "block");
            $("#menu-tongji li:eq(0) ").css("background-color", "rgba(171, 166, 166, 0.43)");
            $("#menu-tongji li:eq(0) a").css("color", "#06c");
            createChart((new Date()).getFullYear())
            $("#searchBtn").click(function () {

                //alert($("#datebyYears").val());
                createChart($("#datebyYears").val())
            });
            function createChart(date) {
                $.post("/handler/tousuStatistics.ashx", { type: "all", date: date }, function (data) {
                    var listObj = $.parseJSON(data);
                    var datalength = listObj.length;
                    var cate = new Array();
                    var data = new Array();
                    for (var i = 0; i < datalength; i++) {;
                        cate[i] = listObj[i].month;
                        data[i] = parseInt(listObj[i].sum);
                    }
                    $.post("/handler/tousuStatistics.ashx", { type: "getbymonth_Type", date: date }, function (data1) {
                        var listObj1 = $.parseJSON(data1);
                        //alert(listObj1);
                        $('#container').highcharts({
                            chart: {
                                type: 'spline'
                            },
                            title: {
                                text:date+ '年七星景区旅游投诉曲线图'
                            },
                            subtitle: {
                                text: '来源：旅游投诉网'
                            },
                            xAxis: {
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
                                shared: true,
                                pointFormat: '<span style="color:{point.color}">{series.name}</span>: <b>{point.y}(例)</b> <br/>'
                            },
                            plotOptions: {
                                spline: {
                                    marker: {
                                        radius: 4,
                                        lineColor: '#666666',
                                        lineWidth: 1
                                       
                                    }
                                }
                            },
                            series: listObj1
                        });
                    });
                });
            }
           
        });
    </script>
</asp:Content>
