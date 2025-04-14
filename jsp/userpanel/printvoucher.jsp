<%@page import="java.util.*,java.text.*"  %>
<%
	session.setAttribute("itr", "1");
	String strId = "";
	String strName = "";
	String strAccNo = "";
	String strRemark = "";
	
	String strVoucherId = "";
	String strVoucherNo = "";
	String HeadId = "";
	String strType="";
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
//	out.println(""+hmAll);
	//out.println(""+hmData);

	String strAllocate = "";
	String strexp = "";
	double strBalance=0;
	DecimalFormat d = new DecimalFormat("##0.00");

//************************************
//	String str1 = "17650000.00";
//	String str2 = "1276229.00";
//	String str3 = String.valueOf(Double.parseDouble(str1) - Double.parseDouble(str2));
//	out.println(""+(Double.parseDouble(str1) - Double.parseDouble(str2)));
//
//************************************
	
	if(hmData!=null && hmData.size()>0){
		strVoucherId = (String)hmData.get("voucherId");
		strVoucherNo = (String)hmData.get("VouNo");
		String DT =(String)hmData.get("dt");
 		Date =DT.substring(8,10)+"-"+DT.substring(5,7)+"-"+DT.substring(0,4);

		//Date = (String)hmData.get("dt");
		strAccountNo = (String)hmData.get("strAccNo");
		amt = (String)hmData.get("amt");
		dblAmount= (String)hmData.get("dblAmount");
		dblTds= (String)hmData.get("dblTds");
		strType=(String)hmData.get("strType");
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

function setAction(code){
    
    switch(code){
        case 1:
            document.BudgetHead.action ="/budget-management/PrintOpenVoucher.do";
            break;
        case 2:
            document.BudgetHead.action = "/budget-management/Close.do";
            break;
        case 3:
            document.BudgetHead.action = "/budget-management/PrintTDSVoucher.do";
            break;            
    }
    
    document.BudgetHead.submit();
}
    
</script>

<td width="80%" valign="top">
   <form name="BudgetHead" method="post" action="PrintOpenVoucher.do">
   <input type="hidden" name="txtMode" value="">
   <input type="hidden" name="page" value="VoucherList">
   <input type="hidden" name="id" value="<%=strVoucherId%>">  
	<input type="hidden" name="opr" value="2">  
	<table width="80%" border="0" cellspacing="1" cellpadding="1" align="center" >
		<tr> 
			<td colspan=4>&nbsp;</td>
		</tr>
		<tr> 
			<td width="25%" class="innertitle" align="left">&nbsp;</td>
			<td width="25%" align="left">&nbsp;</td>
			<td width="20%" class="innertitle" align="left">Voucher No</td>
			
        <td width="30%" align="left"> <font face="Georgia, Times, serif" size="3"><%=strVoucherNo%></font></td>
		</tr>
		<tr> 
			<td width="30%" class="innertitle" align="left"></td>
			<td width="20%" align="left">
			   					</td>
			<td width="20%" class="innertitle" align="left">Date </td>
			<td width="30%" align="left"> <font face="Georgia, Times, serif" size="3"><%=Date%></font></td>
		</tr>
		<tr> 
		
			<td width="30%" class="innertitle" align="left">Dr</td>
			
        <td width="20%" align="left"> <font face="Georgia, Times, serif" size="3">
          <%
				    if(hmAll!=null && hmAll.size()>0){
				    	for(int indx=0;indx<hmAll.size();indx++)
					{
				    	    HashMap hmt = (HashMap)hmAll.get(""+indx);
				    	    String strTempId = (String)hmt.get("HeadId");
				    	    String strTempName = (String)hmt.get("strName");
				    	    	if(HeadId.equals(strTempId))
						{
						strAllocate= (String)hmt.get("allocate");
						strexp= (String)hmt.get("exp");
						strBalance=Double.parseDouble(strAllocate)-Double.parseDouble(strexp);
							%>
          <%=strTempName%> 
          <%
							}
				    	}
				    }
				%>
          </font> </td>
			<td width="20%" class="innertitle" align="right"></td>
			<td width="30%" align="right"></td>
			
		</tr>
		
		<tr> 
			<td width="25%" class="innertitle" align="left">Account No</td>
			
        <td width="30%" align="left" > <font face="Georgia, Times, serif" size="3"><%=strAccountNo%></font></td>
		</tr>
		<tr> 
		    <td colspan=2 align="center" width="50%">
		    	<table width="100%" border="0" cellspacing="1" cellpadding="1" align="center">
			    <tr>
			    	<td width="50%" align="left" class="innertitle" >
			    	    Allocate <font size="1">(Rs.)</font>
			    	</td>
			    	
              <td width="50%" align="left" class="innertitle"> <font face="Georgia, Times, serif" size="3"><%=strAllocate%></font>	
              </td>
					
			    </tr>
			    <tr>
			    	<td width="50%" align="left" class="innertitle">
			    	    Already spend <font size="1">(Rs.)</font>
			    	</td>
			    	
              <td width="50%" align="left" class="innertitle"> <font face="Georgia, Times, serif" size="3"><%=strexp%></font> 
              </td>
					
			    </tr>
			    <tr>
			    	<td  width="50%" align="left" class="innertitle">
			    	    Balance <font size="1">(Rs.)</font>
			    	</td>
			    	
              <td width="50%" align="left" class="innertitle"> <font face="Georgia, Times, serif" size="3"><%=d.format(strBalance)%></font>	
              </td>
			    </tr>
		    	</table>
		    </td>
		    <td colspan=2 align="center" width="50%">
		    	<table width="100%" border="1" cellspacing="1" cellpadding="1" align="center">
			    <tr>
			    	<td width="20%" align="left" class="innertitle">
			    	    Amount <font size="1">(Rs.)</font>
			    	</td>
			    	
              <td width="30%" align="right" class="innertitle"> <font face="Georgia, Times, serif" size="3"><%=dblAmount%></font>	
              </td>
			    </tr>
			    <tr>
			    	<td align="left" class="innertitle">
			    	    <%=strType%><font size="1">(Rs.)</font>	
			    	</td>
			    	
              <td align="right"> <font face="Georgia, Times, serif" size="3"><%=dblTds%></font>	
              </td>
			    </tr>
			    <tr>
			    	<td align="left" class="heading">
			    	    <font size="2">Net Amount </font><font size="1">(Rs.)</font>
			    	</td>
			    	
              <td align="right"> <font face="Georgia, Times, serif" size="3"><%=amt%></font>	
              </td>
			    </tr>
		    	</table>
		    </td>
		</tr>
		<tr>
		<td colspan="4"></td>
		</tr>
		
		<tr> 
		    <td align="left" class="innertitle">
		    	Rupees <font size="1">(in words)</font>
		    </td>
		    <td colspan=3 class="innertitle" align="left"><font face="Georgia, Times, serif" size="3">
		    	<Script language="JavaScript">
				document.write(ChkWord(<%=amt%>));
			</Script></font>
		    </td>
		</tr>
		<tr> 
		    <td align="left" class="innertitle">
		    	On Account Of
		    </td>
		    
        <td class="innertitle" align="left"> <font face="Georgia, Times, serif" size="3"><%=strToAcc%></font> 
        </td>
		</tr>
		<tr> 
		    <td align="left" class="innertitle">
		    	By Cash/Cheque
		    </td>
		    
        <td class="innertitle" align="left"> <font face="Georgia, Times, serif" size="3"><%=strPaymentMode+" "+"No"+" "+strCheque%></font> 
        </td>
		    <td align="left" class="innertitle">&nbsp;
		    	
		    </td>
		</tr>
	
		
		<tr> 
		    <td align="left" class="innertitle">
		    	Receiver's Name 
		    </td>
		    
        <td  class="innertitle" align="left"> <font face="Georgia, Times, serif" size="3"><%=strReceiverNm%></font> 
        </td>
		</tr>
			<tr> 
		 </tr>
		
		<tr> 
			<td colspan=4 align="center">
		
			</td>
		</tr>
		<tr> 
			
        <td colspan=4 align="center"> 
        	<input type="button" name="btn3" value="  Print  " accesskey="D" onClick="setAction(1)" class="PPRSbmtBtn"> 
		<%
		if(strType.equals("TDS"))
		{ %>
		<input type="button" name="btn1" value="<%=strType%>" accesskey="T" onClick="setAction(3)" class="PPRSbmtBtn"> 
		<% } %>
		<input type="button" name="btn1" value="   Close   " accesskey="C" onClick="setAction(2)" class="PPRSbmtBtn"> 
		    					
			</td>
		</tr>
	</table>
    </form>
</td>

