package struts.adminpanel;

import login.SessionUtils;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.DynaActionForm;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.util.HashMap;
import java.util.Vector;

import struts.common.CVDal;
import struts.common.ErrorHandler;

public class showBudgetRequisitionHandler extends Action
{
    private static final String Success = "success";
    public static final String GLOBAL_FORWARD_failure = "failure";

    public ActionForward execute(ActionMapping mapping, ActionForm form,
                                 HttpServletRequest request,
                                 HttpServletResponse response)
            throws RuntimeException, Exception
    {
        HttpSession session = request.getSession(true);
        ErrorHandler eh = new ErrorHandler();

        try{
            HashMap hmUser = (HashMap)session.getAttribute("user");
            String dbName = (String)hmUser.get("DBnm");
            CVDal cvdal = new CVDal(dbName);
            Vector values = new Vector();
            HashMap hmHead = new HashMap();
            HashMap hmDepartment = new HashMap();

            if(SessionUtils.isAccountUser(session)){
                cvdal.setSQL("openAllHead", values);
            }else{
                values.addElement(SessionUtils.getDepartmentId(session));
                cvdal.setSQL("openAllHead", values); //openAllHeadDept
            }

            Vector heads = (Vector)cvdal.executeQuery();
            if(heads != null){
                for(int index = 0; index < heads.size(); index++){
                    hmHead.put("" + index, heads.elementAt(index));
                }
            }

            values.clear();
            cvdal.setSQL("openAllDepartment", values);
            Vector departments = (Vector)cvdal.executeQuery();
            if(departments != null){
                for(int index = 0; index < departments.size(); index++){
                    hmDepartment.put("" + index, departments.elementAt(index));
                }
            }

            request.setAttribute("data", new HashMap());
            request.setAttribute("head", hmHead);
            request.setAttribute("ghead", hmDepartment);
            request.setAttribute("deptId", SessionUtils.getDepartmentId(session));
            return mapping.findForward(Success);
        }catch(Exception e){
            e.printStackTrace();
            String err = eh.getError("147420");
            HashMap hmErr = new HashMap();
            hmErr.put("no", "147420");
            hmErr.put("Source", "showBudgetRequisitionHandler");
            hmErr.put("err", err);
            hmErr.put("nxtpg", "AllBudgetAllocation.do");
            request.setAttribute("err", hmErr);
            request.setAttribute("eDetail", e);
            return mapping.findForward(GLOBAL_FORWARD_failure);
        }
    }
}
