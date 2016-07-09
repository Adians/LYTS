<%@ Page Title="" Language="C#" MasterPageFile="~/share/tousuAdmin.Master" AutoEventWireup="true" CodeBehind="charts-5.aspx.cs" Inherits="TCS.Web.admin.charts_5" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderAdmin1" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderAdminbar" runat="server">
    <li class="active"><span title="饼状图" data-href="charts-5.aspx">饼状图</span><em></em></li>
 </asp:Content>   

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolderAdmin2" runat="server">

<nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 统计管理 <span class="c-gray en">&gt;</span> 饼状图 <a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
<div class="pd-20">
    <div class="text-c">
            选择年份：
            <select class="input-text Wdate" style="width: 120px;" id="datebyYears">
                <option value="all">全部</option>
                <%for (int i = 0; i < 5; i++)
                  {%>
                <option value="<%=DateTime.Now.ToString("yyyy").ToInt32()-i %>"><%=DateTime.Now.ToString("yyyy").ToInt32()-i %></option>
                <% } %>
                
            </select>
		
            <button type="button" class="btn btn-success radius" id="searchBtn" name=""><i class="Hui-iconfont">&#xe665;</i> 查询</button>
        </div>
        <div class="cl pd-5 bg-1 bk-gray mt-20"><span class="l"></span><span class="r"></span></div>
	<div id="container" style="width:100%;height:400px"></div>
</div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolderAdmin3" runat="server">
    <script type="text/javascript" src="lib/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="lib/Highcharts/4.1.7/js/highcharts.js"></script>
    <script src="lib/Highcharts/4.1.7/js/modules/drilldown.js"></script>

<script type="text/javascript">
    $(function () {
        $("#menu-tongji dt").addClass("selected");
        $("#menu-tongji dd").css("display", "block");
        $("#menu-tongji li:eq(2) ").css("background-color", "rgba(171, 166, 166, 0.43)");
        $("#menu-tongji li:eq(2) a").css("color", "#06c");

        createChart("all")
        $("#searchBtn").click(function () {

            //alert($("#datebyYears").val());
            createChart($("#datebyYears").val())
        });
        function createChart(date) {
            
            $.post("/handler/tousuStatistics.ashx", { type: "typesum", date: date }, function (data) {
                var listObj = $.parseJSON(data);
                //alert(listObj[0].month + "," + listObj.length);
                var datalength = listObj.length;
                var ratedata = new Array();
                var total = 0;
                for (var i = 0; i < datalength; i++) {
                    ratedata[i] = new Array();
                    //cate += "'"+listObj[i].month+"',";
                    //data += parseInt(listObj[i].sum)+", ";
                    ratedata[i][0] = listObj[i].typename;
                    ratedata[i][1] = parseInt(listObj[i].sum);
                    total += parseInt(listObj[i].sum);
                }
                
                if (date == "all") {
                    date = "";
                } else {
                    date =date+'年';
                }
                
                // Create the chart
                $('#container').highcharts({
                    chart: {
                        type: 'pie'
                    },
                    title: {
                        text: date+'七星景区旅游投诉总数'
                    },
                    subtitle: {
                        text: '点击可按类型查看'
                    },
                    plotOptions: {
                        series: {
                            dataLabels: {
                                enabled: true,
                                format: '{point.name}: {point.y} 例'
                            }
                        }
                    },

                    tooltip: {
                        headerFormat: '<span style="font-size:11px">{series.name}</span><br>',
                        pointFormat: '<span style="color:{point.color}">{point.name}</span>: <b>{point.y}</b> 例 <br/>'
                    },
                    series: [{
                        name: "投诉总数",
                        colorByPoint: true,
                        data: [{
                            name: date+"投诉量",
                            y: total,
                            drilldown: "投诉类型"
                        }]
                    }],
                    drilldown: {
                        series: [{
                            name: date+"投诉量",
                            id: "投诉类型",
                            data: ratedata/* [
                            ["门票问题", 24],
                            ["购物问题", 17],
                            ["环境问题", 8],
                            ["服务问题", 5],
                            ["安全问题", 10],
                            ["餐饮问题", 5],
                            ["停车问题", 33],
                            ["设施问题", 6],
                            ["娱乐问题", 5],
                            ["导游问题", 33],
                            ["其他问题", 6]
                        ]*/
                        }]
                    }
                });
            });
        }
        });
		</script>
</asp:Content>
