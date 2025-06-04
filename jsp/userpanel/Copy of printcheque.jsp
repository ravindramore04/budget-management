<html>
<title></title>
<head></head>


<%@page import="java.util.*" %>
<%
	session.setAttribute("itr", "1");
	String strId = "";
	String strName = "";
	String strAccNo = "";
	String strRemark = "";
	
	String strVoucherId = "";
	String strVoucherNo = "";
	String HeadId = "";
	String dblTds = "";
	String strToAcc = "";
	String voucherNo = "";
	String amt = "";
	String dblAmount = "";
	String bMode="0";
	String Date="";
	String strAccountNo="";
	String strReceiverNm="";
	String strCheque="";
	
	HashMap hmAll=(HashMap)request.getAttribute("all"); 
	HashMap hmData=(HashMap)request.getAttribute("data"); 
	//out.print(""+hmData);
	String strAllocate = "";
	String strexp = "";
	double strBalance=0;
	
	if(hmData!=null && hmData.size()>0){
		strVoucherId = (String)hmData.get("voucherId");
		strVoucherNo = (String)hmData.get("voucherNo");
		Date = (String)hmData.get("dt");
		strAccountNo = (String)hmData.get("strAccNo");
		amt = (String)hmData.get("amt");
		dblAmount= (String)hmData.get("dblAmount");
		dblTds= (String)hmData.get("dblTds");
		strToAcc= (String)hmData.get("strToAcc");
		strReceiverNm=(String)hmData.get("strReceiverNm");
		bMode=(String)hmData.get("bMode");
		HeadId=(String)hmData.get("HeadId");
		strCheque=(String)hmData.get("strChequeNo");
		
		
	}
	String strPaymentMode="";
	if(bMode.equals("0"))
	    strPaymentMode="Cash";
	else
	    strPaymentMode="Cheque";	
//out.println(hmData);
%>
<script language="javascript">
function Num2Word(num,fmt) {
	num = Math.round(num).toString(); // round value
	if (num == 0) return 'zero';
	var wnums = [['hundred','thousand','million','billion','trillion','zillion'],['one','first','ten','','th'],['two','second','twen',0,0],['three','third','thir',0,0],['four','fourth',0,0,0],['five','fifth','fif',0,0],['six','sixth',0,0,0],['seven','seventh',0,0,0],['eight','eighth','eigh',0,0],['nine','ninth',0,0,0],['ten',],['eleven',],['twelve','twelfth'],['thirteen',],['fourteen',],['fifteen',],['sixteen',],['seventeen',],['eighteen',],['nineteen',]];
	var dot = (num.length % 3) ? num.length % 3 : 3;
	var sets = Math.ceil(num.length/3);
	var rslt = '';
	for (var i = 0; i < sets; i++) {
		var subt = num.substring((!i) ? 0 : dot + (i - 1) * 3,(!i) ? dot : dot + i * 3);
		if (subt != 0){
			var hdec = (subt.length > 2) ? subt.charAt(0) : 0;
			var ddec = subt.substring(Math.max(subt.length - 2,0),subt.length);
			var odec = subt.charAt(subt.length - 1);
			if (hdec != 0) rslt += ' ' + wnums[hdec][0] + '-hundred ' + ((fmt && ddec == 0) ? 'th' : '');
			if (ddec < 20 && 9 < ddec) {
				rslt += ' ' + ((fmt) ? ((wnums[ddec][1]) ? wnums[ddec][1] : wnums[ddec][0] + 'th') : wnums[ddec][0]);
			} else {
				if ((0 < hdec || 1 < sets) && i + 1 == sets && 0 < ddec && ddec < 10) rslt += 'and ';
				if (19 < ddec) rslt += wnums[ddec.charAt(0)][(wnums[ddec.charAt(0)][2]) ? 2 : 0] + ((i + 1 == sets && odec == 0 && fmt) ? 'tieth' : 'ty') + ((0 < odec) ? '-' : ' ');
				if (0 < odec) rslt += wnums[odec][(i + 1 == sets && fmt) ? 1 : 0];
			}

			if (i + 1 < sets) rslt += ' ' + wnums[0][sets - i - 1] + ' ';
		} else if (i + 1 == sets && fmt) {
				rslt += 'th'; // add cardinal "th"
		}
	}
	return rslt
}
	function setAction(){
		document.chqprn.action ="/budget-management/ChqPrint.do";
		document.chqprn.submit();
	}
  
</script>
<body >  <!-- onLoad="javacript:print();setAction()" -->
<td width="90%" align="top">
<form name="chqprn">
<BR><BR><BR><BR><BR><BR><BR><BR><BR>
   	<table width="100%" border="1" cellspacing="1" cellpadding="1" align="center" >
		<tr> 
			<td width="30%" class="innertitle" align="left"></td>
			<td width="20%" align="left"></td>
			<td width="20%" class="innertitle" align="left"></td>
			<td width="30%" align="right"><%=Date%></td>
		</tr>
		<tr> 
			<td width="10%" class="innertitle" align="left"></td>
			<td width="10%" align="right">
		<%
		    if(hmAll!=null && hmAll.size()>0)
		    {
			for(int indx=0;indx<hmAll.size();indx++)
			{
			    HashMap hmt = (HashMap)hmAll.get(""+indx);
			    String strTempId = (String)hmt.get("HeadId");
			    String strTempName = (String)hmt.get("strName");
					strAllocate= (String)hmt.get("allocate");
					strexp= (String)hmt.get("exp");
					strBalance=Double.parseDouble(strAllocate)-Double.parseDouble(strexp);
			    if(HeadId.equals(strTempId))
			    {
		%>                                     
				<%=strTempName%>
				
		  	    <%
			    }
			}
		    }
		            %>
			    
				</td>
			<tr> 
				<td colspan=4>&nbsp;</td>
	        </tr>
						
			<tr> 
					
				<td align="center" class="innertitle">   </td>
				<td colspan=3 class="innertitle" align="center"> 
					<Script language="JavaScript">
					document.write(Num2Word(<%=dblAmount%>));
				</Script>
				</td>
			</tr>
				
			<tr> 
				<td colspan=4>&nbsp;</td>
	        </tr>		  
	    <tr> 
		<td width="30%" class="innertitle" align="left"></td>
		<td width="20%" align="left"> </td>
		<td width="20%" class="innertitle" align="left"></td>
		<td width="30%" align="right" valign="top"><%=dblAmount%></td>
        </tr>
	
				
	</form>
</body></html>