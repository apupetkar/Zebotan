<%@ Page Title="" Language="C#" EnableEventValidation="false" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true" CodeFile="ManageCategory.aspx.cs" Inherits="Admin_ManageCategory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<script type="text/javascript">
    $(function () {
        $(".chk").click(function () {
            debugger;
            cnt = $('input[type=CheckBoxList]:checked').length;
            if (cnt == 0) {
                alert("select1");
            }
            else {
                alert("selected 1");
            }
        });
    });
</script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<table width="720px" border="0" cellpadding="1" cellspacing="0">
    <tr>
        <td class="common_text">
            <table id="tblSearch" runat="server" width="100%">
                <tr>
                    <td style="width:10%">
                        <asp:Label ID="lblCategoryName" runat="server" Text="Category"></asp:Label>
                    </td>
                    <td style="width:10%">
                        <asp:TextBox ID="txtCategoryName" runat="server"></asp:TextBox>
                    </td>
                    <td style="width:50%" align="right">
                        <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="button" OnClick="btnSearch_Click" />
                    </td>
                    <td style="width:10%" align="right">
                        <asp:Button ID="btnAddNewCategory" runat="server" Text="Add New Category" 
                            OnClick="btnAddNewCategory_Click" CssClass="button" />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td class="common_text">
            
            <asp:FormView ID="fvCategory" runat="server" HeaderText="Add New Category" DefaultMode="Insert" 
                    Visible="false" Width="500px" BorderWidth="1px">
                
                <InsertItemTemplate>
                <table width="500px" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td></td>
                        <td colspan="2" align="left">
                            <font color="red">
                                <asp:Label ID="Label1" runat="server" Text="* indicates required field."></asp:Label>
                            </font>
                        </td>
                    </tr>
                    <tr>
                        <td style="width:105px">
                            <asp:Label ID="lblCategoryName" runat="server" Text="Category Name:"></asp:Label><font color="red">*</font>
                        </td>
                        <td style="width:125px">
                            <asp:TextBox ID="txtCategoryName" runat="server" MaxLength="50" Text=""></asp:TextBox>
                            
                        </td>
                        <td align="left" style="color:Red; padding-left: 5px">
                            <asp:Label ID="lblDuplicateCategory" runat="server" Text=""></asp:Label>

                            <asp:RequiredFieldValidator ID="rfvCategoryName" runat="server" ControlToValidate="txtCategoryName" 
                                Display="Dynamic" ValidationGroup="Add" ErrorMessage="Category Name is required">
                            </asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblOccasions" runat="server" Text="Occasions:"></asp:Label><font color="red">*</font>
                        </td>
                        <td>
                           <asp:CheckBoxList ID="chkOccasions" runat="server" DataSourceID="sdsOccasions" CssClass="chk"
                            DataTextField="Occasion" DataValueField="OccasionID" RepeatDirection="Horizontal"
                                RepeatColumns="5"></asp:CheckBoxList>
                            <asp:SqlDataSource ID="sdsOccasions" runat="server" ConnectionString='<%$ ConnectionStrings:strconn %>'
                                SelectCommand="r_Occasions_Select" SelectCommandType="StoredProcedure">
                            </asp:SqlDataSource>
                            <asp:Label ID="errmsg" runat="server"></asp:Label>
                        </td>
                        <td align="left" style="color:Red">
                            <%--<asp:RequiredFieldValidator ID="rfvOccasions" runat="server" ControlToValidate="chkOccasions" 
                                Display="Dynamic" ValidationGroup="Add" ErrorMessage="Select atleast 1 Occasion">
                            </asp:RequiredFieldValidator>--%>
                        </td>
                    </tr>
                    
                    <tr>
                        <td></td>
                        <td colspan="2">
                            <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click"
                                CssClass="button" ValidationGroup="Add" />
                        
                            <asp:Button ID="btnCancel" runat="server" Text="Cancel" OnClick="btnCancel_Click" 
                            CssClass="button" />
                        </td>
                    </tr>
                </table>
            </InsertItemTemplate>

            <EditItemTemplate>
                <table width="500px" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td></td>
                        <td colspan="2">
                            <font color="red">
                                <asp:Label ID="Label1" runat="server" Text="* indicates required field."></asp:Label>
                            </font>
                        </td>
                    </tr>
                    <tr>
                        <td style="width:125px">
                            <asp:Label ID="lblCategoryName" runat="server" Text="Category Name:"></asp:Label><font color="red">*</font>
                        </td>
                        <td>
                            <asp:TextBox ID="txtCategoryName" runat="server" Text='<%# Eval("CategoryName") %>' MaxLength="50"></asp:TextBox>
                        </td>
                        <td align="left" style="color:Red">
                            <asp:RequiredFieldValidator ID="rfvCategoryName" runat="server" ControlToValidate="txtCategoryName" 
                                Display="Dynamic" ValidationGroup="Edit" ErrorMessage="Category Name is required">
                            </asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblOccasions" runat="server" Text="Occasions:"></asp:Label><font color="red">*</font>
                        </td>
                        <td>
                           <asp:CheckBoxList ID="chkOccasions" runat="server" DataSourceID="sdsOccasions"
                            DataTextField="Occasion" DataValueField="OccasionID" RepeatDirection="Horizontal"
                                RepeatColumns="5" ></asp:CheckBoxList>
                            <asp:SqlDataSource ID="sdsOccasions" runat="server" ConnectionString='<%$ ConnectionStrings:strconn %>'
                                SelectCommand="r_Occasions_Select" SelectCommandType="StoredProcedure">
                            </asp:SqlDataSource>
                        </td>
                        <td align="left" style="color:Red">
                            <%--<asp:RequiredFieldValidator ID="rfvOccasions" runat="server" ControlToValidate="chkOccasions" 
                                Display="Dynamic" ValidationGroup="Add" ErrorMessage="Select atleast 1 Occasion">
                            </asp:RequiredFieldValidator>--%>
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td colspan="2">
                            <asp:Button ID="btnUpdate" runat="server" Text="Update" OnClick="btnUpdate_Click" 
                                CssClass="button" ValidationGroup="Edit" />
                        
                            <asp:Button ID="btnCancel" runat="server" Text="Cancel"  OnClick="btnCancel_Click" 
                            CssClass="button" />
                        </td>
                    </tr>
                </table>
            </EditItemTemplate>
            </asp:FormView>
        </td>
    </tr>
    <tr>
        <td align="center">
            <asp:Label ID="lblMsg" runat="server" ForeColor="Green"></asp:Label>
        </td>
    </tr>
    <tr>
        <td class="common_text">
            <asp:GridView ID="gvCategory" runat="server"  PagerStyle-HorizontalAlign ="Center"
                    AllowPaging="true" AllowSorting="true" AutoGenerateColumns="false" 
                    Width="100%" GridLines="None" CellPadding="4" >
                                  
            <RowStyle CssClass="grid_row"></RowStyle>
            <HeaderStyle CssClass="tableheading"/>
            <AlternatingRowStyle CssClass="grid_alternaterow" />
            <Columns>
                <asp:TemplateField HeaderText="Category Name" ItemStyle-HorizontalAlign="Left" 
                    HeaderStyle-HorizontalAlign="Left" SortExpression="CategoryName">
                    <ItemTemplate>
                        <asp:Label ID="lblCategoryName" runat="server" Text='<%# Eval("CategoryName")%>' 
                                style="word-wrap: break-word;word-break:break-all;" Width="80%" >
                        </asp:Label>
                    </ItemTemplate>
                    <ItemStyle CssClass="column_left_padding" />
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Occasions" ItemStyle-HorizontalAlign="Left" 
                    HeaderStyle-HorizontalAlign="Left">
                    <ItemTemplate>
                    <asp:HiddenField ID="hdnCategoryID1" runat="server" Value='<%# Eval("CategoryID") %>' />
        
                        <asp:Repeater ID="repOccasions" runat="server" DataSourceID="sdsOccasions" >
                            <ItemTemplate>
                            <asp:Label ID="lblOccasion" runat="server" Text='<%# Eval("Occasion")%>' 
                                    style="word-wrap: break-word;word-break:break-all;" Width="80%" >
                            </asp:Label>
                            </ItemTemplate>
                        </asp:Repeater>
                        <asp:SqlDataSource ID="sdsOccasions" runat="server" ConnectionString="<%$ ConnectionStrings:strconn %>"
                            SelectCommand="r_CategoryOccasion_Select" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="hdnCategoryID1" Name="CategoryID" PropertyName="Value"
                                    ConvertEmptyStringToNull="false" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </ItemTemplate>
                    <ItemStyle CssClass="column_left_padding" />
                </asp:TemplateField>
    
                <asp:TemplateField HeaderText="Status" ItemStyle-Width="8%" SortExpression="IsActive"  >
                    <ItemTemplate>
                        <asp:ImageButton ID="lnkStatus" runat="server" 
                                ImageUrl='<%# "~/Admin/images/" + Eval("IsActive") + ".png" %>' 
                                OnClick="lnkStatus_Clicked" CommandName="Update"
                                OnClientClick="return confirm('Are you sure, you want to change the status of category?')"
                                CommandArgument='<%# Eval("CategoryID")%>' />          
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                    <HeaderStyle HorizontalAlign="Center" />
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Edit" ItemStyle-Width="8%"  >
                    <ItemTemplate>
                        <asp:ImageButton ID="lnkEdt" runat="server" 
                                ImageUrl="~/Admin/Images/edit.png"
                                OnClick="lnkEdit_Clicked" 
                                CommandArgument='<%# Eval("CategoryID")%>' />          
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                    <HeaderStyle HorizontalAlign="Center" />
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Delete" ItemStyle-Width="8%"  >
                    <ItemTemplate>
                        <asp:ImageButton ID="lnkDelete" runat="server" ImageUrl="~/Admin/Images/delete.png" 
                            OnClick="lnkDelete_Clicked" 
                            OnClientClick="return confirm('Deleting a category can delete the corresponding subcategories.\nAre you sure, you want to delete category?')"
                            CommandArgument='<%# Eval("CategoryID")%>' />          
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
            
           <asp:SqlDataSource ID="sdsCategory" runat="server" ConnectionString="<%$ ConnectionStrings:strconn %>" 
                SelectCommand="r_CategoryMst_Select" SelectCommandType="StoredProcedure" 
                UpdateCommand="i_Category_ChangeStatus" UpdateCommandType="StoredProcedure"
                DeleteCommand="i_Category_Delete" DeleteCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:ControlParameter ControlID="txtCategoryName" Name="CategoryName" PropertyName="Text" 
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
                        Enabled = '<%# Eval("Enabled") %>' OnClick = "Page_Changed">
                    </asp:LinkButton>
                </ItemTemplate>
            </asp:Repeater>
            <asp:HiddenField ID="hdnPageNo" runat="server" />
        </td>
    </tr>
    <tr>
        <td>
            <asp:HiddenField ID="hdnCategoryID" runat="server" />
        </td>
    </tr>

</table>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder11" Runat="Server">
</asp:Content>

