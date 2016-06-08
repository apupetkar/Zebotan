<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AdminLogin.aspx.cs" Inherits="Admin_AdminLogin" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="Admincss.css" rel="stylesheet" type="text/css" />
</head>

<body>
    <form id="form1" runat="server">
    <table width="950" align="center" border="0" cellpadding="0" cellspacing="0" style="border-left: solid 1px #D7D7D7;
        border-right: solid 1px #D7D7D7">
        <tr>
            <td class="header_bg">
                <a href ="adminpanel.aspx" class="logo">
                </a><div class="welcome_text">
                    Welcome to Admin Panel
                </div>
            </td>
        </tr>
        <tr>
            <td class="nev">
                <table class="comman_heading" width="100%" border="0" cellpadding="0" cellspacing="0" style="margin:0 0 0 0">
                    <tr>
                        <td width="100%" align="center">
                            Admin Control Panel
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td align="center" valign="middle" height="400px">
                <table width="350" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td class="log_top_left_cor"></td>
                        <td align="left" valign="middle" class="log_top_bg">Login</td>
                        <td class="log_top_right_cor"></td>
                    </tr>
                    <tr>
                        <td class="log_left_bg"></td>
                        <td bgcolor="#f5f5f5">
                            <asp:Login ID="login" runat="server" width="100%"
                                DestinationPageUrl="~/Admin/AdminPanel.aspx" OnLoggedIn="Login_LoggedIn"
                                OnLoginError="Login_LoginError" OnLoggingIn="Login_LoggingIn">
                                <LayoutTemplate>
                                    <table width="300px" border="0" cellpadding="0" cellspacing="0" align="center"
                                         style="margin-top:20px; margin-bottom:25px">
                                        <tr>
                                            <td class="common_text" align="right" valign="middle" height="30" 
                                                style="padding-right:5px">
                                                <asp:Label ID="lblUserName" runat="server" AssociatedControlID="UserName">Username:</asp:Label>
                                                <span style="color:Red">*</span>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="UserName" runat="server">
                                                </asp:TextBox>
                                            </td>
                                        </tr>  
                                        <tr>
                                            <td colspan="1"></td>
                                            <td valign="middle" align="left">
                                                <asp:RequiredFieldValidator ID="valUsername" runat="server" 
                                                    ControlToValidate="UserName" ErrorMessage="Username is required"
                                                    Display="Dynamic" SetFocusOnError="true" CssClass="validation_text"
                                                    ValidationGroup="Login" >
                                                    </asp:RequiredFieldValidator>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="common_text" align="right" valign="middle" height="30" 
                                                style="padding-right:5px; padding-top:2px">
                                                <asp:Label ID="Label1" runat="server" AssociatedControlID="Password">Password:</asp:Label>
                                                <span style="color:Red">*</span>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="Password" runat="server" TextMode="Password">
                                                </asp:TextBox>
                                            </td>
                                        </tr> 
                                        <tr>
                                            <td colspan="1"></td>
                                            <td valign="middle" align="left">
                                                <asp:RequiredFieldValidator ID="valPassword" runat="server" 
                                                    ControlToValidate="Password" ErrorMessage="Password is required"
                                                    Display="Dynamic" SetFocusOnError="true" CssClass="validation_text"
                                                    ValidationGroup="Login" >
                                                    </asp:RequiredFieldValidator>
                                            </td>
                                        </tr>   
                                        <tr>
                                            <td align="right" valign="middle" height="30" 
                                                style="padding-right:5px; padding-top:2px"></td>
                                            <td>
                                                <asp:Button ID="btnLogin" Text="Login" runat="server" CommandName="Login" 
                                                    ValidationGroup="Login" CssClass="button" OnClick="btnLogin_Click" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="3">
                                                <asp:Literal ID="FailureText" runat="server"></asp:Literal>
                                            </td>
                                        </tr>
                                    </table>
                                </LayoutTemplate>

                            </asp:Login>
                        </td><td class="log_right_bg"></td>
                        </tr>
                        <tr>
                            <td class="log_bot_left_cor"></td>
                            <td class="log_bot_bg"></td>
                            <td class="log_bot_right_cor"></td>
                        </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td align="center" valign="middle" class="footer_bg"><span class="footer_text">Copyright ©2013.</span></td>
        </tr>
    </table>
    </form>
</body>
</html>
