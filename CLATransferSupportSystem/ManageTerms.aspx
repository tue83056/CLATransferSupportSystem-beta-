<%@ Page Title="" Language="C#" MasterPageFile="~/AdvisorCLA.Master" AutoEventWireup="true" CodeBehind="ManageTerms.aspx.cs" Inherits="CLATransferSupportSystem.WebForm2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta http-equiv="Content-type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <link rel="shortcut icon" type="image/png" href="/media/images/favicon.png">
    <%--<link rel="alternate" type="application/rss+xml" title="RSS 2.0" href="http://www.datatables.net/rss.xml">--%>
    <%--<link rel="stylesheet" type="text/css" href="/media/css/site-examples.css?_=758e23b3f1a4c34d6c055f5cc10bae7e">--%>
   <%-- <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.16/css/jquery.dataTables.min.css">--%>
    <style type="text/css" class="init">
	
	</style>
    <%-- <script type="text/javascript" src="/media/js/site.js?_=d78b222e2531b63c1f8683e47301add9">
    </script>
    <script type="text/javascript" src="/media/js/dynamic.php?comments-page=examples%2Fstyling%2Forder-column.html" async>
    </script>
    <script type="text/javascript" language="javascript" src="//code.jquery.com/jquery-1.12.4.js">
    </script>
    <script type="text/javascript" language="javascript" src="https://cdn.datatables.net/1.10.16/js/jquery.dataTables.min.js">
    </script>
    <script type="text/javascript" language="javascript" src="../resources/demo.js">
    </script>
    <script type="text/javascript" class="init">

        $(document).ready(function () {
            $('#mytable').DataTable();
        });

    </script>--%>

    <style>
        .jumbotron {
            background-color: #dedcdd;
        }

        th {
            background-color: #A41E35;
            color: white;
        }
    </style>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ManageTermsContent" runat="server">
    <div class="container-fluid">
      <h3>Manage Terms</h3>
        <div class="jumbotron">
           <b>Add New Term: </b><br /><br />
           <div class="form-inline">
              
                   <label for="txtTermCode">Term Code: </label>
               <asp:TextBox ID="txtTermCode" class="form-control input-sm" runat="server"></asp:TextBox>&nbsp&nbsp
              
              
                   <label for="ddlTermDescription">Term: </label>
                   <asp:DropDownList ID="ddlTermSemester" class="form-control input-sm" runat="server">
                       <asp:ListItem Selected="True">Fall</asp:ListItem>
                       <asp:ListItem>Spring</asp:ListItem>
                   </asp:DropDownList>&nbsp&nbsp
               
              
                   <label for="ddlTermYear">Term Year: </label>
                   <asp:DropDownList ID="ddlTermYear" class="form-control input-sm" runat="server">
                       <asp:ListItem Selected="True">2017</asp:ListItem>
                       <asp:ListItem>2018</asp:ListItem>
                       <asp:ListItem>2019</asp:ListItem>
                       <asp:ListItem>2020</asp:ListItem>
                   </asp:DropDownList>&nbsp&nbsp
                                           
                   <asp:Button ID="btnSave" style="background-color: #A41E35; color: #FFFFFF" CssClass="btn" runat="server" Text="Save" />
               
           </div><br />
            <br />
            <b>Search Majors:</b><br />
            <div class="table-responsive">
               <table id="mytable" class="table table-striped table-bordered">
                    <thead>
                        <tr>
                            <th><b>Term Code</b></th>
                            <th><b>Description</b></th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>2018036</td>
                            <td>Spring 2017</td>
                            <td>
                                <asp:DropDownList ID="ddlTerm1" runat="server">
                                    <asp:ListItem>Active</asp:ListItem>
                                    <asp:ListItem Selected="True">Inactive</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                         <tr>
                            <td>2017036</td>
                            <td>Fall 2017</td>
                            <td>
                                <asp:DropDownList ID="ddlTerm2" runat="server">
                                    <asp:ListItem Selected="True">Active</asp:ListItem>
                                    <asp:ListItem>Inactive</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                         </tr>
                        <tr>
                            <td>2018037</td>
                            <td>Spring 2018</td>
                            <td>
                                <asp:DropDownList ID="ddlTerm3" runat="server">
                                    <asp:ListItem Selected="True">Active</asp:ListItem>
                                    <asp:ListItem>Inactive</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                         </tr>
                        <tr>
                            <td>2018038</td>
                            <td>Fall 2018</td>
                            <td>
                                <asp:DropDownList ID="ddlTerm4" runat="server">
                                    <asp:ListItem Selected="True">Active</asp:ListItem>
                                    <asp:ListItem>Inactive</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                         </tr>
                        <tr>
                            <td>2018039</td>
                            <td>Spring 2019</td>
                            <td>
                                <asp:DropDownList ID="ddlTerm5" runat="server">
                                    <asp:ListItem Selected="True">Active</asp:ListItem>
                                    <asp:ListItem>Inactive</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                         </tr>
                    </tbody>
                   </table>
        </div>
    </div>

    <script src="/Scripts/jquery.dataTables.min.js"></script>
    <script type="text/javascript" src="~/Scripts/jquery-1.12.4.js"></script>
    <script type="text/javascript" class="init">
        $(document).ready(function () {
            $('#mytable').DataTable();
        });
    </script>
           <%--<div class="table-responsive border-right">
                <table id="tblTerm" class="table table-striped table-bordered">
                    <thead>
                        <tr>
                            <th><b>Term Code</b></th>
                            <th><b>Description</b></th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>2018036</td>
                            <td>Spring 2017</td>
                            <td>
                                <asp:DropDownList ID="ddlTerm1" runat="server">
                                    <asp:ListItem>Active</asp:ListItem>
                                    <asp:ListItem Selected="True">Inactive</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                         <tr>
                            <td>2017036</td>
                            <td>Fall 2017</td>
                            <td>
                                <asp:DropDownList ID="ddlTerm2" runat="server">
                                    <asp:ListItem Selected="True">Active</asp:ListItem>
                                    <asp:ListItem>Inactive</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                         </tr>
                        <tr>
                            <td>2018037</td>
                            <td>Spring 2018</td>
                            <td>
                                <asp:DropDownList ID="ddlTerm3" runat="server">
                                    <asp:ListItem Selected="True">Active</asp:ListItem>
                                    <asp:ListItem>Inactive</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                         </tr>
                        <tr>
                            <td>2018038</td>
                            <td>Fall 2018</td>
                            <td>
                                <asp:DropDownList ID="ddlTerm4" runat="server">
                                    <asp:ListItem Selected="True">Active</asp:ListItem>
                                    <asp:ListItem>Inactive</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                         </tr>
                        <tr>
                            <td>2018039</td>
                            <td>Spring 2019</td>
                            <td>
                                <asp:DropDownList ID="ddlTerm5" runat="server">
                                    <asp:ListItem Selected="True">Active</asp:ListItem>
                                    <asp:ListItem>Inactive</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                         </tr>
                    </tbody>
                </table>
            </div>--%>
        </div>
</asp:Content>
