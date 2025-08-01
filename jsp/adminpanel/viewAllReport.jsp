<%@ page import="java.util.*,java.text.*" %>
<%@ include file="/jsp/adminpanel/header.jsp" %>
<%	DecimalFormat d = new DecimalFormat("##0.00");

HashMap data=(HashMap)request.getAttribute("data");
//out.println("data"+data); //{dblAmount=115000.00, AllocId=100007, strDepartmentNm=Computer Application, HeadId=100004, dblReservedAmount=0.00, dblUtilisedAmount=0.00, strName=Research Expenses}
HashMap Allo=new HashMap();
HashMap Vouc=new HashMap();
HashMap HMFinal=new HashMap();

Allo=(HashMap)request.getAttribute("Alloc");
//out.println(Allo); 
Vouc=(HashMap)request.getAttribute("Vouch");
//out.println("Vouc"+Vouc);
String strBudgroupId="";
if(Allo!=null && Allo.size()>0){
	HashMap hmt=(HashMap)Allo.get(""+0);
	strBudgroupId=(String)hmt.get("strBudgroupId");
}
double totRemaning=0;
double totAllocated=0;
double totResearved=0;
double totUtilized=0;

String HeadId="";

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
    case 0:
	document.HeadList.id.value = "0";
	document.HeadList.action = "<%=strPath+"ViewRpt.do"%>";
	break;
    case 1:
	document.HeadList.action = "<%=strPath+"ViewRpt.do"%>";
	break;

        case 2:
            document.HeadList.action = "<%=strPath+"ViewRpt.do"%>";
            break;
        case 4:
            document.HeadList.action = "<%=strPath+"/jsp/adminpanel/panel.jsp"%>";
            break;
    }
    document.HeadList.opr.value=code;
    document.HeadList.submit();
}

</script>
<form name="HeadList" method="post" action="#">
    <input type="hidden" name="page" value="ParamRpt">
    <input type="hidden" name="NAV" value="">
    <input type="hidden" name="txtBGid" value="<%//=strBudgroupId%>">

    <input type="hidden" name="id" value="">
    <input type="hidden" name="opr" value="">
    
    <td width="80%" valign="top" align="center">
	<table width="100%" border="0" cellspacing="1" cellpadding="1" align="center" >
      <tr bgcolor="#33CC99" class="titles"> 
        <td height="20" colspan="7" >Report</font></td>
      </tr>
      <tr bgcolor="#99CCFF" class="link"> 
        <td width="4%" height="20" > <div align="center">S.No.</div></td>
        <td width="16%"  height="20" align="center">Head Name</td>
		<td width="18%"  height="20" align="center">Department</td>
        <td width="13%"  height="20" align="center">Budget Allocation</td>
		 <td width="12%"  height="20" align="center">Utilized</td>
        <td width="17%"  height="20" align="center">PO/Reserved(In Progress)</td>
        <td width="20%"  height="20" align="center">Remaning</td>
      </tr>
      <%
	  if(data!=null && data.size()>0){
	   for(int i=0;i<data.size();i++)
	  {
	    //{dblAmount=115000.00, AllocId=100007, strDepartmentNm=Computer Application, HeadId=100004, dblReservedAmount=0.00, dblUtilisedAmount=0.00, strName=Research Expenses}
	  	double remaining=0;
	  	HashMap hmt = (HashMap)data.get(""+i);
		String hid=(String)hmt.get("HeadId");
		String sname=(String)hmt.get("strName");
		String Allocated=(String)hmt.get("dblAmount");
		String departMent=(String)hmt.get("strDepartmentNm");
		String dblUtilisedAmount=(String)hmt.get("dblUtilisedAmount");
		String dblReservedAmount=(String)hmt.get("dblReservedAmount");
		if(Allocated==null)
		Allocated="0.00";
		remaining=Double.parseDouble( Allocated ) - (Double.parseDouble(dblUtilisedAmount)+ Double.parseDouble(dblReservedAmount));
		totRemaning+=remaining;
		totAllocated+=Double.parseDouble( Allocated );
 		totResearved+=Double.parseDouble(dblReservedAmount);
 		totUtilized+=Double.parseDouble(dblUtilisedAmount);
		%>
			<tr  class="link"  bgcolor="#cccccc"> 
				<td width="4%" height="20" > <div align="center"><%=(i+1)%></div></td>
				<td width="16%" align="left" height="20"><%=sname%></a></td>
				<td width="18%" align="left" height="20"><%=departMent%></a></td>
				<td width="13%" align="right" height="20"><%=Allocated%></td>
				<td width="12%" align="right" height="20"><%=d.format(Double.parseDouble(dblUtilisedAmount))%></td>
				<td width="17%" align="right" height="20"><%=d.format(Double.parseDouble(dblReservedAmount))%></td>
				<td width="20%" align="right" height="20"><%=d.format(remaining)%></td>
			</tr>
		      	<% 
		}
		
	}
	 %>
     
		<tr bgcolor="#cccccc" class="link"> 
		<td width="4%" height="20" > </td>
		<td width="16%" height="20" > </td>
		<td width="18%" align="center" height="20">Total : </a></td>
		
		<td width="13%" align="right" height="20"><%=d.format(totAllocated)%></td>
		<td width="12%" align="right" height="20"><%=d.format(totUtilized)%></td>
		<td width="17%" align="right" height="20"><%=d.format(totResearved)%></td>
		<td width="20%" align="right" height="20"><%=d.format(totRemaning)%></td>
		</tr>		

      <tr bgcolor="#99CCFF"> 
        <td height="20" colspan=7>&nbsp;</td>
      </tr>
      <tr> 
        <td colspan="7" valign="top" height="20" align="center">&nbsp; </td>
      </tr>
	    <tr> 
		<td colspan="7" height="20">&nbsp;</td>
	    </tr>
      
    </table>
    <input type="button" accesskey="P" name="Print" value=" Print " onClick="setAction(2,0)"> 
    <input type="button" accesskey="C" name="Close" value="Close" onClick="setAction(4,0)"> 
    </td>		
</form>
<%@ include file="/jsp/include/footer.jsp" %>