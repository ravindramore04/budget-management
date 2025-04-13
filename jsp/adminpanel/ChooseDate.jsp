<%@ include file="/jsp/adminpanel/header.jsp" %>
<% /*
HashMap hm=(HashMap)request.getAttribute("data");
int indx = 0;*/
//strYY=Date.substring(0,4);
		//strMM=Date.substring(5,7);
		//strDD=Date.substring(8,10);
			String Date="";
	String strDD="";
	String strMM="";
	String strYY="";
    String Str="";
		
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
%>
<html>
<head>
<title>Luscious Technologies Pvt. Ltd.</title>

</head>
<body  topmargin="0" leftmargin="0" >
<SCRIPT language="javascript">


function setAction(code){
   
    switch(code){
        case 1:
		 if(validate())
		 {
           
			document.DateForm.action = "<%=strPath+"SavePurchaseOrderReport.do"%>";
			 document.DateForm.submit();
		}
			break;
        case 2:
            document.DateForm.action = "<%=strPath+"Close.do"%>";
			 document.DateForm.submit();
            break;
			 }
    document.DateForm.opr.value=code;
   
}

function validate(){
		document.DateForm.Fromdt.value=document.DateForm.YY.value+"-"+document.DateForm.MM.value+"-"+document.DateForm.DD.value;
		document.DateForm.Todt.value=document.DateForm.YY1.value+"-"+document.DateForm.MM1.value+"-"+document.DateForm.DD1.value;
		if(document.DateForm.con.checked==false){
			if(document.DateForm.Non.checked==false){
				alert("select Atleast one Consumable or NonConsumable ");
				return false;
			}			
		}
		return true
}
function setId(val){ 	
 	document.DateForm.calId.value=val;
}

function ChkDt()
{
	var tyy =document.DateForm.YY.value;
	var tmm = document.DateForm.MM.value;
	var tdd =document.DateForm.DD.value;
	
	document.DateForm.txtDt.value=tyy+"-"+tmm+"-"+tdd;
		document.DateForm.submit();
	}
</Script>
<FORM name="DateForm"  METHOD="POST" >
<input type="hidden" name="Fromdt" value="">
<input type="hidden" name="Todt" value="">
  <td width="80%" valign="top" align="center">

<TABLE ALIGN=Left WIDTH="100%" BORDER=0 CELLPADDING=0 CELLSPACING=0 >
 <tr bgcolor="<%=strColHd%>">
		<td  height="20">&nbsp;

		</td>
		<td  align="center" class="titles" height="20" colspan="7">  <b><font size="4">Purchase Order Report</font></b></td>
		
	    </tr>

	<tr valign=top>
	  <td width="34">&nbsp;</td>
      <td colspan=4 align="left"> <b><font size="3">&nbsp;&nbsp;&nbsp;&nbsp;Choose Date Range</font></b> 
      </td>
	</tr>

	<tr valign=top>
		<td colspan=5 align="center">&nbsp;</td>
	</tr>
					
	<tr valign=top>
	<td align="center">&nbsp;</td>
	  <td width="97" align="center" valign="middle"> <strong><font size="2" face="Verdana, Arial, Helvetica, sans-serif"><u>F</u>rom 
        Date</font></strong> </td>
	  <td width="150" align="left"><select name="DD">
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
          </select> 
      <!-- <input type="text" name="Fromdt" size="15" class="formfield" value=""  >-->
          
	</td>
	  <td width="81" align="left" valign="middle"> <strong><font size="2" face="Verdana, Arial, Helvetica, sans-serif"><u>T</u>o 
        Date</font></strong></td>
	  <td width="256" align="left"><select name="DD1">
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
          </select> <select name="MM1">
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
          </select> <select name="YY1">
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
          </select> 

        <!--<INPUT type="text" name="Todt" size=15 class="formfield"value="" ><strong><font size="2">
          (YYYY-MM-DD) </font>--></td>
	</tr>
		
		
		<tr valign=top>
		<td colspan="5">&nbsp;</td>
		</tr>
		
		<tr valign=top>
			<td colspan=5 align="center">
				<input type="hidden" name="opr" value="1">
			</td>
		</tr>
		<tr valign=top>
			<td colspan=5 align="center">&nbsp;
							</td>
		</tr>
					
			<%%>
		<tr valign=top>
			
      <td colspan=2 align="right"> <input type="checkbox"  name="con"value="1"  >
          
        </td>
       <td colspan=3> &nbsp;Consumable </td>
		</tr>
		<tr>
		<td colspan=2 align="right">
		<input type="checkbox" name="Non" value="1" >
		
		</td>
		  <td colspan=3> &nbsp;NonConsumable </td>
		</tr>
			<%
						%>
			
				<tr>
		 <td colspan=5 class="titles"> <b><font size="3">&nbsp; </font></b> </td>
		</tr>
		<tr>
		 <td colspan=5 class="titles"> <b><font size="3">&nbsp;</font></b> </td>
		</tr>
            
			<tr>
      <td align=center colspan="5"><b><font size="3"> 
        <input type="button" value=" Display " name="btnSave" onClick="setAction(1)" class="PPRSbmtBtn" accesskey="D">
        <input type="button" value="  Close  "  name="ShowWorkPanel" onClick="setAction(2)" class="PPRSbmtBtn" accesskey="C">
	    </font></b> </td>
		
			</tr>
			</table>
</td>
	</FORM>

</body>
</html>
<%@ include file="/jsp/include/footer.jsp" %>