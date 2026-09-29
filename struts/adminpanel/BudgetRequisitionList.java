package struts.adminpanel;

import login.SessionUtils;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.DynaActionForm;
import struts.common.CVDal;
import struts.common.ErrorHandler;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Vector;

public class BudgetRequisitionList extends Action
{
    private static final String Success = "success";
    private static final String Failure = "failure";
    private static final int ROWS_PER_PAGE = 20;

    public ActionForward execute(ActionMapping mapping, ActionForm form,
                                 HttpServletRequest request,
                                 HttpServletResponse response)
            throws RuntimeException, Exception
    {
        HttpSession session = request.getSession(true);
        ErrorHandler errorHandler = new ErrorHandler();
        try{
            HashMap user = (HashMap)session.getAttribute("user");
            if(user == null){
                throw new IllegalStateException("User session is not available");
            }
            SessionUtils.addUserToSession(session, (String)user.get("UId"),
                    (String)user.get("UNm"), (String)user.get("departmentId"));

            CVDal cvdal = new CVDal((String)user.get("DBnm"));
            boolean accountUser = SessionUtils.isAccountUser(session);
            String departmentId = SessionUtils.getDepartmentId(session);
            if(departmentId == null || departmentId.length() == 0){
                throw new IllegalStateException("User department is not available");
            }
            Vector values = new Vector();

            if("csv".equalsIgnoreCase(request.getParameter("export"))){
                if(accountUser){
                    cvdal.setSQL("budgetRequisitionExportAll", values);
                }else{
                    values.addElement(departmentId);
                    cvdal.setSQL("budgetRequisitionExportDept", values);
                }
                writeCsv(response, (Vector)cvdal.executeQuery());
                return null;
            }

            if("true".equalsIgnoreCase(request.getParameter("print"))){
                if(accountUser){
                    cvdal.setSQL("budgetRequisitionExportAll", values);
                }else{
                    values.addElement(departmentId);
                    cvdal.setSQL("budgetRequisitionExportDept", values);
                }
                Vector printRows = (Vector)cvdal.executeQuery();
                HashMap printData = rowsAsMap(printRows);
                HashMap printPage = new HashMap();
                printPage.put("current_page", "1");
                printPage.put("total_page", "1");
                printPage.put("total_rows", String.valueOf(printData.size()));
                request.setAttribute("data", printData);
                request.setAttribute("page", printPage);
                request.setAttribute("printMode", Boolean.TRUE);
                request.setAttribute("requisitionSaved", session.getAttribute("requisitionSaved"));
                session.removeAttribute("requisitionSaved");
                return mapping.findForward(Success);
            }

            if(accountUser){
                cvdal.setSQL("budgetRequisitionCountAll", values);
            }else{
                values.addElement(departmentId);
                cvdal.setSQL("budgetRequisitionCountDept", values);
            }
            Vector countRows = (Vector)cvdal.executeQuery();
            int totalRows = 0;
            if(countRows != null && !countRows.isEmpty()){
                String count = (String)((HashMap)countRows.elementAt(0)).get("total_rows");
                totalRows = Integer.parseInt(count);
            }

            DynaActionForm listForm = (DynaActionForm)form;
            String requestedPage = (String)listForm.get("current_page");
            String navigation = (String)listForm.get("NAV");
            int totalPages = (int)Math.ceil(totalRows / (double)ROWS_PER_PAGE);
            int currentPage = 1;
            if(requestedPage != null && requestedPage.length() > 0){
                try{
                    currentPage = Integer.parseInt(requestedPage);
                }catch(NumberFormatException ignored){
                    currentPage = 1;
                }
            }
            if("1".equals(navigation)){
                currentPage = 1;
            }else if("2".equals(navigation)){
                currentPage++;
            }else if("3".equals(navigation)){
                currentPage--;
            }else if("4".equals(navigation)){
                currentPage = totalPages;
            }
            if(currentPage < 1){
                currentPage = 1;
            }
            if(totalPages > 0 && currentPage > totalPages){
                currentPage = totalPages;
            }

            Vector rows = new Vector();
            if(totalRows > 0){
                values.clear();
                if(!accountUser){
                    values.addElement(departmentId);
                }
                values.addElement(String.valueOf((currentPage - 1) * ROWS_PER_PAGE));
                values.addElement(String.valueOf(ROWS_PER_PAGE));
                cvdal.setSQL(accountUser ? "budgetRequisitionListAll" : "budgetRequisitionListDept", values);
                rows = (Vector)cvdal.executeQuery();
            }

            HashMap data = rowsAsMap(rows);
            HashMap page = new HashMap();
            page.put("current_page", String.valueOf(currentPage));
            page.put("total_page", String.valueOf(totalPages));
            page.put("total_rows", String.valueOf(totalRows));
            request.setAttribute("data", data);
            request.setAttribute("page", page);
            request.setAttribute("printMode", Boolean.FALSE);
            request.setAttribute("requisitionSaved", session.getAttribute("requisitionSaved"));
            session.removeAttribute("requisitionSaved");
            return mapping.findForward(Success);
        }catch(Exception e){
            e.printStackTrace();
            HashMap error = new HashMap();
            error.put("no", "138530");
            error.put("Source", "BudgetRequisitionList");
            error.put("err", errorHandler.getError("138530"));
            error.put("nxtpg", "ValidatedLogin.do");
            request.setAttribute("err", error);
            request.setAttribute("eDetail", e);
            return mapping.findForward(Failure);
        }
    }

    private HashMap rowsAsMap(Vector rows)
    {
        HashMap data = new HashMap();
        if(rows != null){
            for(int index = 0; index < rows.size(); index++){
                data.put(String.valueOf(index), rows.elementAt(index));
            }
        }
        return data;
    }

    private void writeCsv(HttpServletResponse response, Vector rows) throws Exception
    {
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/csv; charset=UTF-8");
        response.setHeader("Content-Disposition", "attachment; filename=budget-requisitions.csv");
        PrintWriter writer = response.getWriter();
        writer.write("\uFEFF");
        writer.println("Requisition ID,Requisition Date,Saved On,Budget Head,Requested Amount,Approved Amount,Status,Remark,Created By,Department");
        if(rows != null){
            for(int index = 0; index < rows.size(); index++){
                HashMap row = (HashMap)rows.elementAt(index);
                writer.println(csv(row.get("RequisitionId")) + "," +
                        csv(row.get("Dt")) + "," +
                        csv(row.get("strInsOn")) + "," +
                        csv(row.get("budget_head_name")) + "," +
                        csv(row.get("dblRequestedAmount")) + "," +
                        csv(row.get("dblApprovedAmount")) + "," +
                        csv(row.get("strStatus")) + "," +
                        csv(row.get("strRemark")) + "," +
                        csv(row.get("created_by_name")) + "," +
                        csv(row.get("department_name")));
            }
        }
        writer.flush();
    }

    private String csv(Object value)
    {
        String text = value == null ? "" : String.valueOf(value);
        String trimmed = text.trim();
        if(trimmed.length() > 0 && ("=+-@".indexOf(trimmed.charAt(0)) >= 0 ||
            text.charAt(0) == '\t' || text.charAt(0) == '\r')){
            text = "'" + text;
        }
        return "\"" + text.replace("\"", "\"\"") + "\"";
    }
}
