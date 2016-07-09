<%@ Page Title="" Language="C#" MasterPageFile="~/share/tousuAdmin.Master" AutoEventWireup="true" CodeBehind="charts-3.aspx.cs" Inherits="TCS.Web.admin.charts_3" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderAdmin1" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderAdminbar" runat="server">
    <li class="active"><span title="区域图" data-href="charts-3.aspx">区域图</span><em></em></li>
 </asp:Content>   

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolderAdmin2" runat="server">

<nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 统计管理 <span class="c-gray en">&gt;</span> 区域图 <a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
<div class="pd-20">
	<div id="container" style="width:100%;height:400px"></div>
</div>

</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolderAdmin3" runat="server">

    <script type="text/javascript" src="lib/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="lib/Highcharts/4.1.7/js/highcharts.js"></script>
<script type="text/javascript">
$(function () {
    $('#container1').highcharts({
        chart: {
            type: 'area'
        },
        title: {
            text: 'US and USSR nuclear stockpiles'
        },
        subtitle: {
            text: 'Source: thebulletin.metapress.com'
        },
        xAxis: {
            labels: {
                formatter: function() {
                    return this.value; // clean, unformatted number for year
                }
            }
        },
        yAxis: {
            title: {
                text: 'Nuclear weapon states'
            },
            labels: {
                formatter: function() {
                    return this.value / 1000 +'k';
                }
            }
        },
        tooltip: {
            pointFormat: '{series.name} produced <b>{point.y:,.0f}</b><br/>warheads in {point.x}'
        },
        plotOptions: {
            area: {
                pointStart: 1940,
                marker: {
                    enabled: false,
                    symbol: 'circle',
                    radius: 2,
                    states: {
                        hover: {
                            enabled: true
                        }
                    }
                }
            }
        },
        series: [{
            name: 'USA',
            data: [null, null, null, null, null, 6 , 11, 32, 110, 235, 369, 640,1005, 1436,
            		2063, 3057, 4618, 6444, 9822, 15468, 20434, 24126,27387, 29459, 31056, 31982,
            		32040, 31233, 29224, 27342, 26662,26956, 27912, 28999, 28965, 27826, 25579,
            		25722, 24826, 24605,24304, 23464, 23708, 24099, 24357, 24237, 24401, 24344,
            		23586,22380, 21004, 17287, 14747, 13076, 12555, 12144, 11009, 10950,
                10871, 10824, 10577, 10527, 10475, 10421, 10358, 10295, 10104 
            ]
        }, {
            name: 'USSR/Russia',
            data: [null, null, null, null, null, null, null , null , null ,null,5, 25, 50,
            	120, 150, 200, 426, 660, 869, 1060, 1605, 2471, 3322,4238, 5221, 6129,
            	7089, 8339, 9399, 10538, 11643, 13092, 14478,15915, 17385, 19055, 21205,
            	23044, 25393, 27935, 30062, 32049,33952, 35804, 37431, 39197, 45000, 43000,
            	41000, 39000, 37000,35000, 33000, 31000, 29000, 27000, 25000, 24000, 23000,
            	22000,21000, 20000, 19000, 18000, 18000, 17000, 16000
            ]
        }]
    });
});
</script>

	<script type="text/javascript">
$(function () {
    $('#container').highcharts({
        chart: {
            plotBackgroundColor: null,
            plotBorderWidth: null,
            plotShadow: false,
            type: 'pie'
        },
        title: {
            text: 'Browser market shares January, 2015 to May, 2015'
        },
        tooltip: {
            pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
        },
        plotOptions: {
            pie: {
                allowPointSelect: true,
                cursor: 'pointer',
                dataLabels: {
                    enabled: true,
                    format: '<b>{point.name}</b>: {point.percentage:.1f} %',
                    style: {
                        color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
                    }
                }
            }
        },
        series: [{
            name: "Brands",
            colorByPoint: true,
            data: [{
                name: "Microsoft Internet Explorer",
                y: 56.33
            }, {
                name: "Chrome",
                y: 24.030000000000005,
                sliced: true,
                selected: true
            }, {
                name: "Firefox",
                y: 10.38
            }, {
                name: "Safari",
                y: 4.77
            }, {
                name: "Opera",
                y: 0.9100000000000001
            }, {
                name: "Proprietary or Undetectable",
                y: 0.2
            }]
        }]
    });
});
		</script>
</asp:Content>
