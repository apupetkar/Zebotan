using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.IO;
using System.Drawing;
using System.Drawing.Imaging;

public partial class ThumbnailCreator : System.Web.UI.Page
{
    private void Page_Load(object sender, System.EventArgs e)
    {

        string Image = Request.QueryString["ImageId"];

        if (Image == null)
        {

            this.ErrorResult();

            return;

        }



        string sSize = Request["Size"];
        string sWidth = Request["width"];
        string sHeight = Request["height"];
        int Size = 100;
        int width = 100;
        int height = 100;
        if (sSize != null)

            Size = Int32.Parse(sSize);

        if (sWidth != null)

            width = Int32.Parse(sWidth);
        if (sHeight != null)

            height = Int32.Parse(sHeight);


        string Path = Server.MapPath(Request.ApplicationPath) + Image;

        Bitmap bmp = CreateThumbnail(Path, width, height);



        if (bmp == null)
        {

            this.ErrorResult();

            return;

        }



        string OutputFilename = null;

        OutputFilename = Request.QueryString["OutputFilename"];



        if (OutputFilename != null)
        {

            if (this.User.Identity.Name == "")
            {

                // *** Custom error display here

                bmp.Dispose();

                this.ErrorResult();

            }

            try
            {

                bmp.Save(OutputFilename);

            }

            catch (Exception ex)
            {

                bmp.Dispose();

                this.ErrorResult();

                return;

            }

        }



        // Put user code to initialize the page here

        Response.ContentType = "image/jpeg";

        bmp.Save(Response.OutputStream, System.Drawing.Imaging.ImageFormat.Jpeg);

        bmp.Dispose();

    }



    private void ErrorResult()
    {

        Response.Clear();

        Response.StatusCode = 404;

        Response.End();

    }



    /// 

    /// Creates a resized bitmap from an existing image on disk.

    /// Call Dispose on the returned Bitmap object

    /// 

    /// 

    /// 

    /// 

    /// Bitmap or null

    public static Bitmap CreateThumbnail(string lcFilename, int lnWidth, int lnHeight)
    {



        System.Drawing.Bitmap bmpOut = null;

        try
        {

            Bitmap loBMP = new Bitmap(lcFilename);

            ImageFormat loFormat = loBMP.RawFormat;



            decimal lnRatio;

            decimal lnwRatio;

            decimal lnhRatio;


            int lnNewWidth = 0;

            int lnNewHeight = 0;



            //*** If the image is smaller than a thumbnail just return it

            if (loBMP.Width < lnWidth && loBMP.Height < lnHeight)

                return loBMP;



            lnwRatio = (decimal)lnWidth / loBMP.Width;
            lnhRatio = (decimal)lnHeight / loBMP.Height;
            if (lnwRatio < lnhRatio)
            {
                decimal lnTemp = loBMP.Height * lnwRatio;

                lnNewHeight = (int)lnTemp;

                lnTemp = loBMP.Width * lnwRatio;

                lnNewWidth = (int)lnTemp;
            }
            else
            {
                decimal lnTemp = loBMP.Height * lnhRatio;

                lnNewHeight = (int)lnTemp;

                lnTemp = loBMP.Width * lnhRatio;

                lnNewWidth = (int)lnTemp;
            }

            ////if (loBMP.Width > loBMP.Height)
            ////{

            ////    lnRatio = (decimal)lnWidth / loBMP.Width;

            ////    lnNewWidth = lnWidth;

            ////    decimal lnTemp = loBMP.Height * lnRatio;

            ////    lnNewHeight = (int)lnTemp;

            ////}

            ////else
            ////{

            ////    lnRatio = (decimal)lnHeight / loBMP.Height;

            ////    lnNewHeight = lnHeight;

            ////    decimal lnTemp = loBMP.Width * lnRatio;

            ////    lnNewWidth = (int)lnTemp;

            ////}
          


            // System.Drawing.Image imgOut = 

            //      loBMP.GetThumbnailImage(lnNewWidth,lnNewHeight,

            //                              null,IntPtr.Zero);



            // *** This code creates cleaner (though bigger) thumbnails and properly

            // *** and handles GIF files better by generating a white background for

            // *** transparent images (as opposed to black)

            bmpOut = new Bitmap(lnNewWidth, lnNewHeight);

            Graphics g = Graphics.FromImage(bmpOut);

            g.InterpolationMode = System.Drawing.Drawing2D.InterpolationMode.HighQualityBicubic;

            g.FillRectangle(Brushes.White, 0, 0, lnNewWidth, lnNewHeight);

            g.DrawImage(loBMP, 0, 0, lnNewWidth, lnNewHeight);



            loBMP.Dispose();

        }

        catch
        {

            return null;

        }



        return bmpOut;

    }

    
}
