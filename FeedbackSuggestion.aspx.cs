using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;

public partial class FeedbackSuggestion : System.Web.UI.Page
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
        cmd.Parameters.AddWithValue("@Feedback", txtResponse.Text);

        string strSQL = DB.GetSingleValue(cmd, "i_Feedback");

        if (strSQL == "")
            lblStatus.Text = "Thanks for your feedback/ Suggesstion!!!";

    }
}