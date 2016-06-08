using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net.Mail;

public partial class testmail : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        SendEmail("varade.rupali@gmail.com", "test mail", "hello this is a test mail from zebotan server");
    }

    public static void SendEmail(string strToEmail, string strSubject, string strBody)
    {
        MailMessage msg = new MailMessage();
        msg.Subject = strSubject;
        msg.From = new MailAddress("zebotan<enquiry@zebotan.com>");

        msg.To.Add(strToEmail);
        //msg.Bcc.Add("websites.tester@gmail.com");
        msg.Body = strBody;
        msg.IsBodyHtml = true;
        msg.Priority = MailPriority.High;
        //SmtpClient smtp = new SmtpClient("relay-hosting.secureserver.net");
        SmtpClient smtp = new SmtpClient("127.0.0.1");
        try
        {
            smtp.Send(msg);
        }
        catch { }
    }
}