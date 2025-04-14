<%@ include file="/jsp/adminpanel/header.jsp" %>
<%
    int nCurrent_Page = 0;
    int nTotal_pages = 0;
    HashMap hmData=(HashMap)request.getAttribute("data"); 
    //out.println("Sanjeev<BR>"+hmData);
    HashMap hmPage=(HashMap)request.getAttribute("page");
    //out.println("<BR>PAGE<BR>"+hmPage);
    if(hmPage!=null && hmPage.size()>0){
        nCurrent_Page = Integer.parseInt((String)hmPage.get("current_page"));
        nTotal_pages = Integer.parseInt((String)hmPage.get("total_page"));
    }
%>
<Sanjeev>
<script language="JavaScript">
function navigation(code){
    document.HeadBalanceList.NAV.value = code;
    document.HeadBalanceList.action = "<%=strPath+"AllBudgetAllocation.do"%>";
    document.HeadBalanceList.submit();
}

function setAction(code,id){
    document.HeadBalanceList.id.value = id;
	document.HeadBalanceList.opr.value=code;

    switch(code){
        case 1:
            document.HeadBalanceList.action = "<%=strPath+"showBudgetAllocation.do"%>";
            break;
        case 2:
            document.HeadBalanceList.action = "<%=strPath+"openBudgetAllocation.do"%>";
            break;
       
        case 4:
            document.HeadBalanceList.action = "<%=strPath+"Close.do"%>";
            break;
    }
    
    document.HeadBalanceList.submit();
}

</script>
<form name="HeadBalanceList" method="post" action="#">
    <input type="hidden" name="page" value="HeadBalanceList">
    <input type="hidden" name="NAV" value="">
    <input type="hidden" name="current_page" value="<%=nCurrent_Page%>">
    <input type="hidden" name="id" value="">
    <input type="hidden" name="opr" value="">


    <td width="80%" valign="top" align="center">
	<table width="100%" border="0" cellspacing="1" cellpadding="1" align="center" >
	    <tr bgcolor="<%=strColHd%>">
		<td width="10%" height="20">&nbsp;

		</td>
		<td width="22%" align="center" class="titles" height="20">
			Budget Head
		</td>
		<td width="22%" align="center" class="titles" height="20">
			Dept. Name
		</td>
		<td width="22%"  align="center" class="titles" height="20">
			Allocated Ballance
		</td>
		<td width="22%"  align="center" class="titles" height="20">
			Reservered Balance
		</td>
		<td width="22%"  align="center" class="titles" height="20">
			Utilised Balance
		</td>
		<td width="22%"  align="center" class="titles" height="20">
			Remaining Balance
		</td>
	    </tr>
    	    <%
            if(hmData!=null && hmData.size()>0){
                for(int indx=0;indx<hmData.size();indx++){
                    HashMap hmt = (HashMap)hmData.get(""+indx);
                    if(hmt!=null && hmt.size()>0){
                    	
                        String strId = (String)hmt.get("HeadId");
                        String strName = (String)hmt.get("strName");
			String strBalance = (String)hmt.get("dblAmount");
			String strDepartmentNm = (String)hmt.get("strDepartmentNm");
			String dblReservedAmount = (String)hmt.get("dblReservedAmount");
			String dblUtilisedAmount = (String)hmt.get("dblUtilisedAmount");
                        %>
			<tr bgcolor="<%=indx%2==0?strCol2:strCol1%>">
				<td align="center" height="20">
				    <input type="checkbox" name="<%="chk"+indx%>" value="<%=strId%>"> 
				</td>
				<td align="left" class="link" height="20">
					<a href="#" onClick="setAction(2,<%=strId%>)"><%=strName%></a>
				</td>
				<td align="left" class="link" height="20">
				<%=strDepartmentNm%>
				</td>
		        <td  align="left" class="link" height="20"> <%=strBalance%></td>
				<td align="left" class="link" height="20">
					<%=dblReservedAmount%>
				</td>
				<td align="left" class="link" height="20">
					<%=dblUtilisedAmount%>
				</td>
				<td align="left" class="link" height="20">
					<!-- TODO: Add remianing balance-->
				</td>

			</tr>
    			<%
                    }
                }
            }
            int nRow = 10;
            if(hmData!=null && hmData.size()>0)
                nRow -= hmData.size();
            for(int indx=0;indx<nRow;indx++){
                %>
	        <tr> 
	      	    <td valign="top" height="20">&nbsp; </td>
	            <td valign="top" height="20">&nbsp; </td>
	            <td valign="top" height="20">&nbsp; </td>
				<td valign="top" height="20">&nbsp; </td>
				<td valign="top" height="20">&nbsp; </td>
	    	</tr>
	    	<%        
	    }
	    %>
	    
	    <tr bgcolor="<%=strColHd%>"> 
	      <td colspan="5" height="20" align="center"> 
		<%
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
		%>
	      </td>
	    </tr>
	    <tr> 
		<td colspan="5" height="20">&nbsp;</td>
	    </tr>
	    <tr> 
	      <td colspan="5" valign="top" height="20" align="center">
	          <table width="50%">
		      <tr> 
		    	<td colspan="2" align="right"> <input type="button" name="btn1" value="Add new" accesskey="N" onClick="setAction(1,0)" class="PPRSbmtBtn">
		    	</td>
		    	<td colspan="2" align="left"> <input type="button" name="btn1" value="   Close   " accesskey="C" onClick="setAction(4,0)" class="PPRSbmtBtn"> 
		    	</td>
		      </tr>
		  </table>
	      </td>
	    </tr>
	</table>
    </td>		
</form>
<%@ include file="/jsp/include/footer.jsp" %>
