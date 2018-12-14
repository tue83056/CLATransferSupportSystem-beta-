<%@ Page Title="" Language="C#" MasterPageFile="~/AdvisorCLA.Master" AutoEventWireup="true" CodeBehind="ManageAdmin.aspx.cs" Inherits="CLATransferSupportSystem.WebForm4" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta http-equiv="Content-type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title></title>
    <%--<link rel="shortcut icon" type="image/png" href="/media/images/favicon.png">--%>
    <%--<link rel="alternate" type="application/rss+xml" title="RSS 2.0" href="http://www.datatables.net/rss.xml">
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

    <script type="text/javascript">
        function showAddAdminPopup() {
            $("#btnShowAddAdminPopup").click();
        }

        function showNotFoundPopup() {
            $("#btnShowNotFoundPopup").click();
        }
    </script>

    <style>
        .jumbotron {
            background-color: #dedcdd;
        }

        th {
            background-color: #A41E35;
            color: white;
        }

        .form-control {
           margin-bottom: 10px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="ManageAdminContent" runat="server">
    <h3 style="font-family: Verdana, Geneva, Tahoma, sans-serif">&nbsp&nbsp Manage Administrators</h3>

    <div class="container-fluid">
        <div class="jumbotron">


            <div>                      


                 <%--hidden controls for modals--%>
                <button type="button" style="display: none;" id="btnShowAddAdminPopup" class="btn btn-primary btn-lg"
                    data-toggle="modal" data-target="#addAdminModal">                  
                </button>
                 <button type="button" style="display: none;" id="btnShowNotFoundPopup" class="btn btn-primary btn-lg"
                    data-toggle="modal" data-target="#notFoundModal">                  
                </button>
                <asp:Label ID="lblFoundID" runat="server" Visible="false" Text="false"></asp:Label>



                <button type="button" class="btn" data-toggle="modal" data-target="#searchAdminModal">
                    <span class="glyphicon glyphicon-plus">&nbsp</span>Add Admin
                 </button><br /><br />

                <div class="modal fade" id="searchAdminModal" role="dialog">
                    <div class="modal-dialog modal-sm">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                                <h4 class="modal-title">Find Temple User</h4>
                            </div>

                            <div class="modal-body">
                                <b>Enter the AccessnetID of user:</b><asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ValidationGroup="valSearchAdmin" ControlToValidate="findAccessNetID" ErrorMessage="*" Display="Dynamic" Font-Bold="False" ForeColor="#CC0000"></asp:RequiredFieldValidator>
                                <asp:TextBox ID="findAccessNetID" CssClass="form-control" placeholder="e.g. tud11111" runat="server" Width="100%"></asp:TextBox>

                            </div>
                            <div class="modal-footer">
                                <asp:Button ID="btnFindUser" runat="server" ValidationGroup="valSearchAdmin" CssClass="btn" OnClick="btnFindUser_Click" Text="Find User" />

                               <%-- <button runat="server" type="button" class="btn" data-toggle="modal" data-target="#addAdminModal" data-dismiss="modal">
                                    Find User
                                </button>--%>
                                <button type="button" class="btn btn-default" style="color: black" data-dismiss="modal">Cancel</button>
                            </div>


                        </div>
                      
                    </div>
                  
                </div>

                <div class="modal fade" id="notFoundModal" role="dialog">
                    <div class="modal-dialog modal-sm">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                                <h4 class="modal-title">Find Temple User</h4>
                            </div>

                            <div class="modal-body">
                               <b>User Not Found.</b>

                            </div>
                            <div class="modal-footer">                                                          
                                <button type="button" class="btn btn-default" style="color: black" data-dismiss="modal">OK</button>
                            </div>


                        </div>
                      
                    </div>
                  
                </div>

                <div class="modal fade" id="addAdminModal" role="dialog">
                    <div class="modal-dialog modal-sm">

                        <!-- Modal content-->
                        <div class="modal-content">

                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                                <h4 class="modal-title">Add New Admin</h4>
                            </div>
                            <div class="modal-body">

                                <b>AccessNet Username:</b> <asp:RequiredFieldValidator ID="valUsername" runat="server" ValidationGroup="valAddAdmin" ControlToValidate="txtUsername" ErrorMessage="*" Display="Dynamic" Font-Bold="False" ForeColor="#CC0000"></asp:RequiredFieldValidator>
                                <asp:TextBox ID="txtUsername" CssClass="form-control input-sm" Width="100%" runat="server" Enabled="false"></asp:TextBox>
                                

                                <b>Last Name:</b><asp:RequiredFieldValidator ID="valLastName" runat="server" ValidationGroup="valAddAdmin" ControlToValidate="txtLastName" ErrorMessage="*" Display="Dynamic" Font-Bold="False" ForeColor="#CC0000"></asp:RequiredFieldValidator>
                                <asp:TextBox ID="txtLastName" CssClass="form-control input-sm" runat="server" Width="100%" Enabled="false"></asp:TextBox>
                                

                                <b>First Name:</b><asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ValidationGroup="valAddAdmin" ControlToValidate="txtFirstName" ErrorMessage="*" Display="Dynamic" Font-Bold="False" ForeColor="#CC0000"></asp:RequiredFieldValidator>
                                <asp:TextBox ID="txtFirstName" CssClass="form-control input-sm" runat="server" Width="100%" Enabled="false"></asp:TextBox>
                                

                                <b>TUID:</b><asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ValidationGroup="valAddAdmin" ControlToValidate="txtTUID" ErrorMessage="*" Display="Dynamic" Font-Bold="False" ForeColor="#CC0000"></asp:RequiredFieldValidator>
                                <asp:TextBox ID="txtTUID" CssClass="form-control input-sm" runat="server" Width="100%" Enabled="false"></asp:TextBox>
                                

                                <b>Access Level:</b>
                                <asp:DropDownList ID="ddlAccessLevel" runat="server" CssClass="form-control">
                                    <asp:ListItem>Administrator</asp:ListItem>
                                    <asp:ListItem>Reviewer</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="modal-footer">
                                 <asp:Button ID="btnAddAdmin" CssClass="btn" style="background-color: #A41E35; color: #FFFFFF" runat="server" OnClick="btnAddAdmin_Click" Text="Save" ValidationGroup="valAddAdmin"></asp:Button>
                                <button type="button" class="btn btn-default" style="color: black" data-dismiss="modal">Cancel</button>

                             

                            </div>



                        </div>
                    </div>

                </div>
              

                <div class="table-responsive">

                    <asp:Repeater ID="Repeater1" runat="server" OnItemCommand="Repeater1_ItemCommand">
                        <HeaderTemplate>
                            <table id="mytable" class="table table-striped table-bordered">
                                <thead>
                                    <tr>
                                        <th><b>AccessNet Username</b></th>
                                        <th><b>Last Name</b></th>
                                        <th><b>First Name</b></th>
                                        <th><b>TUID</b></th>
                                        <th><b>Access Level</b></th>
                                        <th><b>Status</b></th>
                                        <th><b>Action</b></th>
                                    </tr>

                                </thead>
                                <tbody>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <tr>
                                <td>
                                    <asp:Label ID="lblAccessNetID" runat="server" Text='<%# Bind("accessNetID") %>'></asp:Label>
                                    <asp:TextBox ID="txtAccessNetID" CssClass="form-control" runat="server" Visible="false"></asp:TextBox>
                                    
                                </td>
                                <td>
                                    <asp:Label ID="lblAdminLastName" runat="server" Text='<%# Bind("adminLastName") %>'></asp:Label>
                                    <asp:TextBox ID="txtAdminLastName" CssClass="form-control" runat="server" Visible="false"></asp:TextBox>
                                    
                                </td>
                                <td>
                                    <asp:Label ID="lblAdminFirstName" runat="server" Text='<%# Bind("adminFirstName") %>'></asp:Label>
                                    <asp:TextBox ID="txtAdminFirstName" CssClass="form-control" runat="server" Visible="false"></asp:TextBox>
                                    
                                </td>
                                <td>
                                    <asp:Label ID="lblAdminTUID" runat="server" Text='<%# Bind("TUID") %>'></asp:Label>
                                    <%--<asp:TextBox ID="txtAdminTUID" CssClass="form-control" runat="server" Visible="false"></asp:TextBox>--%>
                                    
                                </td>
                                <td>                                 
                                    <asp:Label ID="lblHiddenAccessLevel" runat="server" Visible="false" Text='<%# Bind("accessLevel") %>'></asp:Label>
                                    <asp:DropDownList ID="ddlAccessLevelRpt" runat="server" CssClass="form-control" OnSelectedIndexChanged="ddlAccessLevelRpt_SelectedIndexChanged" AutoPostBack="true">
                                        <asp:ListItem Value="Administrator">Administrator</asp:ListItem>
                                        <asp:ListItem Value="Reviewer">Reviewer</asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                                <td>
                                    <asp:Label ID="lblHiddenTUID" runat="server" Visible="false" Text='<%# Bind("TUID") %>'></asp:Label>
                                    <asp:Label ID="lblHiddenStatus" runat="server" Visible="false" Text='<%# Bind("adminStatus") %>'></asp:Label>
                                    <asp:DropDownList CssClass="form-control" ID="ddlAdmin" OnSelectedIndexChanged="ddlAdmin_SelectedIndexChanged" AutoPostBack="true" runat="server">
                                        <asp:ListItem Value="Active">Active</asp:ListItem>
                                        <asp:ListItem Value="Inactive">Inactive</asp:ListItem>
                                    </asp:DropDownList>

                                </td>
                                <td>
                                    <asp:LinkButton ID="lbRemoveAdmin" runat="server" CommandName="RemoveAdmin" CommandArgument='<%# Bind("TUID") %>' OnClientClick='javascript:return confirm("Are you sure you want to delete this user?")'>Remove</asp:LinkButton>
                                    
                                </td>

                            </tr>


                        </ItemTemplate>
                        <FooterTemplate>
                            </tbody>
                        </table> 
                        </FooterTemplate>
                    </asp:Repeater>



                </div>
                <%-- <div class="table-responsive">
                <table id="mytable" class="table table-striped table-bordered">
                    <thead>
                        <tr>
                            <th>AccessNet Username</th>
                            <th>Last Name</th>
                            <th>First Name</th>                           
                            <th>TUID</th>
                            <th>Access Level</th>
                            <th>Status</th>

                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                             <td>tud23465</td>
                            <td>Nelson</td>
                            <td>Sarah</td>                          
                            <td>957446573</td>
                            <td>Administrator</td>
                            <td>
                                <select class="selectpicker">
                                    <option>Active</option>
                                    <option>Inactive</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                             <td>tug12768</td>
                            <td>Blanco</td>
                            <td>Hugo</td>                          
                            <td>917569384</td>
                            <td>Administrator</td>
                            <td>
                                <select class="selectpicker">
                                    <option>Active</option>
                                    <option>Inactive</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                             <td>tuf34596</td>
                            <td>Graham</td>
                            <td>Paul</td>                         
                            <td>914786493</td>
                            <td>Reviewer</td>

                            <td>
                                <select class="selectpicker">
                                    <option>Active</option>
                                    <option>Inactive</option>
                                </select>
                            </td>
                        </tr>
                    </tbody>
                </table>--%>
            </div>
        </div>
    </div>
   <asp:Label ID="lblJavaScript" runat="server"></asp:Label>
   <%-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script src="/Scripts/jquery.dataTables.min.js"></script>
    <script type="text/javascript" src="~/Scripts/jquery-1.12.4.js"></script>--%>
    <script type="text/javascript" class="init">

        $(document).ready(function () {
            $('#mytable').DataTable();
        });


      
    </script>

</asp:Content>
