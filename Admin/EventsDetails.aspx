<%@ Page Title="" Language="C#" MasterPageFile="~/HomeMaster.master" AutoEventWireup="true" CodeFile="EventsDetails.aspx.cs" Inherits="EventsDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table>
        <tr>
            <td>
                <asp:Label ID="lblEventName" Text="Event Name:" runat="server">
                </asp:Label>
            </td>
            <td>
                <asp:Label ID="txtEventName" Text="City Centre Mall" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="lblEventDescription" Text="Event Description:" runat="server">
                </asp:Label>
            </td>
            <td>
                <asp:Label ID="txtEventDescription" Text="An Exhibition held in City Centre mall Nashik in the celebration of New Year 2014." runat="server">
                </asp:Label>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <table>
                    <tr>
                        <td>
                           <%-- <asp:Image ID="imgProd" runat="server" AlternateText='<%# Eval("ProductName")%>' 
                            ImageUrl='<%# "../Product Images/" + Eval("ImageName")%>' Height="100px" Width="100px" />--%>
                             <asp:Image ID="imgProd" runat="server" AlternateText="" 
                            ImageUrl="Events/DSC_0382.jpg" Width="400px" Height="250px" />
                           <%-- <img id="img1" src="Events/DSC_0382.jpg"  size=" />--%>
                        </td>
                        <td>
                            <asp:Image ID="Image1" runat="server" AlternateText="" ImageUrl="Events/DSC_0383.jpg" Width="400px" Height="250px" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Image ID="Image2" runat="server" AlternateText="" ImageUrl="Events/DSC_0384.jpg" Width="400px" Height="250px" />
                        </td>
                        <td>
                            <asp:Image ID="Image3" runat="server" AlternateText="" ImageUrl="Events/DSC_0386.jpg" Width="400px" Height="250px" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Image ID="Image4" runat="server" AlternateText="" ImageUrl="Events/DSC_0387.jpg" Width="400px" Height="250px" />
                        </td>
                        <td>
                            <asp:Image ID="Image5" runat="server" AlternateText="" ImageUrl="Events/DSC_0390.jpg" Width="400px" Height="250px" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Image ID="Image6" runat="server" AlternateText="" ImageUrl="Events/DSC_0391.jpg" Width="400px" Height="250px" />
                        </td>
                        <td>
                            <asp:Image ID="Image7" runat="server" AlternateText="" ImageUrl="Events/DSC_0392.jpg" Width="400px" Height="250px" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Image ID="Image8" runat="server" AlternateText="" ImageUrl="Events/DSC_0393.jpg" Width="400px" Height="250px" />
                        </td>
                        <td>
                            <asp:Image ID="Image9" runat="server" AlternateText="" ImageUrl="Events/DSC_0394.jpg" Width="400px" Height="250px" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</asp:Content>

