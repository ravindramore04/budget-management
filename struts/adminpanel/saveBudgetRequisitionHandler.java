package struts.adminpanel;

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
import struts.common.CommonLogic;
import struts.common.ErrorHandler;

public class saveBudgetRequisitionHandler extends Action
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
            if(hmUser == null){
                throw new IllegalStateException("User session is not available");
            }

            String dbName = (String)hmUser.get("DBnm");
            String userId = (String)hmUser.get("UId");
            DynaActionForm daf = (DynaActionForm)form;

            String headId = (String)daf.get("Head");
            String requestDate = (String)daf.get("txtDate");
            String requestedAmount = (String)daf.get("txtAmount");
            String remark = (String)daf.get("txtRemark");
            String departmentId = (String)daf.get("strDepartmentId");

            if(headId == null || headId.length() == 0 || "0".equals(headId)){
                throw new IllegalArgumentException("Budget head is required");
            }
            if(requestDate == null || requestDate.length() == 0){
                throw new IllegalArgumentException("Requisition date is required");
            }
            if(requestedAmount == null || requestedAmount.length() == 0){
                throw new IllegalArgumentException("Requested amount is required");
            }
            Double.parseDouble(requestedAmount);
            if(departmentId == null || departmentId.length() == 0 || "0".equals(departmentId)){
                throw new IllegalArgumentException("Department is required");
            }

            CommonLogic commonLogic = new CommonLogic();
            String today = commonLogic.getToday();
            Vector values = new Vector();
            values.addElement(headId);
            values.addElement(requestDate);
            values.addElement(requestedAmount);
            values.addElement(remark == null ? "" : remark);
            values.addElement(userId);
            values.addElement(today);
            values.addElement(departmentId);

            CVDal cvdal = new CVDal(dbName);
            cvdal.setSQL("insertintobudgetrequisition", values);
            int insertedRows = cvdal.executeUpdate();
            if(insertedRows != 1){
                throw new IllegalStateException("Budget requisition was not saved");
            }

            session.setAttribute("itr", "0");
            session.setAttribute("requisitionSaved", "Budget requisition saved successfully.");
            return mapping.findForward(Success);
        }catch(Exception e){
            e.printStackTrace();
            String err = eh.getError("138620");
            HashMap hmErr = new HashMap();
            hmErr.put("no", "138620");
            hmErr.put("Source", "saveBudgetRequisitionHandler");
            hmErr.put("err", err);
            hmErr.put("nxtpg", "AllBudgetAllocation.do");
            request.setAttribute("err", hmErr);
            request.setAttribute("eDetail", e);
            return mapping.findForward(GLOBAL_FORWARD_failure);
        }
    }
}
