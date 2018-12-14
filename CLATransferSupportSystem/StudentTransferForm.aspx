﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StudentTransferForm.aspx.cs" Inherits="CLATransferSupportSystem.StudentTransferForm" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Student Transfer Form</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    
    <link rel="stylesheet" href="Content/bootstrap.min.css" />
    <link rel="stylesheet" href="Content/bootstrap-theme.min.css" />

    <script src='https://www.google.com/recaptcha/api.js'></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js" integrity="sha384-tsQFqpEReu7ZLhBV2VZlAu7zcOV+rXbYlF2cqB8txI/8aZajjp4Bqd+V6D5IgvKT" crossorigin="anonymous"></script>
    <script src="Scripts/bootstrap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.14.15/jquery.mask.min.js" integrity="sha384-gyd4qL89L3l3RHg1DIarsIoh4BT3/hmoq/DtYpJdyT5oPemVJIMdh6/qC4UJ12WJ" crossorigin="anonymous"></script>

    <style>
       

        
        body {
            background-image: url("images/cityhall.jpg");
            background-repeat: no-repeat;
            background-size: cover;
            opacity: 0.97;
        }

        .jumbotron {
            margin: 5px;
        }

        .form-control {
            margin-bottom: 15px;
        }

        .borderRight {
            border-right-style: solid !important;
            border-right: thin;
            border-right-color: darkgrey;
            border-right-width: 1px;
        }
    </style>

    <script type="text/javascript">
        function showErrorPopup() {
            $("#btnShowErrorPopup").click();
        }
        function showThankYou() {
            $("#btnThankYouPopup").click();
        }

      
    </script>

