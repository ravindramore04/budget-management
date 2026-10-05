<!-- JSP File: viewAllReport.jsp -->
<%@ page import="java.util.*,java.text.*" %>
<%@ include file="/jsp/adminpanel/header.jsp" %>

<%	DecimalFormat d = new DecimalFormat("##0.00");

Calendar cal = Calendar.getInstance();
    int year  = cal.get(Calendar.YEAR);
    int month = cal.get(Calendar.MONTH) + 1;
    int day   = cal.get(Calendar.DAY_OF_MONTH);
    String today = String.format("%04d-%02d-%02d", year, month, day);

String strBudgroupId="";
HashMap data=(HashMap)request.getAttribute("data");
//out.println("data"+data); //{dblAmount=115000.00, AllocId=100007, strDepartmentNm=Computer Application, HeadId=100004, dblReservedAmount=0.00, dblUtilisedAmount=0.00, strName=Research Expenses}

HashMap data1=(HashMap)request.getAttribute("data1");
//out.println("data1"+data1);
HashMap OthersGrp=(HashMap)request.getAttribute("OthersGrp");


String fromDate=(String)request.getAttribute("fromDate");
String toDate=(String)request.getAttribute("toDate");

//out.println("fromDate"+fromDate);
//out.println("toDate"+toDate);



HashMap Allo=new HashMap();
HashMap Vouc=new HashMap();
	
//out.println("Recurring  >>"+Allo);

//out.println("Non Recurring  >>"+Vouc);
HashMap HMFinal=new HashMap();


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
        <td height="20" colspan="2" >Report</font></td>
      <td colspan="5" align="center">
        <label for="fromDate" class="innertitle">From Date:</label>
        <input type="date" class="formfield" id="fromDate" name="fromDate" value="<%=fromDate%>" />
        &nbsp;&nbsp;
        <label for="toDate" class="innertitle">To Date:</label>
        <input type="date" class="formfield" id="toDate" name="toDate" value="<%=toDate%>" />
		
		 <input type="button" accesskey="P" name="Submit" value=" Submit " onClick="setAction(1,0)"> 
      </td>
  
      </tr>
      <tr bgcolor="#99CCFF" class="link"> 
        <td width="4%" height="20" > <div align="center">S.No.</div></td>
        <td width="16%"  height="20" align="center">Head Name</td>
		<td width="18%"  height="20" align="center">Department</td>
        <td width="13%"  height="20" align="center">Budget Allocation</td>
		 <td width="12%"  height="20" align="center">Utilized</td>
        <td width="17%"  height="20" align="center">PO/Reserved(In Process)</td>
        <td width="20%"  height="20" align="center">Remaning</td>
      </tr>
	  <tr  class="link"  bgcolor="#cccccc"> 
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

<tr bgcolor="#999999">
<td colspan="7"><b><%=grpName%></b></td>
</tr>

<%
        Iterator rowItr = groupData.keySet().iterator();

        while(rowItr.hasNext()){

            String key = (String)rowItr.next();
            HashMap hmt = (HashMap)groupData.get(key);

            double remaining=0.00;
			double reserved=0.00;
            String sname=(String)hmt.get("strName");
            String Allocated=(String)hmt.get("dblAmount");
            String departMent=(String)hmt.get("strDepartmentNm");
            String dblUtilisedAmount=(String)hmt.get("dblUtilisedAmount");
            String dblReservedAmount=(String)hmt.get("dblReservedAmount");
			String remainingAmt=(String)hmt.get("Remaining");
			String budget_note_amt_tot=(String)hmt.get("Budget_Note_Amount");
            //out.print(dblUtilisedAmount);
            indx++;

            if(Allocated==null)
                Allocated="0.00";

            remaining=Double.parseDouble(remainingAmt);//Double.parseDouble(Allocated) - (Double.parseDouble(dblUtilisedAmount) + Double.parseDouble(dblReservedAmount));
            reserved=(Double.parseDouble(budget_note_amt_tot)) - (Double.parseDouble(dblUtilisedAmount));
            totRemaning+=remaining;
            totAllocated+=Double.parseDouble(Allocated);
            totResearved+=reserved;
            totUtilized+=Double.parseDouble(dblUtilisedAmount);
%>

<tr class="link" bgcolor="#cccccc"> 
<td width="4%" height="20"><div align="center"><%=indx%></div></td>
<td width="16%" align="left"><%=sname%></td>
<td width="18%" align="left"><%=departMent%></td>
<td width="13%" align="right"><%=Allocated%></td>
<td width="12%" align="right"><%=d.format(Double.parseDouble(dblUtilisedAmount))%></td>
<td width="17%" align="right"><%//=d.format(reserved)%></td>
<td width="20%" align="right"><%=d.format(remaining)%></td>
</tr>

<%
        }
    }
}
}
%>
	
	
	
		  <tr  class="link"  bgcolor="#cccccc"> 
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

