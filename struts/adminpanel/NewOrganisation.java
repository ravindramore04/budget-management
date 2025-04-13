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

public class NewOrganisation extends org.apache.struts.action.Action
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
				HashMap hmUser = (HashMap)session.getAttribute("user");
				String DBnm = (String)hmUser.get("DBnm");


				System.out.println("inside servlet ---> " + hmUser);
				CVDal cvdal=new CVDal(DBnm);
				Vector vec = new Vector();
				cvdal.setSQL("openOrg",vec);
				Vector vec1 = (Vector)cvdal.executeQuery();
				HashMap hmFinal = new HashMap();
				if(vec1!=null && vec1.size()>0)
				{
					for(int indx=0;indx<vec1.size();indx++)
					{
						HashMap hmt = (HashMap)vec1.elementAt(indx);
						hmFinal.put(""+indx,hmt);
					}
				}
				request.setAttribute("Data",hmFinal);

				FORWARD_final = Success;
            }catch(Exception e){
                e.printStackTrace();
                String err = eh.getError("148621");
				String nxtpg = "ValidatedLogin.do";
				HashMap hmErr = new HashMap();
				hmErr.put("no","148621");
				hmErr.put("Source","NewOrganisation");
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
