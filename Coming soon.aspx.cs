using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;

public partial class Coming_soon : System.Web.UI.Page
{
    //DBHandler DB = new DBHandler();
   
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            txtEmail.Text = "";
            lblMsg.Text = "";
        }
    }

    protected void btnNotify_Click(object sender, EventArgs e)
    {
        //if (txtEmail.Text != "")
        //{
        //    SqlCommand cmd = new SqlCommand();
        //    cmd.CommandType = CommandType.StoredProcedure;

        //    cmd.Parameters.Add(new SqlParameter("@CustomerEmail", txtEmail.Text));

        //    string strSQL = DB.GetSingleValue(cmd, "i_NotifyInsert");
            
        //    lblMsg.Text = "Thanks!!! You will receive a mail shortly.";
        //    txtEmail.Text = "";
        //}
        //else
        //    lblMsg.Text = "";
               
    }
}