<tr bgcolor="#999999">
<td colspan="7"><b><%=grpName%></b></td>
</tr>

<%
        Iterator rowItr = groupData.keySet().iterator();

        while(rowItr.hasNext()){

            String key = (String)rowItr.next();
            HashMap hmt = (HashMap)groupData.get(key);

            double remaining=0;
            double reserved=0.00;
            //String hid=(String)hmt.get("HeadId");
            String sname=(String)hmt.get("strName");
            String Allocated=(String)hmt.get("dblAmount");
            String departMent=(String)hmt.get("strDepartmentNm");
            String dblUtilisedAmount=(String)hmt.get("dblUtilisedAmount");
            String dblReservedAmount=(String)hmt.get("dblReservedAmount");
            String remainingAmt=(String)hmt.get("Remaining");
			String budget_note_amt_tot=(String)hmt.get("Budget_Note_Amount");
            //out.print(dblUtilisedAmount);
            indx++;

            if(Allocated==null)
                Allocated="0.00";

            remaining=Double.parseDouble(remainingAmt);//Double.parseDouble(Allocated) - (Double.parseDouble(dblUtilisedAmount) + Double.parseDouble(dblReservedAmount));
            reserved=(Double.parseDouble(budget_note_amt_tot)) - (Double.parseDouble(dblUtilisedAmount));
            totRemaning+=remaining;
            totAllocated+=Double.parseDouble(Allocated);
            totResearved+=reserved;
            totUtilized+=Double.parseDouble(dblUtilisedAmount);
%>

<tr class="link" bgcolor="#cccccc"> 
<td width="4%" height="20"><div align="center"><%=indx%></div></td>
<td width="16%" align="left"><%=sname%></td>
<td width="18%" align="left"><%=departMent%></td>
<td width="13%" align="right"><%=Allocated%></td>
<td width="12%" align="right"><%=d.format(Double.parseDouble(dblUtilisedAmount))%></td>
<td width="17%" align="right"><%//=d.format(reserved)%></td>
<td width="20%" align="right"><%=d.format(remaining)%></td>
</tr>

<%
        }
    }
}
}
%>


		  <tr  class="link"  bgcolor="#cccccc"> 
				<td colspan="7" height="20" > <div align="left">Others Group</div></td>
	  </tr>
      <%
if(OthersGrp!=null && OthersGrp.size()>0){

    Iterator groupItr = OthersGrp.keySet().iterator();

    while(groupItr.hasNext()){

        String grpId = (String)groupItr.next();
        HashMap groupData = (HashMap)OthersGrp.get(grpId);

        if(groupData!=null && groupData.size()>0){

            HashMap firstRow = (HashMap)groupData.get("0");
            String grpName = (String)firstRow.get("strBudgroupNm");
%>

<tr bgcolor="#999999">
<td colspan="7"><b><%=grpName%></b></td>
</tr>

<%
        Iterator rowItr = groupData.keySet().iterator();

        while(rowItr.hasNext()){

            String key = (String)rowItr.next();
            HashMap hmt = (HashMap)groupData.get(key);

            double remaining=0;
            double reserved=0.00;
            //String hid=(String)hmt.get("HeadId");
            String sname=(String)hmt.get("strName");
            String Allocated=(String)hmt.get("dblAmount");
            String departMent=(String)hmt.get("strDepartmentNm");
            String dblUtilisedAmount=(String)hmt.get("dblUtilisedAmount");
            String dblReservedAmount=(String)hmt.get("dblReservedAmount");
            String remainingAmt=(String)hmt.get("Remaining");
			String budget_note_amt_tot=(String)hmt.get("Budget_Note_Amount");
            //out.print(dblUtilisedAmount);
            indx++;

            if(Allocated==null)
                Allocated="0.00";

            remaining=Double.parseDouble(remainingAmt);//Double.parseDouble(Allocated) - (Double.parseDouble(dblUtilisedAmount) + Double.parseDouble(dblReservedAmount));
            reserved=(Double.parseDouble(budget_note_amt_tot)) - (Double.parseDouble(dblUtilisedAmount));
            totRemaning+=remaining;
            totAllocated+=Double.parseDouble(Allocated);
            totResearved+=reserved;
            totUtilized+=Double.parseDouble(dblUtilisedAmount);
%>

<tr class="link" bgcolor="#cccccc"> 
<td width="4%" height="20"><div align="center"><%=indx%></div></td>
<td width="16%" align="left"><%=sname%></td>
<td width="18%" align="left"><%=departMent%></td>
<td width="13%" align="right"><%=Allocated%></td>
<td width="12%" align="right"><%=d.format(Double.parseDouble(dblUtilisedAmount))%></td>
<td width="17%" align="right"><%//=d.format(reserved)%></td>
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
		<td width="17%" align="right" height="20"><%//=d.format(totResearved)%></td>
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