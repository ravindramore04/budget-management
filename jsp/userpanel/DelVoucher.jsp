<%@ page import="java.util.*" %>
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
	
//out.println(bMode);
%>
<%@ include file="/jsp/userpanel/header.jsp" %>
<script language="javascript">
    function setValue(code){
    	with(document.BudgetHead){
    	    n=headlst.options.length;
    	    for(indx=0;indx<n;indx++){
    	    	if(headlst.options[indx].value==code){
    	    	    strTemp=headlst.options[indx].text;	
    	    	    mm = strTemp.split("|");
		    txtAccNo.value = mm[0];   
		    txtAllo.value = mm[1];
		    txtExp.value = mm[2];
		    txtBal.value = parseFloat(txtAllo.value)-parseFloat(txtExp.value);
    	    	}
    	    }
    	}
    }
    
    function calcAmount(){
    	with(document.BudgetHead){
    	    n1 = isNaN(parseFloat(txtAmt.value))?0:parseFloat(txtAmt.value);
    	    n2 = isNaN(parseFloat(txtTds.value))?0:parseFloat(txtTds.value);
    	    txtNetAmt.value = n1-n2;
    	    txtWord.value=Num2Word(txtNetAmt.value);
    	}
    }
    
    function setVoucherNo(){
    	with(document.BudgetHead){
    	    txtNo.value = txtChqno.value;	
    	}
    }
    
function changeVisible(code){
	arrr = document.all.tags("div");
	document.BudgetHead.txtMode.value=code;
	for(i=0;i<arrr.length;i++){
		if(arrr[i].id=="kk"){
			if(code==2)
				arrr[i].style.visibility="visible";
			else
				arrr[i].style.visibility="hidden";
		}
	}
	if(code==2)
		document.BudgetHead.txtNo.disabled = true;
	else
		document.BudgetHead.txtNo.disabled = false;
}
   

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
    
