<html><%@page import="java.util.*" %>
<%
	session.setAttribute("itr", "1");
	String strId = "";
	String strName = "";
	String strAccNo = "";
	String strRemark = "";
	
	String strVoucherId = "";
	String strVoucherNo = "";
	String HeadId = "";
	double dblTds = 0;
	String strToAcc = "";
	String voucherNo = "";
	String amt = "";
	double dblAmount = 0;
	String bMode="0";
	String Date="";
	String strAccountNo="";
	String strReceiverNm="";
	String strCheque="";
	
	HashMap hmAll=(HashMap)request.getAttribute("all"); 
	HashMap hmData=(HashMap)request.getAttribute("data"); 
	
	String strAllocate = "";
	String strexp = "";
	double strBalance=0;
	
	if(hmData!=null && hmData.size()>0){
		strVoucherId = (String)hmData.get("voucherId");
		strVoucherNo = (String)hmData.get("voucherNo");
		Date = (String)hmData.get("dt");
		strAccountNo = (String)hmData.get("strAccNo");
		amt = (String)hmData.get("amt");
		dblAmount= Double.parseDouble((String)hmData.get("dblAmount"));
		dblTds= Double.parseDouble((String)hmData.get("dblTds"));
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

function setAction(code){
document.abc.action ="/budget-management/VoucherPrint.do";
document.abc.submit();
}
    
</script>
<body onLoad="javascript:print();setAction()">
<form name="abc" method ="post" action="#">
	<input type="hidden" name="id" value="<%=strVoucherId%>">
	<input type="hidden" name="bMode" value="<%=bMode%>">
</form>
<td width="80%" valign="top">
   <form name="BudgetHead" method="post" action="PrintOpenVoucher.do">
   <input type="hidden" name="page" value="VoucherList">
	<table width="100%" border="0" cellspacing="1" cellpadding="1" align="center" >
		<tr> 
			<td colspan=4>&nbsp;</td>
		</tr>
		<tr> 
			<td colspan=4>&nbsp;</td>
		</tr>
		<tr> 
			<td colspan=4>&nbsp;</td>
		</tr>
		<tr> 
			<td width="10%" class="innertitle" align="left">&nbsp;</td>
			<td width="40%" align="left">&nbsp;</td>
			<td width="20%" class="innertitle" align="left">&nbsp;</td>
			<td width="30%" align="right" valign="top"><%=strVoucherNo%></td>
		</tr>
		<tr> 
			<td colspan=4>&nbsp;</td>
		</tr>
		<tr> 
			<td class="innertitle" align="left">&nbsp;</td>
			<td align="left">&nbsp;</td>
			<td class="innertitle" align="left">&nbsp;</td>
			<td align="right" valign="bottom"><font face="Georgia, Times, serif" size="3"> <%=Date%></font></td>
		</tr>
		<tr> 
			<td colspan=4>&nbsp;</td>
		</tr>
		<tr> 
			<td colspan=4>&nbsp;</td>
		</tr>
		<tr> 
			<td colspan=4>&nbsp;</td>
		</tr>
		<tr> 
			<td class="innertitle" align="left">&nbsp;</td>
			<td align="left" valign="bottom"><font face="Georgia, Times, serif" size="3">
			   			<%
				    if(hmAll!=null && hmAll.size()>0){
				    	for(int indx=0;indx<hmAll.size();indx++){
				    	    HashMap hmt = (HashMap)hmAll.get(""+indx);
				    	    String strTempId = (String)hmt.get("HeadId");
				    	    String strTempName = (String)hmt.get("strName");
							strAllocate= (String)hmt.get("allocate");
							strexp= (String)hmt.get("exp");
							strBalance=Double.parseDouble(strAllocate)-Double.parseDouble(strexp);
				    	    if(HeadId.equals(strTempId)){
							%>
				    	          <%=strTempName%>
				
				    	    <%
							}
				    	}
				    }
				%>
			</font>
			</td>
			<td align="left" colspan=2 valign="bottom"><font face="Georgia, Times, serif" size="3"><%=strAccountNo%></font></td>

		</tr>
		<tr> 
			<td colspan=4>&nbsp;</td>
		</tr>
		<tr> 
			<td colspan=4>&nbsp;</td>
		</tr>
		<tr> 
			<td class="innertitle" align="left" height="50">&nbsp;</td>
			<td align="left">&nbsp;</td>
			<td align="Right" valign="bottom">Amount&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
			<td align="left" valign="bottom"><font face="Georgia, Times, serif" size="3">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <%=dblAmount+dblTds%></font></td>
		</tr>
		<tr> 
			<td class="innertitle" align="left">&nbsp;</td>
			<td align="left">&nbsp;</td>
			<td align="Right" valign="top">TDS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
			<td align="left" valign="top"><font face="Georgia, Times, serif" size="3">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=dblTds%></font></td>
		</tr>
		<tr> 
			<td class="innertitle" align="left">&nbsp;</td>
			<td align="left">&nbsp;</td>
			<td align="Right" valign="bottom">&nbsp;</td>
			<td align="left" valign="bottom"><font face="Georgia, Times, serif" size="3">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <%=dblAmount%></font></td>
		</tr>
		<tr> 
			<td align="left">&nbsp;</td>
			<td align="left" colspan=3><font face="Georgia, Times, serif" size="3">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<Script language="JavaScript">
				document.write(Num2Word(<%=dblAmount%>));
			</Script></font>
			</td>
		</tr>
		<tr> 
			<td colspan=4>&nbsp;</td>
		</tr>
		<tr> 
			<td align="left">&nbsp;</td>
			<td align="left" colspan=3><font face="Georgia, Times, serif" size="3">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=strToAcc%></font></td>
		</tr>
		<tr> 
			<td colspan=4>&nbsp;</td>
		</tr>
		<tr> 
			<td colspan=4>&nbsp;</td>
		</tr>
		<tr> 
			<td colspan=4>&nbsp;</td>
		</tr>
		<tr> 
			<td align="left">&nbsp;</td>
			<td align="left" colspan=3>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=bMode.equals("0")?"Cash": "Cheque ("+strCheque+")"%></td>
		</tr>
		<tr> 
			<td colspan=4>&nbsp;</td>
		</tr>
		<tr> 
			<td align="left">&nbsp;</td>
			<td align="left" colspan=3>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=strReceiverNm%></td>
		</tr>
	</table>
	</form>
</td>
</body>
</html>