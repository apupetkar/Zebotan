using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI.WebControls;

/// <summary>
/// Summary description for ShowPageHeaders
/// </summary>
public class ShowPageHeaders
{
	public ShowPageHeaders()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    public static void SetPageTitle(System.Web.UI.Page currentPage, string strTitle)
    {
        ((Label)(currentPage.Master.FindControl("lblHeader"))).Text = strTitle;
        currentPage.Title = strTitle;
    }

    private void ShowTitle()
    {
    }
}