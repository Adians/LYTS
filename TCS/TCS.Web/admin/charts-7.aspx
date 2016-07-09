<%@ Page Title="" Language="C#" MasterPageFile="~/share/tousuAdmin.Master" AutoEventWireup="true" CodeBehind="charts-7.aspx.cs" Inherits="TCS.Web.admin.charts_7" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderAdmin1" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderAdminbar" runat="server">
    <li class="active"><span title="3D饼状图" data-href="charts-7.aspx">3D饼状图</span><em></em></li>
 </asp:Content>   

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolderAdmin2" runat="server">

<nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 统计管理 <span class="c-gray en">&gt;</span> 饼状图 <a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
<div class="pd-20">
    <div class="text-c"> 日期范围：
		<input type="text" value="<%=DateTime.Now.ToString("yyyy")%>-01-01" onFocus="WdatePicker({maxDate:'#F{$dp.$D(\'datemax\')||\'%y-%M-%d\'}'})" id="datemin" class="input-text Wdate" style="width:120px;">
		-
		<input type="text" value="<%=DateTime.Now.ToString("yyyy-MM-dd") %>" onFocus="WdatePicker({minDate:'#F{$dp.$D(\'datemin\')}',maxDate:'%y-%M-%d'})" id="datemax" class="input-text Wdate" style="width:120px;">
		<%--<input type="text" class="input-text" style="width:250px" placeholder="输入关键词" id="" name="">--%>
		<button type="button" class="btn btn-success radius" id="findByDate" name=""><i class="Hui-iconfont">&#xe665;</i> 筛选</button>
            </div>
        <div class="cl pd-5 bg-1 bk-gray mt-20"> <span class="l"></span> <span class="r"></span> </div>
	<div id="container" style="width:100%;height:400px"></div>
</div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolderAdmin3" runat="server">
    <script type="text/javascript" src="lib/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="lib/Highcharts/4.1.7/js/highcharts.js"></script>
<script type="text/javascript" src="lib/Highcharts/4.1.7/js/highcharts-3d.js"></script>
<script type="text/javascript">
    $(function () {
        $("#menu-tongji dt").addClass("selected");
        $("#menu-tongji dd").css("display", "block");
        $("#menu-tongji li:eq(4) ").css("background-color", "rgba(171, 166, 166, 0.43)");
        $("#menu-tongji li:eq(4) a").css("color", "#06c");
        var nowdate = new Date();

        createChart(nowdate.getFullYear() + "-01-01", nowdate.getFullYear() + "-" + (nowdate.getMonth() + 1) + "-" + nowdate.getDate());
        $("#findByDate").click(function () {

            createChart($("#datemin").val(), $("#datemax").val())

        });
        function createChart(mindate, maxdate) {
            $.post("/handler/tousuStatistics.ashx", { type: "typerate", mindate: mindate, maxdate: maxdate  }, function (data) {
                var listObj = $.parseJSON(data);
                //alert(listObj[0].month + "," + listObj.length);
                var datalength = listObj.length;
                var ratedata = new Array();
                for (var i = 0; i < datalength; i++) {
                    ratedata[i] = new Array();


                    ratedata[i][0] = listObj[i].typename;
                    ratedata[i][1] = parseFloat(listObj[i].rate);
                }
                $('#container').highcharts({
                    chart: {
                        type: 'pie',
                        options3d: {
                            enabled: true,
                            alpha: 45,
                            beta: 0
                        }
                    },
                    title: {
                        text: '2016年七星景区旅游投诉分布示意图'
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
                        data: ratedata
                    }]
                });
            });
        }

});
</script>

</asp:Content>
