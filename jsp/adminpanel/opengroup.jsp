<% //@page import="java.util.*" %>
<%
	session.setAttribute("itr", "1");

	String strId = "";
	String strName = "";
	String strAccNo = "";
	String strHeadOfDeptNm = "";
	
	HashMap hmData=(HashMap)request.getAttribute("data"); 
	
	if(hmData!=null && hmData.size()>0){
		strId = (String)hmData.get("strDepartmentId");
		strName = (String)hmData.get("strDepartmentNm");
		//strAccNo = (String)hmData.get("strAccNo");
		strHeadOfDeptNm = (String)hmData.get("strHeadOfDeptNm");
	}
%>
<%@ include file="/jsp/adminpanel/header.jsp" %>
<script language="JavaScript">
	function formSubmit(){
		var _Name = document.BudgetHead.txtName.value;
		if(_Name.toString()==""){
			alert("Enter The Budget Name Here");
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
			<td width="40%" class="innertitle"> Department Name </td>
			<td width="60%" colspan="3"><input type="text" name="txtName" size="40" class="formfield" value="<%=strName%>"  onKeyPress="handleEnter('strHeadOfDeptNm','BudgetHead')"></td>
		</tr>
		
		<tr> 
			<td class="innertitle" valign = "top">Head of Department</td>
			<td colspan="3">
				<input tyep="text" name="strHeadOfDeptNm" class="formfield" size="40" value="<%=strHeadOfDeptNm%>">
			</td>
		</tr>
		<tr> 
			<td colspan=4>
				<input type="text" name="txtId" value="<%=strId%>">
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
