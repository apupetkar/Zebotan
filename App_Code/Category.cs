using System;
using System.Collections.Generic;
using System.Web;
using System.Data.SqlClient;
using System.Data;

/// <summary>
/// Summary description for Category
/// </summary>
public class Category
{
    DBHandler DB = new DBHandler();
	public Category()
	{
   
	}

    int nCategoryID;
    string strCategoryName;
    int nParentCategoryID;
    string strParentCategoryName;
    List<CategoryOccasions> nlstOccasion;
    Boolean bIsActive;
    Boolean bIsRemoved;
    public static int recordCount;

    public int CategoryID
    {
        get { return nCategoryID; }

        set { nCategoryID = value; }
    }

    public string CategoryName
    {
        get { return strCategoryName; }

        set { strCategoryName = value; }
    }

    public int ParentCategoryID
    {
        get { return nParentCategoryID; }

        set { nParentCategoryID = value; }
    }

    public string ParentCategoryName
    {
        get { return strParentCategoryName; }

        set { strParentCategoryName = value; }

    }
    public List<CategoryOccasions> lstOccasion
    {
        get { return nlstOccasion; }

        set { nlstOccasion = value; }

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


    public DataSet GetCategory(int pageIndex, int nPageSize)
    {
        SqlCommand cmd = new SqlCommand();
        cmd.Parameters.AddWithValue("@CategoryID", nCategoryID);
        cmd.Parameters.AddWithValue("@CategoryName", strCategoryName);
        cmd.Parameters.AddWithValue("@PageIndex", pageIndex);
        cmd.Parameters.AddWithValue("@PageSize", nPageSize);
        cmd.Parameters.Add("@RecordCount", SqlDbType.Int, 4);
        cmd.Parameters["@RecordCount"].Direction = ParameterDirection.Output;

        DataSet ds = DB.GetDataSet(cmd, "r_GetCategoryPageWise");

        recordCount = Convert.ToInt32(cmd.Parameters["@RecordCount"].Value);

        if (recordCount == 0)
            return null;
        else
            return ds;
    }

    public List<Category> GetSubCategory()
    {
        SqlCommand cmd = new SqlCommand();
        cmd.Parameters.AddWithValue("@CategoryID", nCategoryID);
        cmd.Parameters.AddWithValue("@ParentCategoryID", nParentCategoryID);
        cmd.Parameters.AddWithValue("@CategoryName", strCategoryName);
        DataSet ds = DB.GetDataSet(cmd, "r_SubCategory_Select");
        if (ds == null || ds.Tables.Count == 0 || ds.Tables[0].Rows.Count == 0)
            return null;

        List<Category> lstCategory = new List<Category>();
        for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
        {
            Category cat = new Category();
            cat.ReadData(ds.Tables[0].Rows[i]);
            lstCategory.Add(cat);
        }
        return lstCategory;
    }

    //above and this can be merged.
    public DataTable GetSubCategory(int categoryID)
    {
        SqlCommand cmd = new SqlCommand();
        cmd.Parameters.AddWithValue("@ParentCategoryID", categoryID);
        DataTable dt = DB.GetDataTable(cmd, "r_SubCategory_Select");
        if (dt == null || dt.Rows.Count == 0)
            return null;
        else
            return dt;
    }
    
    public DataTable GetSubCategoryOccasion(int categoryID)
    {
        SqlCommand cmd = new SqlCommand();
        cmd.Parameters.AddWithValue("@CategoryID", categoryID);
        DataTable dt = DB.GetDataTable(cmd, "r_CategoryOccasion_Select");
        if (dt == null || dt.Rows.Count == 0)
            return null;
        else
            return dt;
    }

    public DataTable GetCategoryByID()
    {
        SqlCommand cmd = new SqlCommand();
        cmd.Parameters.AddWithValue("@CategoryID", nCategoryID);
        DataSet ds = DB.GetDataSet(cmd, "r_Category_SelectByID");
        if (ds == null || ds.Tables.Count == 0 || ds.Tables[0].Rows.Count == 0)
            return null;

        DataTable dt = ds.Tables[0];

        return dt;
    }

    private void ReadData(DataRow dr)
    {
        //get events fields
        nCategoryID = FormatNumValues.GetNullInt(dr["CategoryID"].ToString());
        strCategoryName = dr["CategoryName"].ToString();
        nParentCategoryID = FormatNumValues.GetNullInt(dr["ParentCategoryID"].ToString());
        strParentCategoryName = dr["ParentCategoryName"].ToString();
        bIsActive = FormatNumValues.GetNullBoolean(dr["IsActive"].ToString());
        bIsRemoved = FormatNumValues.GetNullBoolean(dr["IsRemoved"].ToString());
    }

    public void UpdateCategory(Boolean bOccasions)
    {
        SqlCommand cmd = new SqlCommand();
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@CategoryID", nCategoryID);
        cmd.Parameters.AddWithValue("@CategoryName", strCategoryName);
        cmd.Parameters.AddWithValue("@ParentCategoryID", nParentCategoryID);
        cmd.Parameters.AddWithValue("@IsActive", bIsActive);
        cmd.Parameters.AddWithValue("@IsRemoved", bIsRemoved);
        
        string strSQL = DB.GetSingleValue(cmd, "i_Category_Update");

        if (!bOccasions) return;

        //delete the earlier ones and add new ones.
        CategoryOccasions catOccasions = new CategoryOccasions();
        catOccasions.CategoryID = nCategoryID;
        catOccasions.DeleteOccasions();

        for (int i = 0; i < lstOccasion.Count; i++)
        {
            catOccasions = lstOccasion[i];
            catOccasions.CategoryID = nCategoryID;
            catOccasions.InsertOccasions();
        }
    }

    public void InsertCategory(Boolean bOccasions)
    {
        SqlCommand cmd = new SqlCommand();
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@CategoryName", strCategoryName);
        cmd.Parameters.AddWithValue("@ParentCategoryID", nParentCategoryID);

        string strSQL = DB.GetSingleValue(cmd, "i_Category_Insert");

        if (!bOccasions) return;

        nCategoryID = FormatNumValues.GetNullInt(strSQL);

        for (int i = 0; i < lstOccasion.Count; i++)
        {
            CategoryOccasions catOccasions = lstOccasion[i];
            catOccasions.CategoryID = nCategoryID;
            catOccasions.InsertOccasions();
        }
    }

    public void UpdateStatus()
    {
        SqlCommand cmd = new SqlCommand();
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@CategoryID", nCategoryID);
        string strSQL = DB.GetSingleValue(cmd, "i_Category_ChangeStatus");

    }

    public void DeleteCategory()
    {
        SqlCommand cmd = new SqlCommand();
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@CategoryID", nCategoryID);

        string strSQL = DB.GetSingleValue(cmd, "i_Category_Delete");
    }

    public Boolean CategoryExists()
    {
        SqlCommand cmd = new SqlCommand();
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@CategoryName", strCategoryName);

        string strSQL = DB.GetSingleValue(cmd, "r_Category_Exists");

        return (FormatNumValues.GetNullInt(strSQL) > 0);
    }
    
}


public class CategoryOccasions
{
    DBHandler DB = new DBHandler();
    public CategoryOccasions()
    {

    }

    int nCategoryID;
    int nOccasionID;

    public int CategoryID
    {
        get { return nCategoryID; }

        set { nCategoryID = value; }
    }

    public int OccasionID
    {
        get { return nOccasionID; }

        set { nOccasionID = value; }
    }
    
    public void InsertOccasions()
    {
        SqlCommand cmd = new SqlCommand();
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@CategoryID", nCategoryID);
        cmd.Parameters.AddWithValue("@OccasionID", nOccasionID);

        string strSQL = DB.GetSingleValue(cmd, "i_CategoryOccasion_Insert");
    }

    public void DeleteOccasions()
    {
        SqlCommand cmd = new SqlCommand();
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@CategoryID", nCategoryID);

        string strSQL = DB.GetSingleValue(cmd, "i_CategoryOccasion_Delete");
    }
}