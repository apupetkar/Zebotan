using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using System.IO;

public partial class CreateRoles : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {

            //This is a basic set up of the website.
            //Here we will create all roles in the system.
            //Alse we will create admin.

            Roles.CreateRole("Admin"); //Role admin created

            //Roles.CreateRole("Customer"); // Role Member created

            //Roles.CreateRole("BusinessOwner"); // Role Subadmin created

            Membership.CreateUser("admin", "admin123", "admin@Fashion.com");

            Roles.AddUserToRole("admin", "Admin");

            ProfileCommon pf = Profile.GetProfile("admin");

            pf.FirstName = "Admin";

            pf.LastName = "Admin";

            pf.Save();

            //Directory.CreateDirectory(Server.MapPath("./Uploads/") + "1");

            //Directory.CreateDirectory(Server.MapPath("./Uploads/") + "1" + "/Temp");

            Response.Write("You successfully created roles and admin user..");

        }

        catch (Exception ex)
        {

            Response.Write(ex.Message);

        }
    }
}