<% //@page import="java.util.*" %>
<%
	session.setAttribute("itr", "1");

	String strId = "";
	String strName = "";
	String strAccNo = "";
	String strRemark = "";
	String bgNm="";
	
	//For Budget Group
	String strHeadId = "";
	
	HashMap hmData=(HashMap)request.getAttribute("data"); 
	//HashMap hmGroup=(HashMap)request.getAttribute("ghead"); 
	HashMap hmHead=(HashMap)request.getAttribute("ghead"); 
	//out.println("dghfjgsjdgf"+hmHead);
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
	 
	 const select = document.getElementById('mySelect');
  select.addEventListener('mousedown', function(e) {
    e.preventDefault(); // Prevents the dropdown from opening
  });

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
			<td width="25%" class="innertitle">Group Head Name </td>
	    <td width="75%" colspan="3">		 <select id="mySelect"  name="Head" accesskey="H" class="formfield">
                                <OPTION value="0"  selected>--------Select Group--------</option>
                                <%
                         if(hmHead!=null && hmHead.size()>0){
                                    for(int indx=0;indx<hmHead.size();indx++){
                                        HashMap hmt = (HashMap)hmHead.get(""+indx);
                                        String strBudgroupId = (String)hmt.get("strBudgroupId");
                                        String strBudgroupNm = (String)hmt.get("strBudgroupNm");
                                        %>
                                        <OPTION value="<%=strBudgroupId%>" <%=strBudgroupId.equals(bgNm)?"selected":"" %> ><%=strBudgroupNm%></option>
                                        <%
                                    }
                                }
                                %>
                            </select>
					</td>		
		</tr>
	
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
