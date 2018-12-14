<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="CLATransferSupportSystem.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>TSS Login</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="Content/bootstrap.min.css" />
    <link rel="stylesheet" href="Content/bootstrap-theme.min.css" />

     <style>
        body {
            background-image: url("images/templetree.png");
            background-repeat: no-repeat;
            background-size: cover;
            opacity: 0.97;
        }

        .jumbotron {
            margin: 5px;
        }

   
    </style>

    

</head>
<body style="font-family: Verdana, Geneva, Tahoma, sans-serif; color: #717171">
    <form id="form1" runat="server">
        
        <div class="container-fluid">

            <div class="jumbotron">
                <div class="row">
                    <div class="col-md-5">
                        <a href="http://liberalarts.temple.edu/" class="tumbnail pull-left">
                            <asp:Image ID="cstLogo" runat="server" CssClass="img-responsive" ImageUrl="images/redT_black.png" Height="50px" Width="421px" />
                        </a>                       
                    </div>
                </div>                                                
            </div>
                     
            <div class="row">
                <div id="login-container" class="col-md-3" style="float: none; margin: 0 auto;">
                      <div class="jumbotron">
                    <div class="row">

                        <div class="form-group">
                            <img id="tu-logo" class="img-responsive" src="images/templelogo.png" alt="Temple University" />
                        </div>

                        <div class="form-group">
                            <h4 style="color: #A41E35">Transfer Support System</h4>
                        </div>

                        <div class="form-group">
                            Login with your AccessNet Username and Password:
                        </div>
                        <div class="form-group">
                            <label for="username">Username</label>
                            <%--<input class="form-control" id="username" name="j_username" value="" autofocus="" type="text" />--%>
                            <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" placeholder="Enter TU AccessNet id"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label for="password">Password</label>
                            <%--<input class="form-control" id="password" name="j_password" value="" type="password" />--%>
                            <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" placeholder="Enter password" TextMode="Password"></asp:TextBox>

                        </div>
                        <div class="form-group clearfix">
                            <asp:Button ID="btnLogin" runat="server" CssClass="btn btn-default" Text="Login" ForeColor="#A41E35" OnClick="btnLogin_Click" />                            
                            <asp:Label ID="lblText" runat="server" style="clear: both; width: 100%; text-align: center;" Text=""></asp:Label>
                        </div>
                    </div>
                    <div class="row">
                        <div id="login-footer-left">
                            <a href="//accounts.temple.edu/cgi-bin/accounts.cgi" target="_blank">Forgot Password?</a>
                            
                        </div>
                        </div>
                    </div>
                </div>
            </div>


        </div>


    </form>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js" integrity="sha384-UM1JrZIpBwVf5jj9dTKVvGiiZPZTLVoq4sfdvIe9SBumsvCuv6AHDNtEiIb5h1kU" crossorigin="anonymous"></script>
    <script src="Scripts/bootstrap.min.js"></script>

</body>
</html>
