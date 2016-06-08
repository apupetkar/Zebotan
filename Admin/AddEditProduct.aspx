<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true" CodeFile="AddEditProduct.aspx.cs" Inherits="Admin_AddEditProduct" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<script type="text/javascript">
    function AllowDecimals(e) {

        var evt = (e) ? e : window.event;
        var key = (evt.keyCode) ? evt.keyCode : evt.which;
        if (key != null) {
            key = parseInt(key, 10);
            if ((key < 48 || key > 57) && (key < 96 || key > 105)) {
                if (!jsIsUserFriendlyChar(key, "Decimals")) {
                    return false;
                }
            }
            else {
                if (evt.shiftKey) {
                    return false;
                }
            }

        }
        return true;
    }

    // Function to check for user friendly keys  
    //------------------------------------------
    function jsIsUserFriendlyChar(val, step) {
        // Backspace, Tab, Enter, Insert, and Delete 
        if (val == 8 || val == 9 || val == 13 || val == 45 || val == 46) {
            return true;
        }
        // Ctrl, Alt, CapsLock, Home, End, and Arrows  
        if ((val > 16 && val < 21) || (val > 34 && val < 41)) {
            return true;
        }

        if (val == 110 || val == 46) {  //Check dot key code should not be allowed
            return false;
        }

        if (step == "Decimals") {
            if (val == 190) {  //Check dot key code should be allowed
                var strText;
                strText = document.getElementById("ContentPlaceHolder1_fvProduct_txtPrice").value;

                if (strText.indexOf(".") > 0)
                    return false;

                return true;
            }
        }
        return false;
    }

    function AllowDecimalsPriceDisc(e) {

        var evt = (e) ? e : window.event;
        var key = (evt.keyCode) ? evt.keyCode : evt.which;
        if (key != null) {
            key = parseInt(key, 10);
            if ((key < 48 || key > 57) && (key < 96 || key > 105)) {
                if (!jsIsUserFriendlyChar(key, "Decimals")) {
                    return false;
                }
            }
            else {
                if (evt.shiftKey) {
                    return false;
                }
            }

        }
        return true;
    }

    // Function to check for user friendly keys  
    //------------------------------------------
    function jsIsUserFriendlyChar(val, step) {
        // Backspace, Tab, Enter, Insert, and Delete 
        if (val == 8 || val == 9 || val == 13 || val == 45 || val == 46) {
            return true;
        }
        // Ctrl, Alt, CapsLock, Home, End, and Arrows  
        if ((val > 16 && val < 21) || (val > 34 && val < 41)) {
            return true;
        }

        if (val == 110 || val == 46) {  //Check dot key code should not be allowed
            return false;
        }

        if (step == "Decimals") {
            if (val == 190) {  //Check dot key code should be allowed
                var strText;
                strText = document.getElementById("ContentPlaceHolder1_fvProduct_txtPriceDisc").value;

                if (strText.indexOf(".") > 0)
                    return false;

                return true;
            }
        }
        return false;
    }

    function AllowDecimalsCentDisc(e) {

        var evt = (e) ? e : window.event;
        var key = (evt.keyCode) ? evt.keyCode : evt.which;
        if (key != null) {
            key = parseInt(key, 10);
            if ((key < 48 || key > 57) && (key < 96 || key > 105)) {
                if (!jsIsUserFriendlyChar(key, "Decimals")) {
                    return false;
                }
            }
            else {
                if (evt.shiftKey) {
                    return false;
                }
            }

        }
        return true;
    }

    // Function to check for user friendly keys  
    //------------------------------------------
    function jsIsUserFriendlyChar(val, step) {
        // Backspace, Tab, Enter, Insert, and Delete 
        if (val == 8 || val == 9 || val == 13 || val == 45 || val == 46) {
            return true;
        }
        // Ctrl, Alt, CapsLock, Home, End, and Arrows  
        if ((val > 16 && val < 21) || (val > 34 && val < 41)) {
            return true;
        }

        if (val == 110 || val == 46) {  //Check dot key code should not be allowed
            return false;
        }

        if (step == "Decimals") {
            if (val == 190) {  //Check dot key code should be allowed
                var strText;
                strText = document.getElementById("ContentPlaceHolder1_fvProduct_txtPercentDisc").value;

                if (strText.indexOf(".") > 0)
                    return false;

                return true;
            }
        }
        return false;
    }

    function AllowDecimalsOtherDisc(e) {

        var evt = (e) ? e : window.event;
        var key = (evt.keyCode) ? evt.keyCode : evt.which;
        if (key != null) {
            key = parseInt(key, 10);
            if ((key < 48 || key > 57) && (key < 96 || key > 105)) {
                if (!jsIsUserFriendlyChar(key, "Decimals")) {
                    return false;
                }
            }
            else {
                if (evt.shiftKey) {
                    return false;
                }
            }

        }
        return true;
    }

    // Function to check for user friendly keys  
    //------------------------------------------
    function jsIsUserFriendlyChar(val, step) {
        // Backspace, Tab, Enter, Insert, and Delete 
        if (val == 8 || val == 9 || val == 13 || val == 45 || val == 46) {
            return true;
        }
        // Ctrl, Alt, CapsLock, Home, End, and Arrows  
        if ((val > 16 && val < 21) || (val > 34 && val < 41)) {
            return true;
        }

        if (val == 110 || val == 46) {  //Check dot key code should not be allowed
            return false;
        }

        if (step == "Decimals") {
            if (val == 190) {  //Check dot key code should be allowed
                var strText;
                strText = document.getElementById("ContentPlaceHolder1_fvProduct_txtOtherDisc").value;

                if (strText.indexOf(".") > 0)
                    return false;

                return true;
            }
        }
        return false;
    }
