<%@ Page Language="C#" MasterPageFile="~/ProductsMaster.master" AutoEventWireup="true" CodeFile="ProductsList.aspx.cs" Inherits="ProductsList" %>

<asp:Content ContentPlaceHolderID="catListingPlaceHolder" ID="content1" runat="server">
    <script type="text/javascript" src="js/jquery.min.js">
    </script>
 
    <script type="text/javascript" >
        var jq12 = $.noConflict();
        function togglecat() {
            jq12("#panelcat").slideToggle("slow");
        }

        function togglesubcat() {
            jq12("#panelsubcat").slideToggle("slow");
        }

        function toggleOccasion() {
            jq12("#panelocccasion").slideToggle("slow");
        }

        function pop(div) {
	    document.getElementById("pop1").style.top = (document.body.scrollTop + document.documentElement.scrollTop)+"px";   
            jq12("body").css("overflow", "hidden");
            document.getElementById(div).style.display = 'block';
            return false
        }
        function hide(div) {
            jq12("body").css("overflow", "auto");
            document.getElementById(div).style.display = 'none';
            return false
        }
    </script>
    
    
    <div id="pop1" class="parentDisable">
        <div id="tooltip">
        <div style="float: center; margin-left: 5px;">
            <b>Wanna Buy ?</b><span style="float:right;padding-right:5px"><a style="color: Black; font-size: 12px; font-family:Verdana; font-weight: bolder;" href="javascript:void(0);" onclick="return hide('pop1')">X</a></span>
        </div>
        <div style="clear: both;">
        </div>
        <div style="float: left; margin-right: 5px; margin-left: 5px; margin-top: 0px;">
            <div class="pic-box31">
                <span style="font-weight:bold; font-style:italic; text-align:center">Bahar Pathan</span>
                <br />
                <span style="font:10px; text-align:center">Row House No. 107,</span>
                <br />
                <span style="font:10px; text-align:center">Pride Monarch Apartment,</span>
                <br />
                <span style="font:10px; text-align:center">Jaybhai Colony</span>
                <br />
                <span style="text-align:center">Behind Big Bazaar</span>
                <br />
                <span style="text-align:center">Nashik Road,</span>
                <br />
                <span style="text-align:center">Nashik- 01</span>
                <br />
                <span><b>Cell:</b> +91 9923833023 </span><br />
                <span><b>Email:</b> bahar@zebotan.com</span>
            </div>
        </div>
       </div>
    </div>

    <div style="width:950px">
        <div style="float:left; width:225px"> <%-- Left categories section starts here --%>
            <table>
                <tr>
                    <td>
                        <div id="middle_page">
                            <div id="middle_con2">
                                 <div id="middle_left_con2">
                                    <div class="indemandtopic" style="float:left">
                                       <div class="searchbox">
                                            <span>Search</span>
                                        </div>
                                        
                                        <a ID="lnkCat" runat="server" class="heading_box1" onclick="togglecat()" >Category</a>
                                                                                 
                                        <div id="panelcat">
                                            <asp:CheckBoxList ID="chkListCat" runat="server" RepeatDirection="Vertical" 
                                            DataSourceID="sdsCat" DataTextField="CategoryName" DataValueField="CategoryID" AutoPostBack="true" 
                                                CssClass="dl" onselectedindexchanged="chkListCat_SelectedIndexChanged">
                                            </asp:CheckBoxList>
                                            <asp:SqlDataSource ID ="sdsCat"  runat ="server" 
                                                ConnectionString ="<%$ ConnectionStrings:strconn %>"
                                                CancelSelectOnNullParameter="False"                           
                                                SelectCommand ="r_Category_Select" 
                                                SelectCommandType ="StoredProcedure">
                                            </asp:SqlDataSource>
                                        </div>

                                        <a ID="lnkSubCat" runat="server" class="heading_box1" onclick="togglesubcat()">Sub Category</a>
                                        <div id="panelsubcat">
                                            <asp:CheckBoxList ID="chkListSubCat" runat="server" RepeatDirection="Vertical" AutoPostBack="true"
                                            DataSourceID="sdsSubCat" DataTextField="CategoryName" DataValueField="CategoryID" CssClass="dl"
                                            OnSelectedIndexChanged="chkListSubCat_SelectedIndexChanged">
                                            </asp:CheckBoxList>
                                            <asp:SqlDataSource ID ="sdsSubCat"  runat ="server" 
                                                ConnectionString ="<%$ ConnectionStrings:strconn %>"
                                                CancelSelectOnNullParameter="False"                           
                                                SelectCommand ="r_SubCategory_Select" 
                                                SelectCommandType ="StoredProcedure">
                                            </asp:SqlDataSource>
                                        </div>

                                       <a ID="lnkoccasion" runat="server" class="heading_box1" onclick="toggleOccasion()">Occasion</a>
                                                                                 
                                        <div id="panelocccasion">
                                            <asp:CheckBoxList ID="chkListOcc" runat="server" RepeatDirection="Vertical" AutoPostBack="true"
                                            DataSourceID="sdsOccasion" DataTextField="Occasion" DataValueField="OccasionID" CssClass="dl"
                                            OnSelectedIndexChanged="chkListOcc_SelectedIndexChanged">
                                            </asp:CheckBoxList>
                                            <asp:SqlDataSource ID ="sdsOccasion"  runat ="server" 
                                                ConnectionString ="<%$ ConnectionStrings:strconn %>"
                                                CancelSelectOnNullParameter="False"                           
                                                SelectCommand ="r_Occasions_Select" 
                                                SelectCommandType ="StoredProcedure">
                                            </asp:SqlDataSource>
                                        </div>
                                    </div>
                            
                                    <asp:HiddenField ID="hdnUserId" runat="server" />
                                 </div>
                                 <div id="middle_right_con2">
                                 </div>
                            </div>
                        </div>
                    </td>
                </tr>
            </table>
        </div> <%-- Left categories section ends here --%>
        
        <div style="float:left; width:725px; height:100%"><%-- Right products section starts here --%>
            <table>
                <tr>
                    <td>
                        <asp:ListView ID="lvProduct" runat="server" OnItemCommand="lvProduct_ItemCommand" >
                            <LayoutTemplate>
                                <ul class="productlist">
                                    <asp:PlaceHolder ID="itemPlaceholder" runat="server"></asp:PlaceHolder>
                                </ul>
                            </LayoutTemplate>
                            <ItemTemplate>
                                <li>
                                    <asp:HiddenField ID="hdnProduct" runat="server" Value='<%# Eval("ProductID")%>' />

                                    <small id="newarrival" runat="server" class="offer-out">
                                     <asp:Label ID="Label1" runat="server" Text="New" Visible='<%# Eval("IsNewArrival")%>'
                                            style="word-wrap: break-word;word-break:break-all;" Width="80%" CssClass="offer-in newformat newformattxt" >
                                    </asp:Label>
                                    <asp:Label ID="Label2" runat="server"  Text="Discounted" Visible='<%# Eval("IsDiscounted")%>'
                                            style="word-wrap: break-word;word-break:break-all;" Width="90%" CssClass="offer-in newformat newformattxt" >
                                    </asp:Label>
                                       <%-- <small class="offer-in txt-up clr-fff fs11">New</small>--%>
                                    </small>
                                    <asp:ImageButton ID="btnImgProd" runat="server" ImageUrl='<%# "Product Images/" + Eval("ImageName")%>' 
                                        Height="260px" Width="200px"/>
                                    
                                    <br />
                                    <asp:Label ID="lblProductCode" runat="server" Text='<%# "Code: " + Eval("ProductCode")%>' 
                                            style="word-wrap: break-word;word-break:break-all;" Width="80%" >
                                    </asp:Label>
                                    <br />
                                    <asp:Label ID="lblPrice" runat="server" style="word-wrap: break-word;word-break:break-all;"
                                     Text='<%# "Price: " + Eval("NewPrice")%>'></asp:Label>
                                    <br />
                                    <a href="#" onclick="return pop('pop1')" style="text-decoration:underline">Wanna Buy?</a>
                                </li>
                            </ItemTemplate>
                        </asp:ListView>
                    </td>
                </tr>
                <tr>
                    <td align="left" style="padding-left:40px;">
                        <div class="pagerStyle" style="padding-right:15px;text-align:center">
                           
                            <asp:Repeater ID="rptPager" runat="server">
                                <ItemTemplate>
                                    <asp:LinkButton ID="lnkPage" runat="server" Text = '<%#Eval("Text") %>' CommandArgument = '<%# Eval("Value") %>' 
                                    Enabled = '<%# Eval("Enabled") %>' OnClick = "Page_Changed"></asp:LinkButton>
                                </ItemTemplate>
                            </asp:Repeater>
                        </div>
                        <asp:HiddenField ID="hdnPageNo" runat="server" />
                    </td>
                </tr>
            </table>
        </div> <%-- Right products section ends here --%>
    </div>
</asp:Content>