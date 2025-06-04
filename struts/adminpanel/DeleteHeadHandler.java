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
import java.util.Enumeration;

import java.util.HashMap;
import struts.common.CVDal;
import struts.common.CommonLogic;
import struts.common.ErrorHandler;
import java.util.*;
import java.sql.*;

public class DeleteHeadHandler extends org.apache.struts.action.Action
{

	private static final String Success = "success";
	public static final String GLOBAL_FORWARD_failure = "failure";
	private static String FORWARD_final = GLOBAL_FORWARD_failure;


    public ActionForward execute(ActionMapping mapping, ActionForm form,HttpServletRequest request,
	HttpServletResponse response) throws RuntimeException,Exception
	{
            HttpSession session = request.getSession(true);
            HashMap My = (HashMap)session.getAttribute("user");
			String DBnm = (String)My.get("DBnm");
		    DynaActionForm daf = (DynaActionForm)form;
		    sop("daf >>>>>>>>>>>>>"+daf.getMap().entrySet());
		    String headId=(String)daf.get("id");
            ErrorHandler eh = new ErrorHandler();
            CVDal cvdal = new CVDal(DBnm);
	    	try
	    	{
				Vector vec = new Vector();
				vec.addElement(headId);
				cvdal.setSQL("DeleteHead",vec);
				int i=cvdal.executeUpdate();

				if(vec.size() >0 && i ==0)
					request.setAttribute("message","Budget is allocated for this head , so you cant delete");

				FORWARD_final = Success;
            }catch(Exception e){
                e.printStackTrace();
                String err = eh.getError("148621");
				String nxtpg = "ValidatedLogin.do";
				HashMap hmErr = new HashMap();
				hmErr.put("no","148621");
				hmErr.put("Source","DeleteHeadHandler");
				hmErr.put("err",err);
				hmErr.put("nxtpg",nxtpg);
				request.setAttribute("err",hmErr);
				request.setAttribute("eDetail",e);
                FORWARD_final = GLOBAL_FORWARD_failure;
            }
            sop("forward value is--> "+FORWARD_final);
            return (mapping.findForward(FORWARD_final));
	}//End of execute()

	public void sop(String msg){
		System.out.println(msg);
	}
}
