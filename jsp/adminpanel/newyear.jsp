<% //@page import="java.util.*" %>
<%
	session.setAttribute("itr", "1");

	String strUId = "";
	String strF_Year = "";
	String strT_Year = "";
	String strDBnm = "";
	
	HashMap hmData=(HashMap)request.getAttribute("data"); 
	out.println("hmData"+hmData);
	if(hmData!=null && hmData.size()>0){
		strUId = (String)hmData.get("ID");
		out.println("strUId"+strUId);
		strF_Year = (String)hmData.get("F_Year");
		strT_Year = (String)hmData.get("T_Year");
		strDBnm = (String)hmData.get("DBnm");
		
		
	}
%>
<%@ include file="/jsp/adminpanel/header.jsp" %>
<script language="JavaScript">
/*	function setAction()
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
     }*/

/*	function tt(fieldname,frm){
		alert("hello");
		alert(eval('document.addUser.'+fieldname+'.focus()'));
	}
*/	
function formSubmit(){
		document.addUser.submit();
	}
function ChkYear()
{
	document.addUser.txtYear1.value=parseInt(document.addUser.txtYear.value)+1;
	document.addUser.txtDBName.value="Budget"+(document.addUser.txtYear.value).substring(2,4)+"_"+(document.addUser.txtYear1.value).substring(2,4);
}
</script>


<td width="80%" valign="top">
   <form name="addUser" method="post" action="SaveFinanceYear.do">
	<table width="70%" border="0" cellspacing="1" cellpadding="1" align="center" >
		<tr> 
			<td colspan=4>&nbsp;</td>
		</tr>
		<tr> 
			<td colspan=4>&nbsp;</td>
		</tr>
		<tr> 
			<td width="25%" class="innertitle">Finacial Year </td>
			<td width="75%" colspan="3"><input type="text" name="txtYear" size="15" class="formfield" value="<%=strF_Year%>"  onBlur="ChkYear()">&nbsp;&nbsp;&nbsp;<input type="text" name="txtYear1" value="<%=strT_Year%>" size="15" class="formfield" readonly>	</td>
		<!--onKeyPress="handleEnter('txtLogin','addUser')"-->
		</tr>
		<tr> 
			
        <td width="25%" class="innertitle">DB Name</td>
			<td width="75%" colspan="3"><input type="text" name="txtDBName" size="34" class="formfield" value="<%=strDBnm%>" readonly> </td>
		</tr>
		<tr>
		<tr>
			<td colspan=4 height="22">
			</td>
		</tr> 
			<td colspan=4>
				<input type="text" name="txtId" value="<%=strUId%>">
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
