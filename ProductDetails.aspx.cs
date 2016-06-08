using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Drawing;
using System.Drawing.Imaging;

public partial class ProductDetails : System.Web.UI.Page
{
   public EncryptDecrypt ed = new EncryptDecrypt();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            string strProductID = Server.UrlDecode(ed.Decrypt(Request.QueryString["ProductID"]));
            ShowDetails(strProductID);
        }
    }

    protected void ShowDetails(string strProductID)
    {
        Products product = new Products();
        product.ProductsID = FormatNumValues.GetNullInt(strProductID);
        DataTable dt = product.GetProductsByID();

        if (dt.Rows.Count > 0)
        {
           // imgProduct.ImageUrl = "Product Images/" + dt.Rows[0]["ImageName"].ToString();
            SaveImages(dt.Rows[0]["ImageName"].ToString());

            lvProductDetails.DataSource = dt;
            lvProductDetails.DataBind();

            Label lbl = ((Label)lvProductDetails.Items[0].FindControl("lblCentDiscount"));
            Label lbl1 = ((Label)lvProductDetails.Items[0].FindControl("lblPriceDiscount"));
            Label lbl2 = ((Label)lvProductDetails.Items[0].FindControl("lblOthers"));
            Label lbl3 = ((Label)lvProductDetails.Items[0].FindControl("lblPrice"));
            if (FormatNumValues.GetNullBoolean(dt.Rows[0]["IsDiscounted"].ToString()) == true)
            {
                lbl.Visible = true;
                lbl1.Visible = true;
                lbl2.Visible = true;
                lbl3.Visible = true;
            }
            else
            {
                lbl.Visible = false;
                lbl1.Visible = false;
                lbl2.Visible = false;
                lbl3.Visible = false;
            }
        }
       

        


    }

    protected void SaveImages(string ImageName)
    {
        //FileUpload fuUploadImg = new FileUpload();
        //fuUploadImg.SaveAs(Server.MapPath("~\\Product Images\\Big1.jpg"));

        ResizeImage(2000, Server.MapPath("~\\Product Images\\" + ImageName), Server.MapPath("~\\Product Images\\Big1.jpg"));
        ResizeImage(338, Server.MapPath("~\\Product Images\\" + ImageName), Server.MapPath("~\\Product Images\\small1.jpg"));
    }

    public static void ResizeImage(int size, string filePath, string saveFilePath)
    {
        //variables for image dimension/scale
        double newHeight = 0;
        double newWidth = 0;
        double scale = 0;

        //create new image object
        Bitmap curImage = new Bitmap(filePath);

        //Determine image scaling
        if (curImage.Height > curImage.Width)
        {
            scale = Convert.ToSingle(size) / curImage.Height;
        }
        else
        {
            scale = Convert.ToSingle(size) / curImage.Width;
        }
        if (scale < 0 || scale > 1) { scale = 1; }

        //New image dimension
        newHeight = Math.Floor(Convert.ToSingle(curImage.Height) * scale);
        newWidth = Math.Floor(Convert.ToSingle(curImage.Width) * scale);

        //Create new object image
        Bitmap newImage = new Bitmap(curImage, Convert.ToInt32(newWidth), Convert.ToInt32(newHeight));
        Graphics imgDest = Graphics.FromImage(newImage);
        imgDest.SmoothingMode = System.Drawing.Drawing2D.SmoothingMode.HighQuality;
        imgDest.InterpolationMode = System.Drawing.Drawing2D.InterpolationMode.HighQualityBicubic;
        imgDest.PixelOffsetMode = System.Drawing.Drawing2D.PixelOffsetMode.HighQuality;
        imgDest.CompositingQuality = System.Drawing.Drawing2D.CompositingQuality.HighQuality;
        ImageCodecInfo[] info = ImageCodecInfo.GetImageEncoders();
        EncoderParameters param = new EncoderParameters(1);
        param.Param[0] = new EncoderParameter(System.Drawing.Imaging.Encoder.Quality, 100L);

        //Draw the object image
        imgDest.DrawImage(curImage, 0, 0, newImage.Width, newImage.Height);

        //Save image file
        newImage.Save(saveFilePath, info[1], param);

        //Dispose the image objects
        curImage.Dispose();
        newImage.Dispose();
        imgDest.Dispose();
    }
}

