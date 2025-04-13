package struts.adminpanel;

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

public class OrganisationHandler extends org.apache.struts.action.Action
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
				sop("cvdalcvdal==========================>>>>>>>"+cvdal);
				String strToday = (String)cl.getToday();
				Vector vec = new Vector();
				sop("value---> "+daf);
				String strName= (String)daf.get("txtName");
				String strShrtNm= (String)daf.get("txtShrtNm");
				String strAddr = (String)daf.get("addr");
				String strPh1 = (String)daf.get("txtPh1");
				String strPh2= (String)daf.get("txtPh2");

				String strInsBy =(String)hmUser.get("UId");
				String strInsOn =(String)hmUser.get("today");
				String strUpdtBy =(String)hmUser.get("UId");
				String strUpdtOn =(String)hmUser.get("today");

				vec.clear();
				cvdal.setSQL("openOrg",vec);
				Vector vec1 = (Vector)cvdal.executeQuery();
				if(vec1.size()>0)
				{
					vec.clear();
					vec.addElement(strName);
					vec.addElement(strShrtNm);
					vec.addElement(strAddr);
					vec.addElement(strPh1);
					vec.addElement(strPh2);
					vec.addElement(strUpdtBy);
					vec.addElement(strUpdtBy);
					cvdal.setSQL("UpdateOrg",vec);
					int i= cvdal.executeUpdate();

					sop(""+i);
					//update
				}
				else
				{
					vec.clear();
					vec.addElement(strName);
					vec.addElement(strShrtNm);
					vec.addElement(strAddr);
					vec.addElement(strPh1);
					vec.addElement(strPh2);
					vec.addElement(strInsBy);
					vec.addElement(strToday);
					vec.addElement(strUpdtBy);
					vec.addElement(strToday);
					System.out.println(vec);
					cvdal.setSQL("InsertOrg",vec);
					int i=cvdal.executeUpdate();
						//Insert new entry
				}
			}
			FORWARD_final = Success;
		}catch(Exception e){
			sop("milin----> Catch");
			e.printStackTrace();
			String err = eh.getError("148621");
			String nxtpg = "ValidatedLogin.do";
			HashMap hmErr = new HashMap();
			hmErr.put("no","148621");
			hmErr.put("Source","OrganisationHandler");
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
