<%@ include file="/jsp/adminpanel/header.jsp" %>
<% /*
HashMap hm=(HashMap)request.getAttribute("data");
int indx = 0;*/
//strYY=Date.substring(0,4);
		//strMM=Date.substring(5,7);
		//strDD=Date.substring(8,10);
		String downloadLink=(String)request.getAttribute("downloadLink");
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
 <tr bgcolor="#99FF33">
		<td align="center"  height="20">&nbsp;
        <a href="<%=downloadLink%>" >Download File</a>
		</td>
		<td  align="center" class="titles" height="20" colspan="7">  <b><font size="4"></font></b></td>
		
	    </tr>

	</table>
</td>
	</FORM>

</body>
</html>
<%@ include file="/jsp/include/footer.jsp" %>