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

public class OpenGroupHeadHandler extends org.apache.struts.action.Action
{
    private static final String Success = "success";
    public static final String GLOBAL_FORWARD_failure = "failure";
    private static String FORWARD_final = GLOBAL_FORWARD_failure;

    public ActionForward execute(ActionMapping mapping, ActionForm form,HttpServletRequest request,
	HttpServletResponse response) throws RuntimeException,Exception
	{
            HttpSession session = request.getSession(true);
            HashMap My = (HashMap)session.getAttribute("user");
          //  sop("My"+My);
			String DBnm = (String)My.get("DBnm");
            ErrorHandler eh = new ErrorHandler();
            try{
                CommonLogic cl = new CommonLogic();
                CVDal cvdal = new CVDal(DBnm);
                HashMap hmLocation = new HashMap();
                HashMap hmFinal = new HashMap();
                Vector vec = new Vector();

                DynaActionForm daf = (DynaActionForm)form;
                String strId = (String)daf.get("id");
                int nOpr = Integer.parseInt((String)daf.get("opr"));

                switch(nOpr){
                    case 1:
                        //add new
                    case 2:
                        //update
                        vec.clear();
                        vec.addElement(strId);
                        cvdal.setSQL("openDepartmentWithId", vec);
                        Vector vec1 = (Vector)cvdal.executeQuery();
                        if(vec1!=null && vec1.size()>0){
                            hmFinal = (HashMap)vec1.elementAt(0);
                        }
                    case 3:
                        //delete
                }

                request.setAttribute("data", hmFinal);
                FORWARD_final = Success;
            }catch(Exception e){
                e.printStackTrace();
                String err = eh.getError("147420");
				String nxtpg = "AllHead.do";
				HashMap hmErr = new HashMap();
				hmErr.put("no","147420");
				hmErr.put("Source","OpenHeadHandler");
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
