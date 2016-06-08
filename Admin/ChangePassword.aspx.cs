using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

public partial class Admin_ChangePassword : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Membership.GetUser() != null)
        {
            if (!IsPostBack)
            {
                Label header = (Label)Master.FindControl("lblHeader");
                header.Text = "Change Password";
                Page.Title = "Change Password";
            }
        }
        else
        {
            Response.Redirect("AdminLogin.aspx");
        }
    }

    protected void changePassword_ChangePasswordError(object sender, EventArgs e)
    {
        Literal FailureText = (Literal)changePassword.ChangePasswordTemplateContainer.FindControl("FailureText");
        FailureText.Text = "Old Password is not correct";
    }
}