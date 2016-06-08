using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_ManageSubCategory : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (UserMembership.GetUser() == null)
            Response.Redirect("AdminLogin.aspx");

        ShowPageHeaders.SetPageTitle(this, "Manage SubCategory");
        lblMsg.Text = "";

        if (!IsPostBack)
        {
            BindList();
        }
    }

    private void BindList()
    {
        lvwCategory.DataSource = null;

        Category category = new Category();
        if(ddlCategory.SelectedItem.Text != "ALL")
            category.ParentCategoryID = FormatNumValues.GetNullInt(ddlCategory.SelectedValue);
        category.CategoryName = txtSubCategoryName.Text;
        
        lvwCategory.DataSource = category.GetSubCategory();
        lvwCategory.DataBind();
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        BindList();
    }

    protected void lvwCategory_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        switch (e.CommandName)
        {
            case "Insert":
                {
                    InsertCategory(e.Item);
                    break;
                }
            case "Update":
                {
                    UpdateCategory(e.CommandArgument as string, e.Item);
                    break;
                }
            case "Delete":
                {
                    DeleteCategory(e.CommandArgument as string);
                    break;
                }
        }
    }

    protected void lvwCategory_ItemEditing(object sender, ListViewEditEventArgs e)
    {
        CloseInsert();
        lvwCategory.EditIndex = e.NewEditIndex;
        BindList();
    }

    private void CloseInsert()
    {
        lvwCategory.InsertItemPosition = InsertItemPosition.None;
        NewButton.Visible = true;
    }

    protected void lvwCategory_ItemUpdating(object sender, ListViewUpdateEventArgs e)
    {
    }

    private void InsertCategory(ListViewItem insertItem)
    {
        if (IsValid)
        {
            DBHandler db = new DBHandler();
            
            Category category = new Category();
            category = GetFields("INSERT", insertItem);
            
            category.InsertCategory(false);

            CloseInsert();
            BindList();

            Session["RecordUpdated"] = "0";
            ShowMessage();
            
        }
    }

    private void UpdateCategory(string customerID, ListViewItem editItem)
    {
        if (IsValid)
        {
            DBHandler db = new DBHandler();
            Category category = new Category();
            category = GetFields("UPDATE", editItem);

            category.UpdateCategory(false);
            lvwCategory.EditIndex = -1;
            BindList();

            Session["RecordUpdated"] = "1";
            ShowMessage();
        }
    }

    protected void btnAddNewSubCategory_Click(object sender, EventArgs e)
    {
        lvwCategory.EditIndex = -1;
        lvwCategory.InsertItemPosition = InsertItemPosition.LastItem;
        BindList();
    }

    protected void lvwCategory_ItemCanceling(object sender, ListViewCancelEventArgs e)
    {
        if (e.CancelMode == ListViewCancelMode.CancelingInsert)
        {
            CloseInsert();
        }
        else
        {
            lvwCategory.EditIndex = -1;
        }

        BindList();
    }

    protected void lvwCategory_ItemInserting(object sender, ListViewInsertEventArgs e)
    {
    }

    protected void lvwCategory_ItemDeleting(object sender, ListViewDeleteEventArgs e)
    {
    }

    private void DeleteCategory(string categoryID)
    {
        if (IsValid)
        {
            Category category = new Category();

            category.CategoryID = FormatNumValues.GetNullInt(categoryID);

            category.DeleteCategory();

            BindList();
        }
    }

    protected Category GetFields(string strMode, ListViewItem lvItem)
    {
        Category category = new Category();

        switch (strMode)
        {
            case "INSERT":
                category.CategoryName = ((TextBox)lvItem.FindControl("txtCategoryName")).Text;
                category.ParentCategoryID = FormatNumValues.GetNullInt(((DropDownList)lvItem.FindControl("ddlCategory")).SelectedValue);
                category.IsActive = true;
                category.IsRemoved = false;

                break;

            case "UPDATE":
                category.CategoryID = FormatNumValues.GetNullInt(((HiddenField)lvItem.FindControl("hdnCategoryID")).Value);
                category.CategoryName = ((TextBox)lvItem.FindControl("txtCategoryName")).Text;
                category.ParentCategoryID = FormatNumValues.GetNullInt(((DropDownList)lvItem.FindControl("ddlCategory")).SelectedValue);
                category.IsActive = true;
                category.IsRemoved = false;
                break;

            case "STATUSCHANGE":
                break;
        }
        

        return category;
    }

    protected void lnkStatus_Clicked(object sender, EventArgs e)
    {
        ImageButton img = (ImageButton)sender;
        string str = img.CommandArgument;

        Category category = new Category();
        category.CategoryID = FormatNumValues.GetNullInt(str);
        category.UpdateStatus();

        BindList();

        Session["RecordUpdated"] = "2";
        ShowMessage();
    }

    protected void ShowMessage()
    {
        if (Session["RecordUpdated"] != null)
        {
            if (Convert.ToString(Session["RecordUpdated"]) == "0")
            {
                lblMsg.Text = "Subcategory added successfully.";
            }
            else if (Convert.ToString(Session["RecordUpdated"]) == "1")
            {
                lblMsg.Text = "Subcategory updated successfully.";
            }
            else if (Convert.ToString(Session["RecordUpdated"]) == "2")
            {
                lblMsg.Text = "Subcategory status changed successfully.";
            }
            else if (Convert.ToString(Session["RecordUpdated"]) == "3")
            {
                lblMsg.Text = "Subcategory deleted successfully.";
            }
            else
            {
                lblMsg.Text = "";
            }
        }
        else
        {
            lblMsg.Text = "";
        }

        SetSessionValues();
    }

    protected void SetSessionValues()
    {
        if (Session["PAGEINDEX"] != null && Convert.ToString(Session["PAGEINDEX"]) != "")
        {
            //stores page index in session
          
            //restore value stored in session txtName to the textbox
            if (Convert.ToString(Session["txtSubCategoryName"]) != "")
            {
                //Set Category Title from session to maintain search result
                txtSubCategoryName.Text = Convert.ToString(Session["txtSubCategoryName"]);
            }
        }
        ClearSession();
    }

    protected void ClearSession()
    {
        Session["PAGEINDEX"] = "1";
        Session["txtCategoryName"] = "";
        Session["RecordUpdated"] = "";
    }

 }
