<%@ include file="/jsp/adminpanel/header.jsp" %>
<%
	int i=0;
    int nCurrent_Page = 0;
    int nTotal_pages = 0;
    HashMap hmData=(HashMap)request.getAttribute("data");
		out.println("1-------"+hmData);
	    HashMap hmData1=(HashMap)request.getAttribute("data1");
			//out.println("2----"+hmData1);
		    HashMap hmData2=(HashMap)request.getAttribute("data2");
	//out.println("3-------"+hmData2); 
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
    switch(code){
        case 1:
            document.VoucherList.action = "<%=strPath+"OpenNewPurchaseOrder.do"%>";
            break;
        case 2:
            document.VoucherList.action = "<%=strPath+"viewBudgetNote.do"%>";
            break;
        case 3:
            //delete done later
            document.VoucherList.action = "<%=strPath+"VoucherDelete.do"%>";
            break;
        case 4:
            document.VoucherList.action = "<%=strPath+"Close.do"%>";
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
    
    <td width="80%" valign="top" align="center">
	<table width="100%" border="0" cellspacing="1" cellpadding="1" align="center" >
	    <tr bgcolor="<%=strColHd%>">
		<td width="5%" align="center" class="titles" height="20">
			X
		</td>
		
		<td width="10%" align="center" class="titles" height="20"> PONo</td>
		<td width="40%" align="center" class="titles" height="20">
			BudgetHead
		</td>

		<td width="20%" align="center" class="titles" height="20">
			PartyName
		</td>
		<td width="10%" align="center" class="titles" height="20">
			Amount (Rs.)
		</td>
		<td width="20%" align="center" class="titles" height="20">
			Date
		</td>
	</tr>
		
    	    <%
            if(hmData!=null && hmData.size()>0){
            //	out.println("hmData---->"+hmData);
				//String dd_mm_yyyy="";
            		int j=(nCurrent_Page*10)-9;
					
				HashMap hmFinal=(HashMap)hmData.get("std");

            	
                for(int indx=0;indx<hmFinal.size();indx++){
                    HashMap hmt = (HashMap)hmFinal.get(""+indx);
					//out.println("hmt--->"+hmt);
					

                    if(hmt!=null && hmt.size()>0){
                        String nPONo = (String)hmt.get("nPONo");
						String POId = (String)hmt.get("POId");
						String Strparty = (String)hmt.get("Strparty");
						//out.println("Strparty---"+Strparty);
						String strAmount = (String)hmt.get("nAmt");
						String POdt = (String)hmt.get("POdt");
						String strId = (String)hmt.get("nBudgetId");
						String strName = (String)hmt.get("strName");
                        %>
			<tr bgcolor="<%=indx%2==0?strCol2:strCol1%>">
				<td align="center" class="link"  height="20">
				    <input type="checkbox" name="<%//="chk"+indx%>" value="<%//=strId%>"> 
				</td>
				
				<td align="left" class="link" height="20">
					<%=nPONo%>
				</td>
				<td align="left" class="link" height="20">
					<a href="#" onClick="setAction(2,<%=strId%>)" > <%=strName%></a>
				</td>

				<td align="left" class="link" height="20">
					<%=Strparty%>
				</td>
				<td align="left" class="link" height="20">
					<%=strAmount%>
				</td>
				<td align="left" class="link" height="20">
					<%=POdt%>
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
	    
	    		<td colspan=6 height="20">&nbsp;</td>
	    </tr>
	    <tr> 
	      <td colspan="6" valign="top" height="20" align="center">
	          <table width="50%">
		      <tr> 
		    
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
