using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class Admin_AddEditProduct : System.Web.UI.Page
{
    EncryptDecrypt ed = new EncryptDecrypt();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (UserMembership.GetUser() == null)
            return;

        if (!Page.IsPostBack)
        {
            string strProductID = Request.QueryString["ProductID"];

            if (strProductID == null || strProductID == "")
            {
                fvProduct.DefaultMode = FormViewMode.Insert;
                //Page.Form.DefaultButton = fvEvent.FindControl("btnAdd").UniqueID;
                ShowPageHeaders.SetPageTitle(this, "Add Product");
                Session["FIELDSCOUNT"] = 0;
            }
            else
            {
                fvProduct.DefaultMode = FormViewMode.Edit;
                ShowPageHeaders.SetPageTitle(this, "Edit Product");

                strProductID = Server.UrlDecode(ed.Decrypt(Request.QueryString["ProductID"]));
                string strCatID = GetProductDetails(strProductID);
                ddlCat_SelectedIndexChanged(null, null);
                DropDownList ddlSubCat = (DropDownList)fvProduct.FindControl("ddlSubCat");
                ddlSubCat.SelectedValue = strCatID;
                DropDownList ddlOccassion = (DropDownList)fvProduct.FindControl("ddlOccasion");
                ddlSubCat.SelectedValue = strCatID;
                ddlOccassion.SelectedValue = Session["OccasionID"].ToString();
                //CheckBox chkIsDiscounted = (CheckBox)fvProduct.FindControl("chkIsDiscounted");
                //if (Session["IsDiscounted"].ToString().Equals("True"))
                //    chkIsDiscounted.Checked = true;
                //CheckBox chkIsNewArrival = (CheckBox)fvProduct.FindControl("chkIsNewArrival");
                //if (Session["IsNewArrival"].ToString().Equals("True"))
                //    chkIsNewArrival.Checked = true;
                // hdnEventId.Value = strEventId;
            }

            //ddlCat_SelectedIndexChanged(null, null);
        }
       // AddFields();
    }

    protected void ddlCat_SelectedIndexChanged(object sender, EventArgs e)
    {
        DropDownList ddlCat = (DropDownList)fvProduct.FindControl("ddlCat");
        DropDownList ddlSubCat = (DropDownList)fvProduct.FindControl("ddlSubCat");
        DropDownList ddlOccassion = (DropDownList)fvProduct.FindControl("ddlOccasion");

        ddlSubCat.Items.Clear();
        ddlOccassion.Items.Clear();

        Category cat = new Category();
        DataTable dtSubCat = cat.GetSubCategory(int.Parse(ddlCat.SelectedItem.Value.ToString()));
        if (dtSubCat != null)
        {
            ddlSubCat.DataTextField = dtSubCat.Columns["CategoryName"].ToString();
            ddlSubCat.DataValueField = dtSubCat.Columns["CategoryID"].ToString();
            ddlSubCat.DataSource = dtSubCat;
            ddlSubCat.DataBind();
            ddlSubCat.Items.Insert(0, "Select");
        }
        string str = ddlSubCat.Items.Count.ToString();

        DataTable dtOccasion = cat.GetSubCategoryOccasion(int.Parse(ddlCat.SelectedItem.Value.ToString()));
        if (dtOccasion != null)
        {
            ddlOccassion.DataTextField = dtOccasion.Columns["Occasion"].ToString();
            ddlOccassion.DataValueField = dtOccasion.Columns["OccasionID"].ToString();
            ddlOccassion.DataSource = dtOccasion;
            ddlOccassion.DataBind();
            ddlOccassion.Items.Insert(0, "Select");
        }
    }

    protected string GetProductDetails(string strProductID)
    {
        Products product = new Products();
        product.ProductsID = FormatNumValues.GetNullInt(strProductID);
        DataTable dt = product.GetProductsByID();
        fvProduct.DataSource = dt;
        fvProduct.DataBind();
        Session["OccasionID"] = dt.Rows[0]["OccasionID"].ToString();
        Session["IsDiscounted"] = dt.Rows[0]["IsDiscounted"].ToString();
        Session["IsNewArrival"] = dt.Rows[0]["IsNewArrival"].ToString();
        
        hdnProductID.Value = strProductID;
        hdnImageName.Value = dt.Rows[0]["ImageName"].ToString();

        return dt.Rows[0]["SubCategoryID"].ToString();
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            if (Validation())
            {
                SaveImage();
                InsertProduct();

                Session["RecordUpdated"] = "0";
                Response.Redirect("ManageProduct.aspx");
            }
        }
    }

    private Boolean Validation()
    {
        CheckBox chkDisc = (CheckBox)fvProduct.FindControl("chkIsDiscounted");
        Label lblMsg = (Label)fvProduct.FindControl("lblMsg");
        TextBox txtPrice = (TextBox)fvProduct.FindControl("txtPriceDisc");
        TextBox txtPercent = (TextBox)fvProduct.FindControl("txtPercentDisc");
        TextBox txtOther = (TextBox)fvProduct.FindControl("txtOtherDisc");

        if ((chkDisc.Checked) && (txtPrice.Text.Equals("")) && (txtPercent.Text.Equals("")) && (txtOther.Text.Equals("")))
        {
            lblMsg.Text = "Please enter either of the discount values.";
            return false;
        }
        else return true;
    }

    protected void SaveImage()
    {
        //FileUpload fuUploadImg = (FileUpload)fvProduct.FindControl("fuProductImg");
        //fuUploadImg.SaveAs(AppDomain.CurrentDomain.BaseDirectory + "\\Images\\" + fuUploadImg.FileName);
       CreateRandomFileNameNSave();
    }

    /// <summary>
    /// Create random file name and saves on the server.
    /// </summary>
    string strFinalImageName = "";
    private void CreateRandomFileNameNSave()
    {
        FileUpload fuUploadImg = (FileUpload)fvProduct.FindControl("fuProductImg");
        string file = fuUploadImg.FileName.ToString();
        string filename = System.IO.Path.GetFileNameWithoutExtension(file);
        string sFileNameDt = DateTime.Now.Ticks.ToString();

        var extension = System.IO.Path.GetExtension(file).ToLower();

        string strImgName = filename + sFileNameDt + ".jpg";

        if (fuUploadImg.HasFile)
        {
            if (extension == ".png" || extension == ".jpg" || extension == ".jpeg" || extension == ".gif")
            {
                string strThImgName = "th" + strImgName;

                fuUploadImg.SaveAs(Server.MapPath("~\\Product Images\\" + strThImgName));
            }
        }
        strFinalImageName = "th" + strImgName;

        //Image img = (Image)fvProduct.FindControl("Image1");
        //img.ImageUrl = "../Product Images/" + strFinalImageName;
    }

    protected void InsertProduct()
    {
        Products product = new Products();
        //product = GetFields();
        product.InsertProducts(GetFields());
    }

    protected Products GetFields()
    {
        Products product = new Products();

        /*
            string file = flupThumb.FileName.ToString();
            string filename = System.IO.Path.GetFileNameWithoutExtension(file);
            string sFileNameDt = DateTime.Now.Ticks.ToString();

            var extension = System.IO.Path.GetExtension(file).ToLower();

            strImgName = filename + sFileNameDt + ".jpg";
       
        */

        product.ProductsID = FormatNumValues.GetNullInt(hdnProductID.Value);
        product.ProductsName = ((TextBox)fvProduct.FindControl("txtProductName")).Text;
        product.IsActive = true;
        product.IsRemoved = false;
        
        string imageName = ((FileUpload)fvProduct.FindControl("fuProductImg")).FileName.ToString();
        //string filename = System.IO.Path.GetFileNameWithoutExtension(imageName);
        //string sFileNameDt = DateTime.Now.Ticks.ToString();
        //string newImgName = filename + sFileNameDt + ".jpg";
        if (imageName.Equals(""))
            product.ImageName = hdnImageName.Value;
        else
            product.ImageName = strFinalImageName;
        
        product.ProductsCode = ((TextBox)fvProduct.FindControl("txtProductCode")).Text;

        product.ProductDescription = ((TextBox)fvProduct.FindControl("txtDescription")).Text;

        product.Price = FormatNumValues.GetNullDouble(((TextBox)fvProduct.FindControl("txtPrice")).Text);
        product.IsDiscounted = ((CheckBox)fvProduct.FindControl("chkIsDiscounted")).Checked;
        double priceDiscount = 0.0, percentDiscount = 0.0;
        if (!((TextBox)fvProduct.FindControl("txtPriceDisc")).Text.Equals(""))
            priceDiscount = double.Parse(((TextBox)fvProduct.FindControl("txtPriceDisc")).Text);
        
        product.PriceDiscount = priceDiscount;
        if (!((TextBox)fvProduct.FindControl("txtPercentDisc")).Text.Equals(""))
            percentDiscount = double.Parse(((TextBox)fvProduct.FindControl("txtPercentDisc")).Text);
        product.PercentDiscount = percentDiscount;

        List<ProductsOccasions> lstOccasions = new List<ProductsOccasions>();
        DropDownList ddlList = (DropDownList)fvProduct.FindControl("ddlOccasion");
        int ocaassionId = int.Parse(ddlList.SelectedItem.Value.ToString());
        //product.CatOccasion = catOcaassionId;
        product.Occasion = ocaassionId;
        product.Category = int.Parse(((DropDownList)fvProduct.FindControl("ddlCat")).SelectedItem.Value.ToString());
        product.SubCategory = int.Parse(((DropDownList)fvProduct.FindControl("ddlSubCat")).SelectedItem.Value.ToString());
        product.IsNewArrival = ((CheckBox)fvProduct.FindControl("chkIsNewArrival")).Checked;

        return product;
    }

    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        if (Validation())
        {
            SaveImage();
            UpdateProduct();

            Session["RecordUpdated"] = "1";
            Response.Redirect("ManageProduct.aspx");
        }
    }

    protected void UpdateProduct()
    {
        Products product = new Products();
        //product = GetFields();
        product.UpdateProducts(GetFields());
    }
}