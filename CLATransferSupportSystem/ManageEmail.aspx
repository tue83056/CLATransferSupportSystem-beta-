<%@ Page Title="" Language="C#" MasterPageFile="~/AdvisorCLA.Master" AutoEventWireup="true" ValidateRequest="false" CodeBehind="ManageEmail.aspx.cs" Inherits="CLATransferSupportSystem.WebForm5" %>



<asp:Content ID="Content6" runat="server" ContentPlaceHolderID="ManageEmailContent">




    <style>
        .jumbotron {
            background-color: #dedcdd;
        }

        th {
            background-color: #A41E35;
            color: white;
        }

        button {
            /*background-color: lightgrey !important;*/
            background-image: none !important;
            color: white !important;
        }

            button:hover {
                background-color: black;
            }
    </style>




    <div class="container-fluid">
        <h3>Manage Email</h3>

        <div class="jumbotron">




            <h5>Enter information for how the automated email will appear to </h5>
            <h5>students in response to the student transfer form submission.</h5>








            <div class="form-group">

                <br />
                <label for="email">Subject:</label>
                <asp:TextBox runat="server" placeholder="Subject.." ID="txtSubject" type="text" Style="width: 500px" class="form-control" />



                <asp:TextBox ID="txtSummernote" placeholder="Email Body.." HtmlEncode="false" runat="server" TextMode="MultiLine" Rows="10"></asp:TextBox>
                <%--The data is being stored in this hidden label--%>
                <asp:Label ID="hiddentxt" ClientIDMode="Static" runat="server" Style="display: none"></asp:Label>

            </div>





            <script type="text/javascript">
                function funcMyHtml() {

                    document.getElementById("#<%= txtSummernote.ClientID %>").value = $('#<%= txtSummernote.ClientID %>').summernote('code');
                }
            </script>




            <asp:Label ID="lbltestError" runat="server" ForeColor="#CC0000"></asp:Label>

            <div class="form-inline">
                <br />
                Enter your email below in the text box and click the send button to receive a copy of the email. (This is for testing purposes) <br /> 
                <asp:TextBox ID="txtTestemail" CssClass="form-control input-sm" runat="server" Width="231px" placeholder="example@temple.edu"></asp:TextBox>
                
                <asp:Button ID="btnTestEmail" runat="server" CssClass="btn" ValidationGroup="1" OnClick="btnTestEmail_Click" Text="Send Test Email"></asp:Button>
                <br />
                <asp:RequiredFieldValidator ID="valEmail" runat="server" ValidationGroup="1" ControlToValidate="txtTestemail" Display="Dynamic" ErrorMessage="Email Required *" Font-Bold="False" ForeColor="#CC0000"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="valEmail2" runat="server" ValidationGroup="1" ControlToValidate="txtTestemail" Display="Dynamic" ErrorMessage="Invalid e-mail format *" Font-Bold="False" ForeColor="#CC0000"  ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                
            </div>
            <br />

            <asp:Button ID="Button1" CssClass="btn" runat="server" OnClientClick="funcMyHtml()" Text="Save" OnClick="Button1_Click" />&nbsp
            <asp:CheckBox ID="chkDisableEmail" runat="server" Text="Disable Email" />




        </div>
    </div>

    <script>

        $(function () {
            // Set up your summernote instance
            $("#<%= txtSummernote.ClientID %>").summernote({
                        toolbar: [
    // [groupName, [list of button]]
    ['style', ['style']],
    ['design', ['bold', 'italic', 'underline', 'clear']],
    ['font', ['fontname']],
    ['fontsize', ['fontsize']],
    ['height', ['height']],
    ['color', ['color']],
    ['para', ['ul', 'ol', 'paragraph']],
    ['table'],
    ['link']
                        ]
                        //height: 400
                    });
                    focus: true

                    // When the summernote instance loses focus, update the content of your <textarea>
                    $("#<%= txtSummernote.ClientID %>").on('summernote.blur', function () {
                        $('#<%= txtSummernote.ClientID %>').html($('#<%= txtSummernote.ClientID %>').summernote('code'));
                    });
                });



    </script>



</asp:Content>

