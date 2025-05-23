<html>
<title>Budget Note</title>
<head></head>
<%@ page import="java.util.*,java.text.*" %>
<%
DecimalFormat d = new DecimalFormat("##0.00");
String strPath="/budget-management/";
HashMap hmData=(HashMap)request.getAttribute("budgetNoteInputData");
//out.println("budgetNoteInputData====>" + hmData);

String departmentName = "";
String headName = "";
String allocatedAmount = "";
String allocation_reserved_amount = "";
String utilisedAmount = "";
String availableBalance = "";
String budget_note_remark = "";
String budget_note_expense = "";
String balance_after_expense="";
String budget_note_status="";
String budget_note_id="";
String bal="";
String vou="";
if(hmData!=null && hmData.size()>0){
         departmentName = (String)hmData.get("departmentName");
         headName = (String)hmData.get("headName");
         allocatedAmount = (String)hmData.get("allocatedAmount");
         allocation_reserved_amount = (String)hmData.get("reservedAmount");
         utilisedAmount = (String)hmData.get("utilisedAmount");
         availableBalance = (String)hmData.get("availableBalance");
		 budget_note_status=(String)hmData.get("budget_note_status");
		  budget_note_expense= (String)hmData.get("budget_note_expense");
	 	budget_note_remark=(String)hmData.get("budget_note_remark");
	 	balance_after_expense= (String)hmData.get("allocation_balance_amount_after_expense");
		budget_note_id=(String)hmData.get("budget_note_id");
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
            document.HeadList.action = "<%=strPath+"PrintSingHead.do"%>";
            break;
        case 3:
            //delete done later
            document.HeadList.action = "<%=strPath+"OpenHead.do"%>";
            break;
        case 4:
            document.HeadList.action = "<%=strPath+"Close.do"%>";
            break;
        case 5:
            document.HeadList.action = "<%=strPath+"budgetNote.do"%>";
            break;
			
			
    }
    document.HeadList.opr.value=code;
    //document.HeadList.submit();
}

</script>
 <body onLoad="javascript:print();setAction(5,0)"> 
<body>
<form name="HeadList" method="post" action="#">
    <input type="hidden" name="page" value="PrintList">
    <input type="hidden" name="NAV" value="">
    <input type="hidden" name="txtBGid" value="<%=budget_note_id%>">
    <input type="hidden" name="id" value="">
    <input type="hidden" name="opr" value="">
    
    <td width="80%" valign="top" align="center">

	<Table width="100%" border="1" cellspacing="1" cellpadding="1" align="center">
	<TR>
	<TD>
	<table width="100%" border="0" cellspacing="1" cellpadding="1" align="center" >
      <tr class="titles"> 
        <td height="20"  colspan="5"> <div align="center"><strong>BUDGET NOTE-2025-2026</strong></div></td>

      </tr>
	<TR><TD height="2" colspan="4"><HR></TD></TR>
      <tr> 
      </tr>
	<TR><TD height="2" colspan="4"></TD></TR>
	<tr> 
        <td width="30%" ><strong> Budget Note Number.</strong></td>
        <td colspan="3"><strong>:</strong>&nbsp;&nbsp;&nbsp;&nbsp;<strong>&nbsp;&nbsp;<%=budget_note_id%></strong></td>
      </tr>
	 <tr> 
        <td width="30%" ><strong> Name of Dept.</strong></td>
        <td colspan="3"><strong>:</strong>&nbsp;&nbsp;&nbsp;&nbsp;<strong>&nbsp;&nbsp;<%=departmentName%></strong></td>
      </tr>
      <tr> 
        <td width="30%" ><strong> Budget Head.</strong></td>
        <td colspan="3"><strong>:</strong>&nbsp;&nbsp;&nbsp;&nbsp;<strong>&nbsp;&nbsp;<%=headName%></strong></td>
      </tr>
      <tr> 
        <td width="30%"><strong>Budget Sanctioned</strong></td>
        <td width="10%"><strong>: Rs</strong></td>
        <td width="20%" align="right"><strong><%=allocatedAmount%></strong></td>
        <td>&nbsp;</td>
      </tr>
      <tr> 
        <td width="30%"><strong>Amt. already spend</strong></td>
        <td><strong>:</strong> <strong>Rs&nbsp;&nbsp;</strong>&nbsp;&nbsp;&nbsp;&nbsp;</td>
        <td width="20%" align="right"><strong> <%
		 
		%><%=utilisedAmount%></strong></td>
        <td>&nbsp;</td>
      </tr>
      <tr> 
        <td width="30%"><strong>Balance</strong></td>
        <td><strong>: Rs &nbsp;&nbsp;</strong>&nbsp;&nbsp;&nbsp;&nbsp; </td>
        <td width="20%" align="right"><strong><%=availableBalance%></strong></td>
        <td align="center"><strong>Head of Department</strong></td>
      </tr>
      <tr> 
        <td><strong>This Expenditure</strong></td>
        <td><strong>: Rs &nbsp;&nbsp;</strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
        <td align="right"><%=budget_note_expense%></strong></td>
        <td >&nbsp;</td>
      </tr>
      <tr> 
        <td><strong>Balance after Current Expenditure</strong></td>
        <td><strong>: Rs &nbsp;&nbsp;</strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
        <td align="right"><%=balance_after_expense%></strong></td>
        <td align="center"></td>
      </tr>
 <!--     <tr> 
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td align="right">&nbsp;</td>
        <td >&nbsp;</td>
      </tr>  -->
      <tr> 
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td align="right"></td>
        <td align="center"><strong>
		<%if("APPROVED".equals(budget_note_status)){%>
		Status : APPROVED
		<%} else{%>
		Approved: Yes / No
		<%}%>
		</strong></td>
      </tr>
      <tr> 
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td align="right">&nbsp;</td>
        <td align="center">&nbsp;</td>
      </tr>
      <tr> 
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td align="right">&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td align="center" colspan="2"><strong>Store &amp; Purchase Assistant</strong></td>
        <!-- <td>&nbsp;</td> -->
        <td align="center"><strong>Chief Accounts &amp; Finance Officer</strong></td>
        <td  align="center"><strong>Director</strong></td>
      </tr>
    </table>
	</TD>
	</TR>
	</Table>

    </td>		
</form>
</body>
</html>