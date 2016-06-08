<%@ Page EnableEventValidation="false" Title="" Language="C#" MasterPageFile="AdminMaster.master" 
AutoEventWireup="true" CodeFile="ManageProduct.aspx.cs" Inherits="ManageProduct" %>

<asp:Content ID="content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%--<link rel="Stylesheet" href="../css/wcss.css" type="text/css" />--%>
   <%-- <h3>Products</h3>--%>
   <%-- <div>
        <asp:DropDownList ID="ddlCat" runat="server" AutoPostBack="true" DataSourceID="sdsCat" DataTextField="CategoryName" 
            DataValueField="CategoryID" OnSelectedIndexChanged="ddlCat_SelectedIndexChanged" AppendDataBoundItems="true">
            <asp:ListItem Text="Select" Value="0"></asp:ListItem>
        </asp:DropDownList>
        <asp:SqlDataSource ID="sdsCat" runat="server" ConnectionString='<%$ ConnectionStrings:strconn %>'
            SelectCommand="r_CategoryMst_Select" SelectCommandType="StoredProcedure">
        </asp:SqlDataSource>

        <asp:DropDownList ID="ddlSubCat" runat="server" AutoPostBack="true" AppendDataBoundItems="true">
            <asp:ListItem Text="Select" Value="0"></asp:ListItem>
        </asp:DropDownList>
        <asp:DropDownList ID="ddlOccassion" runat="server" AutoPostBack="true" AppendDataBoundItems="true">
            <asp:ListItem  Text="Select" Value="0"></asp:ListItem>
        </asp:DropDownList>
        <asp:Label ID="lblProductName" runat="server" Text="Product"></asp:Label>
        <asp:TextBox ID="txtProductName" runat="server"></asp:TextBox>
        <asp:Button ID="btnGetProducts" runat="server" OnClick="btnGetProducts_Click" Text="Search" CssClass="button"/>
        <asp:Button ID="btnAddNewProduct" runat="server" Text="Add New Product" 
                            OnClick="btnAddNewProduct_Click" CssClass="button" />
    </div>--%>
   

