
<%@ include file="/jsp/adminpanel/header.jsp" %>
<%
    int nCurrent_Page = 0;
    int nTotal_pages = 0;
    String Str="  ";
    String strBudgroupId="";
    HashMap hmData=(HashMap)request.getAttribute("data"); 
    HashMap hmPage=(HashMap)request.getAttribute("page");
   // out.println(" Size--->"+hmData);
    if(hmData!=null && hmData.size()>0){
    	for(int i=0;i<hmData.size();i++){
    		HashMap hmpt=(HashMap)hmData.get(""+0);
    	    	strBudgroupId=(String)hmpt.get("strBudgroupId");
    	}
    }
    if(hmPage!=null && hmPage.size()>0){
        nCurrent_Page = Integer.parseInt((String)hmPage.get("current_page"));
        nTotal_pages = Integer.parseInt((String)hmPage.get("total_page"));
    }
    
%>
<script language="JavaScript">
function navigation(code){
    document.rptParam.NAV.value = code;
    document.rptParam.action = "<%=strPath+"budgetNote.do"%>";
    document.rptParam.submit();
}

function setAction(code,id){
    document.rptParam.id.value = id;
    switch(code){
        case 0:
            document.rptParam.action = "<%=strPath+"viewBudgetNote.do"%>";
            break;
        case 1:
            document.rptParam.action = "<%=strPath+"viewBudgetNote.do"%>";
            break;
            
    }
    document.rptParam.opr.value=code;
    document.rptParam.submit();
}

</script>
<form name="rptParam" method="post" action="#">
    <input type="hidden" name="page" value="rptParam">
    <input type="hidden" name="NAV" value="">
    <input type="hidden" name="current_page" value="<%=nCurrent_Page%>">
    <input type="hidden" name="id" value="">
    <input type="hidden" name="txtBudgroupId" value="<%=strBudgroupId%>">
    <input type="hidden" name="txtBGid" value="<%=strBudgroupId%>">
    <input type="hidden" name="opr" value="">
    
    <td width="80%" valign="top" align="center">
	<table width="100%" border="0" cellspacing="1" cellpadding="1" align="center" >
      <tr > 
        <td width="30%" height="20" bgcolor="#FFCC00" class="link">click on the 
          Expense Head to Create Budget Note for </td>
        <td width="35%" align="center" class="link" height="20"><div align="left"> 
          </div></td>
        <td width="35%" align="Right" class="link" height="20"><p align="left">&nbsp;</p>
          </td>
      </tr>
<!-- colspan="2"  -->
      <tr bgcolor="<%=strColHd%>"> 
        <td width="33%" height="20">&nbsp; </td>
        <td width="33%" align="center" class="titles" height="20">&nbsp;</td>
        <td width="33%" colspan="2" align="center" class="titles" height="20">&nbsp;</td>
      </tr>
      <% int indx=-1;

//		if(hmData!=null && hmData.size()>0){
//**************out.println("size inside if-"+hmData.size());
//		   for(int outerindx=1;outerindx<=hmData.size()/3;outerindx++)
//		   {indx++;
		   
		   
		   
		if(hmData!=null && hmData.size()>0){
//**************out.println("size inside if-"+hmData.size());
		   int outerloop=hmData.size()/3;//if( outerloop==0) {outerloop++;}
		   for(int outerindx=0;outerindx<=outerloop;outerindx++)
		   {indx++;		   
	%>
	 <tr bgcolor="<%=strCol2%>"> 
				<% 
                for(;indx<hmData.size();indx++){
                    HashMap hmt = (HashMap)hmData.get(""+indx);
					
                    if(hmt!=null && hmt.size()>0){
                        String strId = (String)hmt.get("HeadId");
                        String strName = (String)hmt.get("strName");
                        %>
		<td align="center" class="link" height="20" width="33%" onMouseOver=							"this.style.backgroundColor='#cccccc'" onMouseOut="this.style.backgroundColor='<%=strCol2%>'"> 
          <a href="javascript:setAction(1,<%=strId%>)"><%=strName%></a> </td>
                <%   }
				if((indx+1)%3==0 && indx!=0) break;	 
				}
					%>
	  </tr>
				<% 
			}
		}
		//****
		int nRow = 10;
		if(hmData!=null && hmData.size()>0)
			nRow -= (hmData.size()/3);
		for(int in=0;in<nRow-1;in++){
		%>
			<tr> 
				<td valign="top" height="20">&nbsp; </td>
				<td valign="top" height="20">&nbsp; </td>
				<td valign="top" height="20">&nbsp; </td>
			</tr>
		<%        
			    }


		//****		
		%>
	  <tr bgcolor="<%=strColHd%>"> 
		<td width="33%" height="20" ><div align="center" ></div></td>
		<td width="33%" align="center" class="titles" height="20">&nbsp;</td>
		<td width="33%" colspan="2" align="center" class="titles" height="20">&nbsp;</td>
	  </tr>
	<tr bgcolor="<%=strColHd%>"> 
	<td colspan="4" height="20" align="center"> 
	<%
	if(nCurrent_Page!=1){
	   %>
		<a href="#" accesskey="F" class="titles" onClick="navigation(1)">First</a>&nbsp;&nbsp;
	   <%
	}
	if(nCurrent_Page!=1){
	    %>
		<a href="#" accesskey="P" class="titles" onClick="navigation(3)">Previous</a>&nbsp;&nbsp; 
	    <%
	}
	if(nCurrent_Page<nTotal_pages){
	    %>
		<a href="#" accesskey="N" class="titles" onClick="navigation(2)">Next</a>&nbsp;&nbsp; 
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

    </table>
    </td>		
</form>
<%@ include file="/jsp/include/footer.jsp" %>
