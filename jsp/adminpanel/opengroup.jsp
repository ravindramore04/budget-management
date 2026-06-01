<% //@page import="java.util.*" %>
<%
	session.setAttribute("itr", "1");

	String strId = "";
	String strName = "";
	String strAccNo = "";
	String bgNm = "";
	
	HashMap hmData=(HashMap)request.getAttribute("data"); 
	//out.print(hmData);
	if(hmData!=null && hmData.size()>0){
		strId = (String)hmData.get("strBudgroupId");
		strName = (String)hmData.get("strBudgroupNm");
		//strAccNo = (String)hmData.get("strAccNo");
		bgNm = (String)hmData.get("strRmrk");
	}
	
	String bugGroupChkY="checked";
	String bugGroupChkN="";
	String bugGroupChkOth="";
	if("1".equals(bgNm)){
		 bugGroupChkY="checked";
		 bugGroupChkN="";
		 bugGroupChkOth="";
		 }else if("0".equals(bgNm)){
		  bugGroupChkY="";
		 bugGroupChkN="checked";
		 bugGroupChkOth="";
		 } else {
		  bugGroupChkOth="checked";
		 }
%>
<%@ include file="/jsp/adminpanel/header.jsp" %>
<script language="JavaScript">
	function formSubmit(){
		var _Name = document.BudgetHead.txtName.value;
		if(_Name.toString()==""){
			alert("Enter The Group Name Here");
			document.BudgetHead.txtName.focus();
			return false;
		}
		document.BudgetHead.submit();
	}

	function handleEnter(fieldname,frm){
	 	 var keyCode = event.keyCode ? event.keyCode : event.which ? event.which : event.charCode;
		 if (keyCode == 13){
		 	eval('document.'+frm+'.'+fieldname+'.focus()');
		}
     }

</script>

<td width="80%" valign="top">
   <form name="BudgetHead" method="post" action="SaveBudGroupHead.do">
	<table width="70%" border="0" cellspacing="1" cellpadding="1" align="center" >
		<tr> 
			<td colspan=4>&nbsp;</td>
		</tr>
		<tr> 
			<td colspan=4>&nbsp;</td>
		</tr>
		<tr> 
			<td width="40%" class="innertitle"> Budget Group Name </td>
			<td width="60%" colspan="3"><input type="text" name="txtName" size="40" class="formfield" value="<%=strName%>"  onKeyPress="handleEnter('strGroupType','BudgetHead')"></td>
		</tr>
		
		<tr> 
			<td class="innertitle" valign = "top">Group Type</td>
			<td colspan="3">
				<input type="radio" id="adyes" name="strGroupType" value="1" <%=bugGroupChkY%> onclick="toggleAdvanceTable(true)">
            <label for="yes">Recurring</label>
            <input type="radio" id="adno" name="strGroupType" value="0" <%=bugGroupChkN%> onclick="toggleAdvanceTable(false)">
            <label for="no">Non Recurring</label>
			<input type="radio" id="adoth" name="strGroupType" value="2" <%=bugGroupChkOth%> onclick="toggleAdvanceTable(false)">
            <label for="no">Others</label>
			</td>
		</tr>
		<tr> 
			<td colspan=4>
				<input type="hidden" name="txtId" value="<%=strId%>">
			</td>
		</tr>
		<tr> 
			<td colspan=4 align="center">
				
				<input name="btnSub" type="Button" value="Submit" class="PPRSbmtBtn" onClick="formSubmit()">
				<input name="btnSub" type="Reset" value=" Reset " class="PPRSbmtBtn">&nbsp;
			</td>
		</tr>
	</table>
    </form>
</td>
<%@ include file="/jsp/include/footer.jsp" %>
