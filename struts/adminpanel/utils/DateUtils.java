package struts.adminpanel.utils;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created by morer on 11-05-2025.
 */
public class DateUtils {

    private static String DEFAULT_DATE_FORMAT = "yyyy-MM-dd";

    public static String getFormattedCurrentDate(String format){
        return getFormattedDate(new Date(), format);
    }

    public static String getFormattedCurrentDate(){
        return getFormattedDate(new Date(), DEFAULT_DATE_FORMAT);
    }

    public static String getFormattedDate(Date date, String format){
        String formattedDate = null;

        SimpleDateFormat formatter = new SimpleDateFormat(format);
        formattedDate = formatter.format(date);

        return formattedDate;
    }

    public static String getCurrentTimestamp(){
        Date now = new Date(); // current timestamp
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd-HH-mm-ss");

        String formattedDate = sdf.format(now);
        return  formattedDate;
    }
}
