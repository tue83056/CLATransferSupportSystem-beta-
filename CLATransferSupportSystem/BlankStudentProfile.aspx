<%@ Page Title=""  Language="C#" MasterPageFile="~/AdvisorCLA.Master" AutoEventWireup="true" CodeBehind="BlankStudentProfile.aspx.cs" Inherits="CLATransferSupportSystem.WebForm6" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    
</asp:Content>

<asp:Content ID="Content7" ContentPlaceHolderID="BlankProfileContent" runat="server">
    <div class="container-fluid">


        <div class="row">
            <h3>&nbsp&nbsp&nbsp Student Profile</h3>
            <div class="col-md-4">
                <div class="jumbotron">
                    <h4 style="text-align: center"><b>Student Information:</b></h4>
                    <br />
                    <table class="table table-condensed table-responsive">

                        <tr>
                            <th>Last Name:</th>
                            <td>
                                <asp:TextBox ID="txtLastName" runat="server" CssClass="form-control" ReadOnly="true" Text=""></asp:TextBox></td>
                        </tr>
                        <tr>
                            <th>First Name:</th>
                            <td>
                                <asp:TextBox ID="txtFirstName" runat="server" CssClass="form-control" ReadOnly="true" Text=""></asp:TextBox></td>
                        </tr>
                        <tr>
                            <th>DOB:</th>
                            <td>
                                <asp:TextBox ID="txtDOB" runat="server" CssClass="form-control" ReadOnly="true" Text=""></asp:TextBox></td>
                        </tr>
                        <tr>
                            <th>Email:</th>
                            <td>
                                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" ReadOnly="true" Text=""></asp:TextBox></td>
                        </tr>
                        <tr>
                            <th>Phone:</th>
                            <td>
                                <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" ReadOnly="true" Text=""></asp:TextBox></td>
                        </tr>
                        <tr>
                            <th>Current Institution:</th>
                            <td>
                                <asp:TextBox ID="txtCurrentInstitution" runat="server" ReadOnly="true" CssClass="form-control" Text=""></asp:TextBox></td>
                        </tr>
                        <tr>
                            <th>Current Major:</th>
                            <td>
                                <asp:TextBox ID="txtCurrentMajor" runat="server" ReadOnly="true" CssClass="form-control" Text=""></asp:TextBox></td>
                        </tr>
                        <tr>
                            <th>Anticipated TU Major:</th>
                            <td>
                                <asp:DropDownList ID="ddlAnticipatedTUMajor" Enabled="false" runat="server" CssClass="form-control">
                                    <asp:ListItem>Africology</asp:ListItem>
                                    <asp:ListItem>American Studies</asp:ListItem>
                                    <asp:ListItem>Anthropology</asp:ListItem>
                                    <asp:ListItem>Asian Studies</asp:ListItem>
                                    <asp:ListItem>Chinese</asp:ListItem>
                                    <asp:ListItem>Criminal Justice</asp:ListItem>
                                    <asp:ListItem>Economics</asp:ListItem>
                                    <asp:ListItem>English</asp:ListItem>
                                    <asp:ListItem>Environmental Studies</asp:ListItem>
                                    <asp:ListItem Selected="True">French</asp:ListItem>
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
                                    <asp:ListItem>Spanish</asp:ListItem>
                                </asp:DropDownList></td>
                        </tr>
                        <tr>
                            <th>Anticipated Transfer Credits:</th>
                            <td>
                                <asp:TextBox ID="txtAnticipatedTransferCredits" ReadOnly="true" runat="server" CssClass="form-control" Text=""></asp:TextBox></td>
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
                        <tr>
                            <th>Has Matriculated:</th>
                            <td>
                                <asp:DropDownList ID="ddlHasMatriculated" Enabled="false" runat="server" CssClass="form-control">
                                    <asp:ListItem>No</asp:ListItem>
                                    <asp:ListItem>Yes</asp:ListItem>
                                </asp:DropDownList></td>
                        </tr>
                        <tr>
                            <th>Initial Contact Date:</th>
                            <td></td>
                        </tr>
                        <tr>
                            <th>Last Contact Date:</th>
                            <td></td>
                        </tr>
                    </table>
                    <br />
                    <div class="form-inline">
                        <asp:Button ID="btnEditStudentInfo" runat="server" Text="Edit" CssClass="btn" Style="background-color: #808080; color: #FFFFFF" OnClick="btnEditStudentInfo_Click" />&nbsp
                         <asp:Button ID="btnSaveStudentInfo" runat="server" Text="Save" CssClass="btn" Style="background-color: #A41E35; color: #FFFFFF" OnClick="btnSaveStudentInfo_Click" />
                    </div>
                </div>

                <div class="jumbotron">
                    <h4 style="text-align: center"><b>Uploaded Files:</b></h4>
                    <br />
                    <div class="panel panel-default" style="width: 500px" >
                        <%--<input type="text" class="form-control" readonly="readonly" />--%>

                        <asp:GridView ID="gvShowFiles" runat="server" AutoGenerateColumns="False" OnRowDeleting="gvShowFiles_RowDeleting"
                            AllowPaging="True" PageSize="3" OnPageIndexChanging="gvShowFiles_PageIndexChanging" >
                            <Columns>
                                <asp:BoundField DataField="documentID" HeaderText="ID" />
                                <asp:BoundField DataField="documentName" HeaderText="Name" />
                                <asp:BoundField DataField="documentCategory" HeaderText="Category" />
                                <asp:BoundField DataField="dateUploaded" HeaderText="Date Uploaded" />
                                <asp:BoundField DataField="addedByAdmin" HeaderText="Added by" />
                                <%--<asp:BoundField DataField="fileData" HeaderText="Data" />--%>


                                <asp:TemplateField HeaderText="Download">
                                    <ItemTemplate>
                                        <asp:Button ID="btnDownloadDocument" runat="server" Text="Download" OnClick="btnDownloadDocument_Click" />
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <%--<asp:CommandField ButtonType="Button" HeaderText="Edit"
                                ShowEditButton="True"></asp:CommandField>--%>
                                <asp:CommandField ButtonType="Button" HeaderText="Delete"
                                    ShowDeleteButton="True" />
                            </Columns>
                        </asp:GridView>

                    </div>



                    <%--<strong>
                        <br />
                        <br />
                        Add File:</strong>--%>
                    <br />
                    <br />
                    
                    <div class="input-group">
                        <label class="input-group-btn">
