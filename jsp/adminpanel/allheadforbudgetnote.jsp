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
	document.HeadBalanceList.opr.value='create';
    switch(code){
        case 1:
            document.HeadBalanceList.action = "<%=strPath+"showBudgetAllocation.do"%>";
            break;
        case 2:
            //document.HeadBalanceList.action = "<%=strPath+"openBudgetAllocation.do"%>";
			document.HeadBalanceList.action = "<%=strPath+"AllHeadForBudgetNote.do"%>"
            break;
       
        case 4:
            document.HeadBalanceList.action = "<%=strPath+"Close.do"%>";
            break;
    }
    
    document.HeadBalanceList.submit();
}

	function showTooltip(event, text) {
			let tooltip = document.getElementById("tooltip");
			tooltip.textContent = text;
			tooltip.style.display = "block";
			tooltip.style.left = (event.target.getBoundingClientRect().left + window.scrollX) + "px";
			tooltip.style.top = (event.target.getBoundingClientRect().top + window.scrollY - 30) + "px";
	}

	function hideTooltip() {
		document.getElementById("tooltip").style.display = "none";
	}

</script>
<form name="HeadBalanceList" method="post" action="#">
    <input type="hidden" name="page" value="HeadBalanceList">
    <input type="hidden" name="NAV" value="">
    <input type="hidden" name="current_page" value="<%=nCurrent_Page%>">
    <input type="hidden" name="id" value="">
    <input type="hidden" name="opr" value="">
    <div id="tooltip" class="tooltip"></div>
    <td width="80%" valign="top" align="center" class="tabbg">
	<table width="100%" border="0" cellspacing="1" cellpadding="1" align="center" >
	  <tr style="<%=strColHd%>"><td colspan="7" class="titles" align="center"><font color="#FF9900">Click on Budget Head Name to create Budget Note</font></td></tr>
	    <tr style="<%=strColHd%>">
		
		<td width="7%" height="20">&nbsp;

		</td>
		<td width="20%" align="center" class="titles" height="20">
			Budget Head
		</td>
		<td width="20%" align="center" class="titles" height="20">
			Dept. Name
		</td>
		<td width="14%"  align="center" class="titles" height="20">
			Allocated Ballance
		</td>
		<td width="14%"  align="center" class="titles" height="20">
			Reservered Balance
		</td>
		<td width="14%"  align="center" class="titles" height="20">
			Utilised Balance
		</td>
		<td width="14%"  align="center" class="titles" height="20">
			Remaining Balance
		</td>
	    </tr>
    	    <%
            if(hmData!=null && hmData.size()>0){
                for(int indx=0;indx<hmData.size();indx++){
                    HashMap hmt = (HashMap)hmData.get(""+indx);
                    if(hmt!=null && hmt.size()>0){
                    	
                        String AllocId = (String)hmt.get("AllocId");
                        String strId = (String)hmt.get("HeadId");
                        String strName = (String)hmt.get("strName");
			String strBalance = (String)hmt.get("dblAmount");
			String strDepartmentNm = (String)hmt.get("strDepartmentNm");
			String dblReservedAmount = (String)hmt.get("dblReservedAmount");
			String dblUtilisedAmount = (String)hmt.get("dblUtilisedAmount");
			
			double remainAmt=Double.parseDouble(strBalance)-(Double.parseDouble(dblReservedAmount)+Double.parseDouble(dblUtilisedAmount));
                        %>
			<tr style="<%=indx%2==0?strCol2:strCol1%>">
				<td align="center" height="20">
				<a href="#" onClick="setAction(2,<%=AllocId%>)">Create</a>
					</td>
				<td align="left" class="link" height="20">
				<div onMouseOver="showTooltip(event, 'Click to Create Budget Note')" onMouseOut="hideTooltip()">
					<a href="#" onClick="setAction(2,<%=AllocId%>)"><%=strName%></a>
				</div>
				</td>
				<td align="left" class="link" height="20">
				<%=strDepartmentNm%>
				</td>
				<td align="left" class="link" height="20">
					<%=strBalance%>
				</td>
				<td align="left" class="link" height="20">
					<%=dblReservedAmount%>
				</td>
				<td align="left" class="link" height="20">
					<%=dblUtilisedAmount%>
				</td>

        <td  align="left" class="link" height="20"> <%=remainAmt%></td>
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
				<td valign="top" height="20">&nbsp; </td>
				<td valign="top" height="20">&nbsp; </td>
	    	</tr>
	    	<%        
	    }
	    %>
	    
	    <tr style="<%=strColHd%>"> 
	      <td colspan="7" height="20" align="center"> 
		<%
		if(nCurrent_Page!=1){
		   %>
		   	<a href="#" accesskey="F" class="titles" onClick="navigation(1)"><i class="arrow left"></i>First</a>&nbsp;&nbsp;
		   <%
		}
		if(nCurrent_Page<nTotal_pages){
		    %>
			<a href="#" accesskey="N" class="titles" onClick="navigation(2)">Next<i class="arrow right"></a>&nbsp;&nbsp; 
		    <%
		}
		if(nCurrent_Page!=1){
		    %>
			<a href="#" accesskey="P" class="titles" onClick="navigation(3)"><i class="arrow left"></i>Previous</a>&nbsp;&nbsp; 
		    <%
		}
		if(nCurrent_Page<nTotal_pages){
		    %>
			<a href="#" accesskey="L" class="titles" onClick="navigation(4)">Last<i class="arrow right"></a> 
		    <%
		}
		%>
	      </td>
	    </tr>
	    <tr> 
		<td colspan="7" height="20">&nbsp;</td>
	    </tr>
	    <tr> 
	      <td colspan="7" valign="top" height="20" align="center">
	          <table width="50%">
		      <tr> 
		    	<td colspan="2" align="right">
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