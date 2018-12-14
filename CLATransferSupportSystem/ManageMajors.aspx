<%@ Page Title="" Language="C#" MasterPageFile="~/AdvisorCLA.Master" AutoEventWireup="true" CodeBehind="ManageMajors.aspx.cs" Inherits="CLATransferSupportSystem.WebForm1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta http-equiv="Content-type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <%--<link rel="shortcut icon" type="image/png" href="/media/images/favicon.png">--%>
   <%-- <link rel="alternate" type="application/rss+xml" title="RSS 2.0" href="http://www.datatables.net/rss.xml">
    <link rel="stylesheet" type="text/css" href="/media/css/site-examples.css?_=758e23b3f1a4c34d6c055f5cc10bae7e">
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.16/css/jquery.dataTables.min.css">
    <style type="text/css" class="init">
	
	</style>--%>
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
        .lb {
            margin: 4px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ManageTermsContent" runat="server">
    <div class="container-fluid">
        <h3>Manage Majors</h3>
        <div class="jumbotron">
            <div class="form-group1 row">

                <%--<div class="form-inline">
                    <b>Add New Major:</b><br />
                    <br />
                    
                       <b>Description:</b>&nbsp
                        <asp:TextBox ID="txtMajorDescription" class="form-control input-sm" runat="server"></asp:TextBox>&nbsp&nbsp

                       <asp:Button ID="btnSave" CssClass="btn" Style="background-color: #A41E35; color: #FFFFFF" runat="server" Text="Save" onclick="btnSave_Click"/>
                </div>--%>

                <button type="button" class="btn" data-toggle="modal" data-target="#addMajorModal">
                    <span class="glyphicon glyphicon-plus">&nbsp</span>Add Major
                </button><br /><br />

                <div class="modal fade" id="addMajorModal" role="dialog">
                    <div class="modal-dialog modal-sm">

                        <!-- Modal content-->
                        <div class="modal-content">

                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                                <h4 class="modal-title">Add New Major</h4>
                            </div>
                            <div class="modal-body">

                                <b>Major Description:</b>
                                <asp:TextBox ID="txtMajorDescription" class="form-control input-sm" Width="100%" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="valAddMajor" runat="server" ValidationGroup="valAddMajor" ControlToValidate="txtMajorDescription" ErrorMessage="* Required" Display="Dynamic" Font-Bold="False" ForeColor="#CC0000"></asp:RequiredFieldValidator>

                            </div>
                            <div class="modal-footer">
                                <asp:Button ID="btnSave" CssClass="btn" Style="background-color: #A41E35; color: #FFFFFF" runat="server" Text="Save" OnClick="btnSave_Click" ValidationGroup="valAddMajor" />
                                <button type="button" class="btn btn-default" style="color: black" data-dismiss="modal">Cancel</button>
                            </div>



                        </div>
                    </div>

                </div>


            </div>
           
           <%-- <asp:Label ID="lblValid" runat="server" Style="color: #A41E35"></asp:Label>--%>
            
           
           <div class="table-responsive">
                
                    <asp:Repeater ID="rptMajors" runat="server" OnItemCommand="rptMajors_ItemCommand">
                        <HeaderTemplate>
                            <table id="mytable" class="table table-striped table-bordered">
                                <thead>
                                    <tr>                                       
                                        <th><b>Description</b></th>
                                        <th><b>Status</b></th>
                                        <th>Edit</th>
                                    </tr>

                                </thead>
                                <tbody>
                        </HeaderTemplate>
                        <ItemTemplate>

                            
                            <tr>
                                                            
                                <td>
                                    <asp:Label ID="lblMajorDescription" runat="server" Text='<%# Bind("majorDescription") %>'></asp:Label>
                                    <asp:TextBox ID="txtEditDescription" CssClass="form-control" runat="server" Visible="false"></asp:TextBox>
                                   
                                </td>
                                <td>
                                    <asp:Label ID="lblHiddenID" runat="server" Visible="false" Text='<%# Bind("majorID") %>'></asp:Label>
                                    <asp:Label ID="lblHiddenStatus" runat="server" Visible="false" Text='<%# Bind("majorStatus") %>'></asp:Label>
                                    <asp:DropDownList CssClass="form-control" ID="ddlMajor" runat="server" OnSelectedIndexChanged="ddlMajor_SelectedIndexChanged" AutoPostBack="true">
                                        <asp:ListItem Value="Active">Active</asp:ListItem>
                                        <asp:ListItem Value="Inactive">Inactive</asp:ListItem>
                                    </asp:DropDownList>
                                   
                                </td>
                                <td>
                                    <asp:LinkButton ID="lbEditMajor" CssClass="lb" runat="server" CommandName="EditMajor" CommandArgument='<%# Bind("majorID") %>'>Edit</asp:LinkButton>
                                    <asp:LinkButton ID="lbCancelEdit" CssClass="lb" runat="server" CommandName="CancelEdit" Visible="false" CommandArgument='<%# Bind("majorID") %>'>Cancel</asp:LinkButton>
                                    <asp:LinkButton ID="lbUpdate" CssClass="lb" runat="server" CommandName="Update" Visible="false" CommandArgument='<%# Bind("majorID") %>'>
                                        Update
                                    </asp:LinkButton>
                                </td>                          
                            </tr>


                        </ItemTemplate>
                        <FooterTemplate>
                            </tbody>
                        </table> 
                        </FooterTemplate>
                    </asp:Repeater>


               
            </div>
        </div>
    </div>
    <%-- <tr>
                            <th>Major Code</th>
                            <th>Description</th>
                            <th>Status</th>

                        </tr>--%>
    <%--<asp:DropDownList CssClass="form-control" ID="ddlMajor5" runat="server">
                                    <asp:ListItem Selected="True">Active</asp:ListItem>
                                    <asp:ListItem>Inactive</asp:ListItem>
                                </asp:DropDownList>--%>
   <%-- <script src="/Scripts/jquery.dataTables.min.js"></script>
    <script type="text/javascript" src="~/Scripts/jquery-1.12.4.js"></script>--%>
    <script type="text/javascript" class="init">
        $(document).ready(function () {
            $('#mytable').DataTable();
        });
    </script>
    <%--<div class=" table table-responsive table-condensed border-right">
                <table id="tblMajor" class="table table-condensed table-striped table-bordered">
                    <thead>
                        <tr>
                            <th><b>Major</b></th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>African American Studies</td>
                            <td>
                                <asp:DropDownList CssClass="form-control" ID="ddlMajor1" runat="server">
                                    <asp:ListItem Selected="True">Active</asp:ListItem>
                                    <asp:ListItem>Inactive</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td>American Studies</td>
                            <td>
                                <asp:DropDownList CssClass="form-control" ID="ddlMajor2" runat="server">
                                    <asp:ListItem Selected="True">Active</asp:ListItem>
                                    <asp:ListItem>Inactive</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td>Anthropology</td>
                            <td>
                                <asp:DropDownList CssClass="form-control" ID="ddlMajor3" runat="server">
                                    <asp:ListItem Selected="True">Active</asp:ListItem>
                                    <asp:ListItem>Inactive</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td>Criminal Justice</td>
                            <td>
                                <asp:DropDownList CssClass="form-control" ID="ddlMajor4" runat="server">
                                    <asp:ListItem Selected="True">Active</asp:ListItem>
                                    <asp:ListItem>Inactive</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td>Economics</td>
                            <td>
                                <asp:DropDownList CssClass="form-control" ID="ddlMajor5" runat="server">
                                    <asp:ListItem Selected="True">Active</asp:ListItem>
                                    <asp:ListItem>Inactive</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>--%>
</asp:Content>
