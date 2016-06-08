<%@ Page Title="" Language="C#" MasterPageFile="~/HomeMaster.master" AutoEventWireup="true" CodeFile="EnquiryForm.aspx.cs" Inherits="EnquiryForm" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <div style="background-color:#FFFFFF; height:500px; margin-left:250px">
          <div class="contact-textarea">
			<table>
                 <tr>
                    <td></td>
                    <td>
                       <span class="internal-header">Enquiry Form</span><br />
            
                    </td>
                </tr>

                <tr>
                    <td>
                        Name:
                    </td>
                    <td>
                        <asp:TextBox ID="txtName" runat="server" Width="300px" ></asp:TextBox>
                    </td>
                </tr>

    
                <tr>
                    
                    <td>
                        Email Address:
                    </td>
                    <td>
                        <asp:TextBox ID="txtEmail" runat="server" Width="300px"  ></asp:TextBox>
                    </td>
                </tr>

    
                <tr>
                    
                    <td>
                        Phone/Mobile:
                    </td>
                    <td>
                        <asp:TextBox ID="txtMobile" runat="server" Width="300px"  ></asp:TextBox>
                    </td>
                </tr>

    
                <tr>
                    
                    <td>
                        Enquiry:
                    </td>
                    <td>
                        <asp:TextBox ID="txtEnquiry" runat="server" Width="300px"  TextMode="MultiLine" ></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td>
                        <asp:Button ID="btnSubmit" runat="server" Text="Submit an enquiry" OnClick="btnSave_Click" />
                    </td>
                </tr>

    
                <tr>
                    <td></td>
                    <td style="color:Green">
                        <asp:Label ID="lblStatus" runat="server"></asp:Label>
                    </td>
                </tr>
            </table>
        </div>
    </div>


</asp:Content>

