<%@page import="java.util.*"%>
<%
	session.setAttribute("itr", "1");
	String txtName ="";
	String txtShrtNm="";
	String txtAddr="";
	String txtPh1="";
	String txtPh2="";

	HashMap hmt=(HashMap)request.getAttribute("Data");
	
	if(hmt!=null && hmt.size()>0)
	
	{
		for(int i=0;i<hmt.size();i++)
		{
	
			HashMap tt = (HashMap)hmt.get(""+i);
			txtName =(String)tt.get("strName");
			txtShrtNm=(String)tt.get("strShortNm");
			txtAddr=(String)tt.get("strAddr");
			txtPh1=(String)tt.get("strPh1");
			txtPh2=(String)tt.get("strPh2");
		}
	}

%>
<script language="JavaScript">
	function setAction()
	{
		var _Name = document.abc.txtName.value;
		var _Address = document.abc.addr.value;

		if(_Name.length==0)
		{
			alert(" Emter The Name");
			document.abc.txtName.focus();
			return false;
		}
		if(_Address.length==0)
		{
			alert("Enter The Address");
			document.abc.addr.focus();
			return false;
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
<%@ include file="/jsp/adminpanel/header.jsp" %>
<td width="80%" valign="top">
   <form name="abc" method="post" action="<%=strPath + "OrganisationPage.do"%>">
   	<table width="70%" border="0" cellspacing="1" cellpadding="1" align="center" >
		<tr> 
			<td colspan=4>&nbsp;</td>
		</tr>
		<tr> 
			<td colspan=4>&nbsp;</td>
		</tr>
		<tr> 
			<td width="25%" class="innertitle">Name </td>
			<td width="75%" colspan="3"><input type="text" name="txtName" size="40" class="formfield" value="<%=txtName%>" onKeyPress="handleEnter('txtShrtNm','abc')"> </td>
		</tr>
		<tr> 
			<td class="innertitle">Short Name</td>
			<td colspan="3"><input type="text" name="txtShrtNm" size="40" value="<%=txtShrtNm%>" class="formfield" onKeyPress="handleEnter('addr','abc')"></td>
		</tr>
		<tr> 
			<td valign="top" class="innertitle">Address</td>
			<td colspan="3"> 
				<textarea name="addr" class="formfield" rows="3" cols="39" onKeyPress="handleEnter('txtPh1','abc')"><%=txtAddr%> </textarea>
			</td>
		</tr>
		<tr> 
			<td class="innertitle">Phone (1)</td>
			<td width="30%"><input type="text" name="txtPh1"  size="15" value="<%=txtPh1%>" class="formfield" onKeyPress="handleEnter('txtPh2','abc')"></td>
			<td width="5%" class="innertitle">(2)</td>
			<td><input type="text" name="txtPh2" size="15"  value="<%=txtPh2%>" class="formfield" onKeyPress="handleEnter('txtPh1','abc')"></td>
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