</script>
<td width="80%" valign="top">
   <form name="BudgetHead" method="post" action="VoucherDel.do">
   <input type="hidden" name="txtMode" value="">
   <input type="hidden" name="txtId" value="<%=strVoucherId%>">
	<table width="80%" border="0" cellspacing="1" cellpadding="1" align="center" >
		<tr> 
			<td colspan=4>&nbsp;</td>
		</tr>
		<tr> 
			<td width="25%" class="innertitle" align="left">&nbsp;</td>
			<td width="25%" align="left">&nbsp;</td>
			<td width="20%" class="innertitle" align="right">Voucher No</td>
			<td width="30%" align="right"><input type="text" name="txtNo" size="12" class="formfield" value=<%=strVoucherNo%>></td>
		</tr>
		<tr> 
			<td width="25%" class="innertitle" align="left">Head</td>
			<td width="25%" align="left">
			    <select name="txtHeadId" class="formfield" onBlur="setValue(value)">
				<option value="">Select Budget Head</option>
				<%
				    if(hmAll!=null && hmAll.size()>0){
				    	for(int indx=0;indx<hmAll.size();indx++){
				    	    HashMap hmt = (HashMap)hmAll.get(""+indx);
				    	    String strTempId = (String)hmt.get("HeadId");
				    	    String strTempName = (String)hmt.get("strName");
							strAllocate= (String)hmt.get("allocate");
							strexp= (String)hmt.get("exp");
							//strBalance=Double.parseDouble(strAllocate)-Double.parseDouble(strexp);
							
				    	    %>
				    	 
								<OPTION value="<%=strTempId%>" <%=strTempId.equals(HeadId)?"selected":"" %> ><%=strTempName%></option>
				    	    <%
				    	}
				    }
				%>
			    </select>
			</td>
			<td width="20%" class="innertitle" align="left">Date</td>
			<td width="30%" align="right"><input type="text" name="txtDt" size="12" class="formfield" value="<%=Date%>"></td>
		</tr>
		<tr> 
			<td width="25%" class="innertitle" align="left">Account No</td>
			<td width="75%" align="right" colspan=3><input type="text" name="txtAccNo" size="52" class="formfield" value=<%=strAccountNo%> disabled></td>
		</tr>
		<tr> 
		    <td colspan=2 align="center" width="50%">
		    	<table width="100%" border="1" cellspacing="1" cellpadding="1" align="center" bgcolor="<%=strCol2%>">
			    <tr>
			    	<td width="60%" align="left" class="innertitle" >
			    	    Allocate <font size="1">(Rs.)</font>
			    	</td>
			    	<td width="40%" align="left" class="innertitle">
			    	    <input type="text" name="txtAllo" size="12" class="formfield" value="<%=strAllocate%>" disabled>	
			    	</td>
			    </tr>
			    <tr>
			    	<td align="left" class="innertitle">
			    	    Already spend <font size="1">(Rs.)</font>
			    	</td>
			    	<td align="left" class="innertitle">
			    	    <input type="text" name="txtExp" size="12" class="formfield" value="<%=strexp%>" disabled>	
			    	</td>
			    </tr>
			    <tr>
			    	<td align="left" class="innertitle">
			    	    Balance <font size="1">(Rs.)</font>
			    	</td>
			    	<td align="left" class="innertitle">
			    	    <input type="text" name="txtBal" size="12" class="formfield" value="<%//=strBalance%>" disabled>	
			    	</td>
			    </tr>
		    	</table>
		    </td>
		    <td colspan=2 align="center" width="50%">
		    	<table width="68%" border="1" cellspacing="1" cellpadding="1" align="Right" bgcolor="<%=strCol2%>">
			    <tr>
			    	<td width="60%" align="left" class="innertitle">
			    	    Amount <font size="1">(Rs.)</font>
			    	</td>
			    	<td width="40%" align="left" class="innertitle">
			    	    <input type="text" name="txtAmt" size="12" class="formfield" value="<%=amt%>" onBlur="calcAmount()">	
			    	</td>
			    </tr>
			    <tr>
			    	<td align="left" class="innertitle">
			    	    TDS <font size="1">(Rs.)</font>	
			    	</td>
			    	<td align="left">
			    	    <input type="text" name="txtTds" size="12" class="formfield" value="<%=dblTds%>"  onBlur="calcAmount()">	
			    	</td>
			    </tr>
			    <tr>
			    	<td align="left" class="heading">
			    	    <font size="2">Net Amount </font><font size="1">(Rs.)</font>
			    	</td>
			    	<td align="left">
			    	    <input type="text" name="txtNetAmt" size="12" class="formfield" value="<%=dblAmount%>" readonly="readonly">	
			    	</td>
			    </tr>
		    	</table>
		    </td>
		</tr>
		
		<tr> 
		    <td align="left" class="innertitle">
		    	Rupees <font size="1">(in words)</font>
		    </td>
		    <td colspan=3 class="innertitle" align="right">
		    	<input type="text" name="txtWord" size="52" class="formfield" value="<%=strName%>" disabled>
		    </td>
		</tr>
		<tr> 
		    <td align="left" class="innertitle">
		    	On Account Of
		    </td>
		    <td colspan=3 class="innertitle" align="right">
		    	<input type="text" name="txtAcc" size="52" class="formfield" value="<%=strToAcc%>">
		    </td>
		</tr>
		<tr> 
		    <td align="left" class="innertitle">
		    	Receiver
		    </td>
		    <td colspan=3 class="innertitle" align="right">
		    	<input type="text" name="txtReceiver" size="52" class="formfield" value="<%=strReceiverNm%>">
		    </td>
		</tr>
		<tr> 
		    <td align="left" class="innertitle">
		    	Payment Mode
		    </td>
		    <td colspan=2 class="innertitle" align="right">
		    
				<input type="radio" name="rd" value="1" onClick="changeVisible(1)" <%=bMode.equals("0")?"Checked":""%> >Cash
		    	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		    	
				<input type="radio" name="rd" value="2" onClick="changeVisible(2)" <%=bMode.equals("2")?"Checked":""%> >Cheque
		    </td>
		    <td align="left" class="innertitle">&nbsp;
		    	
		    </td>
		</tr>
		<tr> 
		    <td align="left" class="innertitle">
		    	<div id="kk" style="visibility:<%=bMode.equals("0")?"hidden":""%>">
		    	Cheque No
		    	</div>
		    </td>
		    <td colspan=2 class="innertitle" align="right">
		    	<div id="kk" style="visibility:<%=bMode.equals("0")?"hidden":""%>">
		    	<input type="text" name="txtChqno" size="29" class="formfield" value="<%=strCheque%>" onBlur="setVoucherNo()">
		    	</div>
		    </td>
		    <td align="left" class="innertitle">&nbsp;
		    	
		    </td>
		</tr>
		
		<tr> 
			<td colspan=4 align="center">
			    <div id="abc" style="visibility:hidden">
			    <select name="headlst" class="formfield">
				<%
				    if(hmAll!=null && hmAll.size()>0){
				    	for(int indx=0;indx<hmAll.size();indx++){
				    	    HashMap hmt = (HashMap)hmAll.get(""+indx);
				    	    String strTempId = (String)hmt.get("HeadId");
				    	    String strAcc = (String)hmt.get("strAccNo");
				    	    String strAllo = (String)hmt.get("allocate");
				    	    String strExp = (String)hmt.get("exp");
				    	    %>
				    	    	<option value="<%=strTempId%>"><%=strAcc+"|"+strAllo+"|"+strExp%></option>
				    	    <%
				    	}
				    }
				%>
			    </select>
			    </div.
			></td>
		</tr>
		<tr> 
			<td colspan=4 align="center">
				<input name="btnSub" type="Reset" value=" Reset " class="PPRSbmtBtn">&nbsp;
				<input name="btnSub" type="submit" value="Submit" class="PPRSbmtBtn">
			</td>
		</tr>
	</table>
    </form>
</td>
<%@ include file="/jsp/include/footer.jsp" %>
