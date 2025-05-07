<% //@page import="java.util.*" %>
<%
	session.setAttribute("itr", "1");

	String strUId = "";
	String strName = "";
	String strLogin = "";
	String deptId="";
	
	HashMap hmGroup=(HashMap)request.getAttribute("departments");
	HashMap hmData=(HashMap)request.getAttribute("data"); 
	if(hmData!=null && hmData.size()>0){
		strUId = (String)hmData.get("UId");
		strName = (String)hmData.get("strName");
		strLogin = (String)hmData.get("strLogin");
		deptId=(String)hmData.get("strDepartmentId");
		if(deptId==null)
		deptId="";
	}
%>
<%@ include file="/jsp/adminpanel/header.jsp" %>
<script language="JavaScript">
	function setAction()
	{
		var _Name = document.addUser.txtName.value;
		var _Login = document.addUser.txtLogin.value;
		var _Pass = document.addUser.txtPassword.value;
		var _Pass1 = document.addUser.txtRetypePassword.value;

		if(_Name.length==0)
		{
			alert(" Emter The Name");
			document.addUser.txtName.focus();
			return false;
		}
		if(_Login.length==0)
		{
			alert("Enter The Login Name");
			document.addUser.txtLogin.focus();
			return false;
		}
		if(_Pass.length==0)
		{
			alert("Enter The Password");
			document.addUser.txtPassword.value="";
			document.addUser.txtPassword.value="";
			document.addUser.txtPassword.focus();
			return false;
		}
		else
		{
			if(!(_Pass==_Pass1))
			{
				alert("Password And Retype Password Not Same");
				return false;
			}
		}

		return true;
	}
	function formSubmit(){
		document.addUser.submit();
	}
	function handleEnter(fieldname,frm){
	 	 var keyCode = event.keyCode ? event.keyCode : event.which ? event.which : event.charCode;
		 if (keyCode == 13){
		 	eval('document.'+frm+'.'+fieldname+'.focus()');
		}
     }

/*	function tt(fieldname,frm){
		alert("hello");
		alert(eval('document.addUser.'+fieldname+'.focus()'));
	}
*/	
</script>


<td width="80%" valign="top">
   <form name="addUser" method="post" action="AddUser.do">
	<table width="70%" border="0" cellspacing="1" cellpadding="1" align="center" >
		<tr> 
			<td colspan=4>&nbsp;</td>
		</tr>
		<tr> 
			<td class="innertitle">Department&nbsp;</td>
			<td colspan="3"><select name="strDepartmentId" class="formfield" >
			 <option value="<%=""+0%>">-------Select---------</option>
		<%
			if(hmGroup!=null && hmGroup.size()>0){
				for(int i=0;i<hmGroup.size();i++){
					HashMap hmt=(HashMap)hmGroup.get(""+i);
					String strDepartmentId=(String)hmt.get("strDepartmentId");
					String strDepartmentNm=(String)hmt.get("strDepartmentNm");
					
				if(deptId.equals(strDepartmentId)){
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
			</select></td>
		</tr>
		<tr> 
			<td width="25%" class="innertitle">Name </td>
			<td width="75%" colspan="3"><input type="text" name="txtName" size="40" class="formfield" value="<%=strName%>" onKeyPress="handleEnter('txtLogin','addUser')"></td>
		</tr>
		<tr> 
			<td width="25%" class="innertitle">login </td>
			<td width="75%" colspan="3"><input type="text" name="txtLogin" size="40" class="formfield" value="<%=strLogin%>" onKeyPress="handleEnter('txtPassword','addUser')"> </td>
		</tr>
		
		<tr> 
			<td class="innertitle">Password </td>
			<td colspan="3"><input type="password" name="txtPassword" size="40" class="formfield" onKeyPress="handleEnter('txtRetypePasswprd','addUser')"></td>
		</tr>
		<tr> 
			<td class="innertitle">Retype Password </td>
			<td colspan="3"><input type="password" name="txtRetypePasswprd" size="40" class="formfield" 
			></td>
		</tr>
		<tr> 
			<td colspan=4>
				<input type="hidden" name="txtId" value="<%=strUId%>">
			</td>
		</tr>
		<tr> 
			<td colspan=4 align="center">
				<input name="btnSub" type="Reset" value=" Reset " class="PPRSbmtBtn">&nbsp;
				<input name="btnSub" type="button" value="Submit" class="PPRSbmtBtn" onClick="formSubmit()">
			</td>
		</tr>
	</table>
    </form>
</td>
<%@ include file="/jsp/include/footer.jsp" %>
