<%@ page import="java.util.*,java.text.*" %>
<%@ include file="/jsp/adminpanel/header.jsp" %>
<%	DecimalFormat d = new DecimalFormat("##0.00");

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
String FDate=(String)request.getAttribute("FDATEi");
String TDate=(String)request.getAttribute("TDATEi");
String FDatem=(String)request.getAttribute("FDATE");
String TDatem=(String)request.getAttribute("TDATE");

int ii = Allo.size()-1;
int jj = Vouc.size()-1;
//out.println("--jj--"+Vouc.size());
String Code1="";
String Code2="";
boolean Stat=false;
double POAmt=0;

String HeadId="";
String VSUM="";
String ids="";
String POSUM="";


/*
for(int k=0;k<=ii;k++)
{
	HashMap HM = new HashMap();
	//out.println("--HM--"+HM);
	HashMap hmt = (HashMap)Allo.get(""+k);
	if(jj>0)
	{
		for(int l=0;l<=jj;l++)
		{
			HashMap hmt1 = (HashMap)Vouc.get(""+l);
			//out.println("hmt1"+hmt1);
			if(((String)hmt.get("HeadId")).equals((String)hmt1.get("HeadId")))
			{
				//out.println("hmt1"+hmt1);
				Stat= true;
				HashMap Hmrr=(HashMap)hmt1.get("rr");
				//out.println("--Hmrr--"+Hmrr);
				HeadId=(String)hmt1.get("HeadId");
				VSUM=(String)hmt1.get("VSUM");
				//VSUM=(String)hmt1.get("VSUM");
				//out.println("VSUM"+VSUM);
				POSUM=(String)Hmrr.get("POAmt");
				//out.println("POSUM"+POSUM);
				ids=(String)hmt1.get("tds");
				
				
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
	//out.println("--HMFinal--"+HMFinal);
	Stat=false;
} commented by ravi  */ 

