<html><%@page import="java.util.*,java.text.*" %>
<%
	DecimalFormat d = new DecimalFormat("##0.00");

	session.setAttribute("itr", "1");
	String strId = "";
	String strName = "";
	String strAccNo = "";
	String TDStype = "";
	String strRemark = "";
	
	String strVoucherId = "";
	String voucher_number = "";
	String HeadId = "";
	double dblTds = 0;
	String strToAcc = "";
	String voucherNo = "";
	String amt = "";
	double dblAmount = 0;
	String bMode="0";
	String Date="";
	String Date1="";
	String strAccountNo="";
	String strReceiverNm="";
	String strCheque="";
	double ExpAmt=0;
	String srCvouNO="";
	String bankName="";
	
	String budget_head_name="";
	String budget_note_id="";
	
	HashMap hmAll=(HashMap)request.getAttribute("all"); 
	HashMap hmData=(HashMap)request.getAttribute("data"); 
	//out.println(""+hmData);
	
	String strAllocate = "";
	String strexp = "";
	double strBalance=0;
	double Balancebudg=0;
	double AvblBudg=0;
	
	
	double dblUtilisedAmount=0.0;
	double dblReservedAmount=0.0;
	double allocatedAmount=0.0;
	double balbudget=0;
	double totVoucherAmt=0.0;
	
	if(hmData!=null && hmData.size()>0){
		strVoucherId = (String)hmData.get("voucher_id");
		budget_note_id= (String)hmData.get("budget_note_id");
		voucher_number = (String)hmData.get("voucher_number");
		Date1 = (String)hmData.get("voucher_date");
		Date= Date1.substring(8,10)+"-"+Date1.substring(5,7)+"-"+Date1.substring(0,4);
		amt = (String)hmData.get("amount");
		dblAmount= Double.parseDouble((String)hmData.get("amount"));
		dblTds= Double.parseDouble((String)hmData.get("tds_amount"));
        totVoucherAmt=dblAmount+dblTds;
		dblUtilisedAmount= Double.parseDouble((String)hmData.get("dblUtilisedAmount"));
		dblReservedAmount= Double.parseDouble((String)hmData.get("dblReservedAmount"));
		allocatedAmount= Double.parseDouble((String)hmData.get("dblAmount"));
		
		
		strToAcc= (String)hmData.get("narration");
		strReceiverNm=(String)hmData.get("receiver_name");
		bMode=(String)hmData.get("payment_mode");
		HeadId=(String)hmData.get("HeadId");
		TDStype = (String)hmData.get("strType");
		strCheque=(String)hmData.get("chequeno");
		srCvouNO=(String)hmData.get("srCvouNO");
		bankName=(String)hmData.get("bank_name");
	
		budget_head_name=(String)hmData.get("budget_head_name");
		
	}
	Balancebudg=dblAmount+dblTds;
	String strPaymentMode="";
	if(bMode.equals("1"))
	    strPaymentMode="Cash";
	else
	    strPaymentMode="Cheque";
	
	String vouchq="";
	if(bMode.equals("2"))
	   	vouchq=srCvouNO;
	else
	   	vouchq="";	
			
//out.println(hmData);

%>
<script language="javascript">
var arr1=['','One','Two','Three' ,'Four','Five','Six','Seven','Eight','Nine'];
var arr2=['Ten','Eleven','Twelve','Thirteen','Fourteen','Fifteen','Sixteen','Seventeen','Eighteen','Ninteen'];
var arr3=['Twenty','Thirty','Forty','Fifty','Sixty','Seventy','Eighty','Ninty'];
var arr4=['Hundred','Thousand','Lakh','Crore',''];


function ChkWord(Amt){
var str=' ';
var c=1;
var tt='';
var j=0;
	if(parseInt(num)==0)
		return 'Zero'
	else
	{
		var num = parseInt(Amt);
		while(parseInt(num)!=0)	{
			num=parseInt(num);
			switch(c){
				case 1:
						rm = parseInt(num % 100); str = str+pass ( rm ) ;
						num /= 100; break ;

				case 2:
						rm = parseInt(num % 10);
						if ( rm != 0 ){
							str = str+" "+arr4[0]+" "; str = str+pass ( rm );
						}
						num /= 10; break ;
				case 3:
						rm = parseInt(num % 100);
						if ( rm != 0 ){
							str = str+" "+arr4[1]+" "; str=str+pass ( rm );
						}
						num /= 100; break ;

				case 4:
						rm = parseInt(num % 100);
						if ( rm != 0 ) {
							str = str+" "; str = str+arr4[2]; str = str+" " ; str = str+pass ( rm ) ;
						}
						num /= 100 ; break ;
				case 5:
						rm = parseInt(num % 100);
						if ( rm != 0 ) {
							str = str+" "; str = str+arr4[3]; str = str+" "; str = str+pass ( rm ) ;
						}
						num /= 100 ; break ;
			}
			c++;
		}
		j=str.length;
		for(var i=j;i>=0;i--){
			if(str.charAt(i)==' ') {
				tt = tt+' '+str.substring(i,j+1);
				j=i;
			}
		}
		return tt+" only"
	}
}

