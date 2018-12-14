<%@ Page Title="" Language="C#" MasterPageFile="~/AdvisorCLA.Master" AutoEventWireup="true" CodeBehind="AdvisorDashboard.aspx.cs" EnableEventValidation="false" Inherits="CLATransferSupportSystem.NEWAdvisorDashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta http-equiv="Content-type" content="text/html; charset=utf-8"/>
    <meta name="viewport" content="width=device-width,initial-scale=1"/>
    <%--<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.14.15/jquery.mask.min.js"></script>--%>
   
    <style>
        /*.jumbotron {
            background-color: #dedcdd;
          
        }*/

        th {
            background-color: #A41E35;
            color: white;
        }

        .btn {
            background-color: #A41E35;
            color: white;
        }

        .lbMarginRight{
            margin-right: 5px;
        }
    

        tfoot tr th {
            margin: 0px;
            padding: 1px;
        }

        /*.dt-button {
            display: inline!important;

        }*/
        
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="AdvisorDashContent" runat="server">
     <%-- hidden button for modal--%>
     <button type="button" style="display: none;" id="btnShowErrorPopup"
                    data-toggle="modal" data-target="#errorModal">                  
     </button>


    <div class="container-fluid">


        <h3>Advisor Dashboard</h3>
        <ul class="nav nav-tabs">
            <li class="active"><a data-toggle="tab" href="#activeProfiles">Active</a></li>
            <li><a data-toggle="tab" href="#inactiveProfiles">Disabled</a></li>
            <li><a data-toggle="tab" href="#matriculatedProfiles">Matriculated</a></li>

        </ul>
        

        <div class="tab-content">
            <div class="jumbotron table-responsive tab-pane active" id="activeProfiles">
                <asp:LinkButton ID="lbAddStudentProfile" runat="server" data-toggle="modal" CausesValidation="false" data-target="#addProfileModal" CssClass="btn" OnClick="lbAddStudentProfile_Click">
                <span class="glyphicon glyphicon-plus">&nbsp</span>Add Student 
                </asp:LinkButton>
                &nbsp
           <%-- <asp:LinkButton ID="btnExport" runat="server" Text="Export" CssClass="btn btn-success" CausesValidation="false" OnClick="exportExcel_Click">
                <span><img src="images/icons8-microsoft-excel-50.png" style="box-sizing:border-box" height="17" width="20" /></span> Export
            </asp:LinkButton>--%>
                 <h4>Active Student Profiles</h4>
               <%-- <div class="table-responsive">--%>
                    <asp:Repeater ID="rptStudents" runat="server" OnItemCommand="rptStudents_ItemCommand" OnItemDataBound="rptStudents_ItemDataBound">
                        <HeaderTemplate>
                            <table id="mytable" class="table table-striped table-bordered">
                                <thead>
                                    <tr>
                                        <th><b>Action</b></th>
                                        <th><b>Last Name</b></th>
                                        <th><b>First Name</b></th>
                                        <th><b>Email</b></th>
                                        <th><b>Phone</b></th>
                                        <th><b>Current Institution</b></th>
                                        <th><b>Current Major</b></th>
                                        <th><b>Transfer Credits</b></th>
                                        <th><b>TU Major</b></th>
                                        <th><b>Anticipated Matric Term</b></th>
                                        <th><b>Associates</b></th>
                                        <th><b>PA Resident</b></th>
                                        <th><b>First Contact</b></th>
                                        <th><b>Last Contacted</b></th>
                                        <th><b>Matriculated</b></th>
                                        <th><b>Matric Term</b></th>
                                    </tr>
                                </thead>
                                <tfoot>
                                    <tr>
                                        <th>Search</th>
                                        <th>Last Name</th>
                                        <th>First Name</th>
                                        <th>Email</th>
                                        <th>Phone</th>
                                        <th>Current Institution</th>
                                        <th>Current Major</th>
                                        <th>Transfer Credits</th>
                                        <th>TU Major</th>
                                        <th>Anticipated Matric Term</th>
                                        <th>Associates</th>
                                        <th>PA Resident</th>
                                        <th>First Contact</th>
                                        <th>Last Contacted</th>
                                        <th>Matriculated</th>
                                        <th>Matric Term</th>
                                    </tr>

                                </tfoot>
                                <tbody>
                        </HeaderTemplate>
                        <ItemTemplate>

                            <tr>

                                <td>                                 
                                    <asp:LinkButton ID="lbViewStudent" runat="server" data-toggle="tooltip" title="View Student Profile" CausesValidation="false" CommandName="ViewStudent" CommandArgument='<%# Bind("studentID") %>' CssClass="btn" BackColor="#8C2132">
                                        <span class="glyphicon glyphicon-user"></span>
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="lbDisable" runat="server" data-toggle="tooltip" title="Disable Student" CommandName="DisableStudent" CausesValidation="false" CommandArgument='<%# Bind("studentID") %>' OnClientClick='javascript:return confirm("Are you sure you want to disable this student?")'>
                                       <span class="glyphicon glyphicon-ban-circle" style="color: red; float:right; margin-top: 8px;"></span>
                                    </asp:LinkButton>

                                </td>
                              
                                <td>
                                    <%# DataBinder.Eval(Container.DataItem, "studentLastName") %>
                                </td>
                                <td>
                                    <%# DataBinder.Eval(Container.DataItem, "studentFirstName") %>
                                </td>
                                <td>
                                    <%# DataBinder.Eval(Container.DataItem, "studentEmail") %>
                                </td>
                                <td>
                                    <%# DataBinder.Eval(Container.DataItem, "studentPhone") %>
                                </td>
                                <td>
                                    <%# DataBinder.Eval(Container.DataItem, "currentInstitution") %>
                                </td>
                                <td>
                                    <%# DataBinder.Eval(Container.DataItem, "currentMajor") %>
                                </td>
                                <td>
                                    <%# DataBinder.Eval(Container.DataItem, "anticipatedTransferCredits") %>
                                </td>
                                <td>
                                    <%# DataBinder.Eval(Container.DataItem, "majorDescription") %>
                                </td>
                                <td>
                                    <%# DataBinder.Eval(Container.DataItem, "anticipatedMatriculationTerm") %>
                                </td>
                                <td>
                                    <%# DataBinder.Eval(Container.DataItem, "associateStatus") %>
                                </td>
                                <td>
                                    <%# DataBinder.Eval(Container.DataItem, "isPAResident") %>
                                </td>
                                <td>
                                    <%# DataBinder.Eval(Container.DataItem, "initialContactDate") %>
                                </td>
                                <td>
                                    <%# DataBinder.Eval(Container.DataItem, "lastContacted") %>
                                </td>
                                <td>
                                    <%# DataBinder.Eval(Container.DataItem, "hasMatriculated") %>
                                </td>
                                <td>
                                    <%# DataBinder.Eval(Container.DataItem, "matriculationTerm") %>
                                </td>
                            </tr>


                        </ItemTemplate>
                        <FooterTemplate>
                            </tbody>
                        </table> 
                        </FooterTemplate>
                    </asp:Repeater>                                                                   
                <%--</div>--%>
               
               

                <%-- modal for add new student profile--%>
                <div class="modal fade" id="addProfileModal" role="dialog">
                    <div class="modal-dialog modal-lg">

                        <!-- Modal content-->
                        <div class="modal-content">
                            <asp:Panel runat="server" DefaultButton="lbAddNewProfile">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                                    <h4 class="modal-title">Add New Profile</h4>
                                </div>
                                <div class="modal-body">
                                    <div class="container">
                                        <div class="col-md-6">
                                            <b>Last Name:</b> 
                                            <asp:RequiredFieldValidator ID="valLastName" runat="server" ControlToValidate="txtLastName" ErrorMessage="*Required" Font-Bold="False" ForeColor="#CC0000"></asp:RequiredFieldValidator>                                           
                                            <asp:RegularExpressionValidator ID="revLastName" runat="server" Display="Dynamic" ErrorMessage="*Please enter a valid name.*" ForeColor="#CC0000" ControlToValidate="txtLastName" ValidationExpression="[a-zA-Z]+"></asp:RegularExpressionValidator>
                                            <asp:TextBox ID="txtLastName" runat="server" CssClass="form-control" Width="100%" placeholder="Last Name *"></asp:TextBox>
                                           
                                            <br />
                                            <b>First Name:</b> 
                                            <asp:RequiredFieldValidator ID="valFirstName" runat="server" ControlToValidate="txtFirstName" ErrorMessage="*Required" Font-Bold="False" ForeColor="#CC0000"></asp:RequiredFieldValidator>
                                            <asp:RegularExpressionValidator ID="revFirstName" runat="server" Display="Dynamic" ErrorMessage="*Please enter a valid name.*" ForeColor="#CC0000" ControlToValidate="txtFirstName" ValidationExpression="[a-zA-Z]+"></asp:RegularExpressionValidator>
                                            <asp:TextBox ID="txtFirstName" runat="server" CssClass="form-control" Width="100%"  placeholder="First Name *"></asp:TextBox>
                                           
                                            <br />
                                            <b>Phone Number:</b>
                                            <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" Width="100%"  placeholder="(123) 456-7898"></asp:TextBox>
                                            <br />

                                            <b>Email:</b>  
                                            <asp:RequiredFieldValidator ID="valEmail" runat="server" ControlToValidate="txtEmail" Display="Dynamic" ErrorMessage="*Required" Font-Bold="False" ForeColor="#CC0000"></asp:RequiredFieldValidator>
                                           
                                            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" Width="100%"  placeholder="example@domain.com *"></asp:TextBox>
                                             <asp:RegularExpressionValidator ID="valEmail2" runat="server" ControlToValidate="txtEmail" Display="Dynamic" ErrorMessage="*Invalid e-mail format" Font-Bold="False" ForeColor="#CC0000"  ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                                            <br />

                                            <b>Confirm Email:</b><asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtConfirmEmail" Display="Dynamic" ErrorMessage="*Required" Font-Bold="False" ForeColor="#CC0000"></asp:RequiredFieldValidator>
                                             <asp:CompareValidator ID="valConfirmEmail" Operator="Equal" runat="server" ControlToValidate="txtConfirmEmail" ControlToCompare="txtEmail" ErrorMessage="*Emails don't match" Font-Bold="False" ForeColor="#CC0000"></asp:CompareValidator>
                                            <asp:TextBox ID="txtConfirmEmail" runat="server" CssClass="form-control" Width="100%" placeholder="example@domain.com *"></asp:TextBox>
                                            <br />

                                        </div>
                                        <div class="col-md-6">
                                            <b>Current Institution:</b>
                                            <asp:RegularExpressionValidator ID="revInstitution" runat="server" Display="Dynamic" ErrorMessage="*Please enter a valid institution.*" ForeColor="#CC0000" ControlToValidate="txtCurrentInstitution" ValidationExpression="[a-zA-Z\s]+"></asp:RegularExpressionValidator>
                                            <asp:TextBox ID="txtCurrentInstitution" runat="server" CssClass="form-control" Width="100%" placeholder="Current Institution.."></asp:TextBox><br />
                                            <b>Current Major:</b>
                                            <asp:RegularExpressionValidator ID="revMajor" runat="server" Display="Dynamic" ErrorMessage="*Please enter a valid major.*" ForeColor="#CC0000" ControlToValidate="txtCurrentMajor" ValidationExpression="[a-zA-Z\s]+"></asp:RegularExpressionValidator>
                                            <asp:TextBox ID="txtCurrentMajor" runat="server" CssClass="form-control" Width="100%" placeholder="Current Major.."></asp:TextBox><br />
                                            <b>Anticipated TU Major:</b>
                                            <asp:DropDownList ID="ddlAnticipatedTUMajor" runat="server" CssClass="form-control"></asp:DropDownList><br />
                                            <b>Anticipated Transfer Credits:</b>
                                            <asp:RegularExpressionValidator ID="revCredits" runat="server" Display="Dynamic" ErrorMessage="*Enter up to 3 digits.*" ForeColor="#CC0000" ControlToValidate="txtAnticipatedTransferCredits" ValidationExpression="^([0-9]|[1-8][0-9]|9[0-9]|[1-8][0-9]{2}|9[0-8][0-9]|99[0-9])$"></asp:RegularExpressionValidator>
                                            <asp:TextBox ID="txtAnticipatedTransferCredits" runat="server" MaxLength="3" CssClass="form-control" placeholder="# Transfer Credits"></asp:TextBox><br />
                                            <b>Anticipated Transfer Term:</b>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="ddlTermName" Display="Dynamic" ErrorMessage="*Required" InitialValue="NA" Font-Bold="False" ForeColor="#CC0000"></asp:RequiredFieldValidator>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="ddlTermYear" Display="Dynamic" ErrorMessage="*Required" InitialValue="NA" Font-Bold="False" ForeColor="#CC0000"></asp:RequiredFieldValidator>
                                            <div class="form-inline">
                                                <asp:DropDownList ID="ddlTermName" runat="server" CssClass="form-control">
                                                    <asp:ListItem Value="NA">Select One</asp:ListItem>
                                                    <asp:ListItem>Fall</asp:ListItem>
                                                    <asp:ListItem>Spring</asp:ListItem>
                                                </asp:DropDownList>
                                                <asp:DropDownList ID="ddlTermYear" runat="server" CssClass="form-control">
                                                </asp:DropDownList>
                                            </div>
                                            <br />
                                            <div style="float:left; margin-right:40px">
                                                <b>Associate's Status:</b>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="ddlAssociatesStatus" Display="Dynamic" ErrorMessage="*Required" InitialValue="NA" Font-Bold="False" ForeColor="#CC0000"></asp:RequiredFieldValidator>
                                                <asp:DropDownList Style="display: block" ID="ddlAssociatesStatus" runat="server" CssClass="form-control">
                                                    <asp:ListItem Value="NA">Select One</asp:ListItem>
                                                    <asp:ListItem>Not Pursuing</asp:ListItem>
                                                    <asp:ListItem>In Progress</asp:ListItem>
                                                    <asp:ListItem>Completed</asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                            <div style="float:left">
                                                <b>PA Resident:</b>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="ddlPAResident" Display="Dynamic" ErrorMessage="*Required" InitialValue="NA" Font-Bold="False" ForeColor="#CC0000"></asp:RequiredFieldValidator>
                                                <asp:DropDownList Style="display: block" ID="ddlPAResident" runat="server" CssClass="form-control">
                                                    <asp:ListItem Value="NA">Select One</asp:ListItem>
                                                    <asp:ListItem>Yes</asp:ListItem>
                                                    <asp:ListItem>No</asp:ListItem>
                                                </asp:DropDownList>

                                            </div>
                                               
                                                                                                                                                                                 
                                        </div>
                                    </div>

                                </div>
                                <div class="modal-footer">
                                    <asp:LinkButton ID="lbAddNewProfile" CssClass="btn" runat="server" OnClick="lbAddNewProfile_Click">Add Profile</asp:LinkButton>
                                    <button type="button" class="btn btn-default" style="color: black" data-dismiss="modal">Cancel</button>
                                </div>

                            </asp:Panel>

                        </div>
                    </div>

                </div>
               
            </div>
            <div class="jumbotron tab-pane table-responsive" id="inactiveProfiles">
                <h4>Inactive Student Profiles</h4>
                <asp:Repeater ID="rptInactive" runat="server" OnItemCommand="rptStudents_ItemCommand" OnItemDataBound="rptInactive_ItemDataBound">
                    <HeaderTemplate>
                        <table id="mytable2" class="table table-striped table-bordered">
                            <thead>
                                <tr>
                                    <th><b>Action</b></th>
                                    <th><b>Last Name</b></th>
                                    <th><b>First Name</b></th>
                                    <th><b>Email</b></th>
                                    <th><b>Phone</b></th>
                                    <th><b>Current Institution</b></th>
                                    <th><b>Current Major</b></th>
                                    <th><b>Transfer Credits</b></th>
                                    <th><b>TU Major</b></th>
                                    <th><b>Anticipated Matric Term</b></th>
                                    <th><b>Associates</b></th>
                                    <th><b>PA Resident</b></th>
                                    <th><b>First Contact</b></th>
                                    <th><b>Last Contacted</b></th>
                                    <th><b>Matriculated</b></th>
                                    <th><b>Matric Term</b></th>



                                </tr>

                            </thead>
                            <tfoot>
                                <tr>
                                    <th>Search</th>                                  
                                    <th><b>Last Name</b></th>
                                    <th><b>First Name</b></th>
                                    <th><b>Email</b></th>
                                    <th><b>Phone</b></th>
                                    <th><b>Current Institution</b></th>
                                    <th><b>Current Major</b></th>
                                    <th><b>Transfer Credits</b></th>
                                    <th><b>TU Major</b></th>
                                    <th><b>Anticipated Matric Term</b></th>
                                    <th><b>Associates</b></th>
                                    <th><b>PA Resident</b></th>
                                    <th><b>First Contact</b></th>
                                    <th><b>Last Contacted</b></th>
                                    <th><b>Matriculated</b></th>
                                    <th><b>Matric Term</b></th>




                                </tr>

                            </tfoot>
                            <tbody>
                    </HeaderTemplate>
                    <ItemTemplate>


                        <tr>

                            <td>
                                <div class="form-inline">
                                    <asp:LinkButton ID="lbViewStudent" runat="server" data-toggle="tooltip" title="View Student Profile" CausesValidation="false" CommandName="ViewStudent" CommandArgument='<%# Bind("studentID") %>' CssClass="btn lbMarginRight" BackColor="#8C2132">
                                        <span class="glyphicon glyphicon-user"></span>
                                    </asp:LinkButton>
                                   <asp:LinkButton ID="lbRestore" runat="server" data-toggle="tooltip" title="Restore Student" CausesValidation="false" CommandName="RestoreStudent" CommandArgument='<%# Bind("studentID") %>' CssClass="lbMarginRight" OnClientClick='javascript:return confirm("Are you sure you want to restore this student?")'>
                                       <span class="glyphicon glyphicon-refresh"></span>
                                   </asp:LinkButton>
                                <asp:LinkButton ID="lbDelete" runat="server" data-toggle="tooltip" title="Delete Student" CausesValidation="false" CommandName="DeleteStudent" CommandArgument='<%# Bind("studentID") %>' OnClientClick='javascript:return confirm("Are you sure you want to permanently delete this student?")'>
                                    <span class="glyphicon glyphicon-remove-circle" style="color: red"></span>
                                </asp:LinkButton>

                                </div>                                                         
                            </td>
                           <%-- <td>
                                 
                            </td>--%>
                            <td>
                                <%# DataBinder.Eval(Container.DataItem, "studentLastName") %>
                            </td>
                            <td>
                                <%# DataBinder.Eval(Container.DataItem, "studentFirstName") %>
                            </td>
                            <td>
                                <%# DataBinder.Eval(Container.DataItem, "studentEmail") %>
                            </td>
                            <td>
                                <%# DataBinder.Eval(Container.DataItem, "studentPhone") %>
                            </td>
                            <td>
                                <%# DataBinder.Eval(Container.DataItem, "currentInstitution") %>
                            </td>
                            <td>
                                <%# DataBinder.Eval(Container.DataItem, "currentMajor") %>
                            </td>
                            <td>
                                <%# DataBinder.Eval(Container.DataItem, "anticipatedTransferCredits") %>
                            </td>
                            <td>
                                <%# DataBinder.Eval(Container.DataItem, "majorDescription") %>
                            </td>
                            <td>
                                <%# DataBinder.Eval(Container.DataItem, "anticipatedMatriculationTerm") %>
                            </td>
                            <td>
                                <%# DataBinder.Eval(Container.DataItem, "associateStatus") %>
                            </td>
                            <td>
                                <%# DataBinder.Eval(Container.DataItem, "isPAResident") %>
                            </td>
                            <td>
                                <%# DataBinder.Eval(Container.DataItem, "initialContactDate") %>
                            </td>
                            <td>
                                <%# DataBinder.Eval(Container.DataItem, "lastContacted") %>
                            </td>
                            <td>
                                <%# DataBinder.Eval(Container.DataItem, "hasMatriculated") %>
                            </td>
                            <td>
                                <%# DataBinder.Eval(Container.DataItem, "matriculationTerm") %>
                            </td>

                        </tr>


                    </ItemTemplate>
                    <FooterTemplate>
                        </tbody>
                        </table> 
                    </FooterTemplate>
                </asp:Repeater>
            </div>


            <div class="jumbotron tab-pane table-responsive" id="matriculatedProfiles">
                <h4>Matriculated Student Profiles</h4>
                <asp:Repeater ID="rptMatriculated" runat="server" OnItemCommand="rptStudents_ItemCommand">
                    <HeaderTemplate>
                        <table id="mytable3" class="table table-striped table-bordered">
                            <thead>
                                <tr>
                                    <th><b>Action</b></th>
                                    <th><b>Last Name</b></th>
                                    <th><b>First Name</b></th>
                                    <th><b>Email</b></th>
                                    <th><b>Phone</b></th>
                                    <th><b>Current Institution</b></th>
                                    <th><b>Current Major</b></th>
                                    <th><b>Transfer Credits</b></th>
                                    <th><b>TU Major</b></th>
                                    <th><b>Anticipated Matric Term</b></th>
                                    <th><b>Associates</b></th>
                                    <th><b>PA Resident</b></th>
                                    <th><b>First Contact</b></th>
                                    <th><b>Last Contacted</b></th>
                                    <th><b>Matriculated</b></th>
                                    <th><b>Matric Term</b></th>



                                </tr>

                            </thead>
                            <tfoot>
                                <tr>
                                    <th>Search</th>                                  
                                    <th><b>Last Name</b></th>
                                    <th><b>First Name</b></th>
                                    <th><b>Email</b></th>
                                    <th><b>Phone</b></th>
                                    <th><b>Current Institution</b></th>
                                    <th><b>Current Major</b></th>
                                    <th><b>Transfer Credits</b></th>
                                    <th><b>TU Major</b></th>
                                    <th><b>Anticipated Matric Term</b></th>
                                    <th><b>Associates</b></th>
                                    <th><b>PA Resident</b></th>
                                    <th><b>First Contact</b></th>
                                    <th><b>Last Contacted</b></th>
                                    <th><b>Matriculated</b></th>
                                    <th><b>Matric Term</b></th>




                                </tr>

                            </tfoot>
                            <tbody>
                    </HeaderTemplate>
                    <ItemTemplate>


                        <tr>

                            <td>
                                <div class="form-inline">
                                    <asp:LinkButton ID="lbViewStudent" runat="server" data-toggle="tooltip" title="View Student Profile" CausesValidation="false" CommandName="ViewStudent" CommandArgument='<%# Bind("studentID") %>' CssClass="btn lbMarginRight" BackColor="#8C2132">
                                        <span class="glyphicon glyphicon-user"></span>
                                    </asp:LinkButton>                            

                                </div>                                                         
                            </td>
                           <%-- <td>
                                 
                            </td>--%>
                            <td>
                                <%# DataBinder.Eval(Container.DataItem, "studentLastName") %>
                            </td>
                            <td>
                                <%# DataBinder.Eval(Container.DataItem, "studentFirstName") %>
                            </td>
                            <td>
                                <%# DataBinder.Eval(Container.DataItem, "studentEmail") %>
                            </td>
                            <td>
                                <%# DataBinder.Eval(Container.DataItem, "studentPhone") %>
                            </td>
                            <td>
                                <%# DataBinder.Eval(Container.DataItem, "currentInstitution") %>
                            </td>
                            <td>
                                <%# DataBinder.Eval(Container.DataItem, "currentMajor") %>
                            </td>
                            <td>
                                <%# DataBinder.Eval(Container.DataItem, "anticipatedTransferCredits") %>
                            </td>
                            <td>
                                <%# DataBinder.Eval(Container.DataItem, "majorDescription") %>
                            </td>
                            <td>
                                <%# DataBinder.Eval(Container.DataItem, "anticipatedMatriculationTerm") %>
                            </td>
                            <td>
                                <%# DataBinder.Eval(Container.DataItem, "associateStatus") %>
                            </td>
                            <td>
                                <%# DataBinder.Eval(Container.DataItem, "isPAResident") %>
                            </td>
                            <td>
                                <%# DataBinder.Eval(Container.DataItem, "initialContactDate") %>
                            </td>
                            <td>
                                <%# DataBinder.Eval(Container.DataItem, "lastContacted") %>
                            </td>
                            <td>
                                <%# DataBinder.Eval(Container.DataItem, "hasMatriculated") %>
                            </td>
                            <td>
                                <%# DataBinder.Eval(Container.DataItem, "matriculationTerm") %>
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

       <div class="modal fade" id="errorModal" role="dialog">
                <div class="modal-dialog modal-sm">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title">Oops..</h4>
                        </div>

                        <div class="modal-body" style="text-align:center">
                           A Student with that e-mail already exists!<br /><br />
                            Student Not Added.

                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" style="color: black" data-dismiss="modal">OK</button>
                        </div>


                    </div>

                </div>

            </div>

        <script type="text/javascript">
            $(document).ready(function () {

                $("#txtNumber").mask('(000) 000-0000');


            });

            function showErrorPopup() {
                $("#btnShowErrorPopup").click();
            }


        </script>
        
        <script type="text/javascript" class="init">
            $(document).ready(function () {

                //$("#txtPhone").mask('(000) 000-0000');
                $.fn.dataTable.moment('l');

                // Setup - add a text input to each footer cell
                $('#mytable tfoot th').each(function () {
                    var title = $(this).text();
                    if (title == "Search") {
                        //$(this).html('<input type="text" class="form-control" placeholder="Search ' + title + '" style="width: 60px" />');
                    } else {
                        $(this).html('<input type="text" class="form-control" placeholder="Search ' + title + '" style="width: 130px" />');
                    }

                });

                var today = new Date();
                var dd = today.getDate();
                var mm = today.getMonth() + 1; //January is 0!

                var yyyy = today.getFullYear();
                if (dd < 10) {
                    dd = '0' + dd;
                }
                if (mm < 10) {
                    mm = '0' + mm;
                }
                var today = mm + '_' + dd + '_' + yyyy;

                // DataTable
                var table = $('#mytable').DataTable({
                    dom: 'lBfrtip',
                    buttons: [{
                        extend: 'excel',
                        title: 'CLA_TransferStudents_' + today
                    }],
                    
    

                });

                $('.dt-button').each(function () {

                    //$(this).removeClass();
                    //$(this).addClass("btn btn-success");
                    $(this).css("margin-left", "15px");
                    $(this).html('<span><img src="images/icons8-microsoft-excel-50.png" style="box-sizing:border-box" height="17" width="20" /></span> Export');           
                   
                });

                $('#mytable_length').css("float", "left");
                //$('#dt-buttons').css("display", "inline");
                
                //$("#mytable_length", "#dt-buttons").wrapAll("<div class='form-inline'></div>");

                //$('.dt-button').html('<span><img src="images/icons8-microsoft-excel-50.png" style="box-sizing:border-box" height="17" width="20" /></span> Export');


                

                // Apply the search
                table.columns().every(function () {
                    var that = this;

                    $('input', this.footer()).on('keyup change', function () {
                        if (that.search() !== this.value) {
                            that
                                .search(this.value)
                                .draw();
                        }
                    });
                });

                $('#mytable2 tfoot th').each(function () {
                    var title = $(this).text();
                    var width = "130px";

                    if (title == "Search") {
                        $(this).html('<input type="text" class="form-control" placeholder="Search ' + title + '" style="width: 90px" />');

                    } else if (title == "PA Resident") {
                        $(this).html('<input type="text" class="form-control" placeholder="Search ' + title + '" style="width: 80px" />');
                    }
                    else {
                        $(this).html('<input type="text" class="form-control" placeholder="Search ' + title + '" style="width: 130px" />');
                    }

                });

                // DataTable
                var table = $('#mytable2').DataTable();

                // Apply the search
                table.columns().every(function () {
                    var that = this;

                    $('input', this.footer()).on('keyup change', function () {
                        if (that.search() !== this.value) {
                            that
                                .search(this.value)
                                .draw();
                        }
                    });
                });

            });


            $('#mytable3 tfoot th').each(function () {
                var title = $(this).text();
                if (title == "Search") {
                    //$(this).html('<input type="text" class="form-control" placeholder="Search ' + title + '" style="width: 60px" />');
                } else {
                    $(this).html('<input type="text" class="form-control" placeholder="Search ' + title + '" style="width: 130px" />');
                }

            });

            // DataTable
            var table = $('#mytable3').DataTable();

            // Apply the search
            table.columns().every(function () {
                var that = this;

                $('input', this.footer()).on('keyup change', function () {
                    if (that.search() !== this.value) {
                        that
                            .search(this.value)
                            .draw();
                    }
                });
            });
        </script>


    </div>
</asp:Content>
