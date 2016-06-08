using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

public partial class ProductsList : System.Web.UI.Page
{
    int _PAGE_SIZE = 6;
    string strCategory = "";
    Boolean bProductsList = true;
    Boolean bIsNewArrival;
    Boolean bIsDiscounted;
    EncryptDecrypt ed = new EncryptDecrypt();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            if (Request.QueryString["CategoryID"] == null)
            {
                strCategory = "";
                bProductsList = true;
            }
            else
            {
                strCategory = Server.UrlDecode(ed.Decrypt(Request.QueryString["CategoryID"]));
                Session["CategoryID"] = strCategory;
                bProductsList = true;
            }
            
            if(Request.QueryString["IsNewArrival"] != null || Request.QueryString["IsDiscounted"] != null)
                bProductsList = false;

            bIsNewArrival = FormatNumValues.GetNullBoolean(Request.QueryString["IsNewArrival"]);
            bIsDiscounted = FormatNumValues.GetNullBoolean(Request.QueryString["IsDiscounted"]);
                
            GetProductsPageWise(1);
        }
    }

    private void GetProductsPageWise(int pageIndex)
    {
        lvProduct.DataSource = null;
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
                if (Session["CategoryID"] != "")
                    cmd.Parameters.AddWithValue("@CategoryID", Session["CategoryID"]);
                else
                    cmd.Parameters.AddWithValue("@CategoryID", GetSelectedCriteriaValue(chkListCat));
                cmd.Parameters.AddWithValue("@SubCatID", GetSelectedCriteriaValue(chkListSubCat));
                cmd.Parameters.AddWithValue("@OccassionID", GetSelectedCriteriaValue(chkListOcc));

                if (bProductsList)
                {
                    cmd.Parameters.AddWithValue("@IsNewArival", null);
                    cmd.Parameters.AddWithValue("@IsDiscounted", null);
                }
                else
                {
                    cmd.Parameters.AddWithValue("@IsNewArival", bIsNewArrival);
                    cmd.Parameters.AddWithValue("@IsDiscounted", bIsDiscounted);
                }
                
                con.Open();
                DBHandler DB = new DBHandler();
                DataSet ds = DB.GetDataSet(cmd, "r_GetListingProductsPageWise");
                lvProduct.DataSource = ds;
                lvProduct.DataBind();

                con.Close();
                int recordCount = Convert.ToInt32(cmd.Parameters["@RecordCount"].Value);
                this.PopulatePager(recordCount, pageIndex);
            }
        }
    }

    private void GetSubCategories()
    {

    }

    private string GetSelectedCriteriaValue(CheckBoxList chkList)
    {
        string selectedValue = string.Empty;
        for (int i = 0; i < chkList.Items.Count; i++)
        {
            if (chkList.Items[i].Selected)
            {
                selectedValue = selectedValue + chkList.Items[i].Value.ToString() + ",";
            }
        }
        
        if (selectedValue.Equals(""))
            return null;
        else 
            return selectedValue.Substring(0, selectedValue.Length - 1);
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

    protected void lvProduct_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        Session["PAGEINDEX"] = e.NewPageIndex + 1;
        GetProductsPageWise(Convert.ToInt16(Session["PAGEINDEX"].ToString()));
    }

    protected void Page_Changed(object sender, EventArgs e)
    {
        int pageIndex = int.Parse((sender as LinkButton).CommandArgument);
        this.GetProductsPageWise(pageIndex);
        Session["PAGEINDEX"] = pageIndex;
    }

    protected void chkListCat_SelectedIndexChanged(object sender, EventArgs e)
    {
        Session["CategoryID"] = "";
        GetProductsPageWise(1);
        GetSubCategories();
    }

    protected void chkListSubCat_SelectedIndexChanged(object sender, EventArgs e)
    {
        GetProductsPageWise(1);
    }

    protected void chkListOcc_SelectedIndexChanged(object sender, EventArgs e)
    {
        GetProductsPageWise(1);
    }

    protected void lvProduct_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        if (e.CommandName == "")
        {
            HiddenField hdn = ((HiddenField)e.Item.FindControl("hdnProduct"));
            if(hdn.Value == null)
                Response.Redirect("ProductDetails.aspx?ProductID=" + ed.Encrypt(""));
            else
                Response.Redirect("ProductDetails.aspx?ProductID=" + ed.Encrypt(hdn.Value));
        }
    }
}