<%--                            <span class="btn" style="background-color: #808080; color: #FFFFFF">Browse&hellip;--%>
                                <input type="file" style="display: none;" multiple="multiple" />
                            </span>
                        </label>
                        <%--<input type="text" class="form-control" readonly="readonly" />--%>
                    </div>
                    <span class="help-block">Select a file to upload
                    </span>

                    <asp:FileUpload ID="FileUpload1" runat="server" /><br />

<div class="form-inline">
                        <strong>Select the category:</strong>&nbsp&nbsp<asp:DropDownList ID="ddlFileCategory" CssClass="form-control" runat="server">
                            <asp:ListItem>Syllabus</asp:ListItem>
                            <asp:ListItem>Unoffical Transcript</asp:ListItem>
                            <asp:ListItem>Academic Plan</asp:ListItem>
                            <asp:ListItem>Other</asp:ListItem>

                        </asp:DropDownList><br />
                        <br />
                    </div>
                    <asp:Button ID="btnUploadDocument" runat="server" CssClass="btn" Style="background-color: #A41E35; color: #FFFFFF" Text="Upload" OnClick="btnUploadDocument_Click" />

                &nbsp;&nbsp;&nbsp;


                    <asp:Button ID="btnClear" runat="server" CssClass="btn" Style="background-color: #A41E35; color: #FFFFFF" Text="Clear selected file" OnClick="btnClear_Click" />

                </div>


            </div>


            <div class="col-md-8">
                <div class="jumbotron">
                    <h4><b>Conversation Entries:</b></h4>
                    <br />
                    <div class="pre-scrollable">
                    </div>
                    <br />
                    <b>Export Entries:</b><br />
                    <br />
                    <b>TUID:</b>&nbsp
                    <asp:TextBox ID="txtTUID" runat="server" CssClass="form-control input-sm"></asp:TextBox><br />
                    <asp:Button ID="btnExportConversationEntries" runat="server" CssClass="btn" Style="background-color: #A41E35; color: #FFFFFF" Text="Export Entries" />
                </div>

                <div class="jumbotron">
                    <h4><b>Add Conversation Entry:</b></h4>
                    <div class="form-inline">
                        <strong>Entry:</strong>&nbsp 1 &nbsp&nbsp<strong>Date:</strong>&nbsp&nbsp 10/29/2017 &nbsp&nbsp<strong>Added by:</strong>&nbsp Nicole Conley
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
                    <asp:Button ID="btnAddEntry" Text="Add Entry" CssClass="btn" Style="background-color: #A41E35; color: #FFFFFF" runat="server" />


                </div>


            </div>


        </div>


    </div>





    <script type="text/javascript">
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
                $(':file').on('fileselect', function (event, numFiles, label) {

                    var input = $(this).parents('.input-group').find(':text'),
                        log = numFiles > 1 ? numFiles + ' files selected' : label;

                    if (input.length) {
                        input.val(log);
                    } else {
                        if (log) alert(log);
                    }

                });
            });

        });

    </script>


</asp:Content>
