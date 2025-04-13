<html>
<title>Budget Note</title>
<head></head>
<%@ page import="java.util.*,java.text.*" %>
<%
DecimalFormat d = new DecimalFormat("##0.00");
String strPath="/budget-management/";
HashMap hmAllo=new HashMap();

hmAllo=(HashMap)request.getAttribute("Head");
//out.println(hmAllo);
String strBudgroupId="";
if(hmAllo!=null && hmAllo.size()>0){
	//HashMap hmt=(HashMap)hmAllo.get(""+0);
	strBudgroupId=(String)hmAllo.get("strBudgroupId");
}
double POAmt=0;

%>
<script language="JavaScript">

function setAction(code,id){
    document.HeadList.id.value = id;
    switch(code){
        case 5:
            document.HeadList.action = "<%=strPath+"OpenPurchaseOrder.do"%>";
            break;
			
			
    }
    document.HeadList.opr.value=code;
   // document.HeadList.submit();
}

</script>
 <body onLoad="javascript:print();setAction(5,0)"> 
<body>
<form name="HeadList" method="post" action="#">
    <input type="hidden" name="page" value="PrintList">
    <input type="hidden" name="NAV" value="">
    <input type="hidden" name="txtBGid" value="<%=strBudgroupId%>">
    <input type="hidden" name="id" value="">
    <input type="hidden" name="opr" value="">
    
    <td width="80%" valign="top" align="center">

	<Table width="100%" border="1" cellspacing="1" cellpadding="1" align="center">
	<TR>
	<TD>
	<table width="100%" border="0" cellspacing="1" cellpadding="1" align="center" >
      <tr class="titles"> 
        <td height="20"  colspan="5"> <div align="center"><strong>BUDGET NOTE-2006-2007</strong></div></td>

      </tr>
	<TR><TD height="2" colspan="4"><HR></TD></TR>
      <tr> 
      </tr>
	<TR><TD height="2" colspan="4"></TD></TR>
      <tr> 
        <td width="30%" ><strong> Name of Dept.</strong></td>
        <td colspan="3"><strong>:</strong>&nbsp;&nbsp;&nbsp;&nbsp;<strong>&nbsp;&nbsp;<%=(String)hmAllo.get("strName")%></strong></td>
      </tr>
      <tr> 
        <td width="30%"><strong>Budget Sanctioned</strong></td>
        <td width="10%"><strong>: Rs</strong></td>
        <td width="20%" align="right"><strong><%=(String)hmAllo.get("BSUM")%></strong></td>
        <td>&nbsp;</td>
      </tr>
      <tr> 
        <td width="30%"><strong>Amt. already spend</strong></td>
        <td><strong>:</strong> <strong>Rs&nbsp;&nbsp;</strong>&nbsp;&nbsp;&nbsp;&nbsp;</td>
        <td width="20%" align="right"><strong>
		 <%
		String bal =(String)hmAllo.get("BSUM");
		String vou =(String)hmAllo.get("VSUM");
		HashMap hr=(HashMap)hmAllo.get("rr");
	
		String POSUM =(String)hr.get("POAmt");
		if(POSUM==null || POSUM.equals(""))
			{
			POSUM="0";
			}
		
		
		
		if (bal!=null)
		{
			double Allresult = (Double.parseDouble(vou)+Double.parseDouble(POSUM));
			out.print(d.format(Allresult));
		}	
		%>
		
		<!--<%//=Double.parseDouble((String)hmAllo.get("VSUM"))%>--></strong></td>
        <td>&nbsp;</td>
      </tr>
	  <tr> 
        <td width="30%"><strong>This Expenditure</strong></td>
        <td><strong>:</strong> <strong>Rs&nbsp;&nbsp;</strong>&nbsp;&nbsp;&nbsp;&nbsp;</td>
              <td width="20%" align="right"> <strong></strong> </strong> </td>
		<td>&nbsp;</td>
      <tr> 
        <td width="30%"><strong>Balance</strong></td>
        <td><strong>: Rs &nbsp;&nbsp;</strong>&nbsp;&nbsp;&nbsp;&nbsp; </td>
        <td width="20%" align="right"><strong> 
          <%
		 bal =(String)hmAllo.get("BSUM");
		 vou =(String)hmAllo.get("VSUM");
		  POSUM =(String)hr.get("POAmt");
		if(POSUM==null || POSUM.equals(""))
			{
			POSUM="0";
			}
		
		POAmt=Double.parseDouble(POSUM);
		
		if (bal!=null)
		{
			double result = Double.parseDouble(bal)-(Double.parseDouble(vou)+Double.parseDouble(POSUM));
			out.print(d.format(result));
		}	
		%>
		</strong></td>
        <td>&nbsp;</td>
      </tr>
      <tr> 
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td align="right">&nbsp;</td>
        <td >&nbsp;</td>
      </tr>
      <tr> 
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td align="right">&nbsp;</td>
        <td >&nbsp;</td>
      </tr>
 <!--     <tr> 
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td align="right">&nbsp;</td>
        <td >&nbsp;</td>
      </tr>  -->
      <tr> 
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td align="right">&nbsp;</td>
        <td><strong>Approved: Yes / No</strong></td>
      </tr>
      <tr> 
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td align="right">&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
      <tr> 
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td align="right">&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td align="center" colspan="2"><strong>Chief Accounts &amp; Finance Officer</strong></td>
        <!-- <td>&nbsp;</td> -->
        <td align="right">&nbsp;</td>
        <td><strong>Executive Director/Principal</strong></td>
      </tr>
    </table>
	</TD>
	</TR>
	</Table>

    </td>		
</form>
</body>
</html>