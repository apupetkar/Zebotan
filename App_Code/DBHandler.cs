using System;
using System.Collections.Generic;
using System.Web;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

/// <summary>
/// Summary description for DBHandler
/// </summary>
public class DBHandler
{
    string strconn = ConfigurationManager.ConnectionStrings["strconn"].ConnectionString;
    public bool ExecuteNonQuery(SqlCommand sqlcmdWithParameters, string CommandText)
    {
        bool bFail = false;
        SqlConnection sqlcon = new SqlConnection(strconn);
        sqlcmdWithParameters.Connection = sqlcon;
        sqlcmdWithParameters.CommandType = CommandType.StoredProcedure;
        sqlcmdWithParameters.CommandText = CommandText;
        try
        {
            sqlcon.Open();
            sqlcmdWithParameters.ExecuteNonQuery();
        }
        catch (Exception ex)
        {
            bFail = true;
        }
        finally
        {
            sqlcon.Close();
        }
        return !(bFail);
    }

    public string GetSingleValue(SqlCommand sqlcmdWithParameters, string CommandText)
    {
        string sReturn = "";
        SqlConnection sqlcon = new SqlConnection(strconn);
        sqlcmdWithParameters.Connection = sqlcon;
        sqlcmdWithParameters.CommandType = CommandType.StoredProcedure;
        sqlcmdWithParameters.CommandText = CommandText;
        try
        {
            sqlcon.Open();
            sReturn = Convert.ToString(sqlcmdWithParameters.ExecuteScalar());
        }
        catch (Exception ex)
        {
            sReturn = "-1";
        }
        finally
        {
            sqlcon.Close();
        }
        return sReturn;
    }


    public DataTable GetDataTable(SqlCommand sqlcmdWithParameters, string CommandText)
    {
        DataTable dtReturn = new DataTable();
        SqlConnection sqlcon = new SqlConnection(strconn);
        sqlcmdWithParameters.Connection = sqlcon;
        sqlcmdWithParameters.CommandType = CommandType.StoredProcedure;
        sqlcmdWithParameters.CommandText = CommandText;
        SqlDataAdapter sqlda = new SqlDataAdapter(sqlcmdWithParameters);
        try
        {
            DataSet ds = new DataSet();
            sqlda.Fill(ds, "Table1");
            dtReturn = ds.Tables["Table1"];
        }
        catch (Exception ex)
        {
        }
        finally
        {
        }
        return dtReturn;
    }

    public DataSet GetDataSet(SqlCommand sqlcmdWithParameters, string CommandText)
    {
        DataSet dsReturn = new DataSet();
        SqlConnection sqlcon = new SqlConnection(strconn);
        sqlcmdWithParameters.Connection = sqlcon;
        sqlcmdWithParameters.CommandType = CommandType.StoredProcedure;
        sqlcmdWithParameters.CommandText = CommandText;
        SqlDataAdapter sqlda = new SqlDataAdapter(sqlcmdWithParameters);
        try
        {
            DataSet ds = new DataSet();
            sqlda.Fill(ds);
            dsReturn = ds;
        }
        catch (Exception ex)
        {
        }
        finally
        {
        }
        return dsReturn;
    }
}