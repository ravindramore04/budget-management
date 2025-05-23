<%@ include file="/jsp/adminpanel/header.jsp" %>

<%
    int i=0;
    int nCurrent_Page = 0;
    int nTotal_pages = 0;
    HashMap hmData=(HashMap)request.getAttribute("data"); 
	//out.println("--hmData--"+hmData);
    HashMap hmPage=(HashMap)request.getAttribute("page");
    if(hmPage!=null && hmPage.size()>0){
        nCurrent_Page = Integer.parseInt((String)hmPage.get("current_page"));
        nTotal_pages = Integer.parseInt((String)hmPage.get("total_page"));
    }
%>
<script language="JavaScript">
function navigation(code){
    document.VoucherList.NAV.value = code;
    document.VoucherList.action = "<%=strPath+"AllVoucher.do"%>";
    document.VoucherList.submit();
}

function setAction(code,id){
    document.VoucherList.id.value = id;
	 document.VoucherList.opr.value=code;
    switch(code){
        case 1:
            document.VoucherList.action = "<%=strPath+"AllHeadForBudgetNote.do"%>";
            break;
        case 2:
            document.VoucherList.action = "<%=strPath+"OpenVoucher.do"%>";
			document.VoucherList.operation.value="voucher";
            break;
        case 3:
			if(confirm("Are you sure you want delete Budget Note?")){
              document.VoucherList.action = "<%=strPath+"AllHeadForBudgetNote.do"%>";
			  document.VoucherList.opr.value="delete";
			}
            break;
		case 5:
              document.VoucherList.action = "<%=strPath+"AllHeadForBudgetNote.do"%>";
			  document.VoucherList.operation.value="edit";
			  document.VoucherList.opr.value="edit";
            break;
		case 6:
              document.VoucherList.action = "<%=strPath+"AllHeadForBudgetNote.do"%>";
			  document.VoucherList.operation.value="print";
			  document.VoucherList.opr.value="print";
            break;
        case 4:
            document.VoucherList.action = "<%=strPath+"Close.do"%>";
            break;
    }
   
    document.VoucherList.submit();
}

</script>
<form name="VoucherList" method="post" action="#">
    <input type="hidden" name="page" value="VoucherList">
    <input type="hidden" name="NAV" value="">
    <input type="hidden" name="current_page" value="<%=nCurrent_Page%>">
    <input type="hidden" name="id" value="">
    <input type="hidden" name="opr" value="">
	<input type="hidden" name="operation" value="">
    
    <td width="80%" valign="top" align="center">
	<table width="100%" border="0" cellspacing="1" cellpadding="1" align="center" >
	   <% if((String)request.getAttribute("message") !=null){
	   %>
	    <tr><td colspan="6"><font color="#FF9900"><%=(String)request.getAttribute("message")%></font></td></tr>
		<%}%>
	    <tr style="<%=strColHd%>"><td colspan="6" class="titles" align="center">Budget Note List</td></tr>
	    <tr style="<%=strColHd%>">
		<td width="20%" align="center" class="titles" height="20">
			Del/Update
		</td>
		<td width="20%" align="center" class="titles" height="20">
			Budget Note Status
		</td>
		<td width="20%" align="center" class="titles" height="20">
			Date
		</td>
		<td width="20%" align="center" class="titles" height="20">
			Head Name
		</td>
		<td width="20%" align="center" class="titles" height="20">
			Department
		</td>
		<td width="20%" align="center" class="titles" height="20">
			Amount (Rs.)
		</td>

	    </tr>
    	    <%
            if(hmData!=null && hmData.size()>0){
            	String dd_mm_yyyy="";
            		int j=(nCurrent_Page*10)-9;

            	
                for(int indx=0;indx<hmData.size();indx++){
                    HashMap hmt = (HashMap)hmData.get(""+indx);
                    if(hmt!=null && hmt.size()>0){
                        String strId = (String)hmt.get("budget_note_id");
                        String strName = (String)hmt.get("strDepartmentNm");
						String head_name=(String)hmt.get("budget_head_name");
						String budget_note_status=(String)hmt.get("budget_note_status");
			String strDt = (String)hmt.get("create_date");
			String strAmount = (String)hmt.get("budget_note_expense");
			
			dd_mm_yyyy = strDt.substring(8,10)+"-"+strDt.substring(5,7)+"-"+strDt.substring(0,4);
			/*		strYY=strDt.substring(0,4);
					strMM=strDt.substring(5,7);
					strDD=strDt.substring(8,10);*/

                        %>
			<tr style="<%=indx%2==0?strCol2:strCol1%>">
				<td align="center" class="link"  height="20">
				<%=strId%>
			    <a href="#" onClick="setAction(3,<%=strId%>)">DEL&nbsp;&nbsp;</a>
					<a href="#" onClick="setAction(5,<%=strId%>)">EDIT</a>
					<a href="#" onClick="setAction(6,<%=strId%>)">PRINT</a>
				</td>
				<td align="left" class="link" height="20">
					<%
					if("APPROVED".equals(budget_note_status) && isAccount){
					%>
					<a href="#" onClick="setAction(2,<%=strId%>)"><%=budget_note_status%> Create Voucher</a>
					<%}else{
					%>
					<%=budget_note_status%>
					<%}%>
				</td>
				<td align="left" class="link" height="20">
					<%=dd_mm_yyyy%>
				</td>
				<td align="left" class="link" height="20">
					<%=head_name%>
				</td>
				<td align="left" class="link" height="20">
					<%=strName%>
				</td>
				<td align="left" class="link" height="20">
					<%=strAmount%>
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
				<td valign="top" height="20">&nbsp; </td>
	    	</tr>
	    	<%        
	    }
	    %>
	    
	    <tr style="<%=strColHd%>"> 
	      <td colspan="6" height="20" align="center"> 
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
		<td colspan=6 height="20">&nbsp;</td>
	    </tr>
	    <tr> 
	      <td colspan="6" valign="top" height="20" align="center">
	          <table width="50%">
		      <tr> 
		    	<td> <input type="button" name="btn1" value="Create Budget Note" accesskey="N" onClick="setAction(1,0)" class="PPRSbmtBtn"> 
		    	</td>
		    	<td> <!-- <input type="button" name="btn3" value="  Delete  " accesskey="D" onClick="setAction(3,0)" class="PPRSbmtBtn"> -->
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
