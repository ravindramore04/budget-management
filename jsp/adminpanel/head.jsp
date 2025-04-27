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
	//out.println("dghfjgsjdgf"+bgNm);
	if(hmData!=null && hmData.size()>0){
		strId = (String)hmData.get("HeadId");
		strName = (String)hmData.get("strName");
		strAccNo = (String)hmData.get("strAccNo");
		strRemark = (String)hmData.get("strRemark");
		bgNm=(String)hmData.get("strDepartmentId");
	}//out.println("dghfjgsjdgf"+bgNm);
%>
<%@ include file="/jsp/adminpanel/header.jsp" %>
<script language="JavaScript">
	function formSubmit(){
		var _Name = document.BudgetHead.txtName.value;
		var gid=document.BudgetHead.strDepartmentId.value;
		//alert(gid);
		if(gid=="0"){
			alert("Select Department From List");
			document.BudgetHead.strDepartmentId.focus();
		}
		else{
		if(_Name.toString()==""){
			alert("Enter The Budget Name Here");
			document.BudgetHead.txtName.focus();
			return false;
		}
		
		document.BudgetHead.submit();
		}
		
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
			<td width="25%" class="innertitle">Department Name </td>
			<td width="75%" colspan="3">
			<select name="strDepartmentId">
			 <option value="<%=""+0%>">-------Select---------</option>
		<%
			if(hmGroup!=null && hmGroup.size()>0){
				for(int i=0;i<hmGroup.size();i++){
					HashMap hmt=(HashMap)hmGroup.get(""+i);
					String strDepartmentId=(String)hmt.get("strDepartmentId");
					String strDepartmentNm=(String)hmt.get("strDepartmentNm");
					
				if(bgNm.equals(strDepartmentId)){
		%>	
		
		
			<option value="<%=strDepartmentId%>" selected> <%=strDepartmentNm%> </option>
		
		
		
		<%
				}else{
		%>
		<option value="<%=strDepartmentId%>" > <%=strDepartmentNm%> </option>
		
		<%
				}
			     }
			}
		
		%>
			</select>
			</td>
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