///*out.println("Allo-->"+Allo);
//out.println("------------------------------");
//out.println("<BR>Vouc -->"+Vouc);
//out.println("------------------------------");
//out.println("<BR>Final -->"+HMFinal);*/

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
    case 0:
	document.HeadList.id.value = "0";
	document.HeadList.action = "<%=strPath+"ViewRpt.do"%>";
	break;
    case 1:
	document.HeadList.action = "<%=strPath+"ViewRpt.do"%>";
	break;

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
<form name="HeadList" method="post" action="#">
    <input type="hidden" name="page" value="ParamRpt">
    <input type="hidden" name="NAV" value="">
    <input type="hidden" name="txtBGid" value="<%=strBudgroupId%>">
    <input type="hidden" name="txtBudgroupId" value="<%=strBudgroupId%>">

    <input type="hidden" name="id" value="">
    <input type="hidden" name="opr" value="">
    <input type="hidden" name="FDD" value="<%=FDatem%>">
    <input type="hidden" name="TDD" value="<%=TDatem%>">
    
    <td width="80%" valign="top" align="center">
	<table width="100%" border="0" cellspacing="1" cellpadding="1" align="center" >
      <tr bgcolor="#33CC99" class="titles"> 
        <td height="20" colspan="7" >Report For the period&nbsp;&nbsp;&nbsp; From&nbsp;&nbsp;&nbsp;<font color="330099"><%=FDate%></font> &nbsp;&nbsp;To&nbsp;&nbsp;&nbsp;<font color="#330099"><%=TDate%></font></td>
      </tr>
      <tr bgcolor="#99CCFF" class="link"> 
        <td width="5%" height="20" > <div align="center">S.No.</div></td>
        <td width="20%"  height="20" align="center">Particulars</td>
        <td width="15%"  height="20" align="center">A/c No.</td>
        <td width="25%"  height="20" align="center">Budget Allocation</td>
		 <td width="20%"  height="20" align="center">Expenditure(PO)</td>
        <td width="20%"  height="20" align="center">Expenditure(Vou)</td>
        <td width="15%"  height="20" align="center">Balance</td>
      </tr>
      <% for(int i=0;i<Allo.size();i++)
	  {
	    //out.println("--hmt--"+Allo.size());
	  	double balance=0;
	  	HashMap hmt = (HashMap)Allo.get(""+i);
		HashMap hmt1 = (HashMap)Vouc.get(""+i);
		String hid=(String)hmt.get("HeadId");
		String sname=(String)hmt.get("strName");
		String bsum=(String)hmt.get("BSUM");
		if(bsum==null)
		bsum="0.00";
		String acno=(String)hmt.get("strAccNo");
		if(acno==null)
		acno="No";
		if( hmt!=null && hmt1!=null)
		{
		 
		%>
      			<tr  class="link"  onMouseOver="this.style.backgroundColor='#cccccc'" onMouseOut="this.style.backgroundColor='<%=i%2==0?strCol2:strCol1%>' "bgcolor="<%=i%2==0?strCol2:strCol1%>"> 
        		<td width="5%" height="20" > <div align="center"><%=(i+1)%></div></td>
		        <td width="20%" align="center" height="20"><a href="javascript:setAction(1,<%=hid%>)"><%=sname%></a></td>
		        
        <td width="15%" align="center" height="20"><%=acno%></td>
		        
        <td width="25%" align="center" height="20"><%=bsum%></td>
		 <td width="15%" align="center" height="20">
		 <%	 
		 /* if(((String)hmt.get("HeadId")).equals((String)hmt1.get("HeadId")))
			{
			
				POSUM=(String)hmt1.get("POSUM");
				
				if(POSUM==null || POSUM.equals(""))
					{
						POSUM="0";
					}
					out.println(""+d.format((Double.parseDouble(POSUM))));
			
			} */
				%>
		 
		 0</td>
		        <td width="20%" align="center" height="20"> 
          		<%
			//	out.println("--hmt--"+hmt1);
			if(((String)hmt.get("HeadId")).equals((String)hmt1.get("HeadId")))
			 {
			    //	out.println("--hmt--"+hmt1);
				String bal=(String)hmt.get("BSUM");
				if(bal==null)
				 bal="0.00";
				String exp=(String)hmt1.get("VSUM");
				if(exp==null)
				 exp="0.00";
				
				String tds=(String)hmt1.get("tds");
				if(tds==null)
				 tds="0.00";
				
				/*	POSUM=(String)hmt1.get("POSUM");
					if(POSUM==null || POSUM.equals(""))
					{
						POSUM="0";
					} */			

				out.println(""+d.format((Double.parseDouble( exp )+Double.parseDouble(tds))));
				if( bal!=null )
				{
					balance=Double.parseDouble( bal );
				}					
				if( exp!=null)
				{
					balance-=(Double.parseDouble( exp )+Double.parseDouble(tds));
				}
			}
			%>
        		</td>
		        <td width="15%" align="center" height="20"><%=d.format(balance)%></td>
			</tr>
		      	<% 
		}
		else
		{
		
			
		 %>
      			<tr  class="link"  onMouseOver="this.style.backgroundColor='#cccccc'" onMouseOut="this.style.backgroundColor='<%=i%2==0?strCol2:strCol1%>' "bgcolor="<%=i%2==0?strCol2:strCol1%>"> 
        		<td width="5%" height="20" > <div align="center"><%=(i+1)%></div></td>
		        <td width="20%" align="center" height="20"><a href="javascript:setAction(1,<%=hid%>)"><%=sname%></a></td>
		        
        <td width="15%" align="center" height="20"><%=acno%></td>
		        
        <td width="25%" align="center" height="20"><%=bsum%></td>
		        <td width="20%" align="center" height="20"> 0.00</td>
				 <td width="20%" align="center" height="20"> 0.00</td>
		        <td width="15%" align="center" height="20"><%=bsum%></td>
			</tr>		
		<%
		}
	}
        //****
	%>

      <tr bgcolor="#99CCFF"> 
        <td height="20" colspan=7>&nbsp;</td>
      </tr>
      <tr> 
        <td colspan="7" valign="top" height="20" align="center">&nbsp; </td>
      </tr>
	    <tr> 
		<td colspan=6 height="20">&nbsp;</td>
	    </tr>
      
    </table>
    <input type="button" accesskey="P" name="Print" value=" Print " onClick="setAction(2,0)"> 
    <input type="button" accesskey="C" name="Close" value="Close" onClick="setAction(4,0)"> 
    </td>		
</form>
<%@ include file="/jsp/include/footer.jsp" %>
