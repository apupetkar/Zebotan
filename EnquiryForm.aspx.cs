using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;

public partial class EnquiryForm : System.Web.UI.Page
{
    DBHandler DB = new DBHandler();
	
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        //if (txtName.Text = "" && txtEmail.Text = "" && txtMobile.Text = "" && txtEnquiry.Text = "")
        //    return;

        SqlCommand cmd = new SqlCommand();
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@Name", txtName.Text);
        cmd.Parameters.AddWithValue("@Email", txtEmail.Text);
        cmd.Parameters.AddWithValue("@Phone", txtMobile.Text);
        cmd.Parameters.AddWithValue("@Enquiry", txtEnquiry.Text);

        string strSQL = DB.GetSingleValue(cmd, "i_Enquiry");

        if (strSQL == "")
            lblStatus.Text = "Thanks " + txtName.Text + " We will get back to you soon!!!";
        
      }
}