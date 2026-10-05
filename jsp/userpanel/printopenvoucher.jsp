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
<style>
@page {
    size: A4;
    margin: 20mm;
}

body {
    font-family: "Bookman Old Style";
}

.print-container {
    width: 210mm;
    min-height: 297mm;
    border: 2px solid black;
    padding: 15px;
    box-sizing: border-box;
    margin: auto;
}

/* Header */
.header {
    text-align: center;
    margin-bottom: 20px;
}

.header .college-name {
    font-size: 20px;
    font-weight: bold;
}

.header .college-address {
    font-size: 14px;
    font-weight: bold;
}

/* Table styling */
.main-table {
    width: 100%;
    border-collapse: collapse;
	font-size: 17px !important;
}

.main-table td {
    padding: 5px;
    vertical-align: top;
}

/* Alignments */
.text-right {
    text-align: right;
}

.text-center {
    text-align: center;
}

/* Print fix */
@media print {
    body {
        margin: 0;
    }
}

/* MAIN VOUCHER BOX */
.voucher-box {
    border: 2px solid black;
    border-collapse: collapse;
}

/* INNER GRID */
.voucher-box td {
    padding: 6px;
    vertical-align: middle;
}

/* LEFT SECTION BORDER */
.left-section {
    border-right: 2px solid black;
}

/* RIGHT SECTION BORDER (Amount Box) */
.right-section {
    border-left: 2px solid black;
}

/* TOP RIGHT BOX (Payment / Voucher Info) */
.top-box {
    border: 2px solid black;
}

/* ROW SEPARATORS */
.row-line td {
    border-top: 1px solid black;
}

/* BOTTOM STRONG LINE */
.bottom-line td {
    border-top: 2px solid black;
}

.no-border {
    border: none !important;
}

</style>

</head>

<body onLoad="javascript:print();setAction()">
<form name="abc">

<div class="print-container">

    <!-- HEADER -->
   <div class="header">

    <div style="font-size:14px; font-weight:bold;">
        MAHARASHTRA ACADEMY OF ENGINEERING AND EDUCATIONAL RESEARCH PUNE'S
    </div>

    <div style="font-size:28px; font-weight:bold; margin:5px 0;">
        MIT | Arts, Commerce & Science College
    </div>

    <div style="font-size:14px; font-weight:bold;">
        Alandi (Devachi), Dist. Pune
    </div>

    <div style="font-size:14px; font-weight:bold; margin-top:5px;">
        (Trust Regn. No. F - 2555)
    </div>

</div>

    <!-- MAIN CONTENT -->

  <table class="main-table voucher-box">

    <!-- TOP RIGHT BOX -->
    <tr>
        <td colspan="4" class="no-border"><strong>Payment Date:</strong></td>
        <td colspan="2"></td>
        <td class="top-box"><strong>Voucher No:</strong></td>
        <td class="top-box text-center"><%=voucher_number%></td>
    </tr>

    <!-- HEADER ROW -->
    <tr class="row-line">
        <td colspan="6" class="left-section">
            <b>Dr. <%=budget_head_name%> - <%=voucher_number%></b>
        </td>

        <td class="top-box"><strong>Voucher Date:</strong></td>
        <td class="top-box text-center"><%=Date%></td>
    </tr>

    <!-- DATA SECTION -->
    <tr class="row-line">
        <td colspan="2" style="border:none; border-top:2px solid black; border-right:2px solid black;">Allocated Amount</td>
        <td class="text-center" style="border-top:2px solid black;"><%=d.format(allocatedAmount)%></td>
        <td colspan="4" class="right-section"></td>
        <td class="right-section text-center">Amount</td>
    </tr>

    <tr class="row-line">
        <td colspan="2" class="left-section">Utilized Amount</td>
        <td class="left-section text-center"><%=d.format(dblUtilisedAmount-totVoucherAmt)%></td>

        <td colspan="4" class="right-section">
            Net Pay
        </td>

        <td class="right-section text-right">
            <% out.println(d.format(dblAmount)); %>
        </td>
    </tr>

    <tr class="row-line">
        <td colspan="2" class="left-section">Budget Available</td>
        <td class="left-section text-center">
            <%=d.format(allocatedAmount-(dblUtilisedAmount-totVoucherAmt))%>
        </td>

        <td colspan="4" class="right-section">
            <% if(!bMode.equals("1")) out.println(TDStype); %>
        </td>

        <td class="right-section text-right">
            <% if(!bMode.equals("1")) out.println(dblTds+"0"); %>
        </td>
    </tr>

    <tr class="row-line">
        <td colspan="2" class="left-section">Voucher Amount</td>
        <td class="left-section text-center"><%=d.format(totVoucherAmt)%></td>
        <td colspan="4" class="right-section">
            
        </td>

        <td class="right-section text-right">
            
        </td>
    </tr>

    <tr class="row-line">
        <td colspan="2" class="left-section">Balance Budget</td>
        <td class="left-section text-center">
            <%=d.format(allocatedAmount-dblUtilisedAmount)%>
        </td>
		<td colspan="4" class="right-section">
          </td>
        <td class="right-section text-right">
         </td>
    </tr>
	 <!-- TOTAL SECTION -->
	 <tr class="bottom-line">
        <td colspan="2" class="left-section"></td>
        <td class="left-section text-center">
            <strong>Received the sum of Rs.</strong>
        </td>
		<td colspan="4" class="right-section"><strong>Total Rs:</strong>
          </td>
        <td class="right-section text-right"><strong><%=d.format(dblAmount+dblTds)%></strong>
         </td>
    </tr>
   
 
    <tr class="row-line">
        <td><strong>Rupees(in words)</strong></td>
        <td colspan="7">
            <script>
                document.write(ChkWord(<%=dblAmount+dblTds%>));
            </script>
        </td>
    </tr>
 <%
  int i=0;
