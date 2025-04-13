<%@ page import="java.util.*,java.text.*" %>
<%
DecimalFormat d = new DecimalFormat("##0.00");
String strPath="/budget0.1/";
int PG=1;
String Date="";
String type="";
double MyBal=0;
int VouNo=0;
HashMap hm=new HashMap();
HashMap hm1=new HashMap();
HashMap hmAmt=new HashMap();
HashMap hmVot=new HashMap();
HashMap hmBal=new HashMap();
HashMap hmFin=new HashMap();
HashMap hmVoct=new HashMap();
HashMap hmAmount=new HashMap();
HashMap FinalTest=new HashMap();

hm=(HashMap)request.getAttribute("Amount");
hm1=(HashMap)request.getAttribute("Voucher");
FinalTest = (HashMap)request.getAttribute("MyHead");
//out.println(FinalTest);
String rd=(String)request.getAttribute("rd");
if(rd.equals("1"))
{ 
  type="CASH";
 }else{
   type="CHEQUE";
    }
String strBudgroupId="";
if(FinalTest!=null && FinalTest.size()>0){
HashMap hmt=(HashMap)FinalTest.get(""+0);
	strBudgroupId=(String)hmt.get("strBudgroupId");
	}

hmFin=(HashMap)FinalTest.get("0");

if(hm!=null && hm.size()>0)
{
	hmAmt=(HashMap)hm.get("AlloAmont");
	hmBal=(HashMap)hm.get("bal");
}
if(hm1!=null && hm1.size()>0)
{
	hmVot=(HashMap)hm1.get("voucher");
}

String bal="";
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
  <!--<Body onLoad="javascript:print();setAction(4,0)">-->
