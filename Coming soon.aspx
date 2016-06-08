<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Coming soon.aspx.cs" Inherits="Coming_soon" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">

<head id="Head1" runat="server">
    <title>Zebo-tan - women wear</title>
    <link href="css/styles.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <div style="height:100%; margin:auto; width:1000px">
        <div style="height:300px; margin:auto; width:800px; background-color:#51650C; padding-top:50px;  margin-top:50px;">
           <div style="float:left; height:150px; margin-left:10px; width:295px; margin-top:-50px"><img src="images/logo.png" border="0" /></div>
           <br />
           <div style="padding-left:100px; padding-top:50px; margin-top:40px; font-family:Monotype Corsiva; font-size:20px; color:#ffffff">
            Coming soon!!! The Fashion site for Womens with Indian ethnic wear ranging from <br>bridal fashion couture to traditional Indian wear and trendy collection.
            <br />
            <br />
            <%--Don't Wait, just Signup below and will be notified when Zebotan is ready to launch...!!!--%>
            <br />
            <asp:TextBox ID="txtEmail" runat="server" Width="230px" Visible="false"></asp:TextBox>
            <asp:Button ID="btnNotify" runat="server" Text="Notify Me" BackColor="#566E00" BorderColor="#181818" ForeColor="#FFFFFF" Visible="false"
                   onclick="btnNotify_Click" />
                   <br />
                   <br />
            <asp:Label ID="lblMsg" runat="server" Text=""></asp:Label>
            <asp:HiddenField ID="hdnMsg" runat="server" />
            </div>
        </div> <!-- end of work area -->
    </div> <!-- end of main area -->
    </form>
</body>
</html>
