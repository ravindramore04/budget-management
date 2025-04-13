package struts.common ;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.HashMap;
import org.apache.struts.action.ActionServlet;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionError;
import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionServlet;
import org.apache.struts.action.DynaActionForm;
import struts.common.CVDal;

public class CommonLogic
{
	public String Dbnm="";
	public CommonLogic(String DB){
		Dbnm=DB;
		System.out.println("Dbnm"+Dbnm);
	}
	public CommonLogic(){

		}

	//HtpServletRe
	//HttpSession session = request.getSession(true);

public String getToday(){


	//HashMap My = (HashMap)session.getAttribute("user");
	//String DBnm = (String)My.get("DBnm");
	CVDal cvdal= new CVDal(Dbnm);
	Vector vec = new Vector();
	String strRet = "";
	cvdal.setSQL("getCurrentDate",vec);
	Vector vec1 = (Vector)cvdal.executeQuery();
	if(vec1 != null && vec1.size()!=0){
		HashMap hm = (HashMap)vec1.elementAt(0);
		strRet = (String)hm.get("Today");
	}
	return strRet;
}

public long getNoOfDays(String dt1yyyy_mm_dd,String dt2yyyy_mm_dd){
	int yyyy1 = Integer.parseInt(dt1yyyy_mm_dd.substring(0,4));
	int mm1 = Integer.parseInt(dt1yyyy_mm_dd.substring(5,7));
	int dd1 = Integer.parseInt(dt1yyyy_mm_dd.substring(8,10));

	int yyyy2 = Integer.parseInt(dt2yyyy_mm_dd.substring(0,4));
	int mm2 = Integer.parseInt(dt2yyyy_mm_dd.substring(5,7));
	int dd2 = Integer.parseInt(dt2yyyy_mm_dd.substring(8,10));

	GregorianCalendar cal1 = new GregorianCalendar(yyyy1,mm1-1,dd1);
	GregorianCalendar cal2 = new GregorianCalendar(yyyy2,mm2-1,dd2);

	long lRet = cal2.getTimeInMillis() - cal1.getTimeInMillis();
	lRet = lRet/1000/60/60/24;

	return lRet;
}
public String getDateAfterYear(String dtyyyy_mm_dd, int iYear){
        String ay[] = {"01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31"};
        String strRet = "";
        int yyyy1 = Integer.parseInt(dtyyyy_mm_dd.substring(0,4));
	int mm1 = Integer.parseInt(dtyyyy_mm_dd.substring(5,7));
	int dd1 = Integer.parseInt(dtyyyy_mm_dd.substring(8,10));
        GregorianCalendar cal1 = new GregorianCalendar(yyyy1,mm1-1,dd1);
        cal1.add(Calendar.YEAR, iYear);
        strRet = cal1.get(Calendar.YEAR)+"/"+ ay[cal1.get(Calendar.MONTH)]+"/"+ay[cal1.get(Calendar.DATE)-1];
	return strRet;
}

public String getDateAfterMonth(String dtyyyy_mm_dd, int iMonth){
        String ay[] = {"01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31"};
        String strRet = "";
        int yyyy1 = Integer.parseInt(dtyyyy_mm_dd.substring(0,4));
	int mm1 = Integer.parseInt(dtyyyy_mm_dd.substring(5,7));
	int dd1 = Integer.parseInt(dtyyyy_mm_dd.substring(8,10));
        GregorianCalendar cal1 = new GregorianCalendar(yyyy1,mm1-1,dd1);
        cal1.add(Calendar.MONTH, iMonth);
        strRet = cal1.get(Calendar.YEAR)+"/"+ ay[cal1.get(Calendar.MONTH)]+"/"+ay[cal1.get(Calendar.DATE)-1];
	return strRet;
}

public String getDateAfterDay(String dtyyyy_mm_dd, int iDay){
        String ay[] = {"01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31"};
        String strRet = "";
        int yyyy1 = Integer.parseInt(dtyyyy_mm_dd.substring(0,4));
	int mm1 = Integer.parseInt(dtyyyy_mm_dd.substring(5,7));
	int dd1 = Integer.parseInt(dtyyyy_mm_dd.substring(8,10));
        GregorianCalendar cal1 = new GregorianCalendar(yyyy1,mm1-1,dd1);
        cal1.add(Calendar.DATE, iDay);
        strRet = cal1.get(Calendar.YEAR)+"/"+ ay[cal1.get(Calendar.MONTH)]+"/"+ay[cal1.get(Calendar.DATE)-1];
	return strRet;
}



/*
public long getNoOfNonWorkingDay(String dt1yyyy_mm_dd,String dt2yyyy_mm_dd, String strBranchId){
	String ay[] = {"01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31"};
	int ayWrk[] = {1,1,1,1,1,1,1};

	int yyyy1 = Integer.parseInt(dt1yyyy_mm_dd.substring(0,4));
	int mm1 = Integer.parseInt(dt1yyyy_mm_dd.substring(5,7));
	int dd1 = Integer.parseInt(dt1yyyy_mm_dd.substring(8,10));

	int yyyy2 = Integer.parseInt(dt2yyyy_mm_dd.substring(0,4));
	int mm2 = Integer.parseInt(dt2yyyy_mm_dd.substring(5,7));
	int dd2 = Integer.parseInt(dt2yyyy_mm_dd.substring(8,10));

	GregorianCalendar cal1 = new GregorianCalendar(yyyy1,mm1-1,dd1);
	GregorianCalendar cal2 = new GregorianCalendar(yyyy2,mm2-1,dd2);
	GregorianCalendar calIndx = new GregorianCalendar();

	CVDal cvdal = new CVDal("schlstatic");
	Vector vec = new Vector();

	vec.clear();
	vec.addElement(strBranchId);  //BranchSessionId
	cvdal.setSQL("static.getBrchID",vec);
	Vector vec1 = (Vector)cvdal.executeQuery();
	String strOrgBranchId = "";
	if(vec1!=null && vec1.size()>0){
		HashMap hm = (HashMap)vec1.elementAt(0);
		strOrgBranchId = (String)hm.get("strBranchId");
	}

	vec.clear();
	vec.addElement(strOrgBranchId);
	cvdal.setSQL("static.workingDay",vec);
	vec1 = (Vector)cvdal.executeQuery();
	if(vec1!=null && vec1.size()>0){
		HashMap hm = (HashMap)vec1.elementAt(0);
		ayWrk[0] = Integer.parseInt((String)hm.get("bSun"));
		ayWrk[1] = Integer.parseInt((String)hm.get("bMon"));
		ayWrk[2] = Integer.parseInt((String)hm.get("bTues"));
		ayWrk[3] = Integer.parseInt((String)hm.get("bWed"));
		ayWrk[4] = Integer.parseInt((String)hm.get("bThur"));
		ayWrk[5] = Integer.parseInt((String)hm.get("bFri"));
		ayWrk[6] = Integer.parseInt((String)hm.get("bSat"));
	}

	cvdal = new CVDal("schlactual");
	cal2.add(Calendar.DATE,1);
	long lRet = 0;
	for(calIndx=cal1;calIndx.before(cal2);calIndx.add(Calendar.DATE,1)){
		String dt = calIndx.get(Calendar.YEAR)+"/"+ ay[calIndx.get(Calendar.MONTH)]+"/"+ay[calIndx.get(Calendar.DATE)-1];
		if(ayWrk[calIndx.get(Calendar.DAY_OF_WEEK)-1]==0) lRet++;
		else{
			vec.clear();
			vec.addElement(dt);
			vec.addElement(dt);
			vec.addElement(strBranchId);
			cvdal.setSQL("actual.checkForHoliday",vec);
			vec1 = (Vector)cvdal.executeQuery();
			if(vec1!=null && vec1.size()>0) lRet++;
		}
	}
	return lRet;
}
*/

public int getWeekDay(String dt1yyyy_mm_dd){
	int yyyy1 = Integer.parseInt(dt1yyyy_mm_dd.substring(0,4));
	int mm1 = Integer.parseInt(dt1yyyy_mm_dd.substring(5,7));
	int dd1 = Integer.parseInt(dt1yyyy_mm_dd.substring(8,10));

	GregorianCalendar cal1 = new GregorianCalendar(yyyy1,mm1-1,dd1);

        int lRet = cal1.get(Calendar.DAY_OF_WEEK);
	return lRet;
        //sunday = 1 , saturday=7
}

public long getNoOfMonths(String dt1yyyy_mm_dd,String dt2yyyy_mm_dd){
	String ay[] = {"01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31"};
	int ayWrk[] = {1,1,1,1,1,1,1};

	int yyyy1 = Integer.parseInt(dt1yyyy_mm_dd.substring(0,4));
	int mm1 = Integer.parseInt(dt1yyyy_mm_dd.substring(5,7));
	int dd1 = Integer.parseInt(dt1yyyy_mm_dd.substring(8,10));

	int yyyy2 = Integer.parseInt(dt2yyyy_mm_dd.substring(0,4));
	int mm2 = Integer.parseInt(dt2yyyy_mm_dd.substring(5,7));
	int dd2 = Integer.parseInt(dt2yyyy_mm_dd.substring(8,10));

	GregorianCalendar cal1 = new GregorianCalendar(yyyy1,mm1-1,dd1);
	GregorianCalendar cal2 = new GregorianCalendar(yyyy2,mm2-1,dd2);
	GregorianCalendar calIndx = new GregorianCalendar();

	int dtCheck  = cal1.get(Calendar.DATE);
	cal2.add(Calendar.DATE,1);

	long lRet = 0;
	for(calIndx=cal1;calIndx.before(cal2);calIndx.add(Calendar.DATE,1)){
		if(calIndx.get(Calendar.DATE) == dtCheck){
			lRet++;
		}
	}
	return lRet;
}

/*
public boolean isWorkingDay(String dt1yyyy_mm_dd, String strBranchId){
	String ay[] = {"01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31"};
	int ayWrk[] = {1,1,1,1,1,1,1};

	int yyyy1 = Integer.parseInt(dt1yyyy_mm_dd.substring(0,4));
	int mm1 = Integer.parseInt(dt1yyyy_mm_dd.substring(5,7));
	int dd1 = Integer.parseInt(dt1yyyy_mm_dd.substring(8,10));

	GregorianCalendar cal1 = new GregorianCalendar(yyyy1,mm1-1,dd1);
	GregorianCalendar calIndx = new GregorianCalendar();

	CVDal cvdal = new CVDal("schlstatic");
	Vector vec = new Vector();

	vec.clear();
	vec.addElement(strBranchId);  //BranchSessionId
	cvdal.setSQL("static.getBrchID",vec);
	Vector vec1 = (Vector)cvdal.executeQuery();
	String strOrgBranchId = "";
	if(vec1!=null && vec1.size()>0){
		HashMap hm = (HashMap)vec1.elementAt(0);
		strOrgBranchId = (String)hm.get("strBranchId");
	}


	vec.clear();
	vec.addElement(strOrgBranchId);
	cvdal.setSQL("static.workingDay",vec);
	vec1 = (Vector)cvdal.executeQuery();
	if(vec1!=null && vec1.size()>0){
		HashMap hm = (HashMap)vec1.elementAt(0);
		ayWrk[0] = Integer.parseInt((String)hm.get("bSun"));
		ayWrk[1] = Integer.parseInt((String)hm.get("bMon"));
		ayWrk[2] = Integer.parseInt((String)hm.get("bTues"));
		ayWrk[3] = Integer.parseInt((String)hm.get("bWed"));
		ayWrk[4] = Integer.parseInt((String)hm.get("bThur"));
		ayWrk[5] = Integer.parseInt((String)hm.get("bFri"));
		ayWrk[6] = Integer.parseInt((String)hm.get("bSat"));
	}
        boolean bRet = true;

        if(ayWrk[cal1.get(Calendar.DAY_OF_WEEK)-1]==0)
            bRet = false;
        else{
            String dt = cal1.get(Calendar.YEAR)+"/"+ ay[cal1.get(Calendar.MONTH)]+"/"+ay[cal1.get(Calendar.DATE)-1];
            cvdal = new CVDal("schlactual");
            vec.clear();
            vec.addElement(dt);
            vec.addElement(dt);
            vec.addElement(strBranchId);
            cvdal.setSQL("actual.checkForHoliday",vec);
            vec1 = (Vector)cvdal.executeQuery();
            if(vec1!=null && vec1.size()>0)
                bRet = false;
            else
                bRet = true;
        }

	return bRet;
}
*/

public String encryptValue(String strTarget)

{
		String strRet=null;               //Return value
		String strTempRet="";             //Return value
		char strChar='a';                 //current character to be convert
		int iAscii=0;                     //Ascii value of current character
		String strTempBinary=null;        //Binary of char Ascii
		String strTemp=null;              // Temp string
		int iCount=0;                     //Temp Number
		int iDeci=0;                      //Temp decimal
		int indx=0;		          //Temp int for loop counter

		try{
		while(strTarget.length()>0){
			strChar = strTarget.charAt(0);
			iAscii=(int)strChar;
//convert nAscii to 8-digit Binary
			strTempBinary="";
				while(iAscii > 0){
				iCount=iAscii % 2;
						strTempBinary = iCount + strTempBinary;
						iAscii = iAscii / 2;
			}
//Make it 8-digit
			strTemp="";
			for(iCount=0;iCount<(8-strTempBinary.length());iCount++){
				strTemp=strTemp+"0";
			}
			strTempBinary=strTemp+strTempBinary;
//Add to return value
				strTempRet = strTempRet + strTempBinary;
//			strTempRet = strTempRet.substring(4,strTempRet.length());
			strTarget = strTarget.substring(1, strTarget.length());
		}
		}catch(Exception e){}
//Convert return string into redable form
		iCount = strTempRet.length();
		strTemp="";
		for(indx=0;indx<3 - iCount % 3;indx++){
			strTemp = strTemp + "0";
		}
		strTempRet = strTemp + strTempRet;
//Assume 3-digit binary and convert into decimal
		strRet = "";
			while(strTempRet.length()>0){
				strTemp = strTempRet.substring(0,3);
				iCount = 0;
			iDeci = 0;
			while(iCount<3){
				switch(iCount){
					case 0:
						if(strTemp.substring(iCount,iCount+1).equals("1"))
							iDeci = iDeci + 4;
						break;
					case 1:
						if(strTemp.substring(iCount,iCount+1).equals("1"))
							iDeci = iDeci + 2;
						break;
					case 2:
						if(strTemp.substring(iCount,iCount+1).equals("1"))
							iDeci = iDeci + 1;
						break;
				}
					iCount = iCount + 1;
				}
				strRet = strRet + iDeci;
				strTempRet = strTempRet.substring(3,strTempRet.length());
		}
		return strRet;
			}
	//*************** End of Encryption Function *************************
}

