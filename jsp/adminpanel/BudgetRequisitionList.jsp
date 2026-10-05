<%@ page import="java.util.*" %>
<%@ include file="/jsp/adminpanel/header.jsp" %>
<%!
    private String escapeHtml(Object value){
        if(value == null){
            return "";
        }
        String text = String.valueOf(value);
        return text.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;")
                .replace("\"", "&quot;").replace("'", "&#39;");
    }
%>
<%
    HashMap data = (HashMap)request.getAttribute("data");
    HashMap pageInfo = (HashMap)request.getAttribute("page");
    int currentPage = 1;
    int totalPages = 0;
    int totalRows = 0;
    if(pageInfo != null){
        currentPage = Integer.parseInt((String)pageInfo.get("current_page"));
        totalPages = Integer.parseInt((String)pageInfo.get("total_page"));
        totalRows = Integer.parseInt((String)pageInfo.get("total_rows"));
    }
    String savedMessage = (String)request.getAttribute("requisitionSaved");
    boolean printMode = Boolean.TRUE.equals(request.getAttribute("printMode"));
    String totalAmount = (String)request.getAttribute("totalAmount");
    if(totalAmount == null){
        totalAmount = "0.00";
    }
%>
<style>
    .requisition-report { width: 100%; border-collapse: collapse; font-size: 13px; }
    .requisition-report th, .requisition-report td { border: 1px solid #9aa4aa; padding: 6px; }
    .requisition-report th { background: #d4dae2; text-align: left; }
    .requisition-total { font-weight: bold; background: #e6e9ec; }
    .requisition-actions { margin: 12px 0; }
    .requisition-actions a, .requisition-actions button, .requisition-actions input { margin-right: 8px; }
    .requisition-empty { text-align: center; padding: 18px; }
    @media print {
        .requisition-actions, .requisition-pagination, .innertitle { display: none !important; }
        .requisition-report { font-size: 10px; }
        .requisition-report th, .requisition-report td { padding: 3px; }
    }
</style>
<script>
function requisitionNavigation(code){
    document.RequisitionList.NAV.value = code;
    document.RequisitionList.submit();
}
<% if(printMode){ %>
window.onload = function(){ window.print(); };
<% } %>
</script>
<form name="RequisitionList" method="post" action="<%=strPath%>BudgetRequisitionList.do">
    <input type="hidden" name="NAV" value="">
    <input type="hidden" name="current_page" value="<%=currentPage%>">
    <td width="80%" valign="top" align="center">
        <table width="100%" border="0" cellspacing="1" cellpadding="1" align="center">
            <tr><td colspan="6" class="titles" align="left">Budget Requisition Report</td></tr>
            <% if(savedMessage != null){ %>
            <tr><td colspan="6" class="link"><%=escapeHtml(savedMessage)%></td></tr>
            <% } %>
            <tr><td colspan="6" class="link">
                <span>Total requisitions: <%=totalRows%></span>
                <div class="requisition-actions">
                    <a href="<%=strPath%>BudgetRequisitionList.do?export=csv">Download CSV</a>
                    <a href="<%=strPath%>BudgetRequisitionList.do?print=true" target="_blank">Print / Save PDF</a>
                    <a href="<%=strPath%>showBudgetRequisition.do?opr=1&amp;id=0">New Requisition</a>
                </div>
            </td></tr>
            <tr>
                <td colspan="6">
                    <table class="requisition-report">
                        <thead><tr>
                            <th>Sr. No.</th><th>Requisition Date</th><th>Budget Head</th>
                            <th>Requested Amount</th>
                            <th>Remark</th><th>Department</th>
                        </tr></thead>
                        <tbody>
                        <%
                            if(data != null && !data.isEmpty()){
                                for(int index = 0; index < data.size(); index++){
                                    HashMap row = (HashMap)data.get(String.valueOf(index));
                                    if(row != null){
                        %>
                        <tr>
                            <td><%=escapeHtml(row.get("RequisitionId"))%></td>
                            <td><%=escapeHtml(row.get("Dt"))%></td>
                            <td><%=escapeHtml(row.get("budget_head_name"))%></td>
                            <td align="right"><%=escapeHtml(row.get("dblRequestedAmount"))%></td>
                            <td><%=escapeHtml(row.get("strRemark"))%></td>
                            <td><%=escapeHtml(row.get("department_name"))%></td>
                        </tr>
                        <%
                                    }
                                }
                            }else{
                        %>
                        <tr><td colspan="6" class="requisition-empty">No requisitions found.</td></tr>
                        <% } %>
                        <tr class="requisition-total">
                            <td colspan="3">Total Amount</td>
                            <td align="right"><%=escapeHtml(totalAmount)%></td>
                            <td colspan="2"></td>
                        </tr>
                        </tbody>
                    </table>
                </td>
            </tr>
            <tr class="requisition-pagination"><td colspan="6" align="center">
                <% if(currentPage > 1){ %>
                    <input type="button" value="First" onclick="requisitionNavigation('1')">
                    <input type="button" value="Previous" onclick="requisitionNavigation('3')">
                <% } %>
                <span>Page <%=currentPage%> of <%=totalPages%></span>
                <% if(currentPage < totalPages){ %>
                    <input type="button" value="Next" onclick="requisitionNavigation('2')">
                    <input type="button" value="Last" onclick="requisitionNavigation('4')">
                <% } %>
            </td></tr>
        </table>
    </td>
</form>
<%@ include file="/jsp/include/footer.jsp" %>
