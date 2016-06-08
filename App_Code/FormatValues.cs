using System;
using System.Collections.Generic;
using System.Web;
using System.Globalization;

/// <summary>
/// Summary description for FormatValues
/// </summary>
public class FormatNumValues
{
    public FormatNumValues()
    {

    }

    public static int GetNullInt(string strValue)
    {
        int nValue;
        int.TryParse(strValue, out nValue);

        return nValue;
    }

    public static double GetNullDouble(string strValue)
    {
        double nValue;
        double.TryParse(strValue, NumberStyles.Number, CultureInfo.InvariantCulture, out nValue);

        return nValue;
    }

    public static string ReplaceCommaAndDot(string strValue)
    {//strValue = "1,010.20";
        string strNewValue1;
        string strNewValue2;
        strNewValue1 = strValue.Replace(".", "^");  //1,010^20
        strNewValue2 = strNewValue1.Replace(",", "."); //1.010^20
        strNewValue1 = strNewValue2.Replace("^", ","); //1.010,20

        return strNewValue1;
    }

    public static DateTime ConvertStringToDateTime(string strValue)
    {
        DateTime dtDate;
        try
        {
            string strM = strValue.Split('/')[0].PadLeft(2,'0');
            string strD = strValue.Split('/')[1].PadLeft(2, '0');
            string strY = strValue.Split('/')[2];
            string strNewDate = strD + "/" + strM + "/" + strY;
            dtDate = DateTime.ParseExact(strNewDate, "d", null);
        }
        catch
        {
            dtDate = DateTime.Now;
        }

        return dtDate;
    }

    public static string ConvertMMddToDDmm(string strValue)
    {
        DateTime dtDate;
        string strDate;

        dtDate = ConvertStringToDateTime(strValue);

        strDate = dtDate.ToString("MM/dd/yyyy");
        return strDate;
    }

    public static string SetSearchDates(string strSearchDate)
    {
        string strReturnDate = "";

        if (strSearchDate == "")
            strReturnDate = "";
        else
            strReturnDate = ConvertMMddToDDmm(strSearchDate);

        return strReturnDate;
    }

    public static Boolean GetNullBoolean(string strValue)
    {
        Boolean bValue;
        Boolean.TryParse(strValue, out bValue);

        return bValue;
    }

}