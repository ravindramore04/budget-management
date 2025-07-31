<%@ page import="java.util.*,java.text.*" %>
<% DecimalFormat d = new DecimalFormat("##0.00");
String strPath="/budget-management/";

HashMap data=(HashMap)request.getAttribute("data");
//out.println("data"+data); //{dblAmount=115000.00, AllocId=100007, strDepartmentNm=Computer Application, HeadId=100004, dblReservedAmount=0.00, dblUtilisedAmount=0.00, strName=Research Expenses}
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
        case 2:
            document.HeadList.action = "<%=strPath+"PrintViewReport.do"%>";
            break;
        case 4:
            document.HeadList.action = "<%=strPath+"Close.do"%>";
            break;
    }
    document.HeadList.opr.value=code;
    document.HeadList.submit();
}

</script>
<Body onLoad="javascript:print();">
<form name="HeadList" method="post" action="#">
    <input type="hidden" name="page" value="ParamRpt">
    <input type="hidden" name="NAV" value="">
    <input type="hidden" name="id" value="">
    <input type="hidden" name="txtBGid" value="<%//=strBudgroupId%>">
    <input type="hidden" name="opr" value="">
  
  <td width="80%" valign="top" align="center">
  	<Center><strong>MIT ARTS,COMMERCE & SCIENCE COLLEGE, <br>Alandi Pune</strong> <strong><BR>
  	  Budget Status</strong></center>
  	  <table width="100%" border="1" align="center" cellpadding="0" cellspacing="0" bgcolor="#666666" >
      <tr height="50%" bgcolor="#99CCFF" class="link"> 
        <td width="5%" height="20" bgcolor="#FFFFFF" > 
<div align="center"><strong>S.No.</strong></div></td>
        <td width="30%"  height="20" align="center" bgcolor="#FFFFFF"><strong>Head Name</strong></td>
        <td width="20%"  height="20" align="center" bgcolor="#FFFFFF"><strong>Budget 
          Allocation</strong></td>
        <td width="17%"  height="20" align="center" bgcolor="#FFFFFF"><strong>Utilized</strong></td>
		<td width="17%"  height="20" align="center" bgcolor="#FFFFFF"><strong>Researved</strong></td>
        <td width="17%"  height="20" align="center" bgcolor="#FFFFFF"><strong>Remaning</strong></td>
      </tr>
      <%
    int j=1;
	for(int i=0;i<data.size();i++)
	  {
	  	j++;
		double remaining=0;
	  	HashMap hmt = (HashMap)data.get(""+i);
		String hid=(String)hmt.get("HeadId");
		String sname=(String)hmt.get("strName");
		String Allocated=(String)hmt.get("dblAmount");
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
		
		<tr height="50" class="link"> 
		<td width="5%" height="43" bgcolor="#FFFFFF" > 
		<div align="center"><%=(i+1)%></div></td>
		<td width="30%" height="40" align="left" bgcolor="#FFFFFF"><%=sname%></td>
		<td width="20%" height="40" align="center" bgcolor="#FFFFFF"><%=Allocated%></td>
		<td width="17%" height="40" align="right" bgcolor="#FFFFFF"><%=d.format(Double.parseDouble(dblUtilisedAmount))%></td>
		<td width="17%" height="40" align="right" bgcolor="#FFFFFF"><%=d.format(Double.parseDouble(dblReservedAmount))%></td>
		<td width="17%" height="43" align="right" bgcolor="#FFFFFF"><%=d.format(remaining)%></td>
		</tr>
 	<%
	}
	%>
	<tr bgcolor="#FFFFFF"> 
		<td width="5%" height="20" > </td>
		<td width="20%" align="center" height="20"><strong>Total : </strong></a></td>
		
		<td width="25%" align="center" height="20"><strong><%=d.format(totAllocated)%></strong></td>
		<td width="20%" align="center" height="20"><strong><%=d.format(totUtilized)%></strong></td>
		<td width="20%" align="center" height="20"><strong><%=d.format(totResearved)%></strong></td>
		<td width="15%" align="center" height="20"><strong><%=d.format(totRemaning)%></strong></td>
		</tr>		

	
    </table>
    </td>		
</form>
</Body>
</HTML>

