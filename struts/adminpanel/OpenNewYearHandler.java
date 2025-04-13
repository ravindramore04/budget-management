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

public class OpenNewYearHandler extends org.apache.struts.action.Action
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
			sop("");sop("");sop("");sop("");
			sop("");sop("");sop("");sop("");
			sop(""+My);
            ErrorHandler eh = new ErrorHandler();
            try{
                CommonLogic cl = new CommonLogic();
                CVDal cvdal = new CVDal(DBnm);
                HashMap hmLocation = new HashMap();
                HashMap hmFinal = new HashMap();
                Vector vec = new Vector();

                DynaActionForm daf = (DynaActionForm)form;
                String strId = (String)daf.get("id");
                sop("strId "+strId);
                int nOpr = Integer.parseInt((String)daf.get("opr"));
                sop("nOpr ==============================>>>>>>>>>>"+nOpr );

                switch(nOpr){
                    case 1:
                        //add new
                        /*vec.clear();
						vec.addElement(strId);
						cvdal.setSQL("openAllFinacialYearwithId", vec);
						Vector vec2 = (Vector)cvdal.executeQuery();
						sop("vec1===========>11111"+vec2);
						if(vec2!=null && vec2.size()>0){
							hmFinal = (HashMap)vec2.elementAt(0);
                        }*/
                        break;
                    case 2:
                        //update
                        vec.clear();
                        vec.addElement(strId);
                        cvdal.setSQL("openAllFinacialYearId", vec);
                        Vector vec1 = (Vector)cvdal.executeQuery();
                        sop("vec1===========>11111"+vec1);
                        if(vec1!=null && vec1.size()>0){
                            hmFinal = (HashMap)vec1.elementAt(0);
                        }

                    case 3:
                        //delete
                        break;
                }

                request.setAttribute("data", hmFinal);
                FORWARD_final = Success;
            }catch(Exception e){
                e.printStackTrace();
                String err = eh.getError("147420");
				String nxtpg = "AllUser.do";
				HashMap hmErr = new HashMap();
				hmErr.put("no","147420");
				hmErr.put("Source","OpenUserHandler");
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