if(strToAcc.length()>300)
{
	strToAcc=strToAcc.substring(0,300);
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
    <!-- ACCOUNT SECTION -->
    <tr class="row-line">
        <td><strong>On Account Of</strong></td>
        <td colspan="7"><%=strToAcc%></td>
    </tr>

    <% if(Str2 != null && Str2.trim().length() > 0){ %>
    <tr>
        <td></td>
        <td colspan="7"><%//=Str2%></td>
    </tr>
    <% } %>

    <% if(Str3 != null && Str3.trim().length() > 0){ %>
    <tr>
        <td></td>
        <td colspan="7"><%//=Str3%></td>
    </tr>
    <% } %>

    <tr class="row-line">
        <td><strong>By Cheque/Cash</strong></td>
        <td colspan="7">
            <%=bMode.equals("1")?"Cash": "Cheque ("+strCheque+")"%>
            <%=bMode.equals("1")?"":"("+bankName+")"%>
        </td>
    </tr>

    <tr class="row-line">
        <td><strong>Receiver's Name</strong></td>
        <td colspan="7"><%=strReceiverNm%></td>
    </tr>

</table>
  
  <div style="margin-top: 80px; width: 100%;">

    <table style="width:100%; text-align:center; border-collapse: collapse; font-size:17px; font-weight:bold;">

        <!-- ROW 1 (CENTERED) -->
        <tr>
            <td colspan="2"></td>

            <!-- Prepared by -->
            <td width="16%" style="width:16%;">
                <div style="height:80px;"></div>
                <div>Prepared by</div>
            </td>

            <!-- Accountant -->
            <td width="16%" style="width:16%;">
                <div style="height:80px;"></div>
                <div>Accountant</div>
            </td>

            <td colspan="2"></td>
        </tr>

        <!-- ROW 2 -->
        <tr>
            <!-- Receiver Signature with box -->
            <td width="16%" style="width:16%;">
                <div style="height:80px; width:80px; border:1px solid #000; margin:auto;"></div>
                <div style="margin-top:5px;">Receiver's Signature & Date</div>
            </td>

            <!-- CA & FO -->
            <td width="16%" style="width:16%;">
                <div style="height:80px;"></div>
                <div>CA & FO</div>
            </td>

            <!-- Registrar -->
            <td style="width:16%;">
                <div style="height:80px;"></div>
                <div>Registrar</div>
            </td>

            <!-- Director -->
            <td style="width:16%;">
                <div style="height:80px;"></div>
                <div>Director</div>
            </td>

            <!-- Executive Director -->
            <td colspan="2" width="36%" style="width:16%;">
                <div style="height:80px;"></div>
                <div>Executive Director</div>
            </td>

           
        </tr>

    </table>

</div>
  
</div>

<!-- SIGNATURE SECTION -->


</form>
</body>
</html>
