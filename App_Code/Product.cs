using System;
using System.Collections.Generic;
using System.Web;
using System.Data.SqlClient;
using System.Data;

/// <summary>
/// Summary description for Products
/// </summary>
public class Products
{
    DBHandler DB = new DBHandler();
    public Products()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    /// <summary>
    /// Summary description for Products
    /// </summary>

    int nProductsID;
    string strProductsName;
    string strImageName;
    //int nCatOccID;
    int nQty;
    double price;
    double percentDisc;
    double priceDisc;
    string otherDisc;
    string strProductCode;
    string strProductDesc;
    int nCategoryID;
    int nSubCategoryID;
    int nOccasionID;
    Boolean bIsActive;
    Boolean bIsRemoved;
    Boolean bIsNewArrival;
    Boolean bIsDiscounted;

    public int ProductsID
    {
        get { return nProductsID; }

        set { nProductsID = value; }
    }

    public string ProductsName
    {
        get { return strProductsName; }

        set { strProductsName = value; }
    }

    public string ImageName
    {
        get { return strImageName; }

        set { strImageName = value; }
    }

    public string ProductsCode
    {
        get { return strProductCode; }

        set { strProductCode = value; }

    }

    public string ProductDescription
    {
        get { return strProductDesc; }

        set { strProductDesc = value; }

    }

    public int Category
    {
        get { return nCategoryID; }

        set { nCategoryID = value; }

    }

    public int SubCategory
    {
        get { return nSubCategoryID; }

        set { nSubCategoryID = value; }

    }

    public int Occasion
    {
        get { return nOccasionID; }

        set { nOccasionID = value; }

    }

    public int Quantity
    {
        get { return nQty; }

        set { nQty = value; }
    }

    public double Price
    {
        get { return price; }

        set { price = value; }
    }

    public double PercentDiscount
    {
        get { return percentDisc; }

        set { percentDisc = value; }
    }

    public double PriceDiscount
    {
        get { return priceDisc; }

        set { priceDisc = value; }
    }

    public string OtherDiscount
    {
        get { return otherDisc; }

        set { otherDisc = value; }
    }

    public Boolean IsActive
    {
        get { return bIsActive; }

        set { bIsActive = value; }
    }

    public Boolean IsRemoved
    {
        get { return bIsRemoved; }

        set { bIsRemoved = value; }
    }

    public Boolean IsNewArrival
    {
        get { return bIsNewArrival; }

        set { bIsNewArrival = value; }
    }

    public Boolean IsDiscounted
    {
        get { return bIsDiscounted; }

        set { bIsDiscounted = value; }
    }

    public List<Products> GetProducts()
    {
        SqlCommand cmd = new SqlCommand();
        cmd.Parameters.AddWithValue("@ProductID", nProductsID);
        DataSet ds = DB.GetDataSet(cmd, "r_Products_Select");
        if (ds == null || ds.Tables.Count == 0 || ds.Tables[0].Rows.Count == 0)
            return null;

        List<Products> lstProducts = new List<Products>();
        for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
        {
            Products cat = new Products();
            cat.ReadData(ds.Tables[0].Rows[i]);
            lstProducts.Add(cat);
        }
        return lstProducts;
    }

    //ap
    public List<Products> GetSubProducts()
    {
        SqlCommand cmd = new SqlCommand();
        cmd.Parameters.AddWithValue("@ProductsID", nProductsID);
        DataSet ds = DB.GetDataSet(cmd, "r_SubProductsMst_Select");
        if (ds == null || ds.Tables.Count == 0 || ds.Tables[0].Rows.Count == 0)
            return null;

        List<Products> lstProducts = new List<Products>();
        for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
        {
            Products cat = new Products();
            cat.ReadData(ds.Tables[0].Rows[i]);
            lstProducts.Add(cat);
        }
        return lstProducts;
    }

    public DataTable GetProductsByID()
    {
        SqlCommand cmd = new SqlCommand();
        cmd.Parameters.AddWithValue("@ProductID", nProductsID);
        DataSet ds = DB.GetDataSet(cmd, "r_Products_Select");
        if (ds == null || ds.Tables.Count == 0 || ds.Tables[0].Rows.Count == 0)
            return null;

        DataTable dt = ds.Tables[0];

        return dt;
    }

