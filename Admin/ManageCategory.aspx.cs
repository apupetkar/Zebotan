using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

public partial class Admin_ManageCategory : System.Web.UI.Page
{
    EncryptDecrypt ed = new EncryptDecrypt();
    int _PAGE_SIZE = 10;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (UserMembership.GetUser() == null)
            Response.Redirect("AdminLogin.aspx");

        ShowPageHeaders.SetPageTitle(this, "Manage Category");
        lblMsg.Text = "";
        ShowSearchBox(true);
        if (!Page.IsPostBack)
        {
            GetCategories(1);
            ShowMessage();

            fvCategory.Visible = false;
        }
     }

    protected void ShowMessage()
    {
        if (Session["RecordUpdated"] != null)
        {
            if (Convert.ToString(Session["RecordUpdated"]) == "0")
            {
                lblMsg.Text = "Category added successfully.";
            }
            else if (Convert.ToString(Session["RecordUpdated"]) == "1")
            {
                lblMsg.Text = "Category updated successfully.";
            }
            else if (Convert.ToString(Session["RecordUpdated"]) == "2")
            {
                lblMsg.Text = "Category status changed successfully.";
            }
            else if (Convert.ToString(Session["RecordUpdated"]) == "3")
            {
                lblMsg.Text = "Category deleted successfully.";
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

    protected void ShowSearchBox(Boolean bShow)
    {
        if(!bShow)
            tblSearch.Style.Add("display", "none");
        else
            tblSearch.Style.Remove("display");
        
    }

    protected void SetSessionValues()
    {
        if (Session["PAGEINDEX"] != null && Convert.ToString(Session["PAGEINDEX"]) != "")
        {
            //stores page index in session
            GetCategories(Convert.ToInt32(Session["PAGEINDEX"]));

            //restore value stored in session txtName to the textbox
            if (Convert.ToString(Session["txtCategoryName"]) != "")
            {
                //Set Category Title from session to maintain search result
                txtCategoryName.Text = Convert.ToString(Session["txtCategoryName"]);
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

    protected void GetCategories(int pageIndex)
    {
        Category category = new Category();
        category.CategoryID = 0;
        category.CategoryName = txtCategoryName.Text;
        gvCategory.DataSource = category.GetCategory(pageIndex, _PAGE_SIZE);
        gvCategory.DataBind();

        int recordCount = Category.recordCount;
        this.PopulatePager(recordCount, pageIndex);
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            if (CategoryExists())
            {
                Label lblDuplicateCategory = ((Label)fvCategory.FindControl("lblDuplicateCategory"));
                lblDuplicateCategory.Text = "Category already exists.";
                return;
            }
            Session["PAGEINDEX"] = GetCurrentPage();

            fvCategory.Visible = true;

            InsertCategory();

            Session["RecordUpdated"] = "0";

            fvCategory.Visible = false;
            ShowMessage();
            GetCategories(1); 
        }
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        fvCategory.Visible = false;
    }

    protected Boolean CategoryExists()
    {
        Category category = new Category();
        category.CategoryName = ((TextBox)fvCategory.FindControl("txtCategoryName")).Text;
        return category.CategoryExists();
    }

    protected void lnkStatus_Clicked(object sender, EventArgs e)
    {
        Session["PAGEINDEX"] = GetCurrentPage();
        ImageButton img = (ImageButton)sender;
        string str = img.CommandArgument;

        Category category = new Category();
        category.CategoryID = FormatNumValues.GetNullInt(str);
        category.UpdateStatus();

        Session["RecordUpdated"] = "2";
        ShowMessage();
        GetCategories(Convert.ToInt32(Session["PAGEINDEX"]));
    }


    protected void lnkEdit_Clicked(object sender, EventArgs e)
    {
        Session["PAGEINDEX"] = GetCurrentPage();
        ImageButton img = (ImageButton)sender;
        string str = img.CommandArgument;

        ShowSearchBox(false);
        fvCategory.Visible = true;

        string strCategoryID = str;
        if (strCategoryID == null || strCategoryID == "")
        {
            fvCategory.DefaultMode = FormViewMode.Insert;
            ShowPageHeaders.SetPageTitle(this, "Add Category");
        }
        else
        {
            fvCategory.ChangeMode(FormViewMode.Edit);
            ShowPageHeaders.SetPageTitle(this, "Edit Category");
            TextOnHeader("Edit Category");
        
            hdnCategoryID.Value = strCategoryID;

            Category category = new Category();
            category.CategoryID = FormatNumValues.GetNullInt(strCategoryID);
            
            fvCategory.DataSource = category.GetCategoryByID();
            fvCategory.DataBind();

            DataTable dt = (DataTable)fvCategory.DataSource;
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                ListItem chkOcc = ((CheckBoxList)fvCategory.FindControl("chkOccasions")).Items[i];
                if (chkOcc.Value.Equals(dt.Rows[i]["OccasionID"].ToString()))
                    chkOcc.Selected = true;
                else
                    chkOcc.Selected = false;
            }
        }
    }

    protected void lnkDelete_Clicked(object sender, EventArgs e)
    {
        Session["PAGEINDEX"] = GetCurrentPage(); 
        ImageButton img = (ImageButton)sender;
        string str = img.CommandArgument;

        Category category = new Category();
        category.CategoryID = FormatNumValues.GetNullInt(str);
        category.DeleteCategory();

        Session["RecordUpdated"] = "3";
        ShowMessage();

        GetCategories(GetCurrentPage());
    }

    protected void gvCategory_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        Session["PAGEINDEX"] = e.NewPageIndex;
    }

    protected void btnAddNewCategory_Click(object sender, EventArgs e)
    {
        ShowPageHeaders.SetPageTitle(this, "Add Category");
       
        Session["Category"] = gvCategory.PageIndex;

        TextOnHeader("Add New Category");
        ShowSearchBox(false);
        fvCategory.Visible = true;
        fvCategory.ChangeMode(FormViewMode.Insert);
        fvCategory.DataSource = null;

    }

    protected void TextOnHeader(string strHeader)
    {
        Label lblHeader = ((Label)fvCategory.FindControl("lblHeader"));
        if (lblHeader != null)
            lblHeader.Text = strHeader;

        fvCategory.HeaderText = strHeader;
    }

    protected void InsertCategory()
    {
        Category category = new Category();
        category = GetFields();
        category.InsertCategory(true);
    }

    protected Category GetFields()
    {
        Category category = new Category();
        category.CategoryID = FormatNumValues.GetNullInt(hdnCategoryID.Value);
        category.CategoryName = ((TextBox)fvCategory.FindControl("txtCategoryName")).Text;
        category.ParentCategoryID = 1;
        category.IsActive = true;
        category.IsRemoved = false;

        List<CategoryOccasions> lstOccasions = new List<CategoryOccasions>();
        CheckBoxList chkList = (CheckBoxList)fvCategory.FindControl("chkOccasions");
        int nOccasions = chkList.Items.Count;
        for (int i = 0; i < nOccasions; i++)
        {
            if (chkList.Items[i].Selected)
            {
                CategoryOccasions occasion = new CategoryOccasions();
                occasion.OccasionID = FormatNumValues.GetNullInt(chkList.Items[i].Value);
                lstOccasions.Add(occasion);
            }
        }
        category.lstOccasion = lstOccasions;
        return category;
    }

    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        Session["Category"] = gvCategory.PageIndex;
        fvCategory.Visible = true;

        UpdateCategory();

        Session["RecordUpdated"] = "1";
        fvCategory.Visible = false;
        ShowMessage();
    }

    protected void UpdateCategory()
    {
        Category category = new Category();
        category = GetFields();
        category.UpdateCategory(true);
    }
    
    protected void gvCategory_RowDeleted(object sender, GridViewDeletedEventArgs e)
    {
        lblMsg.Text = "Category deleted successfully.";
    }

    private void PopulatePager(int recordCount, int currentPage)
    {
        double dblPageCount = (double)((decimal)recordCount / decimal.Parse(_PAGE_SIZE.ToString()));
        int pageCount = (int)Math.Ceiling(dblPageCount);
        List<ListItem> pages = new List<ListItem>();
        if (pageCount > 0)
        {
            pages.Add(new ListItem("First", "1", currentPage > 1));
            for (int i = 1; i <= pageCount; i++)
            {
                pages.Add(new ListItem(i.ToString(), i.ToString(), i != currentPage));
            }
            pages.Add(new ListItem("Last", pageCount.ToString(), currentPage < pageCount));
        }
        rptPager.DataSource = pages;
        rptPager.DataBind();

        hdnPageNo.Value = currentPage.ToString();
    }


    protected void Page_Changed(object sender, EventArgs e)
    {
        int pageIndex = int.Parse((sender as LinkButton).CommandArgument);
        this.GetCategories(pageIndex);

        hdnPageNo.Value = pageIndex.ToString();
    }

    protected int GetCurrentPage()
    {
        return FormatNumValues.GetNullInt(hdnPageNo.Value); ;
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        GetCategories(1);
    }
}
