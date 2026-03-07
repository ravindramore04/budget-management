<%@ page import="java.util.*,java.text.*" %>
<% DecimalFormat d = new DecimalFormat("##0.00");
String strPath="/budget-management/";

HashMap data=(HashMap)request.getAttribute("data");
HashMap data1=(HashMap)request.getAttribute("data1");
//out.println("data"+data); //{dblAmount=115000.00, AllocId=100007, strDepartmentNm=Computer Application, HeadId=100004, dblReservedAmount=0.00, dblUtilisedAmount=0.00, strName=Research Expenses}
double totRemaning=0;
double totAllocated=0;
double totResearved=0;
double totUtilized=0;
int indx=0;
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
        <td width="3%" height="20" bgcolor="#FFFFFF" > 
<div align="center"><strong>S.No.</strong></div></td>
        <td width="16%"  height="20" align="center" bgcolor="#FFFFFF"><strong>Head Name</strong></td>
		<td width="16%"  height="20" align="center" bgcolor="#FFFFFF"><strong>Department</strong></td>
        <td width="13%"  height="20" align="center" bgcolor="#FFFFFF"><strong>Budget 
          Allocation</strong></td>
        <td width="12%"  height="20" align="center" bgcolor="#FFFFFF"><strong>Utilized</strong></td>
		<td width="20%"  height="20" align="center" bgcolor="#FFFFFF"><strong>PO/Reserved(In Process)</strong></td>
        <td width="20%"  height="20" align="center" bgcolor="#FFFFFF"><strong>Remaning</strong></td>
      </tr>
    	  <tr  class="link"  bgcolor="#FFFFFF"> 
				<td colspan="7" height="20" > <div align="left">Recurring</div></td>
	  </tr>
      <%
if(data!=null && data.size()>0){

    Iterator groupItr = data.keySet().iterator();

    while(groupItr.hasNext()){

        String grpId = (String)groupItr.next();
        HashMap groupData = (HashMap)data.get(grpId);

        if(groupData!=null && groupData.size()>0){

            HashMap firstRow = (HashMap)groupData.get("0");
            String grpName = (String)firstRow.get("strBudgroupNm");
%>

<tr bgcolor="#FFFFFF">
<td colspan="7"><b><%=grpName%></b></td>
</tr>

<%
        Iterator rowItr = groupData.keySet().iterator();

        while(rowItr.hasNext()){

            String key = (String)rowItr.next();
            HashMap hmt = (HashMap)groupData.get(key);

            double remaining=0;

            String hid=(String)hmt.get("HeadId");
            String sname=(String)hmt.get("strName");
            String Allocated=(String)hmt.get("dblAmount");
            String departMent=(String)hmt.get("strDepartmentNm");
            String dblUtilisedAmount=(String)hmt.get("dblUtilisedAmount");
            String dblReservedAmount=(String)hmt.get("dblReservedAmount");

            indx++;

            if(Allocated==null)
                Allocated="0.00";

            remaining=Double.parseDouble(Allocated) - 
                     (Double.parseDouble(dblUtilisedAmount) + Double.parseDouble(dblReservedAmount));

            totRemaning+=remaining;
            totAllocated+=Double.parseDouble(Allocated);
            totResearved+=Double.parseDouble(dblReservedAmount);
            totUtilized+=Double.parseDouble(dblUtilisedAmount);
%>

<tr class="link" bgcolor="#FFFFFF"> 
<td width="4%" height="20"><div align="center"><%=indx%></div></td>
<td width="16%" align="left"><%=sname%></td>
<td width="18%" align="left"><%=departMent%></td>
<td width="13%" align="right"><%=Allocated%></td>
<td width="12%" align="right"><%=d.format(Double.parseDouble(dblUtilisedAmount))%></td>
<td width="17%" align="right"><%=d.format(Double.parseDouble(dblReservedAmount))%></td>
<td width="20%" align="right"><%=d.format(remaining)%></td>
</tr>

<%
        }
    }
}
}
%>		

		  <tr  class="link"  bgcolor="#FFFFFF"> 
				<td colspan="7" height="20" > <div align="left">Non Recurring</div></td>
	  </tr>
      <%
if(data1!=null && data1.size()>0){

    Iterator groupItr = data1.keySet().iterator();

    while(groupItr.hasNext()){

        String grpId = (String)groupItr.next();
        HashMap groupData = (HashMap)data1.get(grpId);

        if(groupData!=null && groupData.size()>0){

            HashMap firstRow = (HashMap)groupData.get("0");
            String grpName = (String)firstRow.get("strBudgroupNm");
%>

<tr bgcolor="#FFFFFF">
<td colspan="7"><b><%=grpName%></b></td>
</tr>

<%
        Iterator rowItr = groupData.keySet().iterator();

        while(rowItr.hasNext()){

            String key = (String)rowItr.next();
            HashMap hmt = (HashMap)groupData.get(key);

            double remaining=0;

            String hid=(String)hmt.get("HeadId");
            String sname=(String)hmt.get("strName");
            String Allocated=(String)hmt.get("dblAmount");
            String departMent=(String)hmt.get("strDepartmentNm");
            String dblUtilisedAmount=(String)hmt.get("dblUtilisedAmount");
            String dblReservedAmount=(String)hmt.get("dblReservedAmount");

            indx++;

            if(Allocated==null)
                Allocated="0.00";

            remaining=Double.parseDouble(Allocated) - 
                     (Double.parseDouble(dblUtilisedAmount) + Double.parseDouble(dblReservedAmount));

            totRemaning+=remaining;
            totAllocated+=Double.parseDouble(Allocated);
            totResearved+=Double.parseDouble(dblReservedAmount);
            totUtilized+=Double.parseDouble(dblUtilisedAmount);
%>

<tr class="link" bgcolor="#FFFFFF"> 
<td width="4%" height="20"><div align="center"><%=indx%></div></td>
<td width="16%" align="left"><%=sname%></td>
<td width="18%" align="left"><%=departMent%></td>
<td width="13%" align="right"><%=Allocated%></td>
<td width="12%" align="right"><%=d.format(Double.parseDouble(dblUtilisedAmount))%></td>
<td width="17%" align="right"><%=d.format(Double.parseDouble(dblReservedAmount))%></td>
<td width="20%" align="right"><%=d.format(remaining)%></td>
</tr>

<%
        }
    }
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
	
    </table>
    </td>		
</form>
</Body>
</HTML>