function pass (num1 )
{
	var ms="";
	var rm, q ;
	if(num1<10){
		ms=arr1[num1];
	}

	if(num1>9 && num1<20){
		ms=arr2[num1-10];
	}

	if(num1>19){
		rm = num1 % 10;
		if(rm==0){
			q = parseInt(num1 / 10);  ms=arr3[q-2];
		}else{
			q = parseInt(num1 / 10); ms=arr1[rm]; ms=ms+" "+arr3[q-2];
		}
	}
	return ms;
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

function setAction(){
document.abc.action ="/budget-management/AllVoucher.do";
document.abc.submit();
}
    
</script>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body onLoad="javascript:print();setAction()">  <!-- onLoad="javascript:print();setAction()" -->
<form name="abc">

  <table width="1000" height="471" border="0" align="center" cellpadding="0" cellspacing="0">
    <tr> 
      <td width="310" height="30">&nbsp;</td>
      <td width="37" height="30">&nbsp;</td>
      <td colspan="4" height="30">&nbsp;</td>
      <td width="67" height="30">&nbsp; </td>
      <td width ="95" height="30"><font face="Bookman Old Style" size="3">&nbsp;</font></td>
      <td width="120" height="30" widht="250">&nbsp;</td>
    </tr>
    <tr> 
      <td width="310" height="15">&nbsp;</td>
      <td width="37" height="15">&nbsp;</td>
      <td colspan="4">&nbsp;</td>
      <td width="67">&nbsp; </td>
      <td height="15"><font face="Bookman Old Style" size="3">&nbsp;</font></td>
      <td>&nbsp;</td>
    </tr>
    <tr> 
      <td width="310" height="15">&nbsp;</td>
      <td width="37" height="15">&nbsp;</td>
      <td colspan="4">&nbsp;</td>
      <td width="67">&nbsp; </td>
      <td height="15"></td>
      <td><div align="center"><font face="Bookman Old Style" size="3"><%=voucher_number%></font></div></td>
    </tr>
    <tr> 
      <td width="310" height="15">&nbsp;</td>
      <td width="37" height="15">&nbsp;</td>
      <td colspan="4"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Dr.
        <font face="Bookman Old Style" size="3"><%=budget_head_name%>-&nbsp;<%=voucher_number%></font> </td>
      <td width="67">&nbsp; </td>
      <td height="15"></td>
      <td><div align="center"><font face="Bookman Old Style" size="3"><%=Date%></font></div></td>
    </tr>
    <tr> 
      <td width="310" height="15">&nbsp;</td>
      
      <td height="15" colspan="2"><font face="Bookman Old Style" size="2">Allocated 
        Amount</font>
        
      </td>
	  <td width="130" height="15" ><div align="center"><font face="Bookman Old Style" size="2"><%=d.format(allocatedAmount)%></font></div>
        
      </td>
      <td width="82"> <div align="center"><font face="Bookman Old Style" size="3"></font></div></td>
      <td width="46"><div align="center"><font face="Bookman Old Style" size="3">&nbsp;</font></div></td>
      <td><div align="center"><font face="Bookman Old Style" size="3"><%//=strAccountNo%></font></div></td>
    </tr>
    <tr> 
      <td width="310" height="15">&nbsp;</td>
      <td height="15" colspan="2"><font face="Bookman Old Style" size="2">Utilized 
        Amount </font></td>
      <td width="130" height="15">
        <div align="center"><font face="Bookman Old Style" size="2"><%=d.format(dblUtilisedAmount-totVoucherAmt)%></font></div></td>
      <td colspan="2">&nbsp;</td>
      <td height="20" colspan="2">&nbsp; 
        <% 
	String ASD="";
	if(bMode.equals("2"))
	{
		ASD="Amount";
	} %>
        <font face="Bookman Old Style" size="3"><%=ASD%></font> </td>
      <td height="15"> 
        <div align="right"><font face="Bookman Old Style" size="3"> 
          <%
		if(bMode.equals("1"))
		{
			out.println(" ");
		}else{out.println(dblAmount+"0");}
	%>
          </font></div></td>
    </tr>
    <tr> 
      <td width="310" height="15">&nbsp;</td>
      <td height="15" colspan="2"><font size="2" face="Bookman Old Style">Budget 
        Available</font></td>
      <td  width="130" height="15"><div align="center"><font face="Bookman Old Style" size="2"><%=d.format(allocatedAmount-(dblUtilisedAmount-totVoucherAmt))%></font></div></td>
      <td colspan="2">&nbsp;</td>
      <td height="15" colspan="2">&nbsp; 
        <% 
	if(bMode.equals("1"))
	{
		out.println("");
	}else
	{
		out.println(TDStype);
		//out.println("TDS");
	} %>
      </td>
      <td height="15"> <div align="right"><font face="Bookman Old Style" size="3"> 
          <%
	if(bMode.equals("1"))
	{
		out.println("");
	}else
	{
		out.println(dblTds+"0");
	}

%>
          </font></div></td>
    </tr>
    <tr> 
      <td width="310" height="15">&nbsp;</td>
      <td height="15" colspan="2"><font face="Bookman Old Style" size="2">Voucher Amount</font></td>
      <td  width="130" height="15"><div  align="center"><%=d.format(totVoucherAmt)%></div></td>
      <td colspan="2">&nbsp;</td>
      <td height="15" colspan="2">&nbsp;</td>
      <td height="15"><div align="right">&nbsp;</div></td>
    </tr>
    <tr> 
      <td width="310" height="15">&nbsp;</td>
      <td height="15" colspan="2"><font face="Bookman Old Style" size="2">Balance Budget</font></td>
      <td height="15"><div  align="center"><font face="Bookman Old Style" size="2"><%=d.format(allocatedAmount-dblUtilisedAmount)%></font></div></td>
      <td colspan="2">&nbsp;</td>
      <td height="15" colspan="2">&nbsp;</td>
      <td height="15"> <div align="right">&nbsp;</div></td>
    </tr>
    <tr> 
      <td width="310" height="15">&nbsp;</td>
      <td height="15">&nbsp;</td>
      <td width="113">&nbsp;</td>
      <td colspan="4"><div align="center"><font face="Bookman Old Style" size="3">&nbsp;&nbsp;&nbsp;&nbsp;</font></div></td>
      <td><div align="center">&nbsp;</div></td>
      <td><div align="center"><font face="Bookman Old Style" size="3"><%=d.format(dblAmount+dblTds)%></font></div></td>
    </tr>
    <tr> 
      <td width="310" height="15">&nbsp;</td>
      <td height="15" colspan="1">&nbsp;&nbsp;</td>
      <td height="15" colspan="7"><font face="Bookman Old Style" size="2"> 
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<Script language="JavaScript">
		document.write(ChkWord(<%=dblAmount+dblTds%>));
	</Script>
        </font></td>
    </tr>
    <!--   <tr> 
<td width="310" height="15">&nbsp;</td> 
    <td height="15" colspan="8">&nbsp;</td>
  </tr> -->
    <%
  int i=0;
if(strToAcc.length()>215)
{
	strToAcc=strToAcc.substring(0,215);
}

String Str1=" ";
String Str2=" ";
String Str3=" ";
if(strToAcc.length()<=64)
{
	Str1=strToAcc;
}
	
if(strToAcc.length()>64 && strToAcc.length()<= 140)
{
	for(i=0;i<=70;i++)
	{
		if(strToAcc.charAt(i)==' ')
		{
			if(i>60)
				break;
		}
	}
	Str1=strToAcc.substring(0,i);
	Str2=strToAcc.substring(i,strToAcc.length());
}
if(strToAcc.length()>140 && strToAcc.length()< 220)
{
	int Ar[]=new int[2];
	for(i=0;i<=140;i++)
	{
		if(strToAcc.charAt(i)==' ')
		{
			if(i>55 && i< 64)
				Ar[0]=i;
				
			if(i>130 &&i<142)
				Ar[1]=i;
		}
		
	}
	Str1=strToAcc.substring(0,Ar[0]);
	Str2=strToAcc.substring(Ar[0],Ar[1]);
	Str3=strToAcc.substring(Ar[1],strToAcc.length());
}
%>
    <tr> 
      <td width="310" height="15">&nbsp;</td>
      <td height="15" colspan="1"><font face="Bookman Old Style" size="3">&nbsp;&nbsp;</font></td>
      <td height="15" valign="bottom" colspan="7">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font face="Bookman Old Style" size="3"><%=Str1%></font></td>
    </tr>
    <tr> 
      <td width="310" height="15">&nbsp;</td>
	  <td height="15" colspan="1"><font face="Bookman Old Style" size="3">&nbsp;&nbsp;</font></td>
      <td height="15" valign="bottom" colspan="7">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font face="Bookman Old Style" size="3"><%=Str2%></font></td>
    </tr>
    <tr> 
      <td width="310" height="15">&nbsp;</td>
	  <td height="15" colspan="1"><font face="Bookman Old Style" size="3">&nbsp;&nbsp;</font></td>
      <td height="15" valign="bottom" colspan="7">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font face="Bookman Old Style" size="3"><%=Str3%></font></td>
    </tr>
    <tr> 
      <td width="310" height="15">&nbsp;</td>
      <td colspan="1">&nbsp;&nbsp;&nbsp;</td>
      <td height="15" colspan="7">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font face="Bookman Old Style" size="3"><%=bMode.equals("1")?"Cash": "Cheque ("+strCheque+")"%>&nbsp; <%=bMode.equals("1")?"":"("+bankName+")"%></font></td>
    </tr>
    <tr> 
      <td width="310" height="15">&nbsp;</td>
      <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
      <td>&nbsp;</td>
      <td height="15" colspan="6"><font face="Bookman Old Style" size="3">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=strReceiverNm%></font></td>
    </tr>
  </table>
</form>
</body>
</html>
