<%@ include file="/jsp/adminpanel/header.jsp" %>
<%@ page import="java.util.Calendar" %>
<%
    Calendar cal = Calendar.getInstance();
    int year = cal.get(Calendar.YEAR);
    int month = cal.get(Calendar.MONTH) + 1; // Months are 0-based in Calendar
    int day = cal.get(Calendar.DAY_OF_MONTH);

    // Format to yyyy-MM-dd (required for <input type="date">)
    String today = year + "-" +
                   (month < 10 ? "0" + month : month) + "-" +
                   (day < 10 ? "0" + day : day);

    int nCurrent_Page = 0;
    int nTotal_pages = 0;
	String bgNm="";
	HashMap hmGroup=(HashMap)request.getAttribute("ghead");
    HashMap hmData=(HashMap)request.getAttribute("data"); 
   // out.println("hmData-->"+hmData);
	HashMap hmPage=(HashMap)request.getAttribute("page");
   //out.println(hmPage);
    if(hmPage!=null && hmPage.size()>0){
        nCurrent_Page = Integer.parseInt((String)hmPage.get("current_page"));
        nTotal_pages = Integer.parseInt((String)hmPage.get("total_page"));
    }
%>
<script language="JavaScript">
function navigation(code){
    document.HeadList.NAV.value = code;
    document.HeadList.action = "<%=strPath+"AllHead.do"%>";
    document.HeadList.submit();
}

function setAction(code,id){
    document.HeadList.id.value = id;
    switch(code){
        case 1:
        	document.HeadList.id.value=HeadList.txtBGid.value;
            document.HeadList.action = "<%=strPath+"viewheadrept.do"%>";
            document.HeadList.opr.value=code;
    	    document.HeadList.submit();
            break;
        case 2:
            document.HeadList.action = "<%=strPath+"RptParam.do"%>";
            break;
        case 3:
            //delete done later
            document.HeadList.action = "<%=strPath+"DeleteHead.do"%>";
            break;
        case 4:
            document.HeadList.action = "<%=strPath+"Close.do"%>";
            break;
    }
    
}

</script>
<form name="HeadList" method="post" action="#">
    
    <input type="hidden" name="id" value="">
    <input type="hidden" name="opr" value="">
    
    <td width="80%" valign="top" align="center">
	<table width="100%" border="0" cellspacing="1" cellpadding="1" align="center" >
	    <tr bgcolor="<%=strColHd%>">
		<td width="10%" height="20">&nbsp;
		</td>
		
      <td width="45%" align="center" class="titles" height="20">&nbsp; </td>
		<td width="45%" colspan="2" align="center" class="titles" height="20">
			
		</td>
	    </tr>
	    <tr>
	    	<td width="100%">&nbsp;
	    	</td>
	    </tr>
	    <tr>
	    	    	<td width="100%">&nbsp;
	    	    	</td>
	    </tr>
		<tr> 
			<td width="25%" class="innertitle">Department Name </td>
			<td>
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
	    <td width="100%" align="center">
		             <label for="dob">From Date:</label>
                    <input type="date" id="dob" name="fromDate" value="<%= today %>">
					<label for="dob">To Date:</label>
                    <input type="date" id="dob1" name="toDate" value="<%= today %>">
					</td>
					</tr>
	    <tr>
	    	    	
      <td width="100%" align="center">Select The Head from List </td>
	    </tr>

	    <tr>
	    <td width="100%" align="center">
	    <select name="txtBGid">
	    <option value="<%=""+0%>">-------------------Select Head---------------------</option>
    	    <%
            if(hmData!=null && hmData.size()>0){
                for(int indx=0;indx<hmData.size();indx++){
                    HashMap hmt = (HashMap)hmData.get(""+indx);
                    if(hmt!=null && hmt.size()>0){
                        String strId = (String)hmt.get("HeadId");
                        String strName = (String)hmt.get("strName");
                        %>
			<option value="<%=strId%>"><%=strName%></option>
    			<%
                    }
                }
            }
            
                %>
                </td>
                </tr>
					    <tr>
	    	    	<td width="100%" align="center"><input type="radio" name="rd" value="1">Cash
					 <input type="radio" name="rd" value="2">Cheque 
					 <input type="radio" name="rd" value="3" checked>Both   
	    	    	</td>
	    </tr>
				
	        <tr> 
	      	    <td valign="top" height="20">&nbsp; </td>
	            <td valign="top" height="20">&nbsp; </td>
	            <td valign="top" height="20">&nbsp; </td>
	    	</tr>
	    	<tr>
			    	<td width="100%">&nbsp;
			    	</td>
	    </tr>
	    <tr>
	    	    	<td width="100%">&nbsp;
	    	    	</td>
	    </tr>
	    <tr>
	    	    	<td width="100%">&nbsp;
	    	    	</td>
	    </tr><tr>
	    	<td width="100%">&nbsp;
	    	</td>
	    </tr>
	    	
	    
	    <tr bgcolor="<%=strColHd%>"> 
	      <td colspan="4" height="20" align="center"> 
		<!--<%
		if(nCurrent_Page!=1){
		   %>
		   	<a href="#" accesskey="F" class="titles" onClick="navigation(1)">First</a>&nbsp;&nbsp;
		   <%
		}
		if(nCurrent_Page<nTotal_pages){
		    %>
			<a href="#" accesskey="N" class="titles" onClick="navigation(2)">Next</a>&nbsp;&nbsp; 
		    <%
		}
		if(nCurrent_Page!=1){
		    %>
			<a href="#" accesskey="P" class="titles" onClick="navigation(3)">Previous</a>&nbsp;&nbsp; 
		    <%
		}
		if(nCurrent_Page<nTotal_pages){
		    %>
			<a href="#" accesskey="L" class="titles" onClick="navigation(4)">Last</a> 
		    <%
		}
		%>-->
	      </td>
	    </tr>
	    <tr> 
		<td colspan=4 height="20">&nbsp;</td>
	    </tr>
	    <tr> 
	      <td colspan="4" valign="top" height="20" align="center">
	          <table width="50%">
		      <tr> 
		    	<td> <input type="button" name="btn1" value="Submit" accesskey="N" onClick="setAction(1,0)" class="PPRSbmtBtn"> 
		    	</td>
		    	<td><!-- <input type="button" name="btn3" value="  Delete  " accesskey="D" onClick="setAction(3,0)" class="PPRSbmtBtn"> -->
		    	</td>
		    	<td> <input type="button" name="btn1" value="   Close   " accesskey="C" onClick="setAction(4,0)" class="PPRSbmtBtn"> 
		    	</td>
		      </tr>
		  </table>
	      </td>
	    </tr>
	</table>
    </td>		
</form>
<%@ include file="/jsp/include/footer.jsp" %>