</script>

<table width="720px" border="0" cellpadding="0" cellspacing="0">
     <tr>
        <td class="common_text">
        
            <asp:FormView ID="fvProduct" runat="server" DefaultMode="Insert" Width="100%">
                
                <InsertItemTemplate>
                <table width="520px" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td></td>
                        <td colspan="2" align="left">
                            <font color="red">
                                <asp:Label ID="Label1" runat="server" Text="* indicates required field."></asp:Label>
                            </font>
                        </td>
                    </tr>
                    <tr>
                        <td style="width:150px">
                            <asp:Label ID="lblProductName" runat="server" Text="Product Name:"></asp:Label><font color="red">*</font>
                        </td>
                        <td style="width:370px; padding-bottom:5px">
                            <asp:TextBox ID="txtProductName" runat="server" MaxLength="50" Text=""></asp:TextBox>
                            <br />
                            <font color="red">
                                <asp:RequiredFieldValidator ID="rfvProductName" runat="server" ControlToValidate="txtProductName" 
                                    Display="Dynamic" ValidationGroup="Add" ErrorMessage="Product Name is required">
                                </asp:RequiredFieldValidator>
                            </font>
                        </td>
                        <td rowspan="12" align="right">
                                <%--<asp:Image ID="Image1" runat="server" AlternateText='<%# Eval("ProductName")%>' 
                            ImageUrl='<%# "../Product Images/" + Eval("ImageName")%>' Height="375px" Width="250px" />--%>
                        </td>
                    </tr>
                    
                    <tr>
                        <td>
                            <asp:Label ID="lblProductCode" runat="server" Text="Product Code:"></asp:Label><font color="red">*</font>
                        </td>
                        <td style="padding-bottom:5px">
                            <asp:TextBox ID="txtProductCode" runat="server" MaxLength="50" Text=""></asp:TextBox>
                            <br />
                            <font color="red">
                                <asp:RequiredFieldValidator ID="rfvProductCode" runat="server" ControlToValidate="txtProductCode" 
                                    Display="Dynamic" ValidationGroup="Add" ErrorMessage="Product Code is required">
                                </asp:RequiredFieldValidator>
                            </font>
                        </td>
                        <td></td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblDescription" runat="server" Text="Description:"></asp:Label><font color="red">*</font>
                        </td>
                        <td>
                            <asp:TextBox ID="txtDescription" runat="server" TextMode ="MultiLine" Width="330px" Height="75px"></asp:TextBox>
                            <br />
                            <font color="red">
                            <asp:RequiredFieldValidator ID="rfvDescription" runat="server" ControlToValidate="txtDescription" 
                                Display="Dynamic" ValidationGroup="Add" ErrorMessage="Product Description is required">
                            </asp:RequiredFieldValidator>
                            </font>
                        </td>
                        <td></td>
                    </tr>
                   
                    <tr>
                        <td>
                            <asp:Label ID="lblProdImg" runat="server" Text="Product Image:"></asp:Label><font color="red">*</font>
                        </td>
                        <td style="padding-bottom:5px">
                            <asp:FileUpload ID="fuProductImg" runat="server" Width="235px" />
                        </td>
                        <td></td>
                    </tr>
                    <tr>
                        <td></td>
                        <td align="left" style="color:Red">
                            <asp:RequiredFieldValidator ID="rfvFile" runat="server" ControlToValidate="fuProductImg" 
                                Display="Dynamic" ValidationGroup="Add" ErrorMessage="Product image is required">
                            </asp:RequiredFieldValidator>
                        </td>
                        <td></td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblCat" runat="server" Text="Category:"></asp:Label><font color="red">*</font>
                        </td>
                        <td style="padding-bottom:5px">
                            <asp:DropDownList ID="ddlCat" runat="server" DataTextField="CategoryName" DataValueField="CategoryID" AppendDataBoundItems="true" Width="152px"
                                DataSourceID="sdsCat" AutoPostBack="true" OnSelectedIndexChanged="ddlCat_SelectedIndexChanged">
                                <asp:ListItem Text="Select" Value="0"></asp:ListItem></asp:DropDownList>
                            <asp:SqlDataSource ID="sdsCat" runat="server" ConnectionString='<%$ ConnectionStrings:strconn %>'
                                SelectCommand="r_Category_Select" SelectCommandType="StoredProcedure">
                            </asp:SqlDataSource>
                            <br />
                            <font color="red">
                                 <asp:RequiredFieldValidator ID="rfvCat" runat="server" ControlToValidate="ddlCat" InitialValue="0"
                                    Display="Dynamic" ValidationGroup="Add" ErrorMessage="Category is required">
                                </asp:RequiredFieldValidator>
                            </font>
                        </td>
                        <td></td>
                    </tr>

                    <tr>
                        <td>
                            <asp:Label ID="lblSubCat" runat="server" Text="Sub Category:"></asp:Label><font color="red">*</font>
                        </td>
                        <td style="padding-bottom:5px">
                           <asp:DropDownList ID="ddlSubCat" runat="server" AppendDataBoundItems="true" Width="152px">
                                <asp:ListItem Text="Select" Value="0"></asp:ListItem>
                           </asp:DropDownList>
                           <%-- <asp:SqlDataSource ID="sdsCategory" runat="server" ConnectionString="<%$ ConnectionStrings:strconn %>"
                                SelectCommand="r_SubCategory_Select" SelectCommandType="StoredProcedure"  >
                            </asp:SqlDataSource>--%>
                            <br />
                            <font color="red">
                                 <asp:RequiredFieldValidator ID="rfvSubCat" runat="server" ControlToValidate="ddlSubCat" InitialValue="0"
                                    Display="Dynamic" ValidationGroup="Add" ErrorMessage="Sub Category is required">
                                </asp:RequiredFieldValidator>
                            </font>
                        </td>
                        <td></td>
                    </tr>
                   
                    <tr>
                        <td>
                            <asp:Label ID="lblOccasions" runat="server" Text="Occasions:"></asp:Label><font color="red">*</font>
                        </td>
                        <td style="padding-bottom:5px">
                            <asp:DropDownList ID="ddlOccasion" runat="server" AppendDataBoundItems="true" Width="152px">
                                <asp:ListItem Text="Select" Value="0"></asp:ListItem>
                            </asp:DropDownList>
                           <%--<asp:CheckBoxList ID="chkOccasions" runat="server" DataSourceID="sdsOccasions"
                            DataTextField="Occasion" DataValueField="OccasionID" RepeatDirection="Horizontal"
                                RepeatColumns="5"></asp:CheckBoxList>--%>
                           <%-- <asp:SqlDataSource ID="sdsOccasions" runat="server" ConnectionString='<%$ ConnectionStrings:strconn %>'
                                SelectCommand="r_Occasions_Select" SelectCommandType="StoredProcedure">
                            </asp:SqlDataSource>--%>
                            <br />
                            <font color="red">
                                <asp:RequiredFieldValidator ID="rfvOccasion" runat="server" ControlToValidate="ddlOccasion" InitialValue="0"
                                    Display="Dynamic" ValidationGroup="Add" ErrorMessage="Occasion is required">
                                </asp:RequiredFieldValidator>
                            </font>
                        </td>
                        <td>
                        </td>
                    </tr>
                    
                    <tr>
                        <td>
                            <asp:Label ID="lblIsNewArrival" runat="server" Text="Is this new arrival?"></asp:Label>
                        </td>
                        <td style="padding-bottom:5px">
                           <asp:CheckBox ID="chkIsNewArrival" runat="server"></asp:CheckBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblProductPrice" runat="server" Text="Price"></asp:Label>
                        </td>
                        <td style="padding-bottom:5px">
                           <asp:TextBox ID="txtPrice" runat="server" onkeydown="return AllowDecimals(event)" MaxLength="6"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblDiscount" runat="server" Text="Is Discount available?"></asp:Label>
                        </td>
                        <td style="padding-bottom:5px">
                            <asp:CheckBox ID="chkIsDiscounted" runat="server" Text="" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                        </td>
                        <td>
                            <table width="250px">
                                <tr>
                                    <td>
                                        <asp:Label ID="lblPriceDisc" runat="server" Text="Price: "></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblTxtPercentDisc" runat="server" Text="Percentage: "></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblTxtOtherDisc" runat="server" Text="Other: "></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width:15px">
                                        <asp:TextBox ID="txtPriceDisc" runat="server" onkeydown="return AllowDecimalsPriceDisc(event)" 
                                                MaxLength="6" Width="70px"></asp:TextBox> Rs. Off
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtPercentDisc" runat="server" onkeydown="return AllowDecimalsCentDisc(event)" 
                                                MaxLength="6" Width="70px"></asp:TextBox> %
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtOtherDisc" runat="server" onkeydown="return AllowDecimalsOtherDisc(event)" 
                                                MaxLength="6" Width="150px" style="margin-top:-15px"></asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                           
                        </td>
                      
                    </tr>
                    <tr>
                        <td></td>
                        <td colspan="2">
                            <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" 
                                CssClass="button" ValidationGroup="Add" />
                        
                            <asp:Button ID="btnCancel" runat="server" Text="Cancel" 
                            CssClass="button" PostBackUrl="~/Admin/ManageProduct.aspx" />
                        </td>
                    </tr>
                </table>
            </InsertItemTemplate>

            <EditItemTemplate>
                <table width="100%" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td></td>
                        <td colspan="2" align="left">
                            <font color="red">
                                <asp:Label ID="Label1" runat="server" Text="* indicates required field."></asp:Label>
                            </font>
                        </td>
                       
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblProductName" runat="server" Text="Product Name:"></asp:Label><font color="red">*</font>
                        </td>
                        <td style="width:370px">
                            <asp:TextBox ID="txtProductName" runat="server" MaxLength="50" Text='<%# Eval("ProductName") %>'></asp:TextBox>
                            <br />
                            <font color="red">
                            <asp:RequiredFieldValidator ID="rfvProductName" runat="server" ControlToValidate="txtProductName" 
                                Display="Dynamic" ValidationGroup="Edit" ErrorMessage="Product Name is required">
                            </asp:RequiredFieldValidator>
                            </font>
                        </td>
                        <td rowspan="12" align="right">
                                <asp:Image ID="Image1" runat="server" AlternateText='<%# Eval("ProductName")%>' 
                            ImageUrl='<%# "../Product Images/" + Eval("ImageName")%>' Height="375px" Width="250px" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblProductCode" runat="server" Text="Product Code:"></asp:Label><font color="red">*</font>
                        </td>
                        <td>
                            <asp:TextBox ID="txtProductCode" runat="server" MaxLength="50" Text='<%# Eval("ProductCode") %>'></asp:TextBox>
                            <br />
                            <font color="red">
                            <asp:RequiredFieldValidator ID="rfvProductCode" runat="server" ControlToValidate="txtProductCode" 
                                Display="Dynamic" ValidationGroup="Edit" ErrorMessage="Product Code is required">
                            </asp:RequiredFieldValidator>
                            </font>
                        </td>
                        <td></td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblDescription" runat="server" Text="Description:"></asp:Label><font color="red">*</font>
                        </td>
                        <td>
                            <asp:TextBox ID="txtDescription" runat="server" Text='<%# Eval("Description") %>' TextMode ="MultiLine" Width="330px" Height="75px"></asp:TextBox>
                            <br />
                            <font color="red">
                            <asp:RequiredFieldValidator ID="rfvDescription" runat="server" ControlToValidate="txtDescription" 
                                Display="Dynamic" ValidationGroup="Edit" ErrorMessage="Product Description is required">
                            </asp:RequiredFieldValidator>
                            </font>
                        </td>
                        <td></td>
                    </tr>

                    <tr>
                        <td>
                            <asp:Label ID="lblProdImg" runat="server" Text="Product Image:"></asp:Label><font color="red">*</font>
                        </td>
                        <td>
                            <asp:FileUpload ID="fuProductImg" runat="server"  />
                        </td>
                         
                        <td align="left" style="color:Red">
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblCat" runat="server" Text="Category:"></asp:Label><font color="red">*</font>
                        </td>
                        <td>
                           <asp:DropDownList ID="ddlCat" runat="server" AppendDataBoundItems="true" DataTextField="CategoryName" DataValueField="CategoryID" 
                            DataSourceID="sdsCat"  selectedvalue='<%# Bind("CategoryID") %>'
                             AutoPostBack="true" OnSelectedIndexChanged="ddlCat_SelectedIndexChanged"><asp:ListItem Text="Select" Value="0"></asp:ListItem></asp:DropDownList>
                            <asp:SqlDataSource ID="sdsCat" runat="server" ConnectionString='<%$ ConnectionStrings:strconn %>'
                                SelectCommand="r_Category_Select" SelectCommandType="StoredProcedure">
                            </asp:SqlDataSource>
                            <br />
                            <font color="red">
                                <asp:RequiredFieldValidator ID="rfvCat" runat="server" ControlToValidate="ddlCat" Display="Dynamic" ValidationGroup="Edit" 
                                    ErrorMessage="Category is required" SetFocusOnError="true" InitialValue="0">
                                </asp:RequiredFieldValidator>
                            </font>
                        </td>
                        <td></td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblSubCat" runat="server" Text="Sub Category:"></asp:Label><font color="red">*</font>
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlSubCat" runat="server" AppendDataBoundItems="true">
                                <asp:ListItem Text="Select" Value="0"></asp:ListItem>
                            </asp:DropDownList>
                           <%-- <asp:SqlDataSource ID="sdsCategory" runat="server" ConnectionString="<%$ ConnectionStrings:strconn %>"
                                SelectCommand="r_SubCategory_Select" SelectCommandType="StoredProcedure"  >
                            </asp:SqlDataSource>--%>
                            <br />
                            <font color="red">
                                <asp:RequiredFieldValidator ID="rfvSubCat" runat="server" ControlToValidate="ddlSubCat" Display="Dynamic" ValidationGroup="Edit" 
                                    ErrorMessage="Sub Category is required" SetFocusOnError="true" InitialValue="0">
                                </asp:RequiredFieldValidator>
                            </font>

                           <%-- <asp:SqlDataSource ID="sdsSubCat" runat="server" ConnectionString='<%$ ConnectionStrings:strconn %>'
                                SelectCommand="r_SubCategoryMst_Select" SelectCommandType="StoredProcedure">
                                <SelectParameters><asp:ControlParameter ControlID="ddlCat" Name="CategoryID" PropertyName="DataValueField"
                                        ConvertEmptyStringToNull="false" /></SelectParameters>
                            </asp:SqlDataSource>--%>
                        </td>
                        <td></td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblOccasions" runat="server" Text="Occasions:"></asp:Label><font color="red">*</font>
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlOccasion" runat="server" 
                                AutoPostBack="true" AppendDataBoundItems="true">
                                    <asp:ListItem  Text="Select" Value="0"></asp:ListItem>
                            </asp:DropDownList>
                          <%--  <asp:SqlDataSource ID="sdsOccasions" runat="server" ConnectionString='<%$ ConnectionStrings:strconn %>'
                                SelectCommand="r_Occasions_Select" SelectCommandType="StoredProcedure">
                            </asp:SqlDataSource>--%>
                            <br />
                            <font color="red">
                                <asp:RequiredFieldValidator ID="rfvOccasions" runat="server" ControlToValidate="ddlOccasion" Display="Dynamic" ValidationGroup="Edit" 
                                    ErrorMessage="Occasion is required" SetFocusOnError="true" InitialValue="0">
                                </asp:RequiredFieldValidator>
                            </font>
                        </td>
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblIsNewArrival" runat="server" Text="Is this new arrival?"></asp:Label>
                        </td>
                        <td>
                           <asp:CheckBox ID="chkIsNewArrival" runat="server" Checked='<%# Eval("IsNewArrival").ToString()=="1"?true:false %>'></asp:CheckBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblProductPrice" runat="server" Text="Price:"></asp:Label><font color="red">*</font>
                        </td>
                        <td>
                           <asp:TextBox ID="txtPrice" runat="server" Text='<%# Eval("Price").ToString() %>'
                                onkeydown="return AllowDecimals(event)" MaxLength="6"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblDiscount" runat="server" Text="Is Discount available?"></asp:Label>
                        </td>
                        <td>
                            <asp:CheckBox ID="chkIsDiscounted" runat="server" Checked='<%# Eval("IsDiscounted") %>' />
                        </td>
                    </tr>
                    <tr>
                        <td>
                        </td>
                        <td>
                            <table width="250px">
                                <tr>
                                    <td>
                                        <asp:Label ID="lblPriceDisc" runat="server" Text="Price: "></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblTxtPercentDisc" runat="server" Text="Percentage: "></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblTxtOtherDisc" runat="server" Text="Other: " ></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width:15px">
                                        <asp:TextBox ID="txtPriceDisc" runat="server" Text='<%# Eval("PriceDisc") %>'
                                            onkeydown="return AllowDecimalsPriceDisc(event)" MaxLength="6" Width="70px"></asp:TextBox> Rs. Off
                                    </td>

                                    <td>
                                        <asp:TextBox ID="txtPercentDisc" runat="server" Text='<%# Eval("PercentDisc") %>'
                                            onkeydown="return AllowDecimalsCentDisc(event)" MaxLength="6" Width="70px" ></asp:TextBox> %
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtOtherDisc" runat="server" Text='<%# Eval("Others") %>' 
                                            onkeydown="return AllowDecimalsOtherDisc(event)" MaxLength="6" Width="150px" style="margin-top:-15px"></asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                           
                        </td>
                        
                    </tr>
                    <tr>
                        <td></td>
                        <td colspan="2">
                            <asp:Button ID="btnUpdate" runat="server" Text="Update" OnClick="btnUpdate_Click" CssClass="button" ValidationGroup="Edit" />
                       
                            <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="button" PostBackUrl="~/Admin/ManageProduct.aspx" />
                        </td>
                    </tr>
                </table>
                </EditItemTemplate>
            </asp:FormView>
    
        </td>
    </tr>
     <tr>
        <td>
            <asp:HiddenField ID="hdnProductID" runat="server" />
            <asp:HiddenField ID="hdnImageName" runat="server" />
        </td>
    </tr>
</table>


</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder11" Runat="Server">
</asp:Content>

