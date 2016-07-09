<%@ Page Title="" Language="C#" MasterPageFile="~/share/tousu.Master" AutoEventWireup="true" CodeBehind="notice.aspx.cs" Inherits="TCS.Web.notice" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>

       .articleTypeList p {
    margin: 0 0 20px;
}
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">

    <div class=" col-md-offset-1">
        <!-- Left Sidebar Start -->
        <div class="sidebar" style="margin-left: 5%; margin-right: 5%;">



            <!-- Row Start -->
            <div class="row ">
                <div class="col-lg-11 col-md-11 "><a href="#"><%=language!="zh_us"?zh_us.index:zh_us.index_us %></a> > <a href="#"><%=language!="zh_us"?zh_us.notice:zh_us.notice_us %></a></div>
                <div class="col-lg-2 col-md-2 hidden-sm hidden-xs " style="padding-right: 0px;">
                    <div class="widget" style="margin-bottom: 5px;">
                        <div class="widget-header">
                            <div class="title">
                                <%=language!="zh_us"?zh_us.infoclassification:zh_us.infoclassification_us %>
                            </div>

                        </div>
                        <div class="widget-body articleTypeList" style="min-height: 200px; text-align:center; font-size:16px; font-weight:bold;">
                            <%foreach (var item in ArticleTypeList)
                                {%>
                            <p><a href="notice.aspx?type=<%=item.at_id %>"><%=item.at_name %></a></p>
                              <%  } %>
                            
                        </div>

                        
                    </div>
                    <hr class="hr-stylish-1" style="margin: 5px;">
                </div>

                <div class="col-lg-9 col-md-9">
                    <div class="widget no-margin">
                        <div class="widget-header">
                            <div class="title">
                                <%=_ArticleTypeService.QuerySingle(type).at_name %>
                            </div>

                        </div>
                        <div class="widget-body" style="min-height:600px;">
                            <div class="panel-group" id="accordion">
                                <%foreach (var item in ArticleList)
                                    {%>

                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <h4 class="panel-title">
                                            <a data-toggle="collapse" data-parent="#accordion" href="#collapse<%=item.a_id %>" data-original-title="" title="" aria-expanded="false" class="collapsed"><%=item.a_title %>
                                            </a>
                                        </h4>
                                    </div>
                                    <div id="collapse<%=item.a_id %>" class="panel-collapse collapse" aria-expanded="false" style="height: 0px;">
                                        <div class="panel-body" >
                                            <h3 style="text-align:center;"><%=item.a_title %> </h3>
                                            <p style="text-align:center;">
                                                <span>发布时间：<%=item.a_createdTime.ToString("yyyy-MM-dd HH:mm:ss") %></span>
                                                | <span>作者：<%=item.a_author %></span>
                                                | <span>来源：<%=item.a_resource %></span>
                                            </p>
                                            <div style="font-size:14px;"><%=item.a_content %></div>
                                            

                                        </div>
                                    </div>
                                </div>

                                 <%  } %>

                            </div>
                            <%if (TotalPages > 1)
                                    {%>
                            <div class="list-pagination pull-right">
                
                         <%= PagerHelper.RenderPager("/notice.aspx?type=" + type + "&page=@1", TotalPages, PageIndex, size) %>
                        </div>
                            <%} %>
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

    
    <script type="text/javascript">
      
    </script>
</asp:Content>
