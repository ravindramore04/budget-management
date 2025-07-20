<%@ page import="java.util.*,java.text.*,struts.adminpanel.beans.*, struts.adminpanel.utils.*" %>
<%
  //response.setContentType("application/vnd.ms-excel"); // Set the content type for Excel
  //response.setHeader("Content-Disposition", "attachment; filename=VoucherReport.xls"); // Prompt to download as Excel file
DecimalFormat d = new DecimalFormat("##0.00");
List<VoucherReportRow> createVoucherReportRows = (List<VoucherReportRow>) request.getAttribute("ReportDetails");
out.print(createVoucherReportRows);
String toDate = (String) request.getAttribute("toDate");
String fromDate = (String) request.getAttribute("fromDate");
String chkCash = (String) request.getAttribute("chkCash");
String headId = (String) request.getAttribute("headId");
String strDepartmentId = (String) request.getAttribute("strDepartmentId");

String PayMethod = "";
if ("1".equals(chkCash)) {
    PayMethod = "CASH";
} else if ("2".equals(chkCash)) {
    PayMethod = "Cheque";
} else {
    PayMethod = "CASH/Cheque";
}
%>
<%!
/**
 * Reformats "yyyy-MM-dd" to "dd-MM-yyyy"
 */
public String formatIsoToEuropean(String isoDate) {
    try {
        SimpleDateFormat inFmt = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat outFmt = new SimpleDateFormat("dd-MM-yyyy");
        Date date = inFmt.parse(isoDate);
        return outFmt.format(date);
    } catch (Exception e) {
        return isoDate; // fallback on parse error
    }
}

double totalAmount = 0.0;
%>

<script language="JavaScript">
function setAction(code, id) {
    document.HeadList.id.value = id;
    switch (code) {
          case 5:
            document.HeadList.action = "/budget-management/jsp/adminpanel/panel.jsp";
            break;
    }
    document.HeadList.opr.value = code;
    document.HeadList.submit();
}

function printPage() {
    window.print();
}

</script>

<body onLoad="javascript:print();">
<form name="HeadList" method="post" action="#">
    <input type="hidden" name="page" value="ParamRpt">
    <input type="hidden" name="NAV" value="">
    <input type="hidden" name="txtBGid" value="<%=headId%>">
    <input type="hidden" name="strDepartmentId" value="<%=strDepartmentId%>">
    <input type="hidden" name="rd" value="<%=chkCash%>">
    <input type="hidden" name="toDate" value="<%=toDate%>">
    <input type="hidden" name="fromDate" value="<%=fromDate%>">
    <input type="hidden" name="id" value="">
    <input type="hidden" name="opr" value="">

    <td width="80%" valign="top" align="center">
    <div style="width: 90%; background-color: white; padding: 20px; font-family: Arial, sans-serif; color: black;">
        <h2 style="text-align: center; font-weight: bold;">Voucher Report</h2>
        <table width="100%" border="1" cellspacing="0" cellpadding="2" style="border-collapse: collapse;">
            <tr>
                <td width="15%" align="center" class="link">Payment Method:</td>
                <td width="15%" align="center" class="link"><%=PayMethod%></td>
                <td width="15%" align="center" colspan="4" class="link">
                    Print Report From: <%= formatIsoToEuropean(fromDate) %> To: <%= formatIsoToEuropean(toDate) %>
                </td>
            </tr>
            <!-- Header Row, will repeat on new pages -->
            <tr>
                <td width="15%" align="center" class="link">Voucher No</td>
                <td width="15%" align="center" class="link">Voucher Date</td>
                <td width="14%" align="center" class="link">Department</td>
                <td width="28%" align="center" class="link">Head</td>
                <td width="13%" align="center" class="link">Voucher Amount</td>
                <td width="30%" align="center" class="link">Receiver Name</td>
            </tr>
            <%
            int rowCount = 0;
            for (int i = 0; i < createVoucherReportRows.size(); i++) {
                if (rowCount == 25) {
                    // Insert 7 rows of space before repeating header for the next page
                    for (int j = 0; j < 7; j++) {
                        out.print("<tr style='border: none;'><td colspan='6' style='height: 20px; '></td></tr>"); // Add 7 empty rows
                    }
                    out.print("<tr>"); // Repeat header
                    out.print("<td width='15%' align='center' class='link'>Voucher No</td>");
                    out.print("<td width='15%' align='center' class='link'>Voucher Date</td>");
                    out.print("<td width='14%' align='center' class='link'>Department</td>");
                    out.print("<td width='28%' align='center' class='link'>Head</td>");
                    out.print("<td width='13%' align='center' class='link'>Voucher Amount</td>");
                    out.print("<td width='30%' align='center' class='link'>Receiver Name</td>");
                    out.print("</tr>");
                    rowCount = 0; // Reset the row count after a page break
                }
                VoucherReportRow voucherReportRow = createVoucherReportRows.get(i);
                double amt = Double.parseDouble(voucherReportRow.getVoucherAmount());
                totalAmount += amt;
            %>
            <tr>
                <td align="center" class="link"><%=voucherReportRow.getVoucherNumebr()%></td>
                <td align="center" class="link"><%=formatIsoToEuropean(voucherReportRow.getCoucherDate())%></td>
                <td align="center" class="link"><%=voucherReportRow.getDepartmentName()%></td>
                <td align="center" class="link"><%=voucherReportRow.getHeadName()%></td>
                <td align="center" class="link"><%=voucherReportRow.getVoucherAmount()%></td>
                <td align="center" class="link"><%=voucherReportRow.getReceiverName()%></td>
            </tr>
            <%
                rowCount++;
            }
            %>
            <tr>
                <td colspan="4" align="right" class="link"><strong>Total</strong></td>
                <td align="center" class="link"><strong><%=d.format(totalAmount)%></strong></td>
                <td align="center" class="link">&nbsp;</td>
            </tr>
        </table>
        <br>
        <input type="submit" name="Close" value="Close" onclick="setAction(5, 0)">
    </div>
	</td>
</form>
</body>