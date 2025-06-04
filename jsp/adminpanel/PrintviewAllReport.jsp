<%@ page import="java.util.*,java.text.*" %>
<% DecimalFormat d = new DecimalFormat("##0.00");
String strPath="/budget-management/";
HashMap Allo=new HashMap();
HashMap Vouc=new HashMap();
HashMap HMFinal=new HashMap();

Allo=(HashMap)request.getAttribute("Alloc");
Vouc=(HashMap)request.getAttribute("Vouch");
String FDate=(String)request.getAttribute("FDATEi");
String TDate=(String)request.getAttribute("TDATEi");
String FDatem=(String)request.getAttribute("FDATE");
String TDatem=(String)request.getAttribute("TDATE");
//String as = "176542000";
//out.println(Allo);
String strBudgroupId="";
if(Allo!=null && Allo.size()>0){
	HashMap hmt=(HashMap)Allo.get(""+0);
	strBudgroupId=(String)hmt.get("strBudgroupId");
}
FDate = FDate.substring(8,10)+"-"+FDate.substring(5,7)+"-"+FDate.substring(0,4);
TDate = TDate.substring(8,10)+"-"+TDate.substring(5,7)+"-"+TDate.substring(0,4);

int ii = Allo.size()-1;
int jj = Vouc.size()-1;
String Code1="";
String Code2="";
boolean Stat=false;


String HeadId="";
String VSUM="";
String ids="";
String POSUM="";



for(int k=0;k<=ii;k++)
{
	HashMap HM = new HashMap();
	HashMap hmt = (HashMap)Allo.get(""+k);
	if(jj>0)
	{
		for(int l=0;l<=jj;l++)
		{
			HashMap hmt1 = (HashMap)Vouc.get(""+l);
			if(((String)hmt.get("HeadId")).equals((String)hmt1.get("HeadId")))
			{
				Stat= true;
				HashMap Hmrr=(HashMap)hmt1.get("rr");
				HeadId=(String)hmt1.get("HeadId");
				VSUM=(String)hmt1.get("VSUM");
				ids=(String)hmt1.get("tds");
				POSUM=(String)Hmrr.get("POAmt");
				break;
			}
			else
			{
				Stat=false;
			}
		}
	}
	if(Stat)
	{
		HM.put("HeadId",HeadId);
		HM.put("VSUM",VSUM);
		HM.put("tds",ids);
		HM.put("POSUM",POSUM);
	}
	else
	{
		HM.put("HeadId",(String)hmt.get("HeadId"));
		HM.put("VSUM","0.00");
		HM.put("tds","0.00");
		HM.put("POSUM","0.00");
	}
	HMFinal.put(""+k,HM);
	Stat=false;
}

/*out.println("Allo-->"+Allo);
out.println("------------------------------");
out.println("<BR>Vouc -->"+Vouc);
out.println("------------------------------");
out.println("<BR>Final -->"+HMFinal);*/

%>
<script language="JavaScript">
function navigation(code){
    document.HeadList.NAV.value = code;
    document.HeadList.action = "<%=strPath+"AllHead.do"%>"; 
    document.HeadList.submit();
}

