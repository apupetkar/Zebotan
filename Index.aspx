<%@ Page Title="" Language="C#" MasterPageFile="~/HomeMaster.master" AutoEventWireup="true" CodeFile="Index.aspx.cs" Inherits="Index" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <link rel="stylesheet" href="css/orbit-1.2.3.css" />
        
     <!-- Attach necessary JS -->
    <script type="text/javascript" src="js/jquery-1.5.1.min.js"></script>
    <script type="text/javascript" src="js/jquery.orbit-1.2.3.min.js"></script>   
    <script type="text/javascript" src="js/jquery.orbit-1.2.3.js"></script>
    <script type="text/javascript">

        var jq161 = jQuery.noConflict();

        jq161(window).load(function () {
            jq161('#tradFeatured').orbit();
            jq161('#westFeatured').orbit();
        });

        
        function pop(div) {
            jq161("body").css("overflow", "hidden");
            document.getElementById(div).style.display = 'block';
            return false
        }
        function hide(div) {
            jq161("body").css("overflow", "auto");
            document.getElementById(div).style.display = 'none';
            return false
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="homeslider">
         <span class="blink_me"> <a href="#" onclick="return pop('pop1')" style="color:#FF0000;text-decoration:none"> To customize your own dresses + bulk orders. read more... </a></span>
    </div>
    <div id="pop1" class="parentDisable" style="scroll:none">
        <div id="tooltip">
            <div style="float: left; margin-left: 5px;">
                <b>Wanna Buy ?</b>
            </div>
            <div style="float: right;">
                <a style="color: Black; font-size: 12px; font-family:Verdana; font-weight: bolder;" href="javascript:void(0);"
                    onclick="return hide('pop1')">X</a>&nbsp;&nbsp;
            </div>
            <div style="clear: both;">
            </div>
            <div style="float: left; margin-right: 5px; margin-left: 5px; margin-top: 0px;">
                <span style="font:10px; text-align:center">The philosophy to encourage and maintain high quality and strict delivery schedule so as to </span>
                <br />
                <span style="font:10px; text-align:center">successfully cater to exclusive requirements is what has helped us preserve our escalating clientele and a high sales volume. </span>
                <br />
                <span style="font:10px; text-align:center">Our team of designers, master tailors and craftsmen are skilled and competent to undertake </span>
                <br />
                <span style="font:10px; text-align:center">all kinds of customized product development. We nurture the capability to fabricate garments as per client's specification. </span>
                <br />
                <span style="font:10px; text-align:center">In addition to our competent team, our well-organized in-house system also enables us to achieve quality standards exceeding customers’ expectation.</span>
            </div>
        
        </div>
    </div>
    <div class="slide-area">
        <div class="slide-img1">
            <div id="tradFeatured" style="width:100%;height:435px">
                <%
                    System.Data.SqlClient.SqlConnection con1 = new System.Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings["strconn"].ToString());
                    System.Data.SqlClient.SqlCommand cmd1 = new System.Data.SqlClient.SqlCommand("r_ProductMst_Select", con1);
                    cmd1.Parameters.AddWithValue("CategoryName", "Traditional");
                    cmd1.CommandType = System.Data.CommandType.StoredProcedure;
                
                    System.Data.SqlClient.SqlDataAdapter ad1 = new System.Data.SqlClient.SqlDataAdapter(cmd1);
                    System.Data.DataSet ds1 = new System.Data.DataSet();
                    ad1.Fill(ds1);
                    if ((ds1.Tables.Count != 0) && (ds1.Tables[0].Rows.Count != 0))
                    {
                        EncryptDecrypt ed = new EncryptDecrypt();
                        for (int i = 0; i < ds1.Tables[0].Rows.Count; i++)
                        {
                %> 
                <a target="_parent" href="ProductsList.aspx?CategoryId=<%= Server.UrlEncode(ed.Encrypt(ds1.Tables[0].Rows[i]["CategoryID"].ToString()))%>">
                    <img src ="ThumbnailCreator.aspx?ImageId=/Product Images/<%= ds1.Tables[0].Rows[i]["ImageName"].ToString()%>&width=326&Height=435" alt="" style="border:0;" height="435" width="326"/>
                </a>
                                   
                <%
                        }  
                    }
                %>
            </div>
           
        </div>

        <div class="about-text">
            <div style="padding:41px">
                Zebotan, originated in 2001, is a leading brand for Womens' wear in Nashik ,India designing Indian ethnic wear ranging from bridal fashion couture to traditional Indian wear and trendy collection. Our bridal wear collection includes wedding lehengas, designer sarees, designer salwar suits and exclusive chaniya cholis. Our trendy collection includes fabulous designer kurtis whereas our traditional collection includes punjabi suits, beautiful chudidars and designer dress materials...
            <div style="padding-top:20px"><a href="AboutUs.aspx" style="color:white">read more>></a></div>
            </div>
        </div>

        <div class="slide-img2">
           
           <div id="westFeatured" style="width:336px;height:435px">
                <%
                    System.Data.SqlClient.SqlConnection con2 = new System.Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings["strconn"].ToString());
                    System.Data.SqlClient.SqlCommand cmd2 = new System.Data.SqlClient.SqlCommand("r_ProductMst_Select", con2);
                    cmd2.Parameters.AddWithValue("CategoryName", "Western");
                    cmd2.CommandType = System.Data.CommandType.StoredProcedure;

                    System.Data.SqlClient.SqlDataAdapter ad2 = new System.Data.SqlClient.SqlDataAdapter(cmd2);
                    System.Data.DataSet ds2 = new System.Data.DataSet();
                    ad2.Fill(ds2);
                    if ((ds2.Tables.Count != 0) && (ds2.Tables[0].Rows.Count != 0))
                    {
                        EncryptDecrypt ed = new EncryptDecrypt();
                        for (int i = 0; i < ds2.Tables[0].Rows.Count; i++)
                        {
                %> 
                                                                       
                <a target="_parent" href="ProductsList.aspx?CategoryId=<%= Server.UrlEncode(ed.Encrypt(ds2.Tables[0].Rows[i]["CategoryID"].ToString()))%>">
                    <img src ="ThumbnailCreator.aspx?ImageId=/Product Images/<%= ds2.Tables[0].Rows[i]["ImageName"].ToString()%>&width=336&Height=435" alt="" style="border:0;" height="435" width="336"/>
                </a>
                                   
                <%
                        }  
                    }
                %>
                
                <%
                    if ((ds2.Tables.Count == 0) || (ds2.Tables[0].Rows.Count == 0))
                    {
                %>
                    <a target="_parent" href="EventsDetails.aspx">
                        <img src ="ThumbnailCreator.aspx?ImageId=/Events/DSC_0382.png&width=336&Height=435" alt="" style="border:0;" height="435" width="336"/>
                    </a>

                     <a target="_parent" href="EventsDetails.aspx">
                        <img src ="ThumbnailCreator.aspx?ImageId=/Events/DSC_0383.png&width=336&Height=435" alt="" style="border:0;" height="435" width="336"/>
                    </a>
                     <a target="_parent" href="EventsDetails.aspx">
                        <img src ="ThumbnailCreator.aspx?ImageId=/Events/DSC_0384.png&width=336&Height=435" alt="" style="border:0;" height="435" width="336"/>
                    </a>
                     <a target="_parent" href="EventsDetails.aspx">
                        <img src ="ThumbnailCreator.aspx?ImageId=/Events/DSC_0386.png&width=336&Height=435" alt="" style="border:0;" height="435" width="336"/>
                    </a>
                     <a target="_parent" href="EventsDetails.aspx">
                        <img src ="ThumbnailCreator.aspx?ImageId=/Events/DSC_0387.png&width=336&Height=435" alt="" style="border:0;" height="435" width="336"/>
                    </a>
                     <a target="_parent" href="EventsDetails.aspx">
                        <img src ="ThumbnailCreator.aspx?ImageId=/Events/DSC_0390.png&width=336&Height=435" alt="" style="border:0;" height="435" width="336"/>
                    </a>
                     <a target="_parent" href="EventsDetails.aspx">
                        <img src ="ThumbnailCreator.aspx?ImageId=/Events/DSC_0391.png&width=336&Height=435" alt="" style="border:0;" height="435" width="336"/>
                    </a>
                     <a target="_parent" href="EventsDetails.aspx">
                        <img src ="ThumbnailCreator.aspx?ImageId=/Events/DSC_0392.png&width=336&Height=435" alt="" style="border:0;" height="435" width="336"/>
                    </a>
                     <a target="_parent" href="EventsDetails.aspx">
                        <img src ="ThumbnailCreator.aspx?ImageId=/Events/DSC_0393.png&width=336&Height=435" alt="" style="border:0;" height="435" width="336"/>
                    </a>
                     <a target="_parent" href="EventsDetails.aspx">
                        <img src ="ThumbnailCreator.aspx?ImageId=/Events/DSC_0394.png&width=336&Height=435" alt="" style="border:0;" height="435" width="336"/>
                    </a>

                       <%-- <img src ="Product Images/comingsoon.jpg" alt="" style="border:0;" height="435" width="336"/>--%>

                <%
                    }
                %>
            </div>
            
        </div>
    </div><!-- slide area ends -->

    <!-----------------------------------top area ends---------------------------------------------------- -->   

    <div class="seperator"></div>
            
    <div class="bottom-area">
        <div class="box1">
            <div class="box-title">New Arrivals</div>
            <div class="pic-box1">
                <div id="divNewArrivals">
                <%
                    System.Data.SqlClient.SqlConnection conNewArrivals = new System.Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings["strconn"].ToString());
                    System.Data.SqlClient.SqlCommand cmdNewArrivals = new System.Data.SqlClient.SqlCommand("r_ProductMst_Select", conNewArrivals);
                    cmdNewArrivals.Parameters.AddWithValue("IsNewArrival", "1");
                    cmdNewArrivals.CommandType = System.Data.CommandType.StoredProcedure;

                    System.Data.SqlClient.SqlDataAdapter adNewArrivals = new System.Data.SqlClient.SqlDataAdapter(cmdNewArrivals);
                    System.Data.DataSet dsNewArrivals = new System.Data.DataSet();
                    adNewArrivals.Fill(dsNewArrivals);
                    if ((dsNewArrivals.Tables.Count != 0) && (dsNewArrivals.Tables[0].Rows.Count != 0))
                    {
                        EncryptDecrypt ed = new EncryptDecrypt();
                        for (int i = 0; i < 1; i++)
                        {
                %> 
                <a target="_parent" href="ProductsList.aspx?IsNewArrival=True" style="width:335px;Height:235px" >
                <span class="image_rounded_shadow">
                    <img src ="ThumbnailCreator.aspx?ImageId=/Product Images/<%= dsNewArrivals.Tables[0].Rows[i]["ImageName"].ToString()%>&width=335&Height=235" alt="" style="border:0;"/>
                </span> 
                </a>
                
                                   
                <%
                        }  
                    }
                %>
            </div>
            </div>
            <div class="see-more"><a href="ProductsList.aspx?IsNewArrival=True">see more>></a></div>
        </div>
            
        <div style="width:15px; float:left">&nbsp;</div>
         
        <div class="box2">
            <div class="box-title2">Seasonal Offers</div>
            <div class="pic-box2">
            <div id="divDiscounts">
                <%
                    System.Data.SqlClient.SqlConnection conOffers = new System.Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings["strconn"].ToString());
                    System.Data.SqlClient.SqlCommand cmdOffers = new System.Data.SqlClient.SqlCommand("r_ProductMst_Select", conOffers);
                    cmdOffers.Parameters.AddWithValue("IsOffer", "1");
                    cmdOffers.CommandType = System.Data.CommandType.StoredProcedure;

                    System.Data.SqlClient.SqlDataAdapter adOffers = new System.Data.SqlClient.SqlDataAdapter(cmdOffers);
                    System.Data.DataSet dsOffers = new System.Data.DataSet();
                    adOffers.Fill(dsOffers);
                    if ((dsOffers.Tables.Count != 0) && (dsOffers.Tables[0].Rows.Count != 0))
                    {
                        EncryptDecrypt ed = new EncryptDecrypt();
                        for (int i = 0; i < 1; i++)
                        {
                %> 
                <a target="_parent" href="ProductsList.aspx?IsDiscounted=True" style="width:335px;Height:235px" >
                <span class="image_rounded_shadow">
                    <img src ="ThumbnailCreator.aspx?ImageId=/Product Images/<%= dsOffers.Tables[0].Rows[i]["ImageName"].ToString()%>&width=312&Height=235" alt="" style="border:0;"/>
                </span>
                </a>
                                   
                <%
                        }  
                    }
                %>
            </div>
            </div>
            <div class="see-more"><a href="ProductsList.aspx?IsDiscounted=True">see more>></a></div>
        </div> 
            
        <div style="width:15px; float:left">&nbsp;</div>
            
        <div class="box3">
            <div class="box-title3">Quick Contact</div>
            <div class="pic-box3">
                <span style="font-weight:bold; font-style:italic; text-align:center">Bahar Pathan</span>
                <br />
                <span style="font:10px; text-align:center">Row House No. 107,</span>
                <br />
                <span style="font:10px; text-align:center">Pride Monarch Apartment,</span>
                <br />
                <span style="font:10px; text-align:center">Jaybhai Colony</span>
                <br />
                <span style="text-align:center">Behind Big Bazaar</span>
                <br />
                <span style="text-align:center">Nashik Road,</span>
                <br />
                <span style="text-align:center">Nashik- 01</span>
                <br />
                <span><b>Cell:</b> +91 9923833023 </span><br />
                <span><b>Email:</b> bahar@zebotan.com</span>
            </div>
        </div> 

    </div> <!-- bottom area ends -->
</asp:Content>

