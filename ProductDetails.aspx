<%@ Page Title="Product Details" Language="C#" MasterPageFile="~/ProductsMaster.master" AutoEventWireup="true" CodeFile="ProductDetails.aspx.cs" Inherits="ProductDetails" EnableViewStateMac="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script type='text/javascript' src='js/jquery-1.5.1.min.js'></script>  
    <script type='text/javascript' src='js/jquery.jqzoom-core.js'></script>  
        <link rel="stylesheet" type="text/css" href="css/jquery.jqzoom.css" />  
       
<script type="text/javascript">
    $(document).ready(function () {
        $('.jqzoom').jqzoom({
            zoomType: 'standard',
            lens: true,
            preloadImages: false,
            alwaysOn: false,  
            zoomWidth: 500,
            zoomHeight: 350,
            xOffset: 50
        });


    });

</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="catListingPlaceHolder" Runat="Server">



<table width="100%">
    <tr> 
        <td style="width:400px">
            <div class="clearfix" id="content" style="margin-top:40px;margin-left:50px; height:500px;width:300px;" >
                <div class="clearfix">
                    <a href="Product Images/Big1.jpg" class="jqzoom" rel='gal1'  title="">
                        <img src="Product Images/small1.jpg"  title=""  style="border: 4px solid #666;"/>
                    </a>
	                
                </div>
	            <br/>
        
            </div>
        </td>
        <td>
            <table style="margin-top:-239px">
                <tr>
                    <td>
                        <div class="Product-Details">
                            <span class="Product-Details-header">PRODUCT DETAILS</span>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:ListView ID="lvProductDetails" runat="server">
                            <LayoutTemplate>
                                <ul>
                                    <asp:PlaceHolder ID="itemPlaceholder" runat="server"></asp:PlaceHolder>
                                </ul>
                            </LayoutTemplate>
                            <ItemTemplate>
                                <table style="margin-left:-35px; width:540px">
                                    <tr>
                                        <td colspan="2">
                                            <asp:Label ID="lblProductDescription" runat="server" Text='<%# Eval("Description")%>' 
                                                style="word-wrap: break-word;word-break:break-all;" Width="80%" >
                                            </asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                             <br />
                                             <b>Product Code:</b>
                                        </td>
                                        <td style="width:354px">
                                            <asp:HiddenField ID="hdnProduct" runat="server" Value='<%# Eval("ProductID")%>' />
                                            <br />
                                             <asp:Label ID="lblProductCode" runat="server" Text='<%#Eval("ProductCode")%>' 
                                                style="word-wrap: break-word;word-break:break-all;" Width="60%" >
                                            </asp:Label>
                                        </td>
                                    </tr>
                                    <tr id="Discountrow" runat="server">
                                        <td style="display:none">
                                            <asp:Label ID="lblCentDiscount" runat="server" style="word-wrap: break-word;word-break:break-all;"
                                                Text='<%# "Save " + Eval("PercentDisc") + "%" %>'>
                                            </asp:Label>
                                
                                            <asp:Label ID="lblPriceDiscount" runat="server" style="word-wrap: break-word;word-break:break-all;"
                                                Text='<%# "Save Rs." + Eval("PriceDisc")%>'>
                                            </asp:Label>
                                
                                            <asp:Label ID="lblOthers" runat="server" style="word-wrap: break-word;word-break:break-all;"
                                                Text='<%# Eval("Others")%>'>
                                            </asp:Label>
                                        </td>
                                        <td style="display:none">
                                            <asp:Label ID="lblPrice" runat="server" style="word-wrap: break-word;word-break:break-all;"
                                                Text='<%#Eval("NewPrice")%>'>
                                            </asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <asp:Label ID="lblAfterDiscountPrice" runat="server" Text='<%# "Rs. " + Eval("NewPrice")%>' 
                                                style="word-wrap: break-word;word-break:break-all;" Width="80%" CssClass="Product-Details-Price" >
                                            </asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </ItemTemplate>
                        </asp:ListView>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    
</table>

</asp:Content>

