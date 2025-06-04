<%@ page import="java.util.*" %>
<%
String strPath="/budget-management/";
HashMap hm=new HashMap();
HashMap hm1=new HashMap();
HashMap hmAmt=new HashMap();
HashMap hmVot=new HashMap();
HashMap hmBal=new HashMap();
HashMap hmVoct=new HashMap();
HashMap hmAmount=new HashMap();
hm=(HashMap)request.getAttribute("Amount");
hm1=(HashMap)request.getAttribute("Voucher");
if(hm!=null && hm.size()>0)
{
  hmAmt=(HashMap)hm.get("AlloAmont");
  hmBal=(HashMap)hm.get("bal");
}
  if(hm1!=null && hm1.size()>0)
{
  hmVot=(HashMap)hm1.get("voucher");
}
	String balance="",bal="";
	double exp=0,alloc=0;
%>
<script language="JavaScript">
function navigation(code){
    document.HeadList.NAV.value = code;
    document.HeadList.action = "<%=strPath+"AllHead.do"%>";
    document.HeadList.submit();
}

function setAction(code,id){
    document.HeadList.id.value = id;
    switch(code){
        case 1:
            document.HeadList.action = "<%=strPath+"OpenHead.do"%>";
            break;
        case 2:
            document.HeadList.action = "<%=strPath+"PrintViewReport.do"%>";
            break;
        case 3:
            //delete done later
            document.HeadList.action = "<%=strPath+"OpenHead.do"%>";
            break;
        case 4:
            document.HeadList.action = "<%=strPath+"Close.do"%>";
            break;
    }
    document.HeadList.opr.value=code;
    document.HeadList.submit();
}

</script>
<form name="HeadList" method="post" action="#">
    <input type="hidden" name="page" value="ParamRpt">
    <input type="hidden" name="NAV" value="">

    <input type="hidden" name="id" value="">
    <input type="hidden" name="opr" value="">
    
    <td width="80%" valign="top" align="center">
	<table width="100%" border="1" cellspacing="0" cellpadding="0" align="center" >
      <tr> 
        <td height="20" colspan="4" > <div align="left" class="titles"><strong>Expense 
            Head</strong> </div></td>
      </tr>
      <tr> 
        <td width="15%" height="20" align="center" class="link"><strong>Date</strong></td>
        <td width="15%" height="20" align="left" class="link"><div align="center"><strong>Allocation</strong></div></td>
        <td width="23%" height="20" align="left" class="link"><div align="center"><strong>Expense 
            Made</strong></div></td>
        <td width="22%" height="20" align="left" class="link"><div align="center"><strong>Balance</strong></div></td>
      </tr>
      <%
	  if(hmAmt!=null && hmAmt.size()>0){
	  for(int i=0;i<hmAmt.size();i++)
	  {
	  	hmAmount=(HashMap)hmAmt.get(""+i);
		if(i>0){
		balance="";
		}else
		{
		balance=(String)hmBal.get("dblBalance");
		bal=(String)hmBal.get("dblBalance");
		}
		alloc+=Double.parseDouble( (String)hmAmount.get("dblAmount"));
	  %>
      <tr bgcolor=""> 
        <td align="center" height="20" class="link"><%=(String)hmAmount.get("Dt")%></td>
        <td align="left" class="link" height="20" ><div align="center"><%=(String)hmAmount.get("dblAmount")%></div></td>
        <td align="left" class="link" height="20">&nbsp; <div align="center"> 
          </div></td>
        <td align="left" class="link" height="20" ><div align="center">&nbsp;</div></td>
      </tr>
      <%
	  }
	  }
	  %>
      <%
	  if(hmVot!=null && hmVot.size()>0)
	  {
	    for(int j=0;j<hmVot.size();j++)
		{
			hmVoct=(HashMap)hmVot.get(""+j);
			exp+=(Double.parseDouble( (String)hmVoct.get("dblAmount") )+Double.parseDouble((String)hmVoct.get("dblTds")));
	  %>
      <tr bgcolor=""> 
        <td align="center" height="20" class="link" ><%=(String)hmVoct.get("dt")%></td>
        <td align="left" class="link" height="20" ><div align="center">&nbsp;</div></td>
        <td align="center" class="link" height="20"><div align="center"> </div>
         <%=(Double.parseDouble( (String)hmVoct.get("dblAmount") )+Double.parseDouble((String)hmVoct.get("dblTds")))%></td>
        <td align="left" class="link" height="20"><div align="center">&nbsp;</div></td>
      </tr>
      <%
		}
		}
		%>
      <tr> 
        <td colspan=4 height="20">&nbsp;</td>
      </tr>
      <tr class="link"> 
        <td height="20" align="center">Total</td>
        <td height="20" align="center"><%=alloc%> 
          <div align="center"></div></td>
        <td height="20" align="center"><%=exp%> 
          <div align="center"></div></td>
        <td height="20" align="center"><%=bal%></td>
      </tr>
    </table>
    <center>
        	<Table border="0">
    	<Tr>
   	<TD><input type="button" accesskey="P" name="Print" value=" Print " onClick="javascript:print()"></TD>
   	<TD><input type="submit" accesskey="C" name="Close" value="Close" onClick="setAction(4,0)"></TD>
   	</TR>
   	</TABLE>
   	</CENTER>
</td>	
</form>

