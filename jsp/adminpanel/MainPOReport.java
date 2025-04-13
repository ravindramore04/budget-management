<%@ include file="/jsp/adminpanel/header.jsp" %>
<%
    int nCurrent_Page = 0;
    int nTotal_pages = 0;
    String Str="  ";
    HashMap hmData=(HashMap)request.getAttribute("data");
    //out.println(hmData);
    String strBudgroupId="";
    
    if(hmData!=null && hmData.size()>0){
    	HashMap hmb=(HashMap)hmData.get(""+0);
    	strBudgroupId=(String)hmb.get("strBudgroupId");
    }
    HashMap hmPage=(HashMap)request.getAttribute("page");
    //out.println(hmPage);
    if(hmPage!=null && hmPage.size()>0){
        nCurrent_Page = Integer.parseInt((String)hmPage.get("current_page"));
        nTotal_pages = Integer.parseInt((String)hmPage.get("total_page"));
    }
    
%>
<script language="JavaScript">
function navigation(code){
    document.rptParam.NAV.value = code;
    document.rptParam.action = "<%=strPath+"RptParam.do"%>";
    document.rptParam.submit();
}

function setAction(code,id){
    document.rptParam.id.value = id;
    switch(code){
        case 0:
       // var strgiId=document.rptParam.txtBudgroupId.value;
       // alert(strgiId);
        	document.rptParam.id.value = "0";
            document.rptParam.action = "<%=strPath+"ViewRpt.do"%>";
            break;
        case 1:
            document.rptParam.action = "<%=strPath+"ViewRpt.do"%>";
            break;
            
    }
    document.rptParam.opr.value=code;
    document.rptParam.submit();
}

</script>

<form name="rptParam" method="post" action="#">
    <input type="hidden" name="page" value="rptParam">
    <input type="hidden" name="NAV" value="">
    <input type="hidden" name="txtBudgroupId" value="<%=strBudgroupId%>">
    <input type="hidden" name="txtBGid" value="<%=strBudgroupId%>">
    
    <input type="hidden" name="current_page" value="<%=nCurrent_Page%>">
    <input type="hidden" name="id" value="">
    <input type="hidden" name="opr" value="">
    <%
    	//out.println("strBudgroupId>>>>>>>>>>>"+strBudgroupId);
    %>
    <td width="80%" valign="top" align="center">
	<table width="100%" border="0" cellspacing="1" cellpadding="1" align="center" >
      <tr > 
        <td width="30%" height="20" bgcolor="#FFCC00" class="link">click on the Expense Head to see the Report </td>
        <td width="35%" align="center" class="link" height="20"><div align="left"> 
            From 

<select name="FDD">
	<% for(int i=1;i<=31;i++)
          { 
           if(i<10)
           	Str="0"+(""+i).trim();
           else
           	Str=(""+i).trim();
           	
          %>
              <Option value="<%=Str%>"><%=Str%></Option>
              <% } %>
            </select>
            <select name="FMM">
              <% for(int i=1;i<=12;i++)
		{ 
		if(i<10)
			Str="0"+(""+i).trim();
		else
			Str=(""+i).trim();

		%>
		<Option value="<%=Str%>"><%=Str%></Option>
              <% } %>
            </select>
            <select name="FYY">
              <% for(int i=2000;i<=2050;i++)
          { %>
              <Option value="<%=i%>"><%=i%></Option>
              <% } %>
            </select>
          </div></td>
        <td width="35%" align="Right" class="link" height="20"><p align="left">To 
<select name="TDD">
              
              <% for(int i=1;i<=31;i++)
		{ 
		if(i<10)
			Str="0"+(""+i).trim();
		else
			Str=(""+i).trim();

          	%>
          	
              <Option value="<%=Str%>"><%=Str%></Option>
              <% } %>
            </select>
            <select name="TMM">
              <% for(int i=1;i<=12;i++)
		{ 
			if(i<10)
				Str="0"+(""+i).trim();
			else
				Str=(""+i).trim();

		%>
              <Option value="<%=Str%>"><%=Str%></Option>
              <% } %>
            </select>
            <select name="TYY">
              <% for(int i=2000;i<=2050;i++)
          { %>
              <Option value="<%=i%>"><%=i%></Option>
              <% } %>
            </select>
          </p>
          </td>
      </tr>
<!-- colspan="2"  -->
      <tr bgcolor="<%=strColHd%>"> 
        <td width="33%" height="20">&nbsp; </td>
        <td width="33%" align="center" class="titles" height="20">&nbsp;</td>
        <td width="33%" colspan="2" align="center" class="titles" height="20">&nbsp;</td>
      </tr>
      <% int indx=-1;

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
		<td width="33%" height="20"  bgcolor="#33CC99"><div align="center" ><a href="javascript:setAction(0,0)" class="titles" >all  Heads</a></div></td>
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
	    <tr> 
		<td colspan=4 height="20">&nbsp;</td>
	    </tr>
		
    </table>
    </td>		
</form>
<%@ include file="/jsp/include/footer.jsp" %>