/*  $(document).ready(function(){  
        var options = {  
            zoomType: 'standard',  
            lens:true,  
            preloadImages: false,  
            alwaysOn:true,  
            zoomWidth: 300,  
            zoomHeight: 250,  
            xOffset:90,  
            yOffset:30,  
            position:'left' 
    };  
    $('.MYCLASS').jqzoom();  
}); 



*/
/*
<%@ Page Title="Product Details" Language="C#" MasterPageFile="~/ProductsMaster.master" AutoEventWireup="true" CodeFile="ProductDetails.aspx.cs" Inherits="ProductDetails" EnableViewStateMac="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script type='text/javascript' src='js/jquery-1.5.1.min.js'></script>  
    <script type='text/javascript' src='js/jquery.jqzoom-core.js'></script>  
        <link rel="stylesheet" type="text/css" href="css/jquery.jqzoom.css" />  
       
<script type="text/javascript">
    $(document).ready(function () {
        $('.jqzoom').jqzoom({
            zoomType: 'standard',
            lens: true,
            preloadImages: false,
            alwaysOn: false
        });


    });

</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="catListingPlaceHolder" Runat="Server">
<div class="clearfix" id="content" style="margin-top:100px;margin-left:50px; height:500px;width:500px;" >
    <div class="clearfix">
        <a href="imgProd/triumph_big1.jpg" class="jqzoom" rel='gal1'  title="triumph" >
            <img src="imgProd/triumph_small1.jpg"  title="triumph"  style="border: 4px solid #666;">
        </a>
	<select style="position:absolute;left:800px;top:120px;"><option>test ie6</option></select>
    </div>
	<br/>
        <div class="clearfix" >
	<ul id="thumblist" class="clearfix" >
		<li><a class="zoomThumbActive" href='javascript:void(0);' rel="{gallery: 'gal1', smallimage: './imgProd/triumph_small1.jpg',largeimage: './imgProd/triumph_big1.jpg'}"><img src='imgProd/thumbs/triumph_thumb1.jpg'></a></li>
		<li><a href='javascript:void(0);' rel="{gallery: 'gal1', smallimage: './imgProd/triumph_small2.jpg',largeimage: './imgProd/triumph_big2.jpg'}"><img src='imgProd/thumbs/triumph_thumb2.jpg'></a></li>
		<li><a  href='javascript:void(0);' rel="{gallery: 'gal1', smallimage: './imgProd/triumph_small3.jpg',largeimage: './imgProd/triumph_big3.jpg'}"><img src='imgProd/thumbs/triumph_thumb3.jpg'></a></li>
	</ul>
	</div>
</div>
<div class="clearfix" style="margin-left:100px">
      <div class="clearfix"><small style="font-size:10px;">ADVERTISE HERE - contact me at <span style="color:#CC0000">renzi.mrc[at]gmail.com</span></small></div>
     <a href='mailto:renzi.mrc@gmail.com' style="display:inline-block">
     <img src='../images/advertise.jpg'>
     </a>
      &nbsp;   
</div>

<%--<table width="100%">
    <tr>
        <td>
            <asp:Image ID="imgProduct" runat="server" Height="384px" Width="312px" />
        </td>
        <td>
            <table style="margin-top:-190px">
                <tr>
                    <td>
                        <div class="Product-Details">
                            <span class="Product-Details-header">PRODUCT DETAILS</span>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:ListView ID="lvProductDetails" runat="server">
                            <LayoutTemplate>
                                <ul>
                                    <asp:PlaceHolder ID="itemPlaceholder" runat="server"></asp:PlaceHolder>
                                </ul>
                            </LayoutTemplate>
                            <ItemTemplate>
                                <table style="margin-left:-35px; width:310px">
                                    <tr>
                                        <td colspan="2">
                                            <asp:Label ID="lblProductDescription" runat="server" Text='<%# Eval("Description")%>' 
                                                style="word-wrap: break-word;word-break:break-all;" Width="80%" >
                                            </asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                             Product Code:
                                        </td>
                                        <td>
                                            <asp:HiddenField ID="hdnProduct" runat="server" Value='<%# Eval("ProductID")%>' />
                                            <asp:Label ID="lblProductCode" runat="server" Text='<%#Eval("ProductCode")%>' 
                                                style="word-wrap: break-word;word-break:break-all;" Width="80%" >
                                            </asp:Label>
                                        </td>
                                    </tr>
                                    <tr id="Discountrow" runat="server">
                                        <td style="display:none">
                                            <asp:Label ID="lblCentDiscount" runat="server" style="word-wrap: break-word;word-break:break-all;"
                                                Text='<%# "Save " + Eval("PercentDisc") + "%" %>'>
                                            </asp:Label>
                                
                                            <asp:Label ID="lblPriceDiscount" runat="server" style="word-wrap: break-word;word-break:break-all;"
                                                Text='<%# "Save Rs." + Eval("PriceDisc")%>'>
                                            </asp:Label>
                                
                                            <asp:Label ID="lblOthers" runat="server" style="word-wrap: break-word;word-break:break-all;"
                                                Text='<%# Eval("Others")%>'>
                                            </asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblPrice" runat="server" style="word-wrap: break-word;word-break:break-all;"
                                                Text='<%#Eval("Price")%>'>
                                            </asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <asp:Label ID="lblAfterDiscountPrice" runat="server" Text='<%# "Rs. " + Eval("Price")%>' 
                                                style="word-wrap: break-word;word-break:break-all;" Width="80%" CssClass="Product-Details-Price" >
                                            </asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </ItemTemplate>
                        </asp:ListView>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    
</table>--%>
</asp:Content>


*/

/*



*/