</head>
<body style="background-color: #A41E35;">

    <%-- hidden button for modal--%>
    <button type="button" style="display: none;" id="btnThankYouPopup" class="btn btn-primary btn-lg"
        data-toggle="modal" data-target="#ThankYouModal">
    </button>
    <button type="button" style="display: none;" id="btnShowErrorPopup" class="btn btn-primary btn-lg"
        data-toggle="modal" data-target="#errorModal">
    </button>

    <div class="container-fluid">
        <form id="form1" runat="server">
            <div class="row">
                <div class="col-md-10 col-md-offset-1">
                    <div class="jumbotron">

                        <img style="max-width: 300px; margin-top: -60px;"
                            src="images/redT_black.png" />
                         <noscript><h2>This page uses JavaScript to function properly. To submit the form, please enable JavaScript or switch to a different browser.</h2></noscript>
                        <h3>Student Transfer Question Form</h3>
                        <br />
                        Please fill out the information below. Your question will be sent to an adivsor and you will hear back from them shortly through email. 
                        <br />
                        <b>This is not a transfer application.</b>
                        <%--Please fill out the information below with your transfer question included at the bottom.  An advisor will be in touch with you shortly.--%><br />
                        <br />

                       
                        <div class="row">
                            <div class="col-md-3 borderRight">
                                <b>First Name: </b>
                                <asp:RequiredFieldValidator ID="valFirstName" runat="server" ControlToValidate="txtFirstName" Display="Dynamic" ErrorMessage="*First Name Required*" Font-Bold="False" ForeColor="#CC0000"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="revFirstName" runat="server" Display="Dynamic" ErrorMessage="*Please enter a valid name.*" ForeColor="#CC0000" ControlToValidate="txtFirstName" ValidationExpression="[a-zA-Z]+"></asp:RegularExpressionValidator>
                                <asp:TextBox ID="txtFirstName" placeholder="First Name *" MaxLength="30"  name="firstName" CssClass="form-control" runat="server" Width="100%"></asp:TextBox>

                                <b>Last Name: </b>
                                <asp:RequiredFieldValidator ID="valLastName" runat="server" ControlToValidate="txtLastName" Display="Dynamic" ErrorMessage="*Last Name Required*" Font-Bold="False" ForeColor="#CC0000"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="revLastName" runat="server" Display="Dynamic" ErrorMessage="*Please enter a valid name.*" ForeColor="#CC0000" ControlToValidate="txtLastName" ValidationExpression="[a-zA-Z]+"></asp:RegularExpressionValidator>
                                <asp:TextBox ID="txtLastName" placeholder="Last Name *" MaxLength="30" CssClass="form-control" runat="server" Width="100%"></asp:TextBox>

                                <b>Phone Number:  </b>
                                <asp:TextBox ID="txtNumber" placeholder="(123) 456-7898" CssClass="form-control" runat="server" Width="100%"></asp:TextBox>
                            </div>
                            <div class="col-md-3 borderRight">
                                <b>Email: </b>
                                <asp:RequiredFieldValidator ID="valEmail" runat="server" ControlToValidate="txtEmail" Display="Dynamic" ErrorMessage="*Email Required*" Font-Bold="False" ForeColor="#CC0000"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="valEmail2" runat="server" ControlToValidate="txtEmail" Display="Dynamic" ErrorMessage="Invalid e-mail format *" Font-Bold="False" ForeColor="#CC0000" ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>

                                <asp:TextBox ID="txtEmail" placeholder="example@domain.com *" MaxLength="50" CssClass="form-control" runat="server" Width="100%"></asp:TextBox>

                                <b>Confirm Email: </b>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtConfirmEmail" Display="Dynamic" ErrorMessage="*Required*" Font-Bold="False" ForeColor="#CC0000"></asp:RequiredFieldValidator>
                                <asp:CompareValidator ID="valConfirmEmail" runat="server" Operator="Equal" Display="Dynamic" ControlToValidate="txtConfirmEmail" ControlToCompare="txtEmail" ErrorMessage="*Emails don't match*" Font-Bold="False" ForeColor="#CC0000"></asp:CompareValidator>
                                <asp:TextBox ID="txtConfirmEmail" placeholder="example@domain.com *" MaxLength="50" CssClass="form-control" runat="server" Width="100%"></asp:TextBox>

                                <b>Current Institution:</b>
                                <asp:RegularExpressionValidator ID="revInstitution" runat="server" Display="Dynamic" ErrorMessage="*Please enter a valid institution.*" ForeColor="#CC0000" ControlToValidate="txtCurrentInstitution" ValidationExpression="[a-zA-Z\s]+"></asp:RegularExpressionValidator>
                                <asp:TextBox ID="txtCurrentInstitution" placeholder="Name of your current school" MaxLength="60" runat="server" CssClass="form-control" Width="100%"></asp:TextBox>

                            </div>
                            <div class="col-md-3 borderRight">
                                <b>Current Major:</b>
                                <asp:RegularExpressionValidator ID="revMajor" runat="server" Display="Dynamic" ErrorMessage="*Please enter a valid major.*" ForeColor="#CC0000" ControlToValidate="txtCurrentMajor" ValidationExpression="[a-zA-Z\s]+"></asp:RegularExpressionValidator>
                                <asp:TextBox ID="txtCurrentMajor" placeholder="Current Major" runat="server" MaxLength="60" CssClass="form-control" Width="100%"></asp:TextBox>

                                <b>Anticipated TU Major:</b>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" Display="Dynamic" ControlToValidate="ddlAnticipatedTUMajor"  ErrorMessage="*Required*" ForeColor="#CC0000" InitialValue="NA"></asp:RequiredFieldValidator>
                                <asp:DropDownList ID="ddlAnticipatedTUMajor" EnableViewState="true" runat="server" CssClass="form-control" Width="100%">
                                </asp:DropDownList>

                                <b>Anticipated Transfer Credits:</b>
                                <asp:RegularExpressionValidator ID="revCredits" runat="server" Display="Dynamic" ErrorMessage="*Please use up to 3 digits.*" ForeColor="#CC0000" ControlToValidate="txtAnticipatedTransferCredits" ValidationExpression="^([0-9]|[1-8][0-9]|9[0-9]|[1-8][0-9]{2}|9[0-8][0-9]|99[0-9])$"></asp:RegularExpressionValidator>
                                <asp:TextBox ID="txtAnticipatedTransferCredits" placeholder="# of credits transferring" MaxLength="3" runat="server" CssClass="form-control" Width="100%"></asp:TextBox>


                            </div>
                            <div class="col-md-3">
                                <b>Anticipated Transfer Term:</b>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="ddlTermName" Display="Dynamic" ErrorMessage="<br />*Term Required*" ForeColor="#CC0000" InitialValue="NA"></asp:RequiredFieldValidator>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="ddlTermYear" Display="Dynamic" ErrorMessage=" *Year Required*" ForeColor="#CC0000" InitialValue="NA"></asp:RequiredFieldValidator>
                                <div class="form-inline">
                                    <asp:DropDownList ID="ddlTermName" runat="server" CssClass="form-control">
                                        <asp:ListItem Value="NA">Select One</asp:ListItem>
                                        <asp:ListItem Value="Fall">Fall</asp:ListItem>
                                        <asp:ListItem Value="Spring">Spring</asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:DropDownList ID="ddlTermYear" runat="server" CssClass="form-control">
                                    </asp:DropDownList>
                                    
                                </div>
                                <b>Associate's Degree:</b>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="ddlAssociates" Display="Dynamic" ErrorMessage="<br />*Associate Status Required*" ForeColor="#CC0000" InitialValue="NA"></asp:RequiredFieldValidator>
                                <asp:DropDownList ID="ddlAssociates" runat="server" CssClass="form-control">
                                    <asp:ListItem Value="NA">Select One</asp:ListItem>
                                    <asp:ListItem Value="Not Pursuing">Not Pursuing</asp:ListItem>
                                    <asp:ListItem Value="In Progress">In Progress</asp:ListItem>
                                    <asp:ListItem Value="Completed">Completed</asp:ListItem>
                                </asp:DropDownList>
                                <b>Are you a PA Resident?</b>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="ddlPAResident" Display="Dynamic" ErrorMessage="<br />*Resident Status Required*" ForeColor="#CC0000" InitialValue="NA"></asp:RequiredFieldValidator>
                                <asp:DropDownList ID="ddlPAResident" runat="server" CssClass="form-control">
                                    <asp:ListItem Value="NA">Select One</asp:ListItem>
                                    <asp:ListItem Value="Yes">Yes</asp:ListItem>
                                    <asp:ListItem Value="No">No</asp:ListItem>
                                </asp:DropDownList>

                            </div>
                        </div>

                    </div>

                </div>

            </div>
            <div class="row">

                <div class="col-md-10 col-md-offset-1">
                    <div class="jumbotron">
                        <b>Questions/Comments:</b><asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txtStudentQuestion" Display="Dynamic" ErrorMessage="<br />*Question/Comment Required*" ForeColor="#CC0000"></asp:RequiredFieldValidator>
                        <br />
                        <br />
                        <div id="test">
                        <asp:TextBox ID="txtStudentQuestion" placeholder="Transfer Questions Here.. *" TextMode="multiline" CssClass="form-control" Width="100%" Rows="6" runat="server" />
                            </div>
                        <div class="form-inline">
                            <div class="g-recaptcha"
                                data-sitekey="6LcoEU0UAAAAAKcuPXgHNBDr4F7ms1nDRZ6mwCw0">
                            </div>
                            <asp:Label ID="lblCaptchaRequired" runat="server" Text="*Captcha Required*" Display="Dynamic" ForeColor="#CC0000" hidden="true"></asp:Label>
                        </div>



                        <br />
                        <asp:Button ID="btnFormSubmit" Text="Complete" runat="server" Style="background-color: #A41E35; color: #FFFFFF" CssClass="btn" ForeColor="#A41E35" OnClick="btnFormSubmit_Click" />&nbsp
                                <div class="modal fade" id="ThankYouModal" role="dialog">
                                    <div class="modal-dialog modal-lg">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                                                <h4 class="modal-title">Thank you for your Submission!</h4>
                                            </div>

                                            <div class="modal-body">
                                                <br />
                                                <p>We have received your submission and will be contacting you shortly about your question!<br />
                                                    An email will be sent to you confirming your submission.<br />
                                                    You will now be redirected to the Temple College of Liberal Arts Website.
                                                </p>

                                            </div>
                                         
                                            <div class="modal-footer">
                                                <button class="btn" data-dismiss="modal" aria-hidden="true">Ok</button>
                                            </div>



                                        </div>

                                    </div>

                                </div>
                        <asp:Label ID="lblSubmitError" runat="server" Text="Email and Confirm Email do not match." Visible="false"></asp:Label>

                        <asp:GridView ID="gvEmail" runat="server">
                        </asp:GridView>




                    </div>

                </div>

            </div>

            <div class="modal fade" id="errorModal" role="dialog">
                <div class="modal-dialog modal-sm">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title">Oops..</h4>
                        </div>

                        <div class="modal-body" style="text-align: center">
                            <b>There was a problem submitting your form.</b><br />
                            <br />
                            Have you submitted using this e-mail address before?<br />
                            <br />
                            Use a different e-mail address and try again.

                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" style="color: black" data-dismiss="modal">OK</button>
                        </div>


                    </div>

                </div>

            </div>

       

            <footer class="footer">
                <div class="container text-center">
                    <span class="text-muted" style="color: white">Copyright 2017 Temple University - All rights reserved<br />
                        <br />
                    </span>
                </div>
            </footer>
        </form>
    </div>


  


    <script>
        $(document).ready(function () {

            $("#txtNumber").mask('(000) 000-0000');


        });


        $("form").submit(function (event) {

            var recaptcha = $("#g-recaptcha-response").val();
            if (recaptcha === "") {
                event.preventDefault();
                //alert("Please check the recaptcha");
                $("#lblCaptchaRequired").show();
            } else {
                $("#lblCaptchaRequired").hide();
            }
        });

        $('#ThankYouModal').on('hide.bs.modal', function () {
          
            window.location.href = "https://liberalarts.temple.edu/";
           
        });

    </script>


</body>
</html>
