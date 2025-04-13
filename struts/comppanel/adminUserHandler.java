package struts.comppanel;

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

public class adminUserHandler extends org.apache.struts.action.Action
{
	private static final String Success = "success";
	public static final String GLOBAL_FORWARD_failure = "failure";
	private static String FORWARD_final = GLOBAL_FORWARD_failure;

    public ActionForward execute(ActionMapping mapping, ActionForm form,HttpServletRequest request,
	HttpServletResponse response) throws RuntimeException,Exception
	{
		HttpSession session = request.getSession(true);
		ErrorHandler eh = new ErrorHandler();
		try{
			int nItr = Integer.parseInt((String)session.getAttribute("itr"));
			if(nItr>0){

				HashMap hmUser = (HashMap)session.getAttribute("user");
				String DBnm = (String)hmUser.get("DBnm");
				DynaActionForm daf = (DynaActionForm)form;
				CommonLogic cl = new CommonLogic();
				CVDal cvdal=new CVDal(DBnm);
				Vector vec = new Vector();
				int ID =100000;
				int iLvl = 1;

				String strName= (String)daf.get("txtName");
				String strLogin= (String)daf.get("txtLogin");
				String strPassword = (String)daf.get("txtPassword");

				String strInsBy =(String)hmUser.get("UId");
				String strInsOn =(String)hmUser.get("today");
				String strUpdtBy =(String)hmUser.get("UId");
				String strUpdtOn =(String)hmUser.get("today");



				vec.clear();
				vec.addElement(strLogin);
				cvdal.setSQL("checkUserLogin",vec);

				Vector vec1 = (Vector)cvdal.executeQuery();
				if(vec1!=null && vec1.size()>0){
					//Error Code for duplication
					sop("milin----> Catch");
					//e.printStackTrace();
					String err = eh.getError("146520");
					String nxtpg = "ValidatedLogin.do";
					HashMap hmErr = new HashMap();
					hmErr.put("no","146520");
					hmErr.put("Source","adminUserHandler");
					hmErr.put("err",err);
					hmErr.put("nxtpg",nxtpg);
					request.setAttribute("err",hmErr);
					//request.setAttribute("eDetail",e);
					FORWARD_final = GLOBAL_FORWARD_failure;

				}else{
					cvdal.setSQL("lastID",vec);
					vec1 = (Vector)cvdal.executeQuery();
					if(vec1!=null && vec1.size()>0){
						HashMap hmt = (HashMap)vec1.elementAt(0);
						String UID = (String) hmt.get("LastId");
						ID = Integer.parseInt(UID);
					}
				}
				ID++;

				vec.clear();
				vec.addElement(""+ID);
				vec.addElement(strName);
				vec.addElement(strLogin);
				vec.addElement(cl.encryptValue(strPassword));
				vec.addElement(""+iLvl);
				vec.addElement(strInsBy);
				vec.addElement(strInsOn);
				vec.addElement(strUpdtBy);
				vec.addElement(strUpdtOn);

				cvdal.setSQL("insertUser",vec);
				int i=cvdal.executeUpdate();
			}
			FORWARD_final = Success;
		}catch(Exception e){
			sop("milin----> Catch");
			e.printStackTrace();
			String err = eh.getError("146520");
			String nxtpg = "ValidatedLogin.do";
			HashMap hmErr = new HashMap();
			hmErr.put("no","146520");
			hmErr.put("Source","adminUserHandler");
			hmErr.put("err",err);
			hmErr.put("nxtpg",nxtpg);
			request.setAttribute("err",hmErr);
			request.setAttribute("eDetail",e);
			FORWARD_final = GLOBAL_FORWARD_failure;
		}

		return (mapping.findForward(FORWARD_final));
	}//End of execute()

	public void sop(String msg){
		System.out.println(msg);
	}
}