    private void ReadData(DataRow dr)
    {
        //get events fields
        nProductsID = FormatNumValues.GetNullInt(dr["ProductID"].ToString());
        strProductsName = dr["ProductName"].ToString();
        //nParentProductsID = FormatNumValues.GetNullInt(dr["ParentProductsID"].ToString());
        strProductCode = dr["ProductCode"].ToString();
        strImageName = dr["ImageName"].ToString();
        strProductDesc = dr["Description"].ToString();
        bIsNewArrival = FormatNumValues.GetNullBoolean(dr["IsNewArrival"].ToString());
        bIsDiscounted = FormatNumValues.GetNullBoolean(dr["IsDiscounted"].ToString());
        price = FormatNumValues.GetNullDouble(dr["Price"].ToString());
        percentDisc = FormatNumValues.GetNullDouble(dr["PercentDisc"].ToString());
        priceDisc = FormatNumValues.GetNullDouble(dr["PriceDisc"].ToString());
        //otherDisc = FormatNumValues.GetNullDouble(dr["Others"].ToString());
        //strParentProductsName = dr["ParentProductsID"].ToString();
        bIsActive = FormatNumValues.GetNullBoolean(dr["IsActive"].ToString());
        bIsRemoved = FormatNumValues.GetNullBoolean(dr["IsRemoved"].ToString());
    }

    public void UpdateProducts(Products product)
    {
        SqlCommand cmd = new SqlCommand();
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add(new SqlParameter("@ProductID", product.ProductsID));
        cmd.Parameters.Add(new SqlParameter("@ProductName", product.ProductsName.ToString()));
        cmd.Parameters.Add(new SqlParameter("@ProductCode", product.ProductsCode.ToString()));
        cmd.Parameters.Add(new SqlParameter("@ImageName", product.ImageName.ToString()));
        cmd.Parameters.Add(new SqlParameter("@Description", product.strProductDesc));
        cmd.Parameters.Add(new SqlParameter("@Qty", product.Quantity));
        cmd.Parameters.Add(new SqlParameter("@Price", product.Price));
        cmd.Parameters.Add(new SqlParameter("@IsDiscounted", product.IsDiscounted));
        cmd.Parameters.Add(new SqlParameter("@PercentDisc", product.PercentDiscount));
        cmd.Parameters.Add(new SqlParameter("@PriceDisc", product.PriceDiscount));
        cmd.Parameters.Add(new SqlParameter("@Others", product.OtherDiscount));
        cmd.Parameters.Add(new SqlParameter("@CategoryID", product.Category));
        cmd.Parameters.Add(new SqlParameter("@SubCategoryID", product.SubCategory));
        cmd.Parameters.Add(new SqlParameter("@OccasionID", product.Occasion));
        cmd.Parameters.Add(new SqlParameter("@IsNewArrival", product.IsNewArrival));

        string strSQL = DB.GetSingleValue(cmd, "i_Products_Update");

    }

    public void InsertProducts(Products product)
    {

        SqlCommand cmd = new SqlCommand();
        cmd.CommandType = CommandType.StoredProcedure;

        cmd.Parameters.Add(new SqlParameter("@ProductName", product.ProductsName.ToString()));
        cmd.Parameters.Add(new SqlParameter("@ProductCode", product.ProductsCode.ToString()));
        cmd.Parameters.Add(new SqlParameter("@ImageName", product.ImageName.ToString()));
        cmd.Parameters.Add(new SqlParameter("@Description", product.strProductDesc));
        cmd.Parameters.Add(new SqlParameter("@Qty", product.Quantity));
        cmd.Parameters.Add(new SqlParameter("@Price", product.Price));
        cmd.Parameters.Add(new SqlParameter("@IsDiscounted", product.IsDiscounted));
        cmd.Parameters.Add(new SqlParameter("@PercentDisc", product.PercentDiscount));
        cmd.Parameters.Add(new SqlParameter("@PriceDisc", product.PriceDiscount));
        cmd.Parameters.Add(new SqlParameter("@Others", product.OtherDiscount));
        cmd.Parameters.Add(new SqlParameter("@CategoryID", product.Category));
        cmd.Parameters.Add(new SqlParameter("@SubCategoryID", product.SubCategory));
        cmd.Parameters.Add(new SqlParameter("@OccasionID", product.Occasion));
        cmd.Parameters.Add(new SqlParameter("@IsNewArrival", product.IsNewArrival));

        string strSQL = DB.GetSingleValue(cmd, "i_Products_Insert");

        nProductsID = FormatNumValues.GetNullInt(strSQL);
        product.ProductsID = nProductsID;

    }

