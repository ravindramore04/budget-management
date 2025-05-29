<% //@page import="java.util.*" %>
<%
	session.setAttribute("itr", "1");

	String strId = "";
	String strHeadId = "";
	String strDate = "";
	String strAmount = "";
	String strRemark = "";
	String Str="",strDD="",strMM="",strYY="";
	String bgNm="";
	            	

	HashMap hmData=(HashMap)request.getAttribute("data"); 
	HashMap hmHead=(HashMap)request.getAttribute("head"); 
	HashMap hmGroup=(HashMap)request.getAttribute("ghead");
	//out.print(hmGroup);
	if(hmData!=null && hmData.size()>0){
		strId = (String)hmData.get("AllocId");
		strHeadId = (String)hmData.get("HeadId");
		strDate = (String)hmData.get("Dt");
//		String dd_mm_yyyy = strDate.substring(8,10)+"-"+strDate.substring(5,7)+"-"+strDate.substring(0,4);
		strDD =strDate.substring(8,10);
		strMM =strDate.substring(5,7);
		strYY =strDate.substring(0,4);	
		
//		alert(dd_mm_yyyy);
		strAmount = (String)hmData.get("dblAmount");
		strRemark = (String)hmData.get("strRemark");
		bgNm=(String)hmData.get("strDepartmentId");
	}
%>
<%@ include file="/jsp/adminpanel/header.jsp" %>
<script language="JavaScript">
	function formSubmit(){
		var _Head = document.BudgetAllocationMaster.Head.value;
		var _Amount = document.BudgetAllocationMaster.txtAmount.value;
		var _Remark = document.BudgetAllocationMaster.txtRemark.value;
		document.BudgetAllocationMaster.txtDate.value=document.BudgetAllocationMaster.YY.value+"-"+document.BudgetAllocationMaster.MM.value+"-"+document.BudgetAllocationMaster.DD.value;
		
		if(_Head=="0")
		{
			alert("Select Head Name ");
			return false;
		}
		if(_Amount.toString()=="")
		{
			alert("Enter The Amount");
			return false;
		}
		else{
			if(isNaN(_Amount))
			{
				alert("Enter Numeric Value");
				return false;
			}
		}
		document.BudgetAllocationMaster.submit();
	}
	function handleEnter(fieldname,frm){
	 	 var keyCode = event.keyCode ? event.keyCode : event.which ? event.which : event.charCode;
		 if (keyCode == 13){
		 	eval('document.'+frm+'.'+fieldname+'.focus()');
		}
     }


</script>
<td width="80%" valign="top">
   <form name="BudgetAllocationMaster" method="post" action="SaveBudgetAllocation.do">
   <input type="hidden" name="page" value="BudgetAllocationMaster">
	<table width="70%" border="0" cellspacing="1" cellpadding="1" align="center" >
		<tr> 
			<td width="25%" class="innertitle">Department Name </td>
			<td colspan="3">
			<select name="strDepartmentId" class="formfield" >
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
	    <td width="72%">		 <select name="Head" accesskey="H" class="formfield">
                                <OPTION value="0" selected>--------Select Head--------</option>
                                <%
                         if(hmHead!=null && hmHead.size()>0){
                                    for(int indx=0;indx<hmHead.size();indx++){
                                        HashMap hmt = (HashMap)hmHead.get(""+indx);
                                        String HeadId = (String)hmt.get("HeadId");
                                        String strHeadName = (String)hmt.get("strName");
                                        %>
                                        <OPTION value="<%=HeadId%>" <%=HeadId.equals(strHeadId)?"selected":"" %> ><%=strHeadName%></option>
                                        <%
                                    }
                                }
                                %>
                            </select>
					</td>		
		</tr>
		<tr> 
			
        <td width="25%" class="innertitle">Allocation Date </td>
			
        <td colspan="3"> 
          <input type="hidden" name="txtDate" size="25" class="formfield" value=""  >
          <!-- <%=strDate%> -->
          <select name="DD" class="formfield" >
            <% for(int i=1;i<=31;i++)
	            { 
	             if(i<10)
	             	Str="0"+(""+i).trim();
	             else
	             	Str=(""+i).trim();
	             	
	             	
	             if(strDD.equals(Str))
	             {
	    		%>
            <option value="<%=Str%>" selected><%=Str%></option>
            <% } else { %>
            <option value="<%=Str%>"><%=Str%></option>
            <% } } %>
          </select>
          <select name="MM" class="formfield">
            <% 
            for(int i=1;i<=12;i++)
		    { 
		     if(i<10)
			Str="0"+(""+i).trim();
		     else
			Str=(""+i).trim();
			
	             if(strMM.equals(Str))
	             {
	    		%>
            <option value="<%=Str%>" selected><%=Str%></option>
            <% } else { %>
            <option value="<%=Str%>"><%=Str%></option>
            <% } } %>
          </select>
          <select name="YY" class="formfield" >
            <% for(int i=2000;i<=2050;i++)
            { 
	        Str=""+i;
	     	if(strYY.equals(Str.trim()))
	     	{
		%>
            <option value="<%=Str%>" selected><%=Str%></option>
            <% } else { %>
            <option value="<%=i%>"><%=i%></option>
            <% }  } %>
          </select></td></tr>
		<tr> 
			<td width="25%" class="innertitle">Amount </td>
			<td colspan="3"><input type="text" name="txtAmount" size="25" class="formfield" value="<%=strAmount%>" onKeyPress="handleEnter('txtRemark','BudgetAllocationMaster')"> </td>
		</tr>
		
		<tr> 
			<td class="innertitle" valign = "top">Remark</td>
			<td colspan="3">
				<textarea name="txtRemark" class="formfield" cols="25" rows="3"><%=strRemark%></textarea>
			</td>
		</tr>
		<tr> 
			<td colspan=4>
				<input type="hidden" name="txtId" value="<%=strId%>">
			</td>
		</tr>
		<tr> <td width="30%"></td>
			<td colspan=3 align="left">
			
				<input name="btnSub" type="Button" value="Submit" class="PPRSbmtBtn" onClick="formSubmit()">
					&nbsp;<input name="btnSub" type="Reset" value=" Reset " class="PPRSbmtBtn">
			</td>
			
		</tr>
	</table>
    </form>
</td>
<%@ include file="/jsp/include/footer.jsp" %>
