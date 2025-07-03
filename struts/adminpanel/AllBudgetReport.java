package struts.adminpanel;

import login.SessionUtils;
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

public class AllBudgetReport extends org.apache.struts.action.Action
{

    private static final String Success = "success";
    public static final String GLOBAL_FORWARD_failure = "failure";
    private static String FORWARD_final = GLOBAL_FORWARD_failure;


    public ActionForward execute(ActionMapping mapping, ActionForm form,HttpServletRequest request,
                                 HttpServletResponse response) throws RuntimeException,Exception
    {
        HttpSession session = request.getSession(true);
        HashMap My = (HashMap)session.getAttribute("user");
        sop("User Session  departmentId+  " + My.get("departmentId"));
        sop("isAccountUser "+SessionUtils.isAccountUser(session));
        String DBnm = (String)My.get("DBnm");
        ErrorHandler eh = new ErrorHandler();
        try{
            int nNum_Per_Page = 10;
            CommonLogic cl = new CommonLogic();
            CVDal cvdal = new CVDal(DBnm);
            HashMap hmFinal = new HashMap();
            HashMap hmHead = new HashMap();
            Vector vec = new Vector();
            //sdsd
            DynaActionForm daf = (DynaActionForm)form;
            String strPage_num ="";
            String strNavOpr = "";
            if(daf!=null){
                strPage_num = (String)daf.get("current_page");
                strNavOpr = (String)daf.get("NAV");
            }

            vec.clear();
            if(SessionUtils.isAccountUser(session)){
                cvdal.setSQL("openAllHead", vec);
            }else{
                vec.addElement(My.get("departmentId"));
                cvdal.setSQL("openAllHeadDept", vec);
            }

            Vector vec2 = (Vector)cvdal.executeQuery();
            if(vec2!=null && vec2.size()>0){
                for(int i=0;i<vec2.size();i++){
                    HashMap hm=(HashMap)vec2.elementAt(i);
                    hmHead.put(""+i,hm);
                }
            }

            createExcelReport(cvdal);

            request.setAttribute("data", hmFinal);
            request.setAttribute("head", hmHead);
            HashMap hmPage = new HashMap();
            request.setAttribute("page", hmPage);
            FORWARD_final = Success;
        }catch(Exception e){
            e.printStackTrace();
            String err = eh.getError("138530");
            String nxtpg = "ValidatedLogin.do";
            HashMap hmErr = new HashMap();
            hmErr.put("no","138530");
            hmErr.put("Source","AllBudgetReport");
            hmErr.put("err",err);
            hmErr.put("nxtpg",nxtpg);
            request.setAttribute("err",hmErr);
            request.setAttribute("eDetail",e);
            FORWARD_final = GLOBAL_FORWARD_failure;
        }
        sop("forward value is--> "+FORWARD_final);
        return (mapping.findForward(FORWARD_final));
    }//End of execute()

    private void createExcelReport( CVDal cvdal){

        cvdal.setSQL("get_All_Allocation_Status_Report", new Vector());
        Vector vec1 = (Vector)cvdal.executeQuery();

    }

    public void sop(String msg){
        System.out.println(msg);
    }
}