<table width="720px" border="0" cellpadding="1" cellspacing="0">
    <tr>
        <td class="common_text">
            <table width="100%" >
                <tr>
                    <td>
                         <asp:Label ID="Label3" runat="server" Text="Category"></asp:Label>
                    </td>
                    <td>
                         <asp:Label ID="Label2" runat="server" Text="SubCategory"></asp:Label>
                    </td>
                    <td>
                         <asp:Label ID="Label1" runat="server" Text="Occasion"></asp:Label>
                    </td>
                    <td>
                         <asp:Label ID="lblProductName" runat="server" Text="Product"></asp:Label>
                    </td>
                    
                </tr>
                <tr>
                    <td style="width:5%">
                        <asp:DropDownList ID="ddlCat" runat="server" AutoPostBack="true" DataSourceID="sdsCat" DataTextField="CategoryName" 
                            DataValueField="CategoryID" OnSelectedIndexChanged="ddlCat_SelectedIndexChanged" AppendDataBoundItems="true">
                            <asp:ListItem Text="Select" Value="0"></asp:ListItem>
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="sdsCat" runat="server" ConnectionString='<%$ ConnectionStrings:strconn %>'
                            SelectCommand="r_Category_Select" SelectCommandType="StoredProcedure">
                        </asp:SqlDataSource>
                    </td>
                    <td style="width:5%">
                        <asp:DropDownList ID="ddlSubCat" runat="server" AutoPostBack="true" AppendDataBoundItems="true" Width="100px"
                            DataSourceID="sdsSubCat" DataTextField="CategoryName" DataValueField="CategoryID">
                            <asp:ListItem Text="Select" Value="0"></asp:ListItem>
                        </asp:DropDownList>
                        
                       <asp:SqlDataSource ID="sdsSubCat" runat="server" ConnectionString='<%$ ConnectionStrings:strconn %>'
                                SelectCommand="r_SubCategory_Select" SelectCommandType="StoredProcedure">
                            
                        </asp:SqlDataSource>
                    </td>
                    <td style="width:5%">
                        <asp:DropDownList ID="ddlOccassion" runat="server" AutoPostBack="true" AppendDataBoundItems="true" Width="100px"
                             DataSourceID="sdsOccasions" DataTextField="Occasion" DataValueField="OccasionID">
                            <asp:ListItem  Text="Select" Value="0"></asp:ListItem>
                        </asp:DropDownList>

                         <asp:SqlDataSource ID="sdsOccasions" runat="server" ConnectionString='<%$ ConnectionStrings:strconn %>'
                            SelectCommand="r_Occasions_Select" SelectCommandType="StoredProcedure">
                        </asp:SqlDataSource>
                    </td>
                    <td style="width:10%">
                         <asp:TextBox ID="txtProductName" runat="server"></asp:TextBox>
                    </td>
                    <td style="width:10%" align="right">
                        <asp:Button ID="btnGetProducts" runat="server" OnClick="btnGetProducts_Click" Text="Search" CssClass="button"/>
        
                    </td>
                    <td style="width:2%" align="right">
                        <asp:Button ID="btnAddNewProduct" runat="server" Text="Add New Product" 
                            OnClick="btnAddNewProduct_Click" CssClass="button" />
                    </td>
                    
                </tr>
            </table>
        </td>
    </tr>  
 
    <tr>
        <td align="center">
            <asp:Label ID="lblMsg" runat="server" ForeColor="Green"></asp:Label>
        </td>
    </tr>
    <tr> <%-- OnRowCommand="gvProduct_RowCommand" OnRowCreated="gvProduct_RowCreated" OnDataBound="gvProduct_DataBound"  onrowdeleted="gvProduct_RowDeleted"--%> 
        <td class="common_text">
            <asp:GridView ID="gvProduct" runat="server"  PagerStyle-HorizontalAlign ="Center" AllowPaging="true" AllowSorting="true" 
                AutoGenerateColumns="false" Width="100%" GridLines="None"  PageSize="3" CellPadding="4"
                OnPageIndexChanging="gvProduct_PageIndexChanging">
                                  
                <RowStyle CssClass="grid_row"></RowStyle>
                <HeaderStyle CssClass="tableheading"/>
                <AlternatingRowStyle CssClass="grid_alternaterow" />
                
                <Columns>
                    <asp:TemplateField HeaderText="" ItemStyle-HorizontalAlign="Left" 
                        HeaderStyle-HorizontalAlign="Left" SortExpression="ProductName">
                        <ItemTemplate>
                            <asp:Image ID="imgProd" runat="server" AlternateText='<%# Eval("ProductName")%>' 
                            ImageUrl='<%# "../Product Images/" + Eval("ImageName")%>' Height="100px" Width="100px" />
                            
                        </ItemTemplate>
                        <ItemStyle CssClass="column_left_padding" />
                    </asp:TemplateField>
                    
                    <asp:TemplateField HeaderText="Product Name" ItemStyle-HorizontalAlign="Left" 
                        HeaderStyle-HorizontalAlign="Left" SortExpression="ProductName">
                        <ItemTemplate>
                            <asp:Label ID="lblProductName" runat="server" Text='<%# Eval("ProductName")%>' 
                                    style="word-wrap: break-word;word-break:break-all;" Width="80%" >
                            </asp:Label>
                        </ItemTemplate>
                        <ItemStyle CssClass="column_left_padding" />
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Category" ItemStyle-HorizontalAlign="Left" 
                        HeaderStyle-HorizontalAlign="Left" SortExpression="ProductName">
                        <ItemTemplate>
                            <asp:Label ID="lblCategory" runat="server" Text='<%# Eval("CategoryName")%>' 
                                    style="word-wrap: break-word;word-break:break-all;" Width="80%" >
                            </asp:Label>
                        </ItemTemplate>
                        <ItemStyle CssClass="column_left_padding" />
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Occasion" ItemStyle-HorizontalAlign="Left" 
                        HeaderStyle-HorizontalAlign="Left">
                        <ItemTemplate>
                            <asp:Label ID="lblOccasion" runat="server" Text='<%# Eval("Occasion")%>' 
                                style="word-wrap: break-word;word-break:break-all;" Width="80%" >
                            </asp:Label>
                        </ItemTemplate>
                        <ItemStyle CssClass="column_left_padding" />
                    </asp:TemplateField>
                <%--<asp:TemplateField HeaderText="Occasions" ItemStyle-HorizontalAlign="Left" 
                    HeaderStyle-HorizontalAlign="Left">
                    <ItemTemplate>
                    <asp:HiddenField ID="hdnProductID1" runat="server" Value='<%# Eval("ProductID") %>' />
        
                        <asp:Repeater ID="repOccasions" runat="server" DataSourceID="sdsOccasions" >
                            <ItemTemplate>
                            <asp:Label ID="lblOccasion" runat="server" Text='<%# Eval("Occasion")%>' 
                                    style="word-wrap: break-word;word-break:break-all;" Width="80%" >
                            </asp:Label>
                            </ItemTemplate>
                        </asp:Repeater>
                        <asp:SqlDataSource ID="sdsOccasions" runat="server" ConnectionString="<%$ ConnectionStrings:strconn %>"
                            SelectCommand="r_ProductOccasion_Select" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="hdnProductID1" Name="ProductID" PropertyName="Value"
                                    ConvertEmptyStringToNull="false" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </ItemTemplate>
                    <ItemStyle CssClass="column_left_padding" />
                </asp:TemplateField>--%>
    
                <asp:TemplateField HeaderText="Status" ItemStyle-Width="8%" SortExpression="IsActive"  >
                    <ItemTemplate>
                        <asp:ImageButton ID="lnkStatus" runat="server" 
                                ImageUrl='<%# "~/Admin/images/" + Eval("IsActive") + ".png" %>' 
                                OnClick="lnkStatus_Clicked" CommandName="ProdStatusUpdate"
                                OnClientClick="return confirm('Are you sure, you want to change the status of product?')"
                                CommandArgument='<%# Eval("ProductID")%>' />          
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                    <HeaderStyle HorizontalAlign="Center" />
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Edit" ItemStyle-Width="8%"  >
                    <ItemTemplate>
                        <asp:ImageButton ID="lnkEdt" runat="server" 
                                ImageUrl="~/Admin/Images/edit.png"
                                OnClick="lnkEdit_Clicked" 
                                CommandArgument='<%# Eval("ProductID")%>' />          
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                    <HeaderStyle HorizontalAlign="Center" />
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Delete" ItemStyle-Width="8%"  >
                    <ItemTemplate>
                        <asp:ImageButton ID="lnkDelete" runat="server" CommandName="Delete"
                                ImageUrl="~/Admin/Images/delete.png"  OnClick="lnkDelete_Clicked" 
                                OnClientClick="return confirm('Are you sure, you want to delete product?')"
                                CommandArgument='<%# Eval("ProductID")%>' />          
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                    <HeaderStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                </Columns>
    
                <EmptyDataTemplate>
                    <asp:Label ID="lblEmpty" runat="server" Text="No Records Found." ForeColor="Green"></asp:Label>
                </EmptyDataTemplate>
            </asp:GridView>
             <br />
            
           <asp:SqlDataSource ID="sdsProduct" runat="server" ConnectionString="<%$ ConnectionStrings:strconn %>" 
                SelectCommand="r_ProductMst_Select" SelectCommandType="StoredProcedure" 
                UpdateCommand="i_Product_ChangeStatus" UpdateCommandType="StoredProcedure"
                DeleteCommand="i_Product_Delete" DeleteCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:ControlParameter ControlID="txtProductName" Name="ProductName" PropertyName="Text" 
                        ConvertEmptyStringToNull ="false"/>
                </SelectParameters>
            </asp:SqlDataSource>
        </td>
    </tr>
    <tr class="pagerStyle" style="height:25px">
        <td>
            <asp:Repeater ID="rptPager" runat="server">
                <ItemTemplate>
                    <asp:LinkButton ID="lnkPage" runat="server" Text = '<%#Eval("Text") %>' CommandArgument = '<%# Eval("Value") %>' 
                    Enabled = '<%# Eval("Enabled") %>' OnClick = "Page_Changed"></asp:LinkButton>
                </ItemTemplate>
            </asp:Repeater>
             <asp:HiddenField ID="hdnPageNo" runat="server" />
        </td>
    </tr>
    <tr>
        <td>
            <asp:HiddenField ID="hdnProductID" runat="server" />
            <asp:HiddenField ID="hdnImageName" runat="server" />
        </td>
    </tr>

</table>
    
    <br />
    
</asp:Content>