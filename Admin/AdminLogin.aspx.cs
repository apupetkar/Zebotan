using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_AdminLogin : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
            Page.Title = "Welcome to Admin";
    }

    protected void Login_LoggedIn(object sender, EventArgs e)
    {
        Response.Redirect("AdminPanel.aspx");
    }

    protected void Login_LoggingIn(object sender, LoginCancelEventArgs e)
    {
        //if (Membership.GetUser(Login1.UserName) != null)
        //{
        //    if (!Roles.IsUserInRole(Login1.UserName, "Admin") && !Roles.IsUserInRole(Login1.UserName, "Subadmin"))
        //    {
        //        e.Cancel = true;
        //        Login1.FindControl("FailureText").Visible = true;
        //        ((Literal)Login1.FindControl("FailureText")).Text = "The username or password you've entered is incorrect, Please try again.";
        //        return;
        //    }
        //    else if (Roles.IsUserInRole(Login1.UserName, "Subadmin"))
        //    {
        //        MembershipUser user = Membership.GetUser(Login1.UserName);
        //        if (user.IsApproved == false)
        //        {
        //            e.Cancel = true;
        //            Login1.FindControl("FailureText").Visible = true;
        //            ((Literal)Login1.FindControl("FailureText")).Text = "This user is inactive. Please try again.";
        //            return;
        //        }
        //        else
        //        {
        //            //SettingsForSubAdmin(user);
        //        }
        //    }
        //}
        //else
        //{
        //    e.Cancel = true;
        //    Login1.FindControl("FailureText").Visible = true;
        //    ((Literal)Login1.FindControl("FailureText")).Text = "The username or password you've entered is incorrect, Please try again.";
        //    return;
        //}
    }

    protected void Login_LoginError(object sender, EventArgs e)
    {
        //Login1.FindControl("FailureText").Visible = true;
        //((Literal)Login1.FindControl("FailureText")).Text = "The username or password you've entered is incorrect, Please try again.";
    }

    protected void btnLogin_Click(object sender, EventArgs e)
    {
        this.Form.DefaultButton = ((System.Web.UI.Control)(sender)).UniqueID;
    }
}