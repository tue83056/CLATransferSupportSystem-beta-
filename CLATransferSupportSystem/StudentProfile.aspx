<%@ Page Title="" Language="C#" MasterPageFile="~/AdvisorCLA.Master" AutoEventWireup="true" CodeBehind="StudentProfile.aspx.cs" Inherits="CLATransferSupportSystem.WebForm3" MaintainScrollPositionOnPostback="true" %>

<asp:Content ID="contentHead" ContentPlaceHolderID="head" runat="server">

    <script type="text/javascript">
        function showExportPopup() {
            $("#btnShowExportPopup").click();
        }

        function showNotFoundPopup() {
            $("#btnShowNotFoundPopup").click();
        }
    </script>

    <style>
        .lb {
            padding: 4px;
        }

        td {
            height: auto;
        }

        .modal {
            text-align: center;
        }

        @media screen and (min-width: 768px) {
            .modal:before {
                display: inline-block;
                vertical-align: middle;
                content: " ";
                height: 100%;
            }
        }

        .modal-dialog {
            display: inline-block;
            text-align: left;
            /*vertical-align: middle;*/
        }

        .jumbotron {
            margin: 8px !important;
        }

        .no-paddin {
            padding: 0px;
            margin: 0px;
        }

        #documentsJumbo {
            padding: 5px;
        }

        .hiddendiv {           
            white-space: pre-wrap;
            width: 100%;
            min-height: 50px;
            font-family: Arial, sans-serif;
            font-size: 13px;
            padding: 5px;
            word-wrap: break-word;
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="StudentProfileContent" runat="server">

    <div class="container-fluid">


        <div class="row">
            <h3 id="studentNameHeading" style="padding-left: 10px;" runat="server">&nbsp&nbsp Student Profile</h3>

            <div class="col-md-4 no-paddin">
                <div class="jumbotron table-responsive">
                    <h4 style="text-align: center"><b>Student Information:</b></h4>
                    <br />
                    <table class="table table-condensed">

                        <tr>
                            <th>Last Name:</th>
                            <td>
                                <asp:RegularExpressionValidator ID="revLastName" runat="server" Display="Dynamic" ErrorMessage="*Please enter a valid name.*" ForeColor="#CC0000" ControlToValidate="txtLastName" ValidationExpression="[a-zA-Z]+"></asp:RegularExpressionValidator>
                                <asp:TextBox ID="txtLastName" runat="server" CssClass="form-control input-group-sm" ReadOnly="true"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <th>First Name:</th>
                            <td>
                                <asp:RegularExpressionValidator ID="revFirstName" runat="server" Display="Dynamic" ErrorMessage="*Please enter a valid name.*" ForeColor="#CC0000" ControlToValidate="txtFirstName" ValidationExpression="[a-zA-Z]+"></asp:RegularExpressionValidator>
                                <asp:TextBox ID="txtFirstName" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <th>Email:</th>
                            <td>
                                <asp:RegularExpressionValidator ID="valEmail2" runat="server" ControlToValidate="txtEmail" Display="Dynamic" ErrorMessage="*Invalid e-mail format" Font-Bold="False" ForeColor="#CC0000"  ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <th>Phone:</th>
                            <td>
                                <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <th>Current Institution:</th>
                            <td>
                                <asp:RegularExpressionValidator ID="revInstitution" runat="server" Display="Dynamic" ErrorMessage="*Please enter a valid institution.*" ForeColor="#CC0000" ControlToValidate="txtCurrentInstitution" ValidationExpression="[a-zA-Z\s]+"></asp:RegularExpressionValidator>
                                <asp:TextBox ID="txtCurrentInstitution" runat="server" ReadOnly="true" CssClass="form-control"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <th>Current Major:</th>
                            <td>
                                <asp:RegularExpressionValidator ID="revMajor" runat="server" Display="Dynamic" ErrorMessage="*Please enter a valid major.*" ForeColor="#CC0000" ControlToValidate="txtCurrentMajor" ValidationExpression="[a-zA-Z\s]+"></asp:RegularExpressionValidator>
                                <asp:TextBox ID="txtCurrentMajor" runat="server" ReadOnly="true" CssClass="form-control"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <th>Anticipated TU Major:</th>
                            <td>
                                <asp:DropDownList ID="ddlAnticipatedTUMajor" Enabled="false" runat="server" CssClass="form-control">
                                    <%--  <asp:ListItem>Africology</asp:ListItem>
                                    <asp:ListItem>American Studies</asp:ListItem>
                                    <asp:ListItem>Anthropology</asp:ListItem>
                                    <asp:ListItem>Arabic</asp:ListItem>
                                    <asp:ListItem>Asian Studies</asp:ListItem>
                                    <asp:ListItem>Chinese</asp:ListItem>
                                    <asp:ListItem>Criminal Justice</asp:ListItem>
                                    <asp:ListItem>Economics</asp:ListItem>
                                    <asp:ListItem>English</asp:ListItem>
                                    <asp:ListItem>Environmental Studies</asp:ListItem>
                                    <asp:ListItem>French</asp:ListItem>
                                    <asp:ListItem>Gender Studies</asp:ListItem>
                                    <asp:ListItem>Geography</asp:ListItem>
                                    <asp:ListItem>German</asp:ListItem>
                                    <asp:ListItem>Global Studies</asp:ListItem>
                                    <asp:ListItem>Greek and Roman Classics</asp:ListItem>
                                    <asp:ListItem>Histroy</asp:ListItem>
                                    <asp:ListItem>Italian</asp:ListItem>
                                    <asp:ListItem>Latin American Studies</asp:ListItem>
                                    <asp:ListItem>Liberal Arts</asp:ListItem>
                                    <asp:ListItem>Neuroscience</asp:ListItem>
                                    <asp:ListItem>Philosophy</asp:ListItem>
                                    <asp:ListItem>Political Science</asp:ListItem>
                                    <asp:ListItem>Psychology</asp:ListItem>
                                    <asp:ListItem>Religion</asp:ListItem>
                                    <asp:ListItem>Sociology</asp:ListItem>
                                    <asp:ListItem>Spanish</asp:ListItem>--%>
                                </asp:DropDownList></td>
                        </tr>
                        <tr>
                            <th>Anticipated Transfer Credits:</th>
                            <td>
                                <asp:RegularExpressionValidator ID="revCredits" runat="server" Display="Dynamic" ErrorMessage="*Please use a 3 digit number.*" ForeColor="#CC0000" ControlToValidate="txtAnticipatedTransferCredits" ValidationExpression="[0-9]{3}"></asp:RegularExpressionValidator>
                                <asp:TextBox ID="txtAnticipatedTransferCredits" ReadOnly="true" runat="server" CssClass="form-control"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <th>Associates Status:</th>
                            <td>
                                <asp:DropDownList ID="ddlAssociatesStatus" Enabled="false" runat="server" CssClass="form-control">
                                    <asp:ListItem>Not Pursuing</asp:ListItem>
                                    <asp:ListItem>In Progress</asp:ListItem>
                                    <asp:ListItem>Completed</asp:ListItem>
                                </asp:DropDownList></td>
                        </tr>
                        <tr class="form-inline">
                            <th>Anticipated Matriculation Term:</th>
                            <td>
                                <asp:DropDownList ID="ddlTermName" Enabled="false" runat="server" CssClass="form-control">
                                    <asp:ListItem>Fall</asp:ListItem>
                                    <asp:ListItem>Spring</asp:ListItem>
                                </asp:DropDownList>
                                <asp:DropDownList ID="ddlTermYear" Enabled="false" runat="server" CssClass="form-control">
                                </asp:DropDownList>
                            </td>

                        </tr>
                        <tr>
                            <th>PA Resident:</th>
                            <td>
                                <asp:DropDownList ID="ddlPAResident" Enabled="false" runat="server" CssClass="form-control">
                                    <asp:ListItem>Yes</asp:ListItem>
                                    <asp:ListItem>No</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <th>Has Matriculated:</th>
                            <td>
                                <asp:Label ID="lblHasMatriculated" runat="server"></asp:Label>              
                            </td>
                        </tr>
                        <tr class="form-inline">
                            <th>Matriculation Term:</th>
                            <td><asp:Label ID="lblMatriculationTerm" runat="server" Text="NA"></asp:Label></td> 
                        </tr>
                        <tr>
                            <th>Initial Contact Date:</th>
                            <td>
                                <asp:Label ID="lblInitialContactDate" runat="server"></asp:Label></td>
                        </tr>
                        <tr>
                            <th>Last Updated:</th>
                            <td>
                                <asp:Label ID="lblLastUpdated" runat="server"></asp:Label></td>
                        </tr>
                        <tr>
                            <th>Last Updated By:</th>
                            <td>
                                <asp:Label ID="lblLastUpdatedBy" runat="server"></asp:Label></td>
                        </tr>
                    </table>
                    <br />
                    <div class="form-inline">
                        <asp:Button ID="btnEditStudentInfo" runat="server" Text="Edit" CssClass="btn" Style="background-color: #808080; color: #FFFFFF" OnClick="btnEditStudentInfo_Click" />&nbsp
                         <asp:Button ID="btnSaveStudentInfo" runat="server" Text="Save" CssClass="btn" Style="background-color: #A41E35; color: #FFFFFF" OnClick="btnSaveStudentInfo_Click" />
                    </div>
                </div>

                <div class="jumbotron" id="documentsJumbo">
                    <h4 style="text-align: center"><b>Uploaded Files:</b></h4>
                    <br />
                    <div class="panel panel-default table-responsive" style="width: 100%">


                        <asp:Repeater ID="rptUploadedDocuments" runat="server" OnItemCommand="rptUploadedDocuments_ItemCommand" OnItemDataBound="rptUploadedDocuments_ItemDataBound">
                            <HeaderTemplate>
                                <table id="documentsTable" class="table table-condensed" style="width: 100%">
                                    <thead>
                                        <tr>
                                            <th>Name</th>
                                            <th>Category</th>
                                            <th>Date</th>
                                            <th>Added By</th>
                                            <th>Delete</th>
                                        </tr>
                                    </thead>
                            </HeaderTemplate>

                            <ItemTemplate>
                                <tr>
                                    <td>
                                        <asp:LinkButton ID="lbDownloadDocument" runat="server" Text='<%# Bind("documentName") %>' CommandArgument='<%# Bind("documentID") %>' CommandName="DownloadDocument" data-toggle="tooltip" title="Download Document"></asp:LinkButton>
                                    </td>
                                    <td><%# DataBinder.Eval(Container.DataItem, "documentCategory") %></td>
                                    <td><%# DataBinder.Eval(Container.DataItem, "dateUploaded") %></td>
                                    <td><%# DataBinder.Eval(Container.DataItem, "addedByAdmin") %></td>
                                    <td>
                                        <asp:LinkButton ID="lbDeleteDocument" runat="server" data-toggle="tooltip" title="Delete Document" CssClass="lb"  CommandArgument='<%# Bind("documentID") %>' CommandName="DeleteDocument" OnClientClick='javascript:return confirm("Are you sure you want to delete this document?")'>
                                          <span style="color: red" class="glyphicon glyphicon-remove-circle"></span>
                                        </asp:LinkButton>
                                    </td>
                                </tr>

                            </ItemTemplate>

                            <FooterTemplate>
                                </table>
                            </FooterTemplate>

                        </asp:Repeater>

                        <%--<tr>
                                <td>Syllabus</td>
                                <td>Art Culture 101.docx</td>
                                <td>10/24/2017</td>
                                <td><span style="color: cornflowerblue" class="glyphicon glyphicon-download"></span>&nbsp&nbsp<span style="color: red" class="glyphicon glyphicon-remove-circle"></span></td>


                            </tr>
                            <tr>
                                <td>Syllabus</td>
                                <td>Art 1068.docx</td>
                                <td>10/25/2017</td>
                                <td><span style="color: cornflowerblue" class="glyphicon glyphicon-download"></span>&nbsp&nbsp<span style="color: red" class="glyphicon glyphicon-remove-circle"></span></td>
                            </tr>
                            <tr>
                                <td>Unofficial Transcript</td>
                                <td>2017TranscriptSparrow.pdf</td>
                                <td>10/25/2017</td>
                                <td><span style="color: cornflowerblue" class="glyphicon glyphicon-download"></span>&nbsp&nbsp<span style="color: red" class="glyphicon glyphicon-remove-circle"></span></td>
                            </tr>
                            <tr>
                                <td>Academic Plan</td>
                                <td>AP_FA2017_Sparrow.pdf</td>
                                <td>10/26/2017</td>
                                <td><span style="color: cornflowerblue" class="glyphicon glyphicon-download"></span>&nbsp&nbsp<span style="color: red" class="glyphicon glyphicon-remove-circle"></span></td>
                            </tr>--%>
                    </div>
                    <strong>Add File:</strong><br />
                    <br />
                    <div class="form-inline">
                         <asp:FileUpload ID="FileUpload1" runat="server" /><br />
                        <strong>Category:</strong>&nbsp&nbsp<asp:DropDownList ID="ddlFileCategory" CssClass="form-control" runat="server">
                            <asp:ListItem>Syllabus</asp:ListItem>
                            <asp:ListItem>Unoffical Transcript</asp:ListItem>
                            <asp:ListItem>Academic Plan</asp:ListItem>
                            <asp:ListItem>Other</asp:ListItem>
                        </asp:DropDownList><br />
                        <br />
                    </div>
                    <%--  <div class="input-group">
                        <label class="input-group-btn">
                            <span class="btn" style="background-color: #808080; color: #FFFFFF">    &hellip;
                                <input type="file" style="display: none;" multiple="multiple" />
                            </span>
                        </label>
                        <input type="text" class="form-control" readonly="readonly" />
                    </div>--%>
                    <%-- <span class="help-block">Select a file to upload
                    </span>--%>
                   
                    <asp:Button ID="btnUploadDocument" runat="server" CssClass="btn" Style="background-color: #A41E35; color: #FFFFFF" Text="Upload" OnClick="btnUploadDocument_Click" />

                </div>


            </div>


            <div class="col-md-8 no-paddin">
                <%-- <div class="jumbotron">
                    <h4><b>Add Conversation Entry:</b></h4>
                    <div class="form-inline">
                        <strong>Entry:</strong>&nbsp
                        <asp:Label ID="lblNewEntryNumber" runat="server"></asp:Label>
                        &nbsp&nbsp<strong>Date:</strong>&nbsp&nbsp
                        <asp:Label ID="lblNewEntryDate" runat="server"></asp:Label>
                        &nbsp&nbsp<strong>Added by:</strong>&nbsp Nicole Conley
                        &nbsp&nbsp<strong>Contact Type:</strong>&nbsp<asp:DropDownList ID="ddlContactType" runat="server" CssClass="form-control" Width="148px">
                            <asp:ListItem>Email</asp:ListItem>
                            <asp:ListItem>Phone</asp:ListItem>
                            <asp:ListItem>Appointment: 1 on 1</asp:ListItem>
                            <asp:ListItem>Group: General</asp:ListItem>
                            <asp:ListItem>Group: Transfer Tuesday</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <br />
                    <asp:TextBox ID="txtNewConversationEntry" runat="server" CssClass="form-control" TextMode="MultiLine" Columns="100" Rows="10" Width="100%">

                    </asp:TextBox><br />
                    <br />
                    <asp:Button ID="btnAddEntry" Text="Add Entry" CssClass="btn" Style="background-color: #A41E35; color: #FFFFFF" runat="server" OnClick="btnAddEntry_Click" />
                    <br />
                    <br />
                    <br />
                    <asp:Label ID="lblEntrySuccess" ForeColor="Black" runat="server" CssClass="alert alert-success" Visible="false"></asp:Label>

                </div>--%>
                <div class="jumbotron">
                    <h4 style="padding-right: 5px;"><b>Conversation Entries:</b></h4>
                    <br />
                    <button type="button" id="btnAddEntry" class="btn" data-toggle="modal" data-target="#addEntryModal" runat="server"><span class="glyphicon glyphicon-plus" >&nbsp</span>Add Entry</button>
                    <br />
                    <br />
                    <div class="modal fade" id="addEntryModal" role="dialog">
                        <div class="modal-dialog modal-lg">

                            <!-- Modal content-->
                            <div class="modal-content">
                                <asp:Panel runat="server" DefaultButton="lbAddNewEntry">
                                    <div class="modal-header">
                                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                                        <h4 class="modal-title">Add New Entry</h4>
                                    </div>
                                    <div class="modal-body">

                                        <table class="table">
                                            <tr>
                                                <th>Entry:</th>
                                                <td>
                                                    <asp:Label ID="lblNewEntryNumber" runat="server">#</asp:Label></td>
                                                <th>Date:</th>
                                                <td>
                                                    <asp:Label ID="lblNewEntryDate" runat="server">date</asp:Label></td>
                                                <th>Added By:</th>
                                                <td><asp:Label ID="lblEntryAddedBy" runat="server">Advisor Name</asp:Label></td>
                                                <th>Contact Type:</th>
                                                <td>
                                                    <asp:DropDownList ID="ddlContactType" runat="server" CssClass="form-control" Width="148px">
                                                        <asp:ListItem>Email</asp:ListItem>
                                                        <asp:ListItem>Phone</asp:ListItem>
                                                        <asp:ListItem>Appointment: 1 on 1</asp:ListItem>
                                                        <asp:ListItem>Group: General</asp:ListItem>
                                                        <asp:ListItem>Group: Transfer Tuesday</asp:ListItem>
                                                    </asp:DropDownList></td>
                                            </tr>
                                            <tr>
                                                <asp:TextBox ID="txtNewConversationEntry" placeholder="Entry Text Here.." runat="server" CssClass="form-control" TextMode="MultiLine" Rows="10"  Width="100%"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="valEntry" runat="server" ValidationGroup="valEntry" ControlToValidate="txtNewConversationEntry" ErrorMessage="* Entry text required" Display="Dynamic" Font-Bold="False" ForeColor="#CC0000"></asp:RequiredFieldValidator>
                                            </tr>
                                        </table>
                                    </div>
                                    <div class="modal-footer">
                                        <asp:LinkButton ID="lbAddNewEntry" CssClass="btn" ValidationGroup="valEntry" runat="server" OnClick="btnAddEntry_Click">Add Entry</asp:LinkButton>
                                        <button type="button" class="btn btn-default" style="color: black" data-dismiss="modal">Cancel</button>
                                    </div>

                                </asp:Panel>

                            </div>
                        </div>

                    </div>
                    <div style="overflow-y: scroll; height: 100%">
                        <asp:Repeater ID="rptEntries" runat="server" OnItemCommand="rptEntries_ItemCommand" OnItemDataBound="rptEntries_ItemDataBound">
                            <ItemTemplate>
                                <div class="panel panel-default" style="width: 100%; overflow-y: visible;">
                                    <table class="table" style="width: 100%">
                                        <tr>
                                            <th>Entry:</th>
                                            <td>&nbsp
                                                <asp:Label ID="lblIndex" runat="server"></asp:Label>
                                            </td>
                                            <th>&nbsp&nbsp Date Added:</th>
                                            <td>&nbsp  <%# DataBinder.Eval(Container.DataItem, "dateAdded") %></td>
                                            <th>&nbsp&nbsp Added By:</th>
                                            <td>&nbsp <%# DataBinder.Eval(Container.DataItem, "addedByAdmin") %></td>
                                            <th>&nbsp&nbsp Contact Type:</th>
                                            <td>&nbsp  <%# DataBinder.Eval(Container.DataItem, "contactType") %></td>
                                        </tr>
                                    </table>

                                    <div id="txtHidden" runat="server" class="hiddendiv"><%# DataBinder.Eval(Container.DataItem, "entryText") %></div>
                                    <asp:TextBox ID="txtEntryText" Enabled="false" CssClass="form-control" Width="100%" TextMode="MultiLine" Rows="10" Visible="false" runat="server" Text='<%# Bind("entryText") %>' BorderStyle="None">
                                        
                                    </asp:TextBox>
                                    <br />
                                    <asp:LinkButton ID="lbEditEntry" CssClass="lb" Text="Edit" runat="server" CommandName="EditEntry" CommandArgument='<%# Bind("entryID") %>'></asp:LinkButton>
                                    <asp:LinkButton ID="lbCancelEdit" CssClass="lb" Text="Cancel" runat="server" Visible="false" CommandName="CancelEdit" CommandArgument='<%# Bind("entryID") %>'></asp:LinkButton>
                                    <asp:LinkButton ID="lbUpdateEntry" CssClass="lb" Text="Update" runat="server" Visible="false" CommandName="UpdateEntry" CommandArgument='<%# Bind("entryID") %>'></asp:LinkButton>
                                    <asp:LinkButton ID="lbDeleteEntry" Text="Delete" CssClass="lb" runat="server" CommandName="DeleteEntry" CommandArgument='<%# Bind("entryID") %>' OnClientClick='javascript:return confirm("Are you sure you want to delete this entry?")'></asp:LinkButton>



                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                         <%-- modal for add new student profile--%>
                <%--hidden controls for modals--%>
                <button type="button" style="display: none;" id="btnShowExportPopup" class="btn btn-primary btn-lg"
                    data-toggle="modal" data-target="#ExportModal">                  
                </button>
                 <button type="button" style="display: none;" id="btnShowNotFoundPopup" class="btn btn-primary btn-lg"
                    data-toggle="modal" data-target="#notFoundModal">                  
                </button>
                <asp:Label ID="lblFoundID" runat="server" Visible="false" Text="false"></asp:Label>



                <button type="button" class="btn" id="btnExport" data-toggle="modal" data-target="#searchExportModal" runat="server">
                    <span class="glyphicon glyphicon-plus">&nbsp</span>Export Entries
                 </button><br /><br />

                <div class="modal fade" id="searchExportModal" role="dialog">
                    <div class="modal-dialog modal-sm">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                                <h4 class="modal-title">Find Temple Student</h4>
                            </div>

                            <div class="modal-body">
                                <b>Enter the TUID of user:</b><asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ValidationGroup="valSearchExport" ControlToValidate="findTUID" ErrorMessage="*" Display="Dynamic" Font-Bold="False" ForeColor="#CC0000"></asp:RequiredFieldValidator>
                                <asp:TextBox ID="findTUID" CssClass="form-control" placeholder="e.g. 914463895" runat="server" Width="100%"></asp:TextBox>

                            </div>
                            <div class="modal-footer">
                                <asp:Button ID="btnFindStudent" runat="server" ValidationGroup="valSearchExport" CssClass="btn" OnClick="btnFindStudent_Click" Text="Find Student" />

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
                                <h4 class="modal-title">Find Temple Student</h4>
                            </div>

                            <div class="modal-body">
                               <b>Student Not Found.</b>

                            </div>
                            <div class="modal-footer">                                                          
                                <button type="button" class="btn btn-default" style="color: black" data-dismiss="modal">OK</button>
                            </div>
                        </div>                   
                    </div>                 
                </div>

                <div class="modal fade" id="ExportModal" role="dialog">
                    <div class="modal-dialog modal-sm">

                        <!-- Modal content-->
                        <div class="modal-content">

                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                                <h4 class="modal-title">Export Conversation Entries</h4><h5 style="color: red">Caution: This will permanently lock this profile!</h5>
                            </div>
                            <div class="modal-body">

                                <b>AccessNet Username:</b> <asp:RequiredFieldValidator ID="valUsername" runat="server" ValidationGroup="valAddAdmin" ControlToValidate="txtExportUsername" ErrorMessage="*" Display="Dynamic" Font-Bold="False" ForeColor="#CC0000"></asp:RequiredFieldValidator>
                                <asp:TextBox ID="txtExportUsername" CssClass="form-control input-sm" Width="100%" runat="server" Enabled="false"></asp:TextBox>
                                

                                <b>Last Name:</b><asp:RequiredFieldValidator ID="valLastName" runat="server" ValidationGroup="valAddAdmin" ControlToValidate="txtExportLastName" ErrorMessage="*" Display="Dynamic" Font-Bold="False" ForeColor="#CC0000"></asp:RequiredFieldValidator>
                                <asp:TextBox ID="txtExportLastName" CssClass="form-control input-sm" runat="server" Width="100%" Enabled="false"></asp:TextBox>
                                

                                <b>First Name:</b><asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ValidationGroup="valAddAdmin" ControlToValidate="txtExportFirstName" ErrorMessage="*" Display="Dynamic" Font-Bold="False" ForeColor="#CC0000"></asp:RequiredFieldValidator>
                                <asp:TextBox ID="txtExportFirstName" CssClass="form-control input-sm" runat="server" Width="100%" Enabled="false"></asp:TextBox>
                                

                                <b>TUID:</b><asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ValidationGroup="valAddAdmin" ControlToValidate="txtExportTUID" ErrorMessage="*" Display="Dynamic" Font-Bold="False" ForeColor="#CC0000"></asp:RequiredFieldValidator>
                                <asp:TextBox ID="txtExportTUID" CssClass="form-control input-sm" runat="server" Width="100%" Enabled="false"></asp:TextBox>

                                <b>Transfer Term:</b>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="ddlTermNameExport" Display="Dynamic" ErrorMessage="*Required" InitialValue="NA" Font-Bold="False" ForeColor="#CC0000" ValidationGroup="Exportmodal"></asp:RequiredFieldValidator>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="ddlTermYearExport" Display="Dynamic" ErrorMessage="*Required" InitialValue="NA" Font-Bold="False" ForeColor="#CC0000" ValidationGroup="Exportmodal"></asp:RequiredFieldValidator>
                                            <div class="form-inline">
                                                <asp:DropDownList ID="ddlTermNameExport" runat="server" CssClass="form-control">
                                                    <asp:ListItem Value="NA">Select One</asp:ListItem>
                                                    <asp:ListItem>Fall</asp:ListItem>
                                                    <asp:ListItem>Spring</asp:ListItem>
                                                </asp:DropDownList>
                                                <asp:DropDownList ID="ddlTermYearExport" runat="server" CssClass="form-control">
                                                </asp:DropDownList>

                            </div>
                            <div class="modal-footer">
                                 <asp:Button ID="btnExportStudent" CssClass="btn" style="background-color: #A41E35; color: #FFFFFF" runat="server" OnClick="btnExportStudent_Click" Text="Export" ValidationGroup="Exportmodal"></asp:Button>
                                <button type="button" class="btn btn-default" style="color: black" data-dismiss="modal">Cancel</button>
                            </div>
                        </div>
                    </div>
                </div>


                    </div>

                    
                </div>


            </div>


        </div>
        <asp:Label ID="lblTotalEntries" runat="server" Visible="false"></asp:Label>
        <asp:Label ID="lblStudentID" runat="server" Visible="false"></asp:Label>
    </div>

            
    <script type="text/javascript">
        $(document).ready(function () {

            $("#txtPhone").mask('(000) 000-0000');


        });

        $(function () {

            // We can attach the `fileselect` event to all file inputs on the page
            $(document).on('change', ':file', function () {
                var input = $(this),
                    numFiles = input.get(0).files ? input.get(0).files.length : 1,
                    label = input.val().replace(/\\/g, '/').replace(/.*\//, '');
                input.trigger('fileselect', [numFiles, label]);
            });

            // We can watch for our custom `fileselect` event like this
            $(document).ready(function () {


                //jQuery.each(jQuery('textarea'), function () {
                //    var offset = this.offsetHeight - this.clientHeight;

                //    var resizeTextarea = function (el) {
                //        jQuery(el).css('height', 'auto').css('height', el.scrollHeight + offset);
                //    };
                //    jQuery(this).on('change', function () { resizeTextarea(this); }).removeAttr('data-autoresize');
                //});

                $(':file').on('fileselect', function (event, numFiles, label) {

                    var input = $(this).parents('.input-group').find(':text'),
                        log = numFiles > 1 ? numFiles + ' files selected' : label;

                    if (input.length) {
                        input.val(log);
                    } else {
                        //if (log) alert(log);
                    }

                });
            });

        });

    </script>

</asp:Content>
