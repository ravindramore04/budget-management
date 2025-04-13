package struts.common;
import javax.naming.*;
import java.sql.*;
import javax.transaction.*;
import java.util.*;
import java.io.*;

public class ErrorHandler
{
	HashMap hm =new HashMap();
	public ErrorHandler()
	{
		hm=new HashMap();

		hm.put("147420","Some errors occured while performing requisite tasks. ");
		hm.put("146520","Invalid Username or Password...! System unable to proceed");
		hm.put("146430","Branch  does not match with Financial year...! System unable to proceed");
		hm.put("147411","Error occured in opening Menu list...! System unable to proceed");
		hm.put("147530","A Similar Value For The Given Field Already Exists. DUPLICATES are not allowed!");
		hm.put("138530","Error occured in opening Particular list...! ");
		hm.put("138620","Error occured while saving data...! ");
		hm.put("138611","Error occured while saving data...! ");
		hm.put("138512","Error occured Due to Limited Space Available...! ");
		hm.put("138521","Unknown Error occured While preparing report...! ");
		hm.put("139621","Error ocurred because of Company not selected ...! ");
		hm.put("148621","Error ocurred because of No record found ...! ");
		//hm.put("148600","Delete Failed ...! Tyy again..... ");



	}

	public String getError(String no)
	{
		String str = (String)hm.get(no);
		return(str);
	}

}
