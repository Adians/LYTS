<%@ Page Title="" Language="C#" MasterPageFile="~/share/tousu.Master" AutoEventWireup="true" CodeBehind="contactus.aspx.cs" Inherits="TCS.Web.contactus" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     <link href="js/layer-v2.3/layer/skin/layer.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    
    <div class=" col-md-offset-1">
        <!-- Left Sidebar Start -->
        <div class="sidebar" style="margin-left: 5%; margin-right: 5%;">



            <!-- Row Start -->
            <div class="row ">
                <div class="col-lg-11 col-md-11 "><a href="#"><%=language!="zh_us"?zh_us.index:zh_us.index_us %></a> > <a href="#"><%=language!="zh_us"?zh_us.contactus:zh_us.contactus_us %></a></div>
                <div class="col-lg-11 col-md-11">
                    <div class="widget no-margin">
                        <div class="widget-header">
                            <div class="title">
                               <%=language!="zh_us"?zh_us.contactus:zh_us.contactus_us %>
                            </div>

                        </div>
                        <div class="widget-body" style="min-height:600px;">
                            <div class="panel-group" id="accordion">
                                <div style="width:800px;font-size:14px; margin-left:9%;">
                                    <p> 
                                        <%=language!="zh_us"?zh_us.address:zh_us.address_us %>：桂林市七星路1号</p>
                                    <p> <%=language!="zh_us"?zh_us.contacttel:zh_us.contacttel_us %>：0773—5815050 (<%=language!="zh_us"?zh_us.consult:zh_us.consult_us %>）</p>
                                    <p style="margin-left:70px;">0773—5814343（<%=language!="zh_us"?zh_us.cmplt:zh_us.cmplt_us %>）</p>
                                
                                </div>
                                <div style="width:80.5%;height:550px;border:#ccc solid 1px;font-size:12px; margin-left:9%;" id="map">
                                    <img src="img/20160525171535.png" width="100%" height="548px" style="padding:1px;"/>
                                </div>
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
     <script src="js/layer-v2.3/layer/layer.js"></script>
    <script src="js/jquery.js"></script>
     <script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=RE0eCY0G8qPqeOA6MgEmrGRGUpqh28zL"></script>

    <script type="text/javascript">
    //创建和初始化地图函数：
    function initMap(){
      createMap();//创建地图
      setMapEvent();//设置地图事件
      addMapControl();//向地图添加控件
      addMapOverlay();//向地图添加覆盖物
    }
    function createMap(){ 
      map = new BMap.Map("map"); 
      map.centerAndZoom(new BMap.Point(110.319728,25.277847),17);
    }
    function setMapEvent(){
      map.enableScrollWheelZoom();
      map.enableDragging();
      map.enableDoubleClickZoom()
    }
    function addClickHandler(target,window){
      target.addEventListener("click",function(){
        target.openInfoWindow(window);
      });
    }
    function addMapOverlay(){
    }
    //向地图添加控件
    function addMapControl(){
      var scaleControl = new BMap.ScaleControl({anchor:BMAP_ANCHOR_BOTTOM_LEFT});
      scaleControl.setUnit(BMAP_UNIT_IMPERIAL);
      map.addControl(scaleControl);
      var navControl = new BMap.NavigationControl({anchor:BMAP_ANCHOR_TOP_LEFT,type:BMAP_NAVIGATION_CONTROL_LARGE});
      map.addControl(navControl);
      var overviewControl = new BMap.OverviewMapControl({anchor:BMAP_ANCHOR_BOTTOM_RIGHT,isOpen:true});
      map.addControl(overviewControl);
    }
    var map;
    initMap();


    var EventUtil = {
        addHandler: function (element, type, handler) {
            if (element.addEventListener) {
                element.addEventListener(type, handler, false);
            } else if (element.attachEvent) {
                element.attachEvent("on" + type, handler);
            } else {
                element["on" + type] = handler;
            }
        }
    };
    EventUtil.addHandler(window, "online", function () {
        alert("Online");
    });
    EventUtil.addHandler(window, "offline", function () {
        alert("Offline");
    });
    
  </script>
</asp:Content>
