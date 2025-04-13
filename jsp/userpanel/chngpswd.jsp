<%
	session.setAttribute("itr", "1");

	String strUId = "";
	String strName = "";
	String strLogin = "";
	
	HashMap hmData=(HashMap)session.getAttribute("user"); 

	if(hmData!=null && hmData.size()>0){
		strUId = (String)hmData.get("UId");
		strName = (String)hmData.get("strName");
		strLogin = (String)hmData.get("strLogin");
	}
%>
<script language="JavaScript">
	function setAction(){
		var _Pass = document.SaveNewPswd.txtPassword.value;
		var _Pass1 = document.SaveNewPswd.txtRetypePassword.value;
		var _oldPass = document.SaveNewPswd.txtOldPassword.value;
		alert("hello");
		if(_oldPass.length==0){
			alert("Enter Old Password");
			document.SaveNewPswd.txtOldPassword.focus();
			return false;
		}
		if(_Pass.length==0){
			alert("Enter New Password");
			document.SaveNewPswd.txtPassword.value="";
			document.SaveNewPswd.txtPassword.value="";
			document.SaveNewPswd.txtPassword.focus();
			return false;
		}else{
			if(!(_Pass ==_Pass1)){
				alert("Password And Retype Password Not Same");
				return false;
			}
		}
		return true;
	}
	function formSubmit(){
		document.ChngPswd.submit();
	}
	function handleEnter(fieldname,frm){
	 	 var keyCode = event.keyCode ? event.keyCode : event.which ? event.which : event.charCode;
		 if (keyCode == 13){
		 	eval('document.'+frm+'.'+fieldname+'.focus()');
		}
     }	
</script>

<%@ include file="/jsp/userpanel/header.jsp" %>
<td width="80%" valign="top">
   <form name="ChngPswd" method="post" action="SaveUserNewPswd.do" onSubmit="return setAction()">
   <input type="hidden" name="txtId" value="<%=strUId%>">
	<table width="70%" border="0" cellspacing="1" cellpadding="1" align="center" >
      <tr> 
        <td colspan=4>&nbsp;</td>
      </tr>
      <tr> 
        <td colspan=4>&nbsp;</td>
      </tr>
      <tr> 
        <td width="25%" class="innertitle"> Old Password</td>
        <td width="75%" colspan="3"> <input type="password" name="txtOldPassword" size="40" class="formfield" onKeyPress="handleEnter('txtPassword','ChngPswd')"> 
        </td>
      </tr>
      <tr> 
        <td class="innertitle">New Password </td>
        <td colspan="3"><input type="password" name="txtPassword" size="40" class="formfield"  onKeyPress="handleEnter('txtRetypePasswprd','ChngPswd')"></td>
      </tr>
      <tr> 
        <td class="innertitle">Retype Password </td>
        <td colspan="3"><input type="password" name="txtRetypePasswprd" size="40" class="formfield"></td>
      </tr>
      <tr> 
        <td colspan=4> <input type="hidden" name="txtId" value="<%=strUId%>"> 
        </td>
      </tr>
      <tr> 
        <td colspan=4 align="center"> <input name="btnSub" type="Reset" value=" Reset " class="PPRSbmtBtn"> 
          &nbsp; <input name="btnSub" type="submit" value="Submit" class="PPRSbmtBtn" onClick="formSubmit()"> 
        </td>
      </tr>
    </table>
    </form>
</td>
<%@ include file="/jsp/include/footer.jsp" %>
