<%@ include file="/jsp/adminpanel/header.jsp" %>
<%
    int nCurrent_Page = 0;
    int nTotal_pages = 0;
    HashMap hmData=(HashMap)request.getAttribute("data");
//    out.println("Head Balance.jsp"+hmData);
    HashMap hmPage=(HashMap)request.getAttribute("page");
//    out.println("<BR>---->Head Balance.jsp"+hmPage);
    if(hmPage!=null && hmPage.size()>0){
        nCurrent_Page = Integer.parseInt((String)hmPage.get("Newcurrent_page"));
        nTotal_pages = Integer.parseInt((String)hmPage.get("total_page"));
    }
%>
<script language="JavaScript">
function navigation(code){
    document.HeadAllocationList.NAV.value = code;
    document.HeadAllocationList.action = "<%=strPath+"openBudgetAllocation.do"%>";
    document.HeadAllocationList.submit();
}

function setAction(code,id){
    document.HeadAllocationList.id.value = id;
    switch(code){
       case 3:
	   		 n = parseInt(HeadAllocationList.count.value);
			
		      for(indx=0;indx<n;indx++)
		      {
			     chkCat= "chk" + indx;
			  if(document.all.item(chkCat).checked)
		 	  {   
				HeadAllocationList.txtAllocId.options.length =HeadAllocationList.txtAllocId.options.length +1;
				HeadAllocationList.txtAllocId.options[HeadAllocationList.txtAllocId.options.length-1].value = document.all.item(chkCat).value;
				HeadAllocationList.txtAllocId.options[HeadAllocationList.txtAllocId.options.length-1].selected = true;
			   }
             }

            document.HeadAllocationList.action = "<%=strPath+"showBudgetAllocation.do"%>";
            break;
     	
	  case 2:
           document.HeadAllocationList.action = "<%=strPath+"showBudgetAllocation.do"%>";
           break;
     
	 
	    case 1:
            document.HeadAllocationList.action = "<%=strPath+"Close.do"%>";
            break;
    }
    document.HeadAllocationList.opr.value=code;
    document.HeadAllocationList.submit();
}


</script>
<form name="HeadAllocationList" method="post" action="#">
    <input type="hidden" name="page" value="HeadAllocationList">
    <input type="hidden" name="NAV" value="">
    <input type="hidden" name="Newcurrent_page" value="<%=nCurrent_Page%>">
    <input type="hidden" name="id" value="">
    <input type="hidden" name="opr" value="">
    <input type="Hidden" Name="count" value="<%=hmData.size()%>">
	
	
   
    <td width="80%" valign="top" align="center">
      <div id="aa" style="position:relative;visibility:hidden;"> 
      <select size="1" name="txtAllocId" multiple>
      </select>
    </div>

	<table width="100%" border="0" cellspacing="1" cellpadding="1" align="center" >
	    <tr bgcolor="<%=strColHd%>">
		<td width="10%" height="20">&nbsp;

		</td>
		<td width="45%" align="center" class="titles" height="20">
			Date
		</td>
		<td width="45%" colspan="2" align="center" class="titles" height="20">
			Amount
		</td>
	    </tr>
    	    <%
            if(hmData!=null && hmData.size()>0){
                for(int indx=0;indx<hmData.size();indx++){
                    HashMap hmt = (HashMap)hmData.get(""+indx);
                    if(hmt!=null && hmt.size()>0){
                        String strId = (String)hmt.get("AllocId");
                        String strName = (String)hmt.get("Dt");
						String dd_mm_yyyy = strName.substring(8,10)+"-"+strName.substring(5,7)+"-"+strName.substring(0,4);
			            String strBalance = (String)hmt.get("dblAmount");
						String strRemark = (String)hmt.get("strRemark");
                        %>
			<tr bgcolor="<%=indx%2==0?strCol2:strCol1%>">
				<td align="center" height="20">
				    <input type="hidden" name="<%="chk"+indx%>" value="<%=strId%>"> 
				</td>
				<td align="left" class="link" height="20">
					<a href="#" onClick="setAction(2,<%=strId%>)"><%=dd_mm_yyyy%></a>
				</td>
				<td colspan="2" align="left" class="link" height="20">
					<%=strBalance%>
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
	    	</tr>
	    	<%        
	    }
	    %>
	    
	    <tr bgcolor="<%=strColHd%>"> 
	      <td colspan="4" height="20" align="center"> 
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
		<td colspan=4 height="20">&nbsp;</td>
	    </tr>
	    <tr> 
	      <td colspan="4" valign="top" height="20" align="center">
	          <table width="50%">
		      <tr> 
		    	<td align="right" colspan="2"> <!-- <input type="button" name="btn3" value="  Delete  " accesskey="D" onClick="setAction(3,0)" class="PPRSbmtBtn"> -->
		    	</td>
		    	<td align="left" colspan="2"> <input type="button" name="btn1" value="   Close   " accesskey="C" onClick="setAction(1,0)" class="PPRSbmtBtn"> 
		    	</td>
		      </tr>
		  </table>
	      </td>
	    </tr>
	</table>
    </td>		
</form>
<%@ include file="/jsp/include/footer.jsp" %>
