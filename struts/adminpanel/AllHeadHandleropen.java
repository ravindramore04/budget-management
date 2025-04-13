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

public class AllHeadHandleropen extends org.apache.struts.action.Action
{

	private static final String Success = "success";
	public static final String GLOBAL_FORWARD_failure = "failure";
	private static String FORWARD_final = GLOBAL_FORWARD_failure;


    public ActionForward execute(ActionMapping mapping, ActionForm form,HttpServletRequest request,
	HttpServletResponse response) throws RuntimeException,Exception
	{
            HttpSession session = request.getSession(true);
            HashMap My = (HashMap)session.getAttribute("user");
            sop(" DB name"+My);
			String DBnm = (String)My.get("DBnm");
            ErrorHandler eh = new ErrorHandler();
            try{
                    int nNum_Per_Page = 10;
                    CommonLogic cl = new CommonLogic();
                    CVDal cvdal = new CVDal(DBnm);
                    HashMap hmFinal = new HashMap();
                    Vector vec = new Vector();

                    DynaActionForm daf = (DynaActionForm)form;
                    String strPage_num ="";
                    String strNavOpr = "";

                    vec.clear();
                    cvdal.setSQL("openAllHead", vec);
                    Vector vec1 = (Vector)cvdal.executeQuery();
                    vec1 = (Vector)cvdal.executeQuery();
					 if(vec1!=null && vec1.size()>0){
						for(int indx=0;indx<vec1.size();indx++){
							HashMap hmt = (HashMap)vec1.elementAt(indx);
							hmFinal.put(""+indx, hmt);
						 }
                     }
                    request.setAttribute("data", hmFinal);
                    FORWARD_final = Success;
            }catch(Exception e){
                e.printStackTrace();
                String err = eh.getError("138530");
				String nxtpg = "ValidatedLogin.do";
				HashMap hmErr = new HashMap();
				hmErr.put("no","138530");
				hmErr.put("Source","AllHeadHandler");
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
