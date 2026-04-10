package struts.login;

import login.SessionUtils;
import login.User;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionError;
import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionServlet;
import org.apache.struts.action.DynaActionForm;

import javax.servlet.*;
import javax.servlet.http.*;

import java.util.HashMap;
import struts.common.CVDal;
import struts.common.CommonLogic;
import struts.common.ErrorHandler;
import java.util.*;
import java.sql.*;

public class LoginHandler extends org.apache.struts.action.Action
{

	private static final String Success_Comp = "success_comp";
	private static final String Success_Admin = "success_admin";
	private static final String Success_User = "success_user";
	private static final String Success_Director = "success_director";

	public static final String GLOBAL_FORWARD_failure = "failure";
	private static String FORWARD_final = GLOBAL_FORWARD_failure;


	public ActionForward execute(ActionMapping mapping, ActionForm form,HttpServletRequest request,
	HttpServletResponse response) throws RuntimeException,Exception
	{
		HttpSession session = request.getSession(true);
		 ErrorHandler eh = new ErrorHandler();
		try{
			HashMap hmUser = (HashMap)session.getAttribute("user");
			sop("--hmUser---"+hmUser);
			HashMap hmFinal = new HashMap();

			Vector vec = new Vector();

			DynaActionForm daf = (DynaActionForm)form;

			String formUsername=(String)daf.get("txtuser");
			String formPassword=(String)daf.get("txtpassword");
			String DBnm1 =request.getParameter("Year");
			String strUserId="";
			if(DBnm1 == null){
				DBnm1 = (String)hmUser.get("DBnm");
			}

			CommonLogic cl = new CommonLogic();
			CVDal cvdal = new CVDal(DBnm1);
			int iLevel = 10;
			if(formUsername!=null && formUsername.length()>0 && !formUsername.equals("null")){
				//form
				vec.clear();
				vec.addElement(formUsername);
				vec.addElement(cl.encryptValue(formPassword));
				cvdal.setSQL("checkUser",vec);
				Vector vec1 = (Vector)cvdal.executeQuery();
				if(vec1!=null && vec1.size()>0){
					HashMap hmt = (HashMap)vec1.elementAt(0);
					if(hmt!= null && hmt.size()>0){
						strUserId = (String)hmt.get("UId");
						String strUserName = (String)hmt.get("strName");
						String strLogin = (String)hmt.get("strLogin");
						iLevel = Integer.parseInt((String)hmt.get("lvl"));
						String departmentId = (String)hmt.get("strDepartmentId");

						hmFinal.put("lvl",""+iLevel);
						hmFinal.put("UId",strUserId);
						hmFinal.put("UNm",strUserName);
						hmFinal.put("departmentId", departmentId);

						vec.clear();
						cvdal.setSQL("openOrg",vec);
						vec1 = (Vector)cvdal.executeQuery();
						if(vec1!=null && vec1.size()>0){
							hmt = (HashMap)vec1.elementAt(0);
							String strName = (String)hmt.get("strName");
							String strAddr = (String)hmt.get("strAddr");
							hmFinal.put("comp",strName);
							hmFinal.put("addr",strAddr);
							hmFinal.put("DBnm",DBnm1);
						}else{
							hmFinal.put("comp","MoreAI Technologies Pvt. Ltd.");
							hmFinal.put("addr","Dhanori Raod, Pune-15");
							hmFinal.put("DBnm",DBnm1);
						}

						SessionUtils.addUserToSession(session,strUserId, strLogin, departmentId );
					}

					session.setAttribute("user",hmFinal);
					String financeYear=(String)getFinancialYear(DBnm1);
					session.setAttribute("financeYear",financeYear);
					sop(financeYear);
				}else{
					String err = eh.getError("146430");
					String nxtpg = "Startpage.do";
					HashMap hmErr = new HashMap();
					hmErr.put("no","146520");
					hmErr.put("Source","LoginHandler");
					hmErr.put("err",err);
					hmErr.put("nxtpg",nxtpg);
					request.setAttribute("err",hmErr);
					FORWARD_final = GLOBAL_FORWARD_failure;
				}
			}else{
				//session
				iLevel = Integer.parseInt((String)hmUser.get("lvl"));
			}
			switch(iLevel){
				case 0:
					FORWARD_final = Success_Comp;
					break;
				case 1:
					FORWARD_final = Success_Admin;
					break;
				case 2:
					FORWARD_final = Success_Director;
			}

		}catch(Exception e){
			e.printStackTrace();
			String err = eh.getError("146520");
			String nxtpg = "Startpage.do";
			HashMap hmErr = new HashMap();
			hmErr.put("no","146520");
			hmErr.put("Source","LoginHandler");
			hmErr.put("err",err);
			hmErr.put("nxtpg",nxtpg);
			request.setAttribute("err",hmErr);
			request.setAttribute("eDetail",e);
		    FORWARD_final = GLOBAL_FORWARD_failure;
		}
		sop("---final value------"+FORWARD_final);
		return (mapping.findForward(FORWARD_final));
	}//End of execute()

	public void sop(String msg){
		System.out.println("Print Value>>>"+msg);
	}

	public static String getFinancialYear(String budget) {
		if (budget == null || !budget.contains("_")) {
			return "";
		}

		try {
			// Remove prefix "budget"
			String yearPart = budget.replace("budget", "");

			// Split years
			String[] parts = yearPart.split("_");

			if (parts.length != 2) return "";

			int startYear = Integer.parseInt(parts[0]);
			int endYear = Integer.parseInt(parts[1]);

			// Convert to full year (2000 + year)
			int fullStartYear = 2000 + startYear;
			int fullEndYear = 2000 + endYear;

			return fullStartYear + "-" + fullEndYear;

		} catch (Exception e) {
			return "";
		}
	}
}
