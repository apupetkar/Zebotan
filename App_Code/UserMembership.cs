using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Security;

/// <summary>
/// Summary description for UserMembership
/// </summary>
public class UserMembership
{
	public UserMembership()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    public static MembershipUser GetUser()
    {
        return Membership.GetUser();
    }

    public static Boolean IsAdmin()
    {
        return (Membership.GetUser().UserName.ToLower() == "admin");
    }

    //public static string GetUserID()
    //{
    //    return SessionHandler.getWebUserId(Membership.GetUser().ProviderUserKey.ToString());
    //}
}