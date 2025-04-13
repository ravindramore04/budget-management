<%@ page import="java.util.*,java.text.*" %>
<%@ include file="/jsp/adminpanel/header.jsp" %>
<%
DecimalFormat d = new DecimalFormat("##0.00");
String Date="";
double MyBal=0;
HashMap hm=new HashMap();
HashMap hm1=new HashMap();
HashMap hmAmt=new HashMap();
HashMap hmVot=new HashMap();
HashMap hmBal=new HashMap();
HashMap hmFin=new HashMap();
HashMap hmVoct=new HashMap();
HashMap hmAmount=new HashMap();
HashMap FinalTest=new HashMap();
String strBudgroupId="";
hm=(HashMap)request.getAttribute("Amount");
//out.println("--for po--"+hm);
hm1=(HashMap)request.getAttribute("Voucher");
out.println("--->"+hm1);
FinalTest = (HashMap)request.getAttribute("MyHead");
//out.println("FinalTest>>>>>>>>>>>>>"+FinalTest);
if(FinalTest!=null && FinalTest.size()>0){
	HashMap hnb=(HashMap)FinalTest.get(""+0);
	strBudgroupId=(String)hnb.get("strBudgroupId");
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
            document.HeadList.action = "<%=strPath+"RptParam.do"%>";
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
    
    
  <td width="80%" valign="top" align="center"> <table width="100%" border="1" cellspacing="1" cellpadding="1" align="center" >
      <tr bgcolor="#3333FF"> 
        <td height="20" colspan="5" > <div align="left" class="titles">Expense 
            Head-<%=(String)hmFin.get("strName")%> </div></td>
      </tr>
      <tr bgcolor="#E6F3FF"> 
        <td width="15%" height="20" align="center" class="link">Date</td>
        <td width="11%" height="20" align="left" class="link"><div align="center">Allocation</div></td>
        <td width="25%" height="20" align="left" class="link"><div align="center">Party
            Name</div></td>
        <td width="14%" height="20" align="left" class="link"><div align="center">Expense 
            Made BY PO</div></td>
        <td width="17%" height="20" align="left" class="link"><div align="center">Expense 
            Made BY PO Number</div></td>
        <td width="18%" height="20" align="left" class="link"><div align="center">Balance</div></td>
      </tr>
      <%
      
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
        <td align="center" height="20" class="link" bgcolor="#CCFFCC"><%=Date%></td>
        <td align="left" class="link" height="20" bgcolor="#CCFFCC"><div align="center"><%=(String)hmAmount.get("dblAmount")%></div></td>
        <td align="left" class="link" height="20">&nbsp; 
        <td align="left" class="link" height="20">&nbsp; 
        <td align="left" class="link" height="20">&nbsp; <div align="center"> 
          </div></td>
        <!--  <td align="left" class="link" height="20" bgcolor="#FFCC99"><div align="center"><%=balance%></div></td>  -->
        <td align="left" class="link" height="20" bgcolor="#FFCC99"><div align="center"><%=d.format(MyBal)%></div></td>
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
			//System.out.println(j+"  hmAmt   "+hmVot.size());
			//System.out.println("hmAmt   "+hmVot);
			String strPONo=(String)hmVoct.get("nPONo");
			exp+=Double.parseDouble( (String)hmVoct.get("nAmt") );
			MyBal-=Double.parseDouble( (String)hmVoct.get("nAmt") );
			Date = ((String)hmVoct.get("POdt")).substring(8,10)+"-"+((String)hmVoct.get("POdt")).substring(5,7)+"-"+((String)hmVoct.get("POdt")).substring(0,4);
			 
	  %>
      <tr bgcolor=""> 
        <td align="center" height="20" class="link" bgcolor="#CCCCFF"><%=Date%></td>
        <td align="left" class="link" height="20" bgcolor="#CCCCFF"><div align="center">&nbsp;</div></td>
        <td align="left" class="link" height="20" bgcolor="#CCCCFF"><%=(String)hmVoct.get("Strparty")%></td>
        <td align="left" class="link" height="20" bgcolor="#CCCCFF">&nbsp; <div align="center"> 
            <%=Double.parseDouble((String)hmVoct.get("nAmt"))%>0</div></td>
        <td align="left" class="link" height="20" bgcolor="#CCCCFF"><div align="center"><%=strPONo%></div></td>
        <td align="left" class="link" height="20"><div align="center"><%=d.format(MyBal)%></div></td>
      </tr>
      <%
		}
		}
		%>
      <tr class="link"> 
        <td height="20">&nbsp;</td>
        <td height="20">&nbsp;</td>
        <td height="20">&nbsp;</td>
        <td height="20">&nbsp;</td>
        <td height="20">&nbsp;</td>
        <td height="20">&nbsp;</td>
      </tr>
      <tr class="link" > 
        <td height="20" bgcolor="#FFFFFF" align="center"><strong>Total</strong></td>
        <td height="20" bgcolor="#CCFFCC" align="center"><strong><%=d.format(alloc)%></strong></td>
        <td height="20" bgcolor="#CCCCFF" align="center">&nbsp;</td>
        <td height="20" bgcolor="#CCCCFF" align="center"><strong><%=exp%>0</strong></td>
        <td height="20" bgcolor="#FFCC99" align="center"><strong> 
          <%//=bal%>
          </strong></td>
        <td height="20" bgcolor="#FFCC99" align="center"><strong><%=bal%></strong></td>
      </tr>
    </table>
    <input type="submit" accesskey="P" name="Print" value=" Print " onClick="setAction(2,<%=(String)hmBal.get("HeadId")%>)"> 
    <input type="submit" accesskey="C" name="Close" value="Close" onClick="setAction(4,0)"> 

    </td>	

</form>
<%@ include file="/jsp/include/footer.jsp" %>