<form name="HeadList" method="post" action="#">
    
    <input type="hidden" name="page" value="ParamRpt">
    <input type="hidden" name="NAV" value="">
    <input type="hidden" name="id" value="">
    <input type="hidden" name="opr" value="">
  <input type="hidden" name="txtBGid" value="<%=strBudgroupId%>">
  <td width="80%" valign="top" align="center">
  
    <Center><strong>Maharashtra Academy of Engineering, Alandi Pune</strong> <strong><BR>
  	  Budget Status</strong></center>
  	  
	<table width="100%" border="1" align="center" cellpadding="0" cellspacing="0" bgcolor="#666666" >
      <tr bgcolor="#FFFFFF"> 
        <td height="20" colspan="5" > <div align="left" class="titles"><strong>Expense 
            Head-<%=(String)hmFin.get("strName")%> &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;<%=type%></strong></div></td>
         <td align="right">Page No. <%=PG%></td>
      </tr>
      <tr>
	    <td width="10%" height="20" align="center" bgcolor="#FFFFFF" class="link"><strong>Vouch 
          No</strong></td> 
        <td width="13%" height="20" align="center" bgcolor="#FFFFFF" class="link"><strong>Date</strong></td>
        <td width="14%" height="20" align="left" bgcolor="#FFFFFF" class="link"> 
          <div align="center"><strong>Allocation</strong></div></td>
        <td width="28%" height="20" align="left" bgcolor="#FFFFFF" class="link"> 
          <div align="center"><strong>Receiver Name</strong></div></td>
        <td width="15%" height="20" align="left" bgcolor="#FFFFFF" class="link"> 
          <div align="center"><strong>Expense Made</strong></div></td>
        <td width="20%" height="20" align="left" bgcolor="#FFFFFF" class="link"> 
          <div align="center"><strong>Balance</strong></div></td>
      </tr>
      <%
      	int K=1;
	  if(hmAmt!=null && hmAmt.size()>0){
	  for(int i=0;i<hmAmt.size();i++)
	  {
	  	hmAmount=(HashMap)hmAmt.get(""+i);
		String balance="";
		if(i>0){
		balance="";
		}else
		{
		balance=(String)hmBal.get("dblBalance");
		bal=(String)hmBal.get("dblBalance");
		}
		
		//******************************************************
		MyBal +=Double.parseDouble( (String)hmAmount.get("dblAmount")); 
		//******************************************************
		alloc+=Double.parseDouble( (String)hmAmount.get("dblAmount"));
		Date = ((String)hmAmount.get("Dt")).substring(8,10)+"-"+((String)hmAmount.get("Dt")).substring(5,7)+"-"+((String)hmAmount.get("Dt")).substring(0,4);
		/*strYY=strDt.substring(0,4);
		strMM=strDt.substring(5,7);
		strDD=strDt.substring(8,10)*/

	  %>
      <tr bgcolor="">
	    <td height="40" align="center" bgcolor="#FFFFFF" class="link">&nbsp;</td>  
        <td height="40" align="center" bgcolor="#FFFFFF" class="link"><%=Date%></td>
        <td height="40" align="Right" bgcolor="#FFFFFF" class="link" > <%=(String)hmAmount.get("dblAmount")%></td>
        <td height="40" align="Right" bgcolor="#FFFFFF" class="link">&nbsp; <div align="center"> 
        <td height="40" align="Right" bgcolor="#FFFFFF" class="link">&nbsp; <div align="center"> 
          </div></td>
        <!--  <td align="left" class="link" height="20" bgcolor="#FFCC99"><%=balance%></td>  -->
        <td height="40" align="Right" bgcolor="#FFFFFF" class="link"><%=d.format(MyBal)%></td>
      </tr>
      <%
      //*************************************************************
      	K++;
      if(K>20)
      	{	
      		K=1; 
      		PG++;
      		%>
      		
      		</Table>
      		<br>
      		<Center><strong>Maharashtra Academy of Engineering, Alandi Pune</strong> <strong><BR>
		  	  Budget Status</strong></center>
		  	  
			<table width="100%" border="1" align="center" cellpadding="0" cellspacing="0" bgcolor="#666666" >
		      <tr bgcolor="#FFFFFF"> 
		        <td height="20" colspan="5" > <div align="left" class="titles"><strong>Expense 
		            Head-<%=(String)hmFin.get("strName")%>  &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;<%=type%> </strong></div></td>
			     <Td align="right">Page No.<%=PG%></td>
		      </tr>
		      <tr>
			  <td width="10%" height="20" align="center" bgcolor="#FFFFFF" class="link"><strong>Vouch No</strong></td> 
		        <td width="10%" height="20" align="center" bgcolor="#FFFFFF" class="link"><strong>Date</strong></td>
		        <td width="12%" height="20" align="left" bgcolor="#FFFFFF" class="link"> 
		          <div align="center"><strong>Allocation</strong></div></td>
		        <td width="26%" height="20" align="left" bgcolor="#FFFFFF" class="link"> 
		          <div align="center"><strong>Receiver Name</strong></div></td>
		        <td width="13%" height="20" align="left" bgcolor="#FFFFFF" class="link"> 
		          <div align="center"><strong>Expense Made</strong></div></td>
		        <td width="13%" height="20" align="left" bgcolor="#FFFFFF" class="link"> 
		          <div align="center"><strong>Balance</strong></div></td>
      			</tr
      //*************************************************************>
   <%   			
      	}
	  }
	  	
	  }
	  %>
      <%
	  if(hmVot!=null && hmVot.size()>0)
	  {
	 
	    for(int j=0;j<hmVot.size();j++)
		{
			hmVoct=(HashMap)hmVot.get(""+j);
			//System.out.println(j+"  hmAmt   "+hmVot.size());
			//System.out.println("hmAmt   "+hmVot);
			exp+=(Double.parseDouble( (String)hmVoct.get("dblAmount") )+Double.parseDouble((String)hmVoct.get("dblTds")));
			MyBal-=(Double.parseDouble( (String)hmVoct.get("dblAmount") )+Double.parseDouble((String)hmVoct.get("dblTds")));
			Date = ((String)hmVoct.get("dt")).substring(8,10)+"-"+((String)hmVoct.get("dt")).substring(5,7)+"-"+((String)hmVoct.get("dt")).substring(0,4);
			 VouNo++;
	  %>
      <tr bgcolor="">
	    <td height="40" align="center" bgcolor="#FFFFFF" class="link"><%=VouNo%></td> 
        <td height="40" align="center" bgcolor="#FFFFFF" class="link"><%=Date%></td>
        <td height="40" align="Right" bgcolor="#FFFFFF" class="link">&nbsp; </td>
        <td height="40" align="Left" bgcolor="#FFFFFF" class="link"><%=(String)hmVoct.get("strReceiverNm")%></td>
        <td height="40" align="Right" bgcolor="#FFFFFF" class="link"> 
            <%=(Double.parseDouble( (String)hmVoct.get("dblAmount") )+Double.parseDouble((String)hmVoct.get("dblTds")))%>0</td>
        <td height="40" align="Right" bgcolor="#FFFFFF" class="link"> <%=d.format(MyBal)%></td>
      </tr>
      <%
        K++;
      	if(K>20)
      	{
		K=1; 
		PG++;
		%>

		</Table>
		<br>
		<Center><strong>Maharashtra Academy of Engineering, Alandi Pune</strong> <strong><BR>
			  Budget Status</strong></center>

			<table width="100%" border="1" align="center" cellpadding="0" cellspacing="0" bgcolor="#666666" >
		      <tr bgcolor="#FFFFFF"> 
			<td height="20" colspan="5" > <div align="left" class="titles"><strong>Expense 
            Head-<%=(String)hmFin.get("strName")%>  &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;<%=type%></strong></div></td>
			     <Td align="right">Page No.<%=PG%></td>
		      </tr>
		      <tr>
			<td width="10%" height="20" align="center" bgcolor="#FFFFFF" class="link"><strong>Vouch No</strong></td>   
			<td width="10%" height="20" align="center" bgcolor="#FFFFFF" class="link"><strong>Date</strong></td>
			<td width="12%" height="20" align="left" bgcolor="#FFFFFF" class="link"> 
			  <div align="center"><strong>Allocation</strong></div></td>
			<td width="26%" height="20" align="left" bgcolor="#FFFFFF" class="link"> 
			  <div align="center"><strong>Receiver Name</strong></div></td>
			<td width="13%" height="20" align="left" bgcolor="#FFFFFF" class="link"> 
			  <div align="center"><strong>Expense Made</strong></div></td>
			<td width="13%" height="20" align="left" bgcolor="#FFFFFF" class="link"> 
			  <div align="center"><strong>Balance</strong></div></td>
			</tr

      	
      	
	      	><%
      		}
		}
		}
		%>
      <tr class="link">
	    <td height="40" bgcolor="#FFFFFF">&nbsp;</td> 
        <td height="40" bgcolor="#FFFFFF">&nbsp;</td>
        <td height="40" bgcolor="#FFFFFF">&nbsp;</td>
        <td height="40" bgcolor="#FFFFFF">&nbsp;</td>
        <td height="40" bgcolor="#FFFFFF">&nbsp;</td>
        <td height="40" bgcolor="#FFFFFF">&nbsp;</td>
      </tr>
      <tr class="link" >
	    <td height="40" align="center" bgcolor="#FFFFFF"><strong>Total</strong></td> 
        <td height="40" align="center" bgcolor="#FFFFFF"><strong></strong></td>
        <td height="40" align="Right" bgcolor="#FFFFFF"><strong><%=d.format(alloc)%></strong></td>
        <td height="40" align="center" bgcolor="#FFFFFF">&nbsp;</td>
        <td height="40" align="Right" bgcolor="#FFFFFF"><strong><%=exp%>0</strong></td>
        <td height="40" align="Right" bgcolor="#FFFFFF"><strong><%=d.format(MyBal)%></strong></td>
      </tr>
    </table>
    <!-- <input type="submit" accesskey="P" name="Print" value=" Print " onClick="setAction(2,<%=(String)hmBal.get("HeadId")%>)"> -->
    <!-- <input type="submit" accesskey="C" name="Close" value="Close" onClick="setAction(4,0)"> -->

    </td>	

</form>
</Body>