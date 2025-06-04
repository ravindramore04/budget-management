<%@ page import="java.util.*" %>
<%
String strPath="/budget-management/";

HashMap Allo=new HashMap();
HashMap Vouc=new HashMap();

Allo=(HashMap)request.getAttribute("Alloc");
Vouc=(HashMap)request.getAttribute("Vouch");
/*out.println(Vouc);

if(Allo!=null && Allo.size()>0)
{
	for(int indx=0;indx<Allo.size();indx++)
	{
		HashMap hmt = (HashMap)Allo.get(""+indx);
		//(String)hmt.get("strName")
		//(String)hmt.get("HeadId")
		//(String)hmt.get("strAccNo")
		//(String)hmt.get("BSUM")
	}
	for(int indx=0;indx<Vouc.size();indx++)
	{
	
		HashMap hmt1 = (HashMap)Vouc.get(""+indx);
		//(String)hmt1.get("HeadId")
		//(String)hmt1.get("VSUM")
	}
}
*/

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
            document.HeadList.action = "<%=strPath+"OpenHead.do"%>";
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
      <tr class="titles"> 
        <td width="5%" height="20" > <div align="center"><strong>S.No</strong>.</div></td>
        <td width="20%" align="center"  height="20"><strong>Particulars</strong></td>
        <td width="20%" align="center"  height="20"><strong>A/c No.</strong></td>
        <td width="20%" align="center"  height="20"><strong>Budget Allocation</strong></td>
        <td width="20%" align="center"  height="20"><strong>Expenditure</strong></td>
        <td width="15%" align="center"  height="20"><strong>Balance</strong></td>
      </tr>
      <% for(int i=0;i<Allo.size();i++)
	  {
	  		double balance=0;
	  		HashMap hmt = (HashMap)Allo.get(""+i);
			HashMap hmt1 = (HashMap)Vouc.get(""+i);
			if( hmt!=null && hmt1!=null){
		%>
      <tr  class="link"> 
        <td width="5%" height="20" > <div align="center"><%=(i+1)%></div></td>
        <td width="20%" align="center" height="20"><%=(String)hmt.get("strName")%></td>
        <td width="20%" align="center" height="20"><%=(String)hmt.get("strAccNo")%></td>
        <td width="20%" align="center" height="20"><%=(String)hmt.get("BSUM")%></td>
        <td width="20%" align="center" height="20"> 
          <%

		if(((String)hmt.get("HeadId")).equals((String)hmt1.get("HeadId")))
		{
			String bal=(String)hmt.get("BSUM");
			String exp=(String)hmt1.get("VSUM");			
			String tds=(String)hmt1.get("tds");			

				out.println((String)hmt1.get("VSUM"));
				if( bal!=null ){
					balance=Double.parseDouble( bal );
				}					
				if( exp!=null){
					balance-=Double.parseDouble( exp )+Double.parseDouble(tds);
				}
		}
		%>
        </td>
        <td width="15%" align="center" height="20"><%=balance%></td>
      </tr>
      <% }
		  } %>
    </table>
    <center>
    	<Table border="0">
	<Tr>
   	<TD><input type="button" accesskey="P" name="Print" value=" Print " onClick="javascript:print()"></TD>
   	<TD><input type="submit" accesskey="C" name="Close" value="Close" onClick="setAction(4,0)"></TD>
    	</TR>
    	</TAble>
    	</Center>
    </td>		
</form>
