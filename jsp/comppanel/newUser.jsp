<% //@page import="java.util.*" %>
<%
	session.setAttribute("itr", "1");
%>
<script language="JavaScript">
	function setAction()
	{
		var _Name = document.abc.txtName.value;
		var _Login = document.abc.txtLogin.value;
		var _Pass = document.abc.txtPassword.value;
		var _Pass1 = document.abc.txtRetypePasswprd.value;
		if(_Name.length==0)
		{
			alert(" Emter The Name");
			document.abc.txtName.focus();
			return false;
		}
		if(_Login.length==0)
		{
			alert("Enter The Login Name");
			document.abc.txtLogin.focus();
			return false;
		}
		if(_Pass.length==0)
		{
			alert("Enter The Password");
			document.abc.txtPassword.value="";
			document.abc.txtPassword.value="";
			document.abc.txtPassword.focus();
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

		//return true;
		document.abc.submit();
	}
		function handleEnter(fieldname,frm){
		 	 var keyCode = event.keyCode ? event.keyCode : event.which ? event.which : event.charCode;
			 if (keyCode == 13){
			 	eval('document.'+frm+'.'+fieldname+'.focus()');
			}
	     }

		
</script>
<%@ include file="/jsp/comppanel/header.jsp" %>
<td width="80%" valign="top">
   <form name="abc" method="post" action="<%=strPath + "adminUser.do"%>">
	<table width="70%" border="0" cellspacing="1" cellpadding="1" align="center" >
		<tr> 
			<td colspan=4>&nbsp;</td>
		</tr>
		<tr> 
			<td colspan=4>&nbsp;</td>
		</tr>
		<tr> 
			<td width="25%" class="innertitle">Name </td>
			<td width="75%" colspan="3"><input type="text" name="txtName" size="40" class="formfield" onKeyPress="handleEnter('txtLogin','abc')"> </td>
		</tr>
		<tr> 
			<td width="25%" class="innertitle">login </td>
			<td width="75%" colspan="3"><input type="text" name="txtLogin" size="40" class="formfield" onKeyPress="handleEnter('txtPassword','abc')"> </td>
		</tr>
		
		<tr> 
			<td class="innertitle">Password </td>
			<td colspan="3"><input type="password" name="txtPassword" size="40" class="formfield" onKeyPress="handleEnter('txtRetypePasswprd','abc')"></td>
		</tr>
		<tr> 
			<td class="innertitle">Retype Password </td>
			<td colspan="3"><input type="password" name="txtRetypePasswprd" size="40" class="formfield"></td>
		</tr>
		<tr> 
			<td colspan=4>&nbsp;</td>
		</tr>
		<tr> 
			<td colspan=4 align="center">
				<input name="btnSub" type="Reset" value=" Reset " class="PPRSbmtBtn">&nbsp;
				<input name="btnSub" type="Button" value="Submit" class="PPRSbmtBtn" onClick="return setAction()">
			</td>
		</tr>
	</table>
    </form>
</td>
<%@ include file="/jsp/include/footer.jsp" %>