function setAction(code,id){
    document.HeadList.id.value = id;
//    document.HeadList.FDD.value="<%=FDate%>";
//    document.HeadList.TDD.value ="<%=TDate%>";
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
<Body onLoad="javascript:print();setAction(4,0)">
<form name="HeadList" method="post" action="#">
    <input type="hidden" name="page" value="ParamRpt">
    <input type="hidden" name="NAV" value="">
    <input type="hidden" name="id" value="">
    <input type="hidden" name="txtBGid" value="<%=strBudgroupId%>">
    <input type="hidden" name="opr" value="">
    <input type="hidden" name="FDD" value="<%=FDatem%>">
    <input type="hidden" name="TDD" value="<%=TDatem%>">
  
  <td width="80%" valign="top" align="center">
  	<Center><strong>Maharashtra Academy of Engineering, Alandi Pune</strong> <strong><BR>
  	  Budget Status</strong></center>
  	  <div align="center">as on Date <font color="330099"><%=FDate%></font>&nbsp;&nbsp;&nbsp;To&nbsp;&nbsp;&nbsp;<font color="#330099"><%=TDate%></font></div>
	<table width="100%" border="1" align="center" cellpadding="0" cellspacing="0" bgcolor="#666666" >
      <!-- <tr height="50" bgcolor="#FFFFFF" class="titles"> 
        <td height="45" colspan="6" ></td>
        
      </tr> -->
      <tr height="50%" bgcolor="#99CCFF" class="link"> 
        <td width="5%" height="20" bgcolor="#FFFFFF" > 
<div align="center"><strong>S.No.</strong></div></td>
        <td width="36%"  height="20" align="center" bgcolor="#FFFFFF"><strong>Particulars</strong></td>
        <td width="10%"  height="20" align="center" bgcolor="#FFFFFFFF"><strong>A/c 
          No.</strong></td>
        <td width="17%"  height="20" align="center" bgcolor="#FFFFFF"><strong>Budget 
          Allocation</strong></td>
        <td width="17%"  height="20" align="center" bgcolor="#FFFFFF"><strong>Exp(po)</strong></td>
		<td width="17%"  height="20" align="center" bgcolor="#FFFFFF"><strong>Exp(vou)</strong></td>
        <td width="15%"  height="20" align="center" bgcolor="#FFFFFF"><strong>Balance</strong></td>
      </tr>
      <%
      	int j=1;
	for(int i=0;i<Allo.size();i++)
	  {
	  	j++;
	  	double balance=0;
	  	HashMap hmt = (HashMap)Allo.get(""+i);
		HashMap hmt1 = (HashMap)HMFinal.get(""+i);
		if( hmt!=null && hmt1!=null)
		{
		%>
      			<tr height="50" class="link"> 
        		
        <td width="5%" height="43" bgcolor="#FFFFFF" > 
<div align="center"><%=(i+1)%></div></td>
		        
        <td width="36%" height="40" align="left" bgcolor="#FFFFFF"><%=(String)hmt.get("strName")%></td>
		        
        <td width="10%" height="40" align="center" bgcolor="#FFFFFF"><%=(String)hmt.get("strAccNo")%></td>
		        
        <td width="17%" height="40" align="right" bgcolor="#FFFFFF"><%=(String)hmt.get("BSUM")%></td>
		        
        <td width="17%" height="40" align="right" bgcolor="#FFFFFF"> 
          <%
		   if(((String)hmt.get("HeadId")).equals((String)hmt1.get("HeadId")))
			{
			//out.println("---hmt1----ravi-"+hmt1);
			//	for(int rr=0;rr<hmt1.size();rr++)
				//{		
			//	HashMap Hmrr = (HashMap)hmt1.get("rr"+rr);
			//	out.println("---Hmrr---"+Hmrr);
				
				
				//out.println("--Hmrr--"+Hmrr);
				POSUM=(String)hmt1.get("POSUM");
				//out.println("--POSUM--"+POSUM);
				if(POSUM==null || POSUM.equals(""))
					{
						POSUM="0";
					}
					out.println(""+d.format((Double.parseDouble(POSUM))));
				//}
				
			}
			%>
        </td>
		  <td width="15%" height="43" align="right" bgcolor="#FFFFFF"><%
		  
		  
			//	out.println("--hmt--"+hmt1);
			if(((String)hmt.get("HeadId")).equals((String)hmt1.get("HeadId")))
			{
				String bal=(String)hmt.get("BSUM");
				String exp=(String)hmt1.get("VSUM");
				String tds=(String)hmt1.get("tds");
					POSUM=(String)hmt1.get("POSUM");
					if(POSUM==null || POSUM.equals(""))
					{
						POSUM="0";
					}			

				out.println(""+d.format((Double.parseDouble( exp )+Double.parseDouble(tds))));
				if( bal!=null )
				{
					balance=Double.parseDouble( bal );
				}					
				if( exp!=null)
				{
					balance-=(Double.parseDouble( exp )+Double.parseDouble(tds))+Double.parseDouble(POSUM);
				}
			}
		  
		  
		  
		  
		  
		  	  
			/*if(((String)hmt.get("HeadId")).equals((String)hmt1.get("HeadId")))
			{
				String bal=(String)hmt.get("BSUM");
				String exp=(String)hmt1.get("VSUM");
				String tds=(String)hmt1.get("tds");

				out.println(""+d.format((Double.parseDouble( exp )+Double.parseDouble(tds))));
				if( bal!=null )
				{
					balance=Double.parseDouble( bal );
				}					
				if( exp!=null)
				{
					balance-=Double.parseDouble( exp )+Double.parseDouble(tds);
				}
			}*/
		  
		  
		  
		  //=d.format(balance)%></td>       
        <td width="15%" height="43" align="right" bgcolor="#FFFFFF"><%=d.format(balance)%></td>
			</tr>
		      	<% 
		}
		else
		{%>
      			<tr height="50" class="link"> 
        		
        <td width="5%" height="40" bgcolor="#FFFFFF" > 
<div align="center"><%=(i+1)%></div></td>
		        
        <td width="36%" height="40" align="center" bgcolor="#FFFFFF"><%=(String)hmt.get("strName")%></td>
		        
        <td width="10%" height="40" align="center" bgcolor="#FFFFFF"><%=(String)hmt.get("strAccNo")%></td>
		        
        <td width="17%" height="40" align="right" bgcolor="#FFFFFF"><%=(String)hmt.get("BSUM")%></td>
		        
        <td width="17%" height="40" align="right" bgcolor="#FFFFFF"> 0.00</td>
		<td width="15%" height="43" align="right" bgcolor="#FFFFFF"><%//=d.format(balance)%></td>        
         <td width="15%" height="43" align="right" bgcolor="#FFFFFF"><%=d.format(balance)%></td>
			</tr>		
		<%
		}
	if(j> 20)
	{	
		j=1;
		%>
		</Table>
		<BR>
	<Center><strong>Maharashtra Academy of Engineering, Alandi Pune</strong> <strong><BR>
	  	  Budget Status</strong></center>
	  	  <div align="center">as on Date <font color="330099"><%=FDate%></font>&nbsp;&nbsp;&nbsp;To&nbsp;&nbsp;&nbsp;<font color="#330099"><%=TDate%></font></div>
		
    <table width="100%" border="1" align="center" cellpadding="0" cellspacing="0" bgcolor="#666666" >
      <!-- <tr height="50" bgcolor="#FFFFFF" class="titles"> 
	        <td height="45" colspan="6" ></td>
	        
	      </tr> -->
      <tr height="50%" bgcolor="#99CCFF" class="link"> 
	        <td width="5%" height="20" bgcolor="#FFFFFF" > 
	<div align="center"><strong>S.No.</strong></div></td>
	        <td width="36%"  height="20" align="center" bgcolor="#FFFFFF"><strong>Particulars</strong></td>
	        <td width="10%"  height="20" align="center" bgcolor="#FFFFFFFF"><strong>A/c 
	          No.</strong></td>
	        <td width="17%"  height="20" align="center" bgcolor="#FFFFFF"><strong>Budget 
	          Allocation</strong></td>
	        <td width="17%"  height="20" align="center" bgcolor="#FFFFFF"><strong>Expenditure</strong></td>
	        <td width="15%"  height="20" align="center" bgcolor="#FFFFFF"><strong>Balance</strong></td>
      </tr>
      <% } }
	%>
    </table>
    <!-- <input type="button" accesskey="P" name="Print" value=" Print " onClick="setAction(2,0)"> -->
    <!-- <input type="button" accesskey="C" name="Close" value="Close" onClick="setAction(4,0)"> -->
    </td>		
</form>
</Body>
</HTML>