    public void UpdateStatus()
    {
        SqlCommand cmd = new SqlCommand();
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@ProductID", nProductsID);
        string strSQL = DB.GetSingleValue(cmd, "i_Product_ChangeStatus");

    }

    //protected void InsertOccasions()
    //{
    //    lstOccasion = new List<ProductsOccasions>();
    //    ProductsOccasions occasion = new ProductsOccasions();
    //    lstOccasion = occasion.GetOccasion(nProductsID);
    //}

    public void DeleteProducts()
    {
        SqlCommand cmd = new SqlCommand();
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@ProductID", nProductsID);

        string strSQL = DB.GetSingleValue(cmd, "i_Product_Delete");
    }

}


public class ProductsOccasions
{
    DBHandler DB = new DBHandler();
    public ProductsOccasions()
    {

    }

    int nProductsID;
    int nOccasionID;

    public int ProductsID
    {
        get { return nProductsID; }

        set { nProductsID = value; }
    }

    public int OccasionID
    {
        get { return nOccasionID; }

        set { nOccasionID = value; }
    }



    //public List<Occasion> GetOccasion(int nProductsID)
    //{
    //    SqlCommand cmd = new SqlCommand();
    //    cmd.Parameters.AddWithValue("@ProductsID", nProductsID);
    //    DataSet ds = DB.GetDataSet(cmd, "r_OccasionMst_Select");
    //    if (ds == null || ds.Tables.Count == 0 || ds.Tables[0].Rows.Count == 0)
    //        return null;

    //    List<Occasion> lstOccasion = new List<Occasion>();
    //    for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
    //    {
    //        Occasion occasion = new Occasion();
    //        occasion.ReadData(ds.Tables[0].Rows[i]);
    //        lstOccasion.Add(occasion);
    //    }
    //    return lstOccasion;
    //}

    //private void ReadData(DataRow dr)
    //{
    //    nOccasionID = FormatNumValues.GetNullInt(dr["OccasionID"].ToString());
    //    strOccasionName = dr["Occasion"].ToString();
    // }


    public void InsertOccasions()
    {
        SqlCommand cmd = new SqlCommand();
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@ProductsID", nProductsID);
        cmd.Parameters.AddWithValue("@OccasionID", nOccasionID);

        string strSQL = DB.GetSingleValue(cmd, "i_ProductsOccasion_Insert");
    }

    public void DeleteOccasions()
    {
        SqlCommand cmd = new SqlCommand();
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@ProductsID", nProductsID);

        string strSQL = DB.GetSingleValue(cmd, "i_ProductsOccasion_Delete");
    }

    //public void UpdateProducts()
    //{
    //    SqlCommand cmd = new SqlCommand();
    //    cmd.CommandType = CommandType.StoredProcedure;
    //    cmd.Parameters.AddWithValue("@ProductsID", nProductsID);
    //    cmd.Parameters.AddWithValue("@ProductsName", strProductsName);
    //    //cmd.Parameters.AddWithValue("@ParentProductsID", nParentProductsID);

    //    string strSQL = DB.GetSingleValue(cmd, "i_ProductsMst_Update");
    //}



    //public void DeleteProducts()
    //{
    //    SqlCommand cmd = new SqlCommand();
    //    cmd.CommandType = CommandType.StoredProcedure;
    //    cmd.Parameters.AddWithValue("@ProductsID", nProductsID);

    //    string strSQL = DB.GetSingleValue(cmd, "i_ProductsMst_Delete");
    //}

}