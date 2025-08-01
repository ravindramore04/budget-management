<%@ page import="java.util.*,java.text.*,struts.adminpanel.beans.*, struts.adminpanel.utils.*" %>
<%@ include file="/jsp/adminpanel/header.jsp" %>
<%
//response.setContentType("application/vnd.ms-excel");
DecimalFormat d = new DecimalFormat("##0.00");
List<VoucherReportRow> createVoucherReportRows = (List<VoucherReportRow>) request.getAttribute("ReportDetails");

       String toDate=(String)request.getAttribute("toDate");
	   String fromDate=(String)request.getAttribute("fromDate");
	   String chkCash=(String)request.getAttribute("chkCash");
	   String headId=(String)request.getAttribute("headId");
       String strDepartmentId=(String)request.getAttribute("strDepartmentId");
	   
	   String PayMethod="";
	   if("1".equals(chkCash)){
	      PayMethod="CASH";
	   } else  if("2".equals(chkCash)){
	      PayMethod="Cheque";
	   } else{
	      PayMethod="CASH/Cheque";
	   }
 double totalAmount = 0.0;
%>
<%!
  /**
   * Reformats "yyyy-MM-dd" ? "dd-MM-yyyy"
   */
  public String formatIsoToEuropean(String isoDate) {
    try {
      SimpleDateFormat inFmt  = new SimpleDateFormat("yyyy-MM-dd");
      SimpleDateFormat outFmt = new SimpleDateFormat("dd-MM-yyyy");
      Date date = inFmt.parse(isoDate);
      return outFmt.format(date);
    } catch (Exception e) {
      return isoDate; // fallback on parse error
    }
  }
 %>

<script language="JavaScript">
function navigation(code){
    document.HeadList.NAV.value = code;
    document.HeadList.action = "<%=strPath+"AllHead.do"%>";
    document.HeadList.submit();
}

function setAction(code,id){
    document.HeadList.id.value = id;
    switch(code){
        case 1:
            document.HeadList.action = "<%=strPath+"OpenHead.do"%>";
            break;
        case 2:
            document.HeadList.action = "<%=strPath+"PrintViewHeadReport.do"%>";
            break;
        case 3:
            //delete done later
            document.HeadList.action = "<%=strPath+"OpenHead.do"%>";
            break;
        case 4:
            document.HeadList.action = "<%=strPath+"RptParam.do"%>";
            break;
		case 5:
            document.HeadList.action = "<%=strPath + "jsp/adminpanel/panel.jsp"%>";
            break;	
			
    }
    document.HeadList.opr.value=code;
    document.HeadList.submit();
}

</script>

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
	<table width="100%" border="1" cellspacing="1" cellpadding="1" align="center" >
	
	<tr bgcolor="#E6F3FF"> 
	<td width="15%" height="20" align="center" class="link">Payment Method: </td>
	<td width="15%" height="20" align="center" class="link"><%=PayMethod%> </td>
    <td width="15%" height="20" align="center" colspan="4" class="link">Report From : <%= formatIsoToEuropean(fromDate) %>  To : <%= formatIsoToEuropean(toDate) %></td>
    </tr>
	
      <tr bgcolor="#E6F3FF"> 
	  <td width="15%" height="20" align="center" class="link">Voucher No</td>
        <td width="15%" height="20" align="center" class="link">Voucher Date</td>
		<td width="14%" height="20" align="left" class="link"><div align="center">Department</div></td>
        <td width="28%" height="20" align="left" class="link"><div align="center">Head</div></td>
        <td width="13%" height="20" align="left" class="link"><div align="center">Voucher Total Amount</div></td>
        <td width="30%" height="20" align="left" class="link"><div align="center">Receiver Name</div></td>

      </tr>
	  <%
	  for (int i=0; i<createVoucherReportRows.size(); i++){
		  VoucherReportRow voucherReportRow = (VoucherReportRow) createVoucherReportRows.get(i);
		  double amt = Double.parseDouble(voucherReportRow.getVoucherAmount()); // or parse from String
          totalAmount += amt;
	  %>
      <tr bgcolor=""> 
	    <td align="center" height="20" class="link"><%=voucherReportRow.getVoucherNumebr()%></td>
        <td align="center" height="20" class="link" ><%=formatIsoToEuropean(voucherReportRow.getCoucherDate())%></td>
		<td align="left" class="link" height="20"><div align="center"><%=voucherReportRow.getDepartmentName()%></div></td>
		<td align="left" class="link" height="20"><div align="center"><%=voucherReportRow.getHeadName()%></div></td>
        <td align="left" class="link" height="20"><%=voucherReportRow.getVoucherAmount()%></td>
        <td align="left" class="link" height="20">&nbsp;<div align="center"><%=voucherReportRow.getReceiverName()%></div></td>

      </tr>
      <%
	  }
	  %>
      <tr class="link"> 
        <td height="20">&nbsp;</td>
        <td height="20">&nbsp;</td>
        <td height="20">&nbsp;</td>
        <td height="20">&nbsp;</td>
        <!--<td height="20">&nbsp;</td>-->
		 <td height="20">&nbsp;</td>		
      </tr>
		
      <tr class="link" >
	    <td height="20" bgcolor="#FFFFFF" align="center"><strong>Total</strong></td> 
        <td height="20" bgcolor="#FFFFFF" align="center">&nbsp;</td>
        <td height="20" bgcolor="#CCFFCC" align="center"><strong>
          <%//=d.format(alloc)%>
          </strong></td>
		        <td height="20" bgcolor="#CCCCFF" align="center">&nbsp;</td>
        <td height="20" bgcolor="#CCCCFF" align="center"><strong><%=d.format(totalAmount)%></strong></td>
		 <!--<td height="20" bgcolor="#FFCC99" align="center"><strong>&nbsp;</strong></td>-->
        <td height="20" bgcolor="#FFCC99" align="center"><strong><%//=d.format(totalAmount)%></strong></td>
      </tr>
    </table>
   <!-- <input type="submit" accesskey="P" name="Print" value=" Print " onClick="setAction(5,<%//=(String)hmBal.get("HeadId")%>)"> -->
	
    <input type="submit" accesskey="C" name="Close" value="Close" onClick="setAction(5,0)"> 
    </td>
</form>
<%@ include file="/jsp/include/footer.jsp"%>
