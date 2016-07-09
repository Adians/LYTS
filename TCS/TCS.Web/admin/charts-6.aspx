<%@ Page Title="" Language="C#" MasterPageFile="~/share/tousuAdmin.Master" AutoEventWireup="true" CodeBehind="charts-6.aspx.cs" Inherits="TCS.Web.admin.charts_6" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderAdmin1" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderAdminbar" runat="server">
    <li class="active"><span title="3D柱状图" data-href="charts-6.aspx">3D柱状图</span><em></em></li>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolderAdmin2" runat="server">

    <nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 统计管理 <span class="c-gray en">&gt;</span> 柱状图 <a class="btn btn-success radius r mr-20" style="line-height: 1.6em; margin-top: 3px" href="javascript:location.replace(location.href);" title="刷新"><i class="Hui-iconfont">&#xe68f;</i></a></nav>
    <div class="pd-20">
        <div class="text-c">
            选择年份：
            <select class="input-text Wdate" style="width: 120px;" id="datebyYears">
                <%for (int i = 0; i < 5; i++)
                  {%>
                <option value="<%=DateTime.Now.ToString("yyyy").ToInt32()-i %>"><%=DateTime.Now.ToString("yyyy").ToInt32()-i %></option>
                <% } %>
                
            </select>
		
            <button type="button" class="btn btn-success radius" id="searchBtn" name=""><i class="Hui-iconfont">&#xe665;</i> 查询</button>
        </div>
        <div class="cl pd-5 bg-1 bk-gray mt-20"><span class="l"></span><span class="r"></span></div>
        <div id="container" style="width:100%;height: 400px"></div>
    </div>

</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolderAdmin3" runat="server">

    <script type="text/javascript" src="lib/My97DatePicker/WdatePicker.js"></script>
    <script type="text/javascript" src="lib/Highcharts/4.1.7/js/highcharts.js"></script>

    <script src="lib/Highcharts/4.1.7/js/modules/data.js"></script>
    <script src="lib/Highcharts/4.1.7/js/modules/drilldown.js"></script>
    <script type="text/javascript">
        $(function () {
            $("#menu-tongji dt").addClass("selected");
            $("#menu-tongji dd").css("display", "block");
            $("#menu-tongji li:eq(3)").css("background-color", "rgba(171, 166, 166, 0.43)");
            $("#menu-tongji li:eq(3) a").css("color", "#06c");
            createChart((new Date()).getFullYear())
            $("#searchBtn").click(function () {

                //alert($("#datebyYears").val());
                createChart($("#datebyYears").val())
            });
            function createChart(date) {
                $.post("/handler/tousuStatistics.ashx", { type: "byMonth", date: date }, function (data) {

                    var listObj = $.parseJSON(data);
                    var datalength = listObj.length;
                    //alert(listObj);

                    /*var mdata = new Array();
                    for (var i = 0; i < datalength; i++) {
                        mdata[i] = new Array();
                        mdata[i][0] = listObj[i].name;
                        mdata[i][1] = parseInt(listObj[i].y);
                        mdata[i][2] = listObj[i].drilldown;
                    }
                    alert(mdata);*/

                    $.post("/handler/tousuStatistics.ashx", { type: "byDay", date: date }, function (data1) {
                        //alert(listObj);
                        //alert(data1);
                        var listObj1 = $.parseJSON(data1);
                        //alert(listObj1);
                        $('#container').highcharts({
                            chart: {
                                type: 'column'
                            },
                            title: {
                                text: date+'年七星景区投诉数量柱状图'
                            },
                            subtitle: {
                                text: '点击可查看每日投诉量. 来源:旅游投诉网.'
                            },
                            xAxis: {
                                type: 'category'
                            },
                            yAxis: {
                                title: {
                                    text: '投诉数量（例）'
                                }

                            },
                            legend: {
                                enabled: false
                            },
                            plotOptions: {
                                series: {
                                    borderWidth: 0,
                                    dataLabels: {
                                        enabled: true,
                                        format: '{point.y}例'
                                    }
                                }
                            },

                            tooltip: {
                                headerFormat: '<span style="font-size:11px">{series.name}</span><br>',
                                pointFormat: '<span style="color:{point.color}">{point.name}</span>共有: <b>{point.y}例</b> <br/>'
                            },

                            series: [{
                                name: "月份",
                                colorByPoint: true,
                                data: listObj/*[{
                name: "Microsoft Internet Explorer",
                y: 56.33,
                drilldown: "Microsoft Internet Explorer"
            }, {
                name: "Chrome",
                y: 24.030000000000005,
                drilldown: "Chrome"
            }, {
                name: "Firefox",
                y: 10.38,
                drilldown: "Firefox"
            }, {
                name: "Safari",
                y: 4.77,
                drilldown: "Safari"
            }, {
                name: "Opera",
                y: 0.9100000000000001,
                drilldown: "Opera"
            }, {
                name: "Proprietary or Undetectable",
                y: 0.2,
                drilldown: null
            }]*/
                            }],
                            drilldown: {
                                series: listObj1 /* [{
                                name: "三月",
                                id: "三月",
                                data: [
                                [
                                "v11.0",
                                24.13],
                                [
                                "v8.0",
                                17.2],
                                [
                                "v9.0",
                                8.11],
                                [
                                "v10.0",
                                5.33],
                                [
                                "v6.0",
                                1.06],
                                [
                                "v7.0",
                                0.5]
                                ]
                            }, {
                                name: "四月",
                                id: "四月",
                                data: [
                                [
                                "v40.0",
                                5],
                                [
                                "v41.0",
                                4.32],
                                [
                                "v42.0",
                                3.68],
                                [
                                "v39.0",
                                2.96],
                                [
                                "v36.0",
                                2.53],
                                [
                                "v43.0",
                                1.45],
                                [
                                "v31.0",
                                1.24],
                                [
                                "v35.0",
                                0.85],
                                [
                                "v38.0",
                                0.6],
                                [
                                "v32.0",
                                0.55],
                                [
                                "v37.0",
                                0.38],
                                [
                                "v33.0",
                                0.19],
                                [
                                "v34.0",
                                0.14],
                                [
                                "v30.0",
                                0.14]
                                ]
                            }, {
                                name: "五月",
                                id: "五月",
                                data: [
                                [
                                "v35",
                                2.76],
                                [
                                "v36",
                                2.32],
                                [
                                "v37",
                                2.31],
                                [
                                "v34",
                                1.27],
                                [
                                "v38",
                                1.02],
                                [
                                "v31",
                                0.33],
                                [
                                "v33",
                                0.22],
                                [
                                "v32",
                                0.15]
                                ]
                            }, {
                                name: "六月",
                                id: "六月",
                                data: [
                                [
                                "v8.0",
                                2.56],
                                [
                                "v7.1",
                                0.77],
                                [
                                "v5.1",
                                0.42],
                                [
                                "v5.0",
                                0.3],
                                [
                                "v6.1",
                                0.29],
                                [
                                "v7.0",
                                0.26],
                                [
                                "v6.2",
                                0.17]
                                ]
                            }, {
                                name: "Opera",
                                id: "Opera",
                                data: [
                                [
                                "v12.x",
                                0.34],
                                [
                                "v28",
                                0.24],
                                [
                                "v27",
                                0.17],
                                [
                                "v29",
                                0.16]
                                ]
                            }]*/
                            }
                        });
                    });
                });
            }
        });
    </script>

</asp:Content>
