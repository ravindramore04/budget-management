<% //@page import="java.util.*" %>
<%
	session.setAttribute("itr", "1");

	String strId = "";
	String strName = "";
	String strAccNo = "";
	String strRemark = "";
	String bgNm="";
	
	HashMap hmData=(HashMap)request.getAttribute("data"); 
	HashMap hmGroup=(HashMap)request.getAttribute("ghead"); 
	//out.println("dghfjgsjdgf"+hmData);
	if(hmData!=null && hmData.size()>0){
		strId = (String)hmData.get("HeadId");
		strName = (String)hmData.get("strName");
		strAccNo = (String)hmData.get("strAccNo");
		strRemark = (String)hmData.get("strRemark");
		bgNm=(String)hmData.get("strBudgroupId");
	}
	//out.println("hmGrouphmGroup>>"+hmGroup);
	String bugGroupChkY="checked";
	String bugGroupChkN="";
	if("1".equals(bgNm)){
		 bugGroupChkY="checked";
		 bugGroupChkN="";
		 }else{
		  bugGroupChkY="";
		 bugGroupChkN="checked";
		 }
	
%>
<%@ include file="/jsp/adminpanel/header.jsp" %>
<script language="JavaScript">
	function formSubmit(){
		var _Name = document.BudgetHead.txtName.value;
		if(_Name.toString()==""){
			alert("Enter The Head Name Here");
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
   <form name="BudgetHead" method="post" action="SaveHead.do">
	<table width="70%" border="0" cellspacing="1" cellpadding="1" align="center" >
		<tr> 
			<td colspan=4>&nbsp;</td>
		</tr>
		<tr> 
			<td colspan=4>&nbsp;</td>
		</tr>
		<tr> 
			<td width="25%" class="innertitle">Head Name </td>
			<td width="75%" colspan="3"><input type="text" name="txtName" size="40" class="formfield" value="<%=strName%>"  onKeyPress="handleEnter('txtRemark','BudgetHead')"></td>
		</tr>
		<%--tr> 
			<td width="25%" class="innertitle">Account No </td>
			<td width="75%" colspan="3"><input type="text" name="txtAccNo" size="40" class="formfield" value="<%//=strAccNo%>" ReadOnly  onKeyPress="handleEnter('txtRemark','BudgetHead')"> </td>
		</tr--%>
		<input type="hidden" name="txtAccNo" size="40" class="formfield" value="">
		

		<tr> 
			<td width="25%" class="innertitle">Budget Group: </td>
			<td width="75%" colspan="3">
			<input type="radio" id="adyes" name="strBudgroupId" value="1" <%=bugGroupChkY%> onclick="toggleAdvanceTable(true)">
            <label for="yes">Recurring</label>
            <input type="radio" id="adno" name="strBudgroupId" value="0" <%=bugGroupChkN%> onclick="toggleAdvanceTable(false)">
            <label for="no">Non Recurring</label>
			
			</td
		></tr>
		
		<tr> 
			<td class="innertitle" valign = "top">Remark</td>
			<td colspan="3">
				<textarea name="txtRemark" class="formfield" cols="39" rows="3" ><%=strRemark%></textarea>
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
