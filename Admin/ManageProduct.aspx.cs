using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

public partial class ManageProduct : System.Web.UI.Page
{
    int _PAGE_SIZE = 3;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (UserMembership.GetUser() == null)
            Response.Redirect("AdminLogin.aspx");

        // fvProduct.Visible = false;

        ShowPageHeaders.SetPageTitle(this, "Manage Products");
        lblMsg.Text = "";
        //ShowSearchBox(true);
        //ask ap
        if (Session["PAGEINDEX"] == null || Session["PAGEINDEX"].Equals(""))
            GetProductsPageWise(1);
        else
            GetProductsPageWise(int.Parse(Session["PAGEINDEX"].ToString()));

        if (!Page.IsPostBack)
        {
            
           // Session["PAGEINDEX"] = 1;
            ShowMessage();
        }
       
    }

    protected void ShowMessage()
    {
        if (Session["RecordUpdated"] != null)
        {
            if (Convert.ToString(Session["RecordUpdated"]) == "0")
            {
                lblMsg.Text = "Product added successfully.";
                Session["RecordUpdated"] = "";
            }
            else if (Convert.ToString(Session["RecordUpdated"]) == "1")
            {
                lblMsg.Text = "Product updated successfully.";
                Session["RecordUpdated"] = "";

                //SetSessionValues();
            }
            else
            {
                lblMsg.Text = "";
                //SetSessionValues();
            }
        }
        else
        {
            lblMsg.Text = "";
            //SetSessionValues();
        }

        SetSessionValues();
    }

    //protected void ShowSearchBox(Boolean bShow)
    //{
    //    if(!bShow)
    //        tblSearch.Style.Add("display", "none");
    //    else
    //        tblSearch.Style.Remove("display");

    //}

    protected void SetSessionValues()
    {
        if (Session["PAGEINDEX"] != null && Convert.ToString(Session["PAGEINDEX"]) != "")
        {
            //stores page index in session
            gvProduct.PageIndex = Convert.ToInt32(Session["PAGEINDEX"]) - 1;
            //restore value stored in session txtName to the textbox
            if (Convert.ToString(Session["txtProductName"]) != "")
            {
                //Set Products Title from session to maintain search result
                txtProductName.Text = Convert.ToString(Session["txtProductName"]);
            }
        }
        //ClearSession();
    }

    protected void ClearSession()
    {
        Session["PAGEINDEX"] = "";
        Session["txtProductName"] = "";
    }

    protected void lnkStatus_Clicked(object sender, EventArgs e)
    { 
        Session["PAGEINDEX"] = GetCurrentPage();
        ImageButton img = (ImageButton)sender;
        string str = img.CommandArgument;

        Products product = new Products();
        product.ProductsID = FormatNumValues.GetNullInt(str);
        product.UpdateStatus();

        //Session["RecordUpdated"] = "2";
        //ShowMessage();

        lblMsg.Text = "Product status changed successfully.";
        GetProductsPageWise(FormatNumValues.GetNullInt(Session["PAGEINDEX"].ToString()));
    }

    protected void lnkEdit_Clicked(object sender, EventArgs e)
    {
        //Session["PAGEINDEX"] = gvProduct.PageIndex;
        Session["PAGEINDEX"] = GetCurrentPage();
        ImageButton img = (ImageButton)sender;
        string str = img.CommandArgument;

        EncryptDecrypt ed = new EncryptDecrypt();
        string strProductID = Server.UrlEncode(ed.Encrypt(str));
        Response.Redirect("AddEditProduct.aspx?ProductID=" + strProductID);

        //ShowSearchBox(false);
        //fvProduct.Visible = true;

        //string strProductID = str;
        //if (strProductID == null || strProductID == "")
        //{
        //    fvProduct.DefaultMode = FormViewMode.Insert;
        //    ShowPageHeaders.SetPageTitle(this, "Add Products");
        //}
        //else
        //{
        //    fvProduct.DefaultMode = FormViewMode.Edit;
        //    ShowPageHeaders.SetPageTitle(this, "Edit Products");
        //    TextOnHeader("Edit Products");

        //    hdnProductID.Value = strProductID;

        //    Products product = new Products();
        //    product.ProductsID = FormatNumValues.GetNullInt(strProductID);
        //    DataTable dt = product.GetProductsByID();
        //    fvProduct.DataSource = dt;
        //    fvProduct.DataBind();
        //ask ap
        //    DropDownList ddlCat = (DropDownList)fvProduct.FindControl("ddlCat");
        //    ddlCat.SelectedItem.Text = dt.Rows[0]["CategoryName"].ToString();
        //    ddlCat.SelectedItem.Value = dt.Rows[0]["CategoryID"].ToString();

        //    DropDownList ddlSubCat = (DropDownList)fvProduct.FindControl("ddlSubCat");
        //    ddlSubCat.SelectedItem.Text = dt.Rows[0]["CategoryName"].ToString();
        //    ddlSubCat.SelectedItem.Value = dt.Rows[0]["CategoryID"].ToString();

        //    hdnImageName.Value = dt.Rows[0]["ImageName"].ToString();
        //}
    }

    protected int GetCurrentPage()
    {
        return FormatNumValues.GetNullInt(hdnPageNo.Value);
    }

    //protected void lnkDelete_Clicked(object sender, EventArgs e)
    //{
    //    ImageButton img = (ImageButton)sender;
    //    string str = img.CommandArgument;

    //}
    protected void gvProduct_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        Session["PAGEINDEX"] = e.NewPageIndex + 1;
        GetProductsPageWise(Convert.ToInt16(Session["PAGEINDEX"].ToString()));
    }

    protected void gvProduct_DataBound(object sender, EventArgs e)
    {
        //Paging.GridView_DataBound(sender);
    }

    protected void gvProduct_RowCreated(object sender, GridViewRowEventArgs e)
    {
        //Paging.GridView_RowCreated(sender, e);
    }

    protected void gvProduct_RowCommand(object sender, GridViewCommandEventArgs e)
    {

        //Paging.GridView_RowCommand(sender, e);
        //need to confirm if this is required.
        //throws error some times. reverify may be need to keep pageindex as 1 by default
        //Session["PAGEINDEX"] = 1;
        // GetProductsPageWise(int.Parse(Session["PAGEINDEX"].ToString()));
    }

    protected void btnAddNewProduct_Click(object sender, EventArgs e)
    {
        Session["Products"] = gvProduct.PageIndex;


        Response.Redirect("~/Admin/AddEditProduct.aspx");


        //TextOnHeader("Add New Products");
        //ShowSearchBox(false);
        //fvProduct.Visible = true;
        //fvProduct.DefaultMode = FormViewMode.Insert;
        //fvProduct.DataSource = null;

    }

    protected void TextOnHeader(string strHeader)
    {
        //Label lblHeader = ((Label)fvProduct.FindControl("fvHeader"));
        //if (lblHeader != null)
        //    lblHeader.Text = strHeader;
    }

    //protected void btnAddNew_Click(object sender, EventArgs e)
    //{
    //    Session["Products"] = gvProduct.PageIndex;

    //    fvProduct.Visible = true;
    //    FileUpload fuUploadImg = (FileUpload)fvProduct.FindControl("fuProductImg");
    //    fuUploadImg.SaveAs(AppDomain.CurrentDomain.BaseDirectory + "\\Images\\" + fuUploadImg.FileName);

    //    InsertProduct();

    //    Session["RecordUpdated"] = "0";
    //    Response.Redirect("ManageProduct.aspx");
    //}

    protected void ddlCat_SelectedIndexChanged(object sender, EventArgs e)
    {
        //ddlSubCat.Items.Clear();
        //ddlOccassion.Items.Clear();

        //Category cat = new Category();
        //DataTable dtCat  = cat.GetSubCategory(int.Parse(ddlCat.SelectedItem.Value.ToString()));
        //ddlSubCat.DataTextField = dtCat.Columns["CategoryName"].ToString();
        //ddlSubCat.DataValueField = dtCat.Columns["CategoryID"].ToString();
        //ddlSubCat.DataSource = dtCat;
        //ddlSubCat.DataBind();

        //DataTable dtSubCat = cat.GetSubCategoryOccasion(int.Parse(ddlCat.SelectedItem.Value.ToString()));
        //ddlOccassion.DataTextField = dtSubCat.Columns["Occasion"].ToString();
        //ddlOccassion.DataValueField = dtSubCat.Columns["OccasionID"].ToString();
        //ddlOccassion.DataSource = dtSubCat;
        //ddlOccassion.DataBind();
    }

    protected void btnGetProducts_Click(object sender, EventArgs e)
    {
        GetProductsPageWise(1);
    }

    //protected void InsertProduct()
    //{
    //    Products product = new Products();
    //    //product = GetFields();
    //    product.InsertProducts(GetFields());
    //}

    //protected Products GetFields()
    //{
    //    Products product = new Products();
    //    product.ProductsID = FormatNumValues.GetNullInt(hdnProductID.Value);
    //    product.ProductsName = ((TextBox)fvProduct.FindControl("txtProductName")).Text;
    //    product.IsActive = true;
    //    product.IsRemoved = false;
    //    string imageName = ((FileUpload)fvProduct.FindControl("fuProductImg")).FileName.ToString();
    //    if (imageName.Equals(""))
    //        product.ImageName = hdnImageName.Value;
    //    else
    //        product.ImageName = imageName;
    //    product.ProductsCode = ((TextBox)fvProduct.FindControl("txtProductCode")).Text;
    //    product.IsDiscounted = ((CheckBox)fvProduct.FindControl("chkIsDiscounted")).Checked;
    //    double priceDiscount = 0.0, percentDiscount = 0.0;
    //    if (!((TextBox)fvProduct.FindControl("txtPriceDisc")).Text.Equals(""))
    //        priceDiscount = double.Parse(((TextBox)fvProduct.FindControl("txtPriceDisc")).Text);
    //    product.PriceDiscount = priceDiscount;
    //    if (!((TextBox)fvProduct.FindControl("txtPercentDisc")).Text.Equals(""))
    //        percentDiscount = double.Parse(((TextBox)fvProduct.FindControl("txtPercentDisc")).Text);
    //    product.PercentDiscount = percentDiscount;

    //    List<ProductsOccasions> lstOccasions = new List<ProductsOccasions>();
    //    CheckBoxList chkList = (CheckBoxList)fvProduct.FindControl("chkOccasions");
    //    int nOccasions = chkList.Items.Count;
    //    int catOcaassionId = 0;
    //    for (int i = 0; i < nOccasions; i++)
    //    {
    //        if (chkList.Items[i].Selected)
    //        {
    //            catOcaassionId = FormatNumValues.GetNullInt(chkList.Items[i].Value);
    //            break;
    //        }
    //    }
    //    product.CatOccasion = catOcaassionId;
    //    return product;
    //}

    //protected void btnUpdate_Click(object sender, EventArgs e)
    //{
    //    Session["Products"] = gvProduct.PageIndex;
    //    fvProduct.Visible = true;

    //    UpdateProduct();

    //    Session["RecordUpdated"] = "1";
    //    Response.Redirect("ManageProduct.aspx");
    //}

    //protected void UpdateProduct()
    //{
    //    Products product = new Products();
    //    //product = GetFields();
    //    product.UpdateProducts(GetFields());
    //}

    protected void lnkDelete_Clicked(object sender, EventArgs e)
    {
        Session["PAGEINDEX"] = GetCurrentPage();
        ImageButton img = (ImageButton)sender;
        string str = img.CommandArgument;

        Products product = new Products();
        product.ProductsID = FormatNumValues.GetNullInt(str);
        product.DeleteProducts();

        //Session["RecordUpdated"] = "3";
        //ShowMessage();
        //Response.Redirect("ManageCategory.aspx");
        lblMsg.Text = "Product deleted successfully.";
        GetProductsPageWise(Convert.ToInt32(Session["PAGEINDEX"]));
    }

    //protected void gvProduct_RowDeleted(object sender, GridViewDeletedEventArgs e)
    //{
    //    lblMsg.Text = "Products deleted successfully.";
    //}

    private void GetProductsPageWise(int pageIndex)
    {
        gvProduct.DataSource = null;
        string constring = ConfigurationManager.ConnectionStrings["strconn"].ConnectionString;
        using (SqlConnection con = new SqlConnection(constring))
        {
            // using (SqlCommand cmd = new SqlCommand("GetCustomersPageWise", con))
            {
                SqlCommand cmd = new SqlCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@PageIndex", pageIndex);
                cmd.Parameters.AddWithValue("@PageSize", _PAGE_SIZE);
                cmd.Parameters.Add("@RecordCount", SqlDbType.Int, 4);
                cmd.Parameters["@RecordCount"].Direction = ParameterDirection.Output;

                //if (!ddlCat.SelectedValue.Equals("0"))
                cmd.Parameters.AddWithValue("@CategoryID", ddlCat.SelectedValue);
                //if (!ddlSubCat.SelectedValue.Equals("0"))
                cmd.Parameters.AddWithValue("@SubCatID", ddlSubCat.SelectedValue);
                //if (!ddlOccassion.SelectedValue.Equals("0"))
                cmd.Parameters.AddWithValue("@OccassionID", ddlOccassion.SelectedValue);
                //if (!txtProductName.Text.Equals(""))
                cmd.Parameters.AddWithValue("@ProductName", txtProductName.Text);
                
                con.Open();
                //IDataReader idr = cmd.ExecuteReader();
                DBHandler DB = new DBHandler();
                DataSet ds = DB.GetDataSet(cmd, "r_GetProductsPageWise");
                gvProduct.DataSource = ds;
                gvProduct.DataBind();

                con.Close();
                int recordCount = Convert.ToInt32(cmd.Parameters["@RecordCount"].Value);
                this.PopulatePager(recordCount, pageIndex);
            }
        }
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
        this.GetProductsPageWise(pageIndex);
        Session["PAGEINDEX"] = pageIndex;
    }

}

