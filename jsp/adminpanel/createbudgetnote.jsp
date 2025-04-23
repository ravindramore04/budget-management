<% //@page import="java.util.*" %>
<%
	session.setAttribute("itr", "1");

	String strId = "";
	String strAmount = "";
	String strRemark = "";

	String allocationId = "";
	String departmentName = "";
    String headName = "";
    String allocatedAmount = "";
    String allocation_reserved_amount = "";
    String utilisedAmount = "";
    String availableBalance = "";
    String budget_note_remark = "";
    String budget_note_expense = "";


	HashMap hmData=(HashMap)request.getAttribute("budgetNoteInputData");
	out.println("budgetNoteInputData====>" + hmData);

	if(hmData!=null && hmData.size()>0){
         allocationId = (String)hmData.get("allocationId");
         departmentName = (String)hmData.get("departmentName");
         headName = (String)hmData.get("headName");
         allocatedAmount = (String)hmData.get("allocatedAmount");
         allocation_reserved_amount = (String)hmData.get("reservedAmount");
         utilisedAmount = (String)hmData.get("utilisedAmount");
         availableBalance = (String)hmData.get("availableBalance");
	}
%>
<%@ include file="/jsp/adminpanel/header.jsp" %>
<script language="JavaScript">
	function formSubmit(){
	    document.BudgetAllocationMaster.opr.value='insert_budget_note';
		document.BudgetAllocationMaster.submit();
	}
	function handleEnter(fieldname,frm){
	 	 var keyCode = event.keyCode ? event.keyCode : event.which ? event.which : event.charCode;
		 if (keyCode == 13){
		 	eval('document.'+frm+'.'+fieldname+'.focus()');
		}
     }
	 
function calculateDifference() {
    // Get values from the input fields
	 var ballanceBudget = parseFloat(document.getElementById("ballanceBudget").value) || 0;
    var thisExpenditure = parseFloat(document.getElementById("budget_note_expense").value) || 0;
   
    // Calculate the difference
    var result = ballanceBudget - thisExpenditure;

    // Set the result in text3
    document.getElementById("allocation_balance_amount_after_expense").value = result;
}
</script>


</script>
<td width="80%" valign="top">
   <form name="BudgetAllocationMaster" method="post" action="SaveBudgetNote.do">
   <input type="hidden" name="page" value="BudgetAllocationMaster">
   <input type="text" name="allocationId" value="<%=allocationId%>">
   <input type="hidden" name="opr" value="">
	<table width="70%" border="0" cellspacing="1" cellpadding="1" align="center" >
		<tr>
			<td width="25%" class="innertitle">Department Name </td>
			
        <td width="75%" colspan="3"><%=departmentName%></td>
		</tr>
		<tr>
			<td width="25%" class="innertitle">Head Name </td>
			
        <td width="75%" colspan="3"><%=headName%></td>
		</tr>

		<tr>
			<td width="25%" class="innertitle">Budget Sanctioned </td>
			
        <td width="75%" colspan="3"><%=allocatedAmount%></td>
		</tr>
		<tr>
			<td width="25%" class="innertitle">Reserve Amount (Note created but PO not approved) </td>
			
			<td width="75%" colspan="3"><input type="text" id="allocation_reserved_amount" readonly="true" name="allocation_reserved_amount" size="25" class="formfield" value="<%=allocation_reserved_amount%>"/></td>
		</tr>
		<tr>
			<td width="25%" class="innertitle">Budget Already Spent </td>
			<td width="75%" colspan="3"><%=utilisedAmount%></td>
		</tr>
		<tr>
			<td width="25%" class="innertitle">Balance Budget </td>
			<td width="75%" colspan="3"><input type="text" id="ballanceBudget" readonly="true" name="ballanceBudget" size="25" class="formfield" value="<%=availableBalance%>"/></td>
		</tr>




		<tr>
			<td width="25%" class="innertitle">This Expenditure </td>
			<td width="75%" colspan="3"><input type="text" id="budget_note_expense" name="budget_note_expense" size="25" class="formfield" value="<%=budget_note_expense%>" onBlur="calculateDifference()" onKeyPress="handleEnter('budget_note_remark','BudgetAllocationMaster')"> </td>
		</tr>

		<tr>
			<td width="25%" class="innertitle">Balance after current Expenditure </td>
			<td width="75%" colspan="3"><input type="text" id="allocation_balance_amount_after_expense" name="allocation_balance_amount_after_expense" size="25" class="formfield" value="" > </td>
		</tr>

		<tr>
			<td class="innertitle" valign = "top">Remark</td>
			<td colspan="3">
				<textarea name="budget_note_remark" class="formfield" cols="25" rows="3"><%=budget_note_remark%></textarea>
			</td>
		</tr>
		<tr>
			<td colspan=4>
				<input type="hidden" name="txtId" value="<%=strId%>">
			</td>
		</tr>
		<tr>
			<td colspan=4 align="center">
				<input name="btnSub" type="Reset" value=" Reset " class="PPRSbmtBtn">&nbsp;
				<input name="btnSub" type="Button" value="Submit" class="PPRSbmtBtn" onClick="formSubmit()">
			</td>
		</tr>
	</table>
    </form>
</td>
<%@ include file="/jsp/include/footer.jsp" %>
