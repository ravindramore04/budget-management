<%@ page import="java.util.*" %>
<%@ include file="/jsp/userpanel/header.jsp" %>

<%
	session.setAttribute("itr", "1");
	String HeadId = "";
	String Strparty ="";
	String nAmt = "";
	String nPONo = "";
	String POId = "";
	String Date="";
	String strDD="";
	String strMM="";
	String strYY="";
    String Str="";	
	HashMap hmAll=(HashMap)request.getAttribute("all"); 
	//out.println(hmAll);
	HashMap hmData=(HashMap)request.getAttribute("data"); 
	System.out.println(hmData);
	
	if(hmData!=null && hmData.size()>0){
	
		nPONo = (String)hmData.get("nPONo");
		POId = (String)hmData.get("POId");
		Date = (String)hmData.get("POdt");
		Strparty = (String)hmData.get("Strparty");
		nAmt = (String)hmData.get("nAmt");
		HeadId=(String)hmData.get("nBudgetId");
		strYY=Date.substring(0,4);
		strMM=Date.substring(5,7);
		strDD=Date.substring(8,10);
	        
	
	}
	else
	{
		Date date = new Date();
		strDD=""+date.getDate();
		strMM=""+date.getMonth();
		strMM=""+(Integer.parseInt(strMM)+1);
		strYY=""+date.getYear();
		strYY=strYY.substring(1,3);
				
		if(Integer.parseInt(strDD)<10)
			strDD="0"+strDD;	
		if(Integer.parseInt(strMM)<10)
			strMM="0"+strMM;
		
		strYY="20"+strYY;

	}
%>
<script language="javascript">

function ChkDt()
{
	var tyy =document.BudgetHead.YY.value;
	var tmm = document.BudgetHead.MM.value;
	var tdd =document.BudgetHead.DD.value;
	
	document.BudgetHead.txtDt.value=tyy+"-"+tmm+"-"+tdd;
	
	if((document.BudgetHead.txtNo.value).toString()=="")
	{
		alert("Enter The PO No");
		document.BudgetHead.txtNo.focus();
		return false;		
	}
	if((document.BudgetHead.txtPartyNm.value).toString()=="")
	{
		alert("Enter Party Name");
		document.BudgetHead.txtPartyNm.focus();
		return false;

	}
	
	if(isNaN(document.BudgetHead.txtAmt.value))
		{
			alert("Enter Numaric Value only");
			document.BudgetHead.txtAmt.focus();
			return false;
		}

	document.BudgetHead.submit();
}
  
 function handleEnter(fieldname,frm){
	 var keyCode = event.keyCode ? event.keyCode : event.which ? event.which : event.charCode;
	 if (keyCode == 13){
		eval('document.'+frm+'.'+fieldname+'.focus()');
	}
}
</script>

<td width="80%" valign="top">
   <form name="BudgetHead" method="post" action="SavePurchaseOrder.do">
   <input type="hidden" name="OldheadId" value="<%=HeadId%>">
   <input type="hidden" name="OAmmount" value="<%=nAmt%>">  
   <input type="hidden" name="POId" value="<%=POId%>">
   <input type="hidden" name="txtDt" value="">
	
    <table width="100%" border="0" cellspacing="1" cellpadding="1" align="center" >
      <!--DWLayoutTable-->
       <tr> 
	  
        
        <td colspan="3">&nbsp;</td>
      </tr>
      <tr> 
	  
        <td  height="20" class="innertitle" align="left" >Purchase OrderNo :- </td>
        <td colspan="1" align="left" > <input type="text" name="txtNo" size="25" class="formfield" value=<%=nPONo%>></td>
	  <td  class="innertitle" align="right">Date :-</td>
        <td  align="left"> <select name="DD">
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
          </select> <select name="MM">
            <% for(int i=1;i<=12;i++)
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
          </select> <select name="YY">
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
          </select></td>
		  </tr>
      <tr> 
        <td height="15" align="left" class="innertitle">Budget Head :-</td>
        <td align="left" colspan="2"> <div align="left"> 
            <select name="txtHeadId" class="formfield" >
              <option value="">--Select Budget Head--</option>
              <%
				    if(hmAll!=null && hmAll.size()>0){
				    	for(int indx=0;indx<hmAll.size();indx++){
				    	    HashMap hmt = (HashMap)hmAll.get(""+indx);
				    	    String strTempId = (String)hmt.get("HeadId");
				    	    String strTempName = (String)hmt.get("strName");
							//strAllocate= (String)hmt.get("allocate");
							//strexp= (String)hmt.get("exp");
							//strBalance=Double.parseDouble(strAllocate)-Double.parseDouble(strexp);
				    	    %>
              <OPTION value="<%=strTempId%>" <%=strTempId.equals(HeadId)?"selected":"" %> ><%=strTempName%></option>
              <%
				    	}
				    }
				%>
            </select>
          </div></td>
        
      
      </tr>
	  <tr>
	  <td colspan=3>&nbsp;</td>
	  </tr>
      <tr> 
       
        <td colspan=3 class="innertitle" align="center"> <input type="checkbox" name="Con" value="1">
          Consumable&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
          <input type="checkbox" name="Non" value="1">
          NonConsumable</td>
        
       
      </tr>
	  <tr>
	  <td colspan=3>&nbsp;</td>
	  </tr>
      <tr> 
        <td height="24" align="left" class="innertitle">Party Name :-</td>
        <td align="left" colspan=2>  
            <input type="text" name="txtPartyNm" size="25" class="formfield" value="<%=Strparty%>"  onKeyPress="handleEnter('txtNetAmt','BudgetHead')">
          </td>
        
      </tr>
      
      
     
      <tr> 
        <td height="24" align="left" class="innertitle">Amount <font size="1">(Rs.) :-</font> 
        </td>
        <td align="left" class="innertitle" colspan=2> <input type="text" name="txtAmt" size="25" class="formfield" value="<%= nAmt%>" " > 
        </td>
		</tr>
		<tr>
        <td colspan="3">&nbsp;</td>
        
		</tr>
		<tr>
        <td colspan="3">&nbsp;</td>
      </tr>
      
      <tr> 
        <td height="26" colspan=4 align="center"> <input name="btnSub" type="Reset" value=" Reset " class="PPRSbmtBtn"> 
          &nbsp; <input name="btnSub" type="Button" value="Submit" class="PPRSbmtBtn" onClick="return ChkDt()"> 
        </td>
        
      </tr>
    </table>
    </form>
</td>
<%@ include file="/jsp/include/footer.jsp" %>
