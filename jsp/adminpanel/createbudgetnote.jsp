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
	String balance_after_expense="";
	String budget_note_id="";
	String bName="Submit";
	String operation="insert_budget_note";
	String previousBudgetAmount="";
	String budget_note_status="DRAFT";
	String radiocheckYes="";
	String radiocheckNo="";


	HashMap hmData=(HashMap)request.getAttribute("budgetNoteInputData");
	//out.println("budgetNoteInputData====>" + hmData);

	if(hmData!=null && hmData.size()>0){
         allocationId = (String)hmData.get("allocationId");
         departmentName = (String)hmData.get("departmentName");
         headName = (String)hmData.get("headName");
         allocatedAmount = (String)hmData.get("allocatedAmount");
         allocation_reserved_amount = (String)hmData.get("reservedAmount");
         utilisedAmount = (String)hmData.get("utilisedAmount");
         availableBalance = (String)hmData.get("availableBalance");
		 budget_note_id =  (String)hmData.get("budget_note_id");
		 budget_note_status=(String)hmData.get("budget_note_status");
		 if("APPROVED".equals(budget_note_status)){
		 radiocheckYes="checked";
		 }else{
		 radiocheckNo="checked";
		 budget_note_status="DRAFT";
		 }
		 if(budget_note_id !=null){
			 bName="Update";
			 operation="update_budget_note";
			 budget_note_expense= (String)hmData.get("budget_note_expense");
			 previousBudgetAmount=budget_note_expense;
		 	budget_note_remark=(String)hmData.get("budget_note_remark");
		 	balance_after_expense= (String)hmData.get("allocation_balance_amount_after_expense");
		 }
		 
	}
%>
<%@ include file="/jsp/adminpanel/header.jsp" %>
<script language="JavaScript">
	function formSubmit(){
	    calculateDifference();
	   // document.BudgetAllocationMaster.opr.value='insert_budget_note';
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
	var allocation_reserved_amount= parseFloat(document.getElementById("allocation_reserved_amount").value) || 0;
    var isUpdate=document.getElementById("btn").value;
    // Calculate the difference;
    //alert(isUpdate);
	var result;
	if(isUpdate=="Update"){
	  result = (ballanceBudget + allocation_reserved_amount) - thisExpenditure;
	}else{
	  result = ballanceBudget - thisExpenditure;
	}
   // var result = ballanceBudget - thisExpenditure;

    // Set the result in text3
    document.getElementById("allocation_balance_amount_after_expense").value = result;
}
</script>


</script>
<td width="80%" valign="top">
   <form name="BudgetAllocationMaster" method="post" action="SaveBudgetNote.do">
   <input type="hidden" name="page" value="BudgetAllocationMaster">
   <input type="hidden" name="allocationId" value="<%=allocationId%>">
   <input type="hidden" name="opr" value="<%=operation%>">
   <input type="hidden" name="previousBudgetNoteAmount" value="<%=previousBudgetAmount%>">
   <input type="hidden" name="id" value="<%=budget_note_id%>">
   
   
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
			<td width="25%" class="innertitle">Reserve Amount <font color="#FF6600">(Budget Note created but Voucher not Created)</font> </td>
			
			
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
			<td width="75%" colspan="3"><input type="text" id="allocation_balance_amount_after_expense" name="allocation_balance_amount_after_expense" size="25" onBlur="calculateDifference()" class="formfield" value="<%=balance_after_expense%>" > </td>
		</tr>

		<tr>
			<td class="innertitle" valign = "top">Remark</td>
			<td colspan="3">
				<textarea name="budget_note_remark" class="formfield" cols="25" rows="3"><%=budget_note_remark%></textarea>
			</td>
		</tr>
		<tr>
			<td class="innertitle" valign = "top">Budget Note Status</td>
			<td colspan="3">
				<font color="#FF0000"><%=budget_note_status%></font>
			</td>
		</tr>
		<%if(isStoreAccount){%>
		<tr>
			<td width="25%" align="right">
				<input type="hidden" name="txtId" value="<%=strId%>">
				Approve Budget Note:
			</td>
			<td width="75%">&nbsp;
			  <label>Do you approve?</label><br>
 			 <input type="radio" id="yes" name="approval" <%=radiocheckYes%> value="yes">
  			<label for="yes">Yes</label><br>
  			<input type="radio" id="no" name="approval" <%=radiocheckNo%> value="no">
  			<label for="no">No</label>
			</td>
		</tr>
		<%}%>
		<tr>
		   <td class="innertitle" valign = "top"></td>
			<td colspan=3 align="left">
				<input name="btnSub" type="Reset" value=" Reset " class="PPRSbmtBtn">&nbsp;
				<input name="btnSub" id="btn" type="Button" value="<%=bName%>" class="PPRSbmtBtn" onClick="formSubmit()">
			</td>
		</tr>
	</table>
    </form>
</td>
<%@ include file="/jsp/include/footer.jsp" %>
