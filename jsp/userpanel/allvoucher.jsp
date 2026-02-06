<%@ include file="/jsp/adminpanel/header.jsp" %>
<%
     Calendar cal = Calendar.getInstance();
    int year  = cal.get(Calendar.YEAR);
    int month = cal.get(Calendar.MONTH) + 1;
    int day   = cal.get(Calendar.DAY_OF_MONTH);
    String today = String.format("%04d-%02d-%02d", year, month, day);
	 
    int i=0;
    int nCurrent_Page = 0;
    int nTotal_pages = 0;
    HashMap hmData=(HashMap)request.getAttribute("data"); 
	String searchVal=(String)request.getAttribute("searchVal"); 
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

function deleteVoucher(code,id,bud_id,vou_amt){
    document.VoucherList.id.value = id;
	document.VoucherList.budget_note_id.value = bud_id;
	document.VoucherList.voucher_amount.value = vou_amt;
    switch(code){
        case 3:
  			if(confirm("Are you sure you want delete Voucher : Voucher Amount will be Reverted to Budget Note?")){
            document.VoucherList.action = "<%=strPath+"VoucherDelete.do"%>";
			document.VoucherList.operation.value="delete";
			}
            break;
    }
    document.VoucherList.opr.value=code;
    document.VoucherList.submit();
}

function setAction(code,id){
    document.VoucherList.id.value = id;
    switch(code){
        case 1:
            document.VoucherList.action = "<%=strPath+"BudgetNoteList.do"%>";
            break;
        case 2:
            document.VoucherList.action = "<%=strPath+"OpenVoucher.do"%>";
			document.VoucherList.operation.value="view";
            break;
        case 3:
  			if(confirm("Are you sure you want delete Voucher : Voucher Amount will be Reverted to Budget Note?")){
            document.VoucherList.action = "<%=strPath+"VoucherDelete.do"%>";
			document.VoucherList.operation.value="delete";
			}
            break;
	    case 5:
            document.VoucherList.action = "<%=strPath+"PrintVoucherFromList.do"%>";
			document.VoucherList.operation.value="print";
            break;
        case 4:
            document.VoucherList.action = "<%=strPath+"Close.do"%>";
            break;
		case 7:
		      document.VoucherList.action = "<%=strPath+"AllVoucher.do"%>";
			  document.VoucherList.operation.value="search_BN";
			  document.VoucherList.opr.value="search_BN";
			  document.VoucherList.id.value = document.getElementById('searchId').value;
			break;
    }
    document.VoucherList.opr.value=code;
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
	<input type="hidden" name="budget_note_id" value="">
	<input type="hidden" name="voucher_amount" value="">
    
    <td width="80%" valign="top" align="center">
	<table width="100%" border="0" cellspacing="1" cellpadding="1" align="center" >
	
	<tr style="<%=strColHd%>">
		<td width="100%" align="center" class="titles" height="20">
			Receiver Name<input type="text" id="searchId" placeholder="Receiver Name" name="searchBN" value="<%=searchVal%>">
					<label for="fromDate" class="innertitle">From Date:</label>
        <input type="date" class="formfield" id="fromDate" name="fromDate" value="<%=today%>" />
        &nbsp;&nbsp;
        <label for="toDate" class="innertitle">To Date:</label>
        <input type="date" class="formfield" id="toDate" name="toDate" value="<%=today%>" />
		<input type="button" name="btn3"  value="   Search Voucher   " accesskey="C" onClick="setAction(7,0)" class="PPRSbmtBtn"> 
		</td>
		</tr>
	</table>
	<table width="100%" border="0" cellspacing="1" cellpadding="1" align="center" >
	
	<tr style="<%=strColHd%>">
		<td colspan="7" class="titles" align="center">Voucher List</td>
		</tr>
	
	    <tr style="<%=strColHd%>">
		<td width="12%" align="center" class="titles" height="20">
			Vou. Number
		</td>
		<td width="12%" align="center" class="titles" height="20">
			Cancel/Print
		</td>
		<td width="10%" align="center" class="titles" height="20">
			Date
		</td>
		<td width="15%" align="center" class="titles" height="20">
			Budget Head
		</td>
		<td width="13%" align="center" class="titles" height="20">
			Department
		</td>
		<td width="11%" align="center" class="titles" height="20">
			Amount (Rs.)
		</td>
		<td width="27%" align="center" class="titles" height="20">
			Receiver Name
		</td>
	    </tr>
    	    <%
            if(hmData!=null && hmData.size()>0){
            	String dd_mm_yyyy="";
            		int j=(nCurrent_Page*10)-9;
            	
                for(int indx=0;indx<hmData.size();indx++){
                    HashMap hmt = (HashMap)hmData.get(""+indx);
                    if(hmt!=null && hmt.size()>0){
                        String strId = (String)hmt.get("voucher_id");
                        String strName = (String)hmt.get("strName");
						String voucher_number = (String)hmt.get("voucher_number");
						String budget_note_id= (String)hmt.get("budget_note_id");
						String receiver_name=(String)hmt.get("receiver_name");
						String strDepartmentNm=(String)hmt.get("strDepartmentNm");
			String strDt = (String)hmt.get("voucher_date");
			String strAmount = (String)hmt.get("amt");
			dd_mm_yyyy = strDt.substring(8,10)+"-"+strDt.substring(5,7)+"-"+strDt.substring(0,4);
			/*		strYY=strDt.substring(0,4);
					strMM=strDt.substring(5,7);
					strDD=strDt.substring(8,10);*/

                        %>
			<tr style="<%=indx%2==0?strCol2:strCol1%>">
			    <td align="center"><%=voucher_number%></td>
				<td align="center" class="link"  height="20">
				<a href="#" onClick="deleteVoucher(3,<%=strId%>,<%=budget_note_id%>,<%=strAmount%>)">Cancel</a>
				<a href="#" onClick="setAction(5,<%=strId%>)">Print</a>
				</td>
				<td align="left" class="link" height="20">
					<a href="#" onClick="setAction(2,<%=strId%>)"><%=dd_mm_yyyy%></a>
				</td>
				<td align="left" class="link" height="20">
					<%=strName%>
				</td>
				<td align="left" class="link" height="20">
					<%=strDepartmentNm%>
				</td>
				<td align="right" class="link" height="20">
					<%=strAmount%>
				</td>
				<td align="left" class="link" height="20">
					&nbsp;&nbsp;<%=receiver_name%>
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
		<td colspan=7 height="20">&nbsp;</td>
	    </tr>
	    <tr> 
	      <td colspan="7" valign="top" height="20" align="center">
	          <table width="50%">
		      <tr> 
		    	<td> <input type="button" name="btn1" value="Add new" accesskey="N" onClick="setAction(1,0)" class="PPRSbmtBtn"> 
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
