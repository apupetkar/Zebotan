<%@ Page Title="Manage Sub Category" EnableEventValidation="false" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true" CodeFile="ManageSubCategory.aspx.cs" Inherits="Admin_ManageSubCategory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<table width="720px" border="0" cellpadding="0" cellspacing="0">
    <tr>
        <td class="common_text">
            <table id="tblSearch" runat="server" width="100%">
                <tr>
                    <td style="width:10%">
                        <asp:DropDownList ID="ddlCategory" runat="server" DataSourceID="sdsCategory" 
                            DataTextField="CategoryName" DataValueField="CategoryID" AppendDataBoundItems="true">
                            <asp:ListItem Selected="True" Text="ALL" Value="0"></asp:ListItem>
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="sdsCategory" runat="server"
                            ConnectionString="<%$ ConnectionStrings:strconn %>"
                            SelectCommand="SELECT * FROM [Category] WHERE ParentCategoryID = 1 AND IsRemoved = 0" SelectCommandType="Text"  >
                        </asp:SqlDataSource>
                    </td>
                    <td style="width:10%">
                        <asp:Label ID="lblSubCategoryName" runat="server" Text="SubCategory"></asp:Label>
                    </td>
                    <td style="width:10%">
                        <asp:TextBox ID="txtSubCategoryName" runat="server"></asp:TextBox>
                    </td>
                    <td style="width:30%" align="right">
                        <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="button" OnClick="btnSearch_Click" />
                    </td>
                    <td style="width:5%" align="right">
                        <asp:Button ID="NewButton" runat="server" Text="Add New SubCategory"
                         OnClick="btnAddNewSubCategory_Click" CssClass="button"></asp:Button>
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
    <tr>
        <td style="width:100%" class="common_text">
            <asp:ListView ID="lvwCategory" runat="server" DataKeyNames="CategoryID"
                 OnItemCommand="lvwCategory_ItemCommand" OnItemEditing="lvwCategory_ItemEditing"
                 OnItemUpdating="lvwCategory_ItemUpdating" OnItemCanceling="lvwCategory_ItemCanceling"
                 OnItemInserting="lvwCategory_ItemInserting"  OnItemDeleting="lvwCategory_ItemDeleting" >
                  
            <LayoutTemplate>
            <table id="Table1" runat="server" width="100%">
                <tr id="Tr3" runat="server">
                    <td id="Td2" runat="server" style="">
                    </td>
                </tr>
                <tr id="Tr1" runat="server">
                    <td id="Td1" runat="server" >
                        <table ID="itemPlaceholderContainer" runat="server" border="0" style="" width="100%">
                            <tr id="Tr2" runat="server" class="tableheading">
                                <th id="Th1" runat="server" style="width:30%">
                                    Category</th>
                                <th id="Th2" runat="server" style="width:30%">
                                    SubCategory</th>
                                <th id="Th4" runat="server">
                                    Status
                                </th>
                                <th id="Th3" runat="server">
                                    Edit
                                </th>
                                <th id="Th5" runat="server">
                                    Delete
                                </th>
                             </tr>
                            <tr ID="itemPlaceholder" runat="server">
                            </tr>
                        </table>
                    </td>
                </tr>
               <tr class="pagerStyle" style="height:25px">
                    <td>
                        <asp:DataPager ID="DataPager1" runat="server" PageSize="5">
                            <Fields>
                                <asp:NextPreviousPagerField
                                    ButtonType="Link"
                                    ShowFirstPageButton="true"
                                    ShowNextPageButton="false"
                                    ShowPreviousPageButton="false"
                                    />
                                <asp:NumericPagerField
                                    />
                                <asp:NextPreviousPagerField
                                    ButtonType="Link"
                                    ShowLastPageButton="true"
                                    ShowNextPageButton="false"
                                    ShowPreviousPageButton="false"
                                    />
                            </Fields>
                        </asp:DataPager>
                   
                    </td>
                </tr>
                
            </table>
        </LayoutTemplate>

        <ItemTemplate>
            <tr style="">
                <td  style="width:30%">
                    <asp:HiddenField ID="hdnCategoryID" runat="server" Value='<%# Eval("CategoryID") %>' />
                    <asp:Label ID="ParentCategoryIDLabel" runat="server"
                        Text='<%# Eval("ParentCategoryName") %>' />
                </td>
                <td  style="width:30%">
                    <asp:Label ID="SubCategoryNameLabel" runat="server"  
                        Text='<%# Eval("CategoryName") %>' />
                </td>
                <td align="center">
                   <asp:ImageButton ID="lnkStatus" runat="server" 
                        ImageUrl='<%# "~/Admin/images/" + Eval("IsActive") + ".png" %>' 
                        
                        OnClientClick="return confirm('Are you sure, you want to change the status of category?')"
                        OnClick="lnkStatus_Clicked"
                        CommandArgument='<%# Eval("CategoryID")%>' /> 
                </td>
                 <td align="center">
                     <asp:ImageButton ID="lnkEdt" runat="server" ImageUrl="~/Admin/Images/edit.png"  CommandName="Edit" 
                                 CommandArgument='<%# Eval("CategoryID")%>' />    
                </td>
                 <td align="center">
                     <asp:ImageButton ID="lnkDelete" runat="server" ImageUrl="~/Admin/Images/delete.png"  CommandName="Delete" 
                                 CommandArgument='<%# Eval("CategoryID")%>' /> 
                </td>
            </tr>
        </ItemTemplate>
        
        <AlternatingItemTemplate>
            <tr style="">
                <td  style="width:30%">
                    <asp:Label ID="ParentCategoryIDLabel" runat="server"
                        Text='<%# Eval("ParentCategoryName") %>' />
                </td>
                <td  style="width:30%">
                    <asp:Label ID="SubCategoryNameLabel" runat="server"
                        Text='<%# Eval("CategoryName") %>' />
                </td>
                <td align="center">
                    <asp:ImageButton ID="lnkStatus" runat="server" 
                        ImageUrl='<%# "~/Admin/images/" + Eval("IsActive") + ".png" %>' 
                         CommandName="Update"
                        OnClientClick="return confirm('Are you sure, you want to change the status of category?')"
                        CommandArgument='<%# Eval("IsActive")%>' /> 
                </td>
                 <td align="center">
                     <asp:ImageButton ID="lnkEdt" runat="server" ImageUrl="~/Admin/Images/edit.png"  CommandName="Edit" 
                                 CommandArgument='<%# Eval("CategoryID")%>' />    
                </td>
                <td align="center">
                    <asp:ImageButton ID="lnkDelete" runat="server" ImageUrl="~/Admin/Images/delete.png"  CommandName="Delete" 
                                 CommandArgument='<%# Eval("CategoryID")%>' /> 
                </td>
            </tr>
        </AlternatingItemTemplate>

        <EditItemTemplate>
            <tr style="">
                 <td  style="width:30%">
                    <asp:HiddenField ID="hdnCategoryID" runat="server" Value='<%# Eval("CategoryID") %>' />
                    <asp:DropDownList ID="ddlCategory" runat="server" DataSourceID="sdsCategory" Width="200px"
                            DataTextField="CategoryName" DataValueField="CategoryID" AppendDataBoundItems="false"
                           selectedvalue='<%# Bind("ParentCategoryID") %>'  >
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="sdsCategory" runat="server"
                            ConnectionString="<%$ ConnectionStrings:strconn %>"
                            SelectCommand="SELECT * FROM [Category] WHERE ParentCategoryID = 1 AND IsRemoved = 0" SelectCommandType="Text"  >
                        </asp:SqlDataSource>
                </td>
                <td  style="width:30%">
                    <asp:TextBox ID="txtCategoryName" runat="server" 
                        Text='<%# Bind("CategoryName") %>' />
                </td>
                <td align="center">
                    <asp:ImageButton ID="lnkStatus" runat="server" 
                        ImageUrl='<%# "~/Admin/images/" + Eval("IsActive") + ".png" %>' 
                         CommandName="Update"
                        CommandArgument='<%# Eval("IsActive")%>' /> 
                </td>
                <td align="center">
                     <asp:ImageButton ID="lnkEdt" runat="server" ImageUrl="~/Admin/Images/save.png"  CommandName="Update" 
                                 CommandArgument='<%# Eval("CategoryID")%>' ValidationGroup="Edit" />
                     <asp:ImageButton ID="CancelButton" runat="server" ImageUrl="~/Admin/Images/exit.png" CommandName="Cancel" 
                        Text="Cancel" />
                </td>
                <td align="center">
                    <asp:ImageButton ID="lnkDelete" runat="server" ImageUrl="~/Admin/Images/delete.png"  CommandName="Delete" 
                                 CommandArgument='<%# Eval("CategoryID")%>' /> 
                </td>
            </tr>
            <tr>
                <td></td>
                <td style="color:Red">
                    <asp:RequiredFieldValidator ID="rfvCategory" runat="server" ControlToValidate="txtCategoryName" 
                                Display="Dynamic" ValidationGroup="Edit" ErrorMessage="Sub Category Name is required">
                            </asp:RequiredFieldValidator>
                </td>
            </tr>
        </EditItemTemplate>
        <EmptyDataTemplate>
            <table id="Table1" runat="server" style="">
                <tr>
                    <td style="color:Green">
                         No Records Found.  </td>
                        <td>
                      </td>
                </tr>
            </table>
        </EmptyDataTemplate>
        <InsertItemTemplate>
            <tr style="">
                <td  style="width:30%">
                     <asp:DropDownList ID="ddlCategory" runat="server" DataSourceID="sdsCategory" Width="200px"
                            DataTextField="CategoryName" DataValueField="CategoryID" AppendDataBoundItems="false">
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="sdsCategory" runat="server"
                            ConnectionString="<%$ ConnectionStrings:strconn %>"
                            SelectCommand="SELECT * FROM [Category] WHERE ParentCategoryID = 1 AND IsRemoved = 0" SelectCommandType="Text"  >
                        </asp:SqlDataSource>
                </td>
                <td  style="width:30%">
                    <asp:TextBox ID="txtCategoryName" runat="server" 
                        Text='<%# Bind("CategoryName") %>' Width="200px" />
                </td>
                <td align="center">
                </td>
                <td align="center">
                     <asp:ImageButton ID="lnkEdt" runat="server" ImageUrl="~/Admin/Images/save.png"  CommandName="Insert" 
                                 CommandArgument='<%# Eval("CategoryID")%>' ValidationGroup="Add" />
                    
                    <asp:ImageButton ID="CancelButton" runat="server" ImageUrl="~/Admin/Images/exit.png"  CommandName="Cancel"/>
                </td>
                <td align="center">
                    <asp:ImageButton ID="lnkDelete" runat="server" ImageUrl="~/Admin/Images/delete.png"  CommandName="Delete" 
                                 CommandArgument='<%# Eval("CategoryID")%>' /> 
                </td>
            </tr>
            <tr>
                <td></td>
                <td style="color:Red">
                    <asp:RequiredFieldValidator ID="rfvCategory" runat="server" ControlToValidate="txtCategoryName" 
                                Display="Dynamic" ValidationGroup="Add" ErrorMessage="Sub Category Name is required">
                            </asp:RequiredFieldValidator>
                </td>
            </tr>
        </InsertItemTemplate>
    
       
    
    </asp:ListView>
        </td>
    
    </tr>
   
</table>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder11" Runat="Server">
</asp:Content>

