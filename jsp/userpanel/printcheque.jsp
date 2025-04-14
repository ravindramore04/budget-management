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
	
	System.out.println("dblAmount---------------->"+hmData);
	//System.out.println("dblAmount---------------->"+dblAmount);
	
	if(hmData!=null && hmData.size()>0){
		strVoucherId = (String)hmData.get("voucherId");
		strVoucherNo = (String)hmData.get("voucherNo");
		String DT = (String)hmData.get("dt");
		Date =DT.substring(8,10)+"-"+DT.substring(5,7)+"-"+DT.substring(0,4);
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
	if (num == 0) return 'Zero';
	var wnums = [['Hundred','Thousand','Million','Billion','trillion','zillion'],['One','First','Ten','','th'],['Two','Second','Twen',0,0],['Three','Third','Thir',0,0],['Four','Fourth',0,0,0],['Five','Fifth','Fif',0,0],['Six','Sixth',0,0,0],['Seven','Seventh',0,0,0],['Eight','Eighth','Eigh',0,0],['Nine','Ninth',0,0,0],['Ten',],['Eleven',],['Twelve','Twelfth'],['Thirteen',],['Fourteen',],['Fifteen',],['Sixteen',],['Seventeen',],['Eighteen',],['Nineteen',]];
	var dot = (num.length % 3) ? num.length % 3 : 3;
	var sets = Math.ceil(num.length/3);
	var rslt = '';
	for (var i = 0; i < sets; i++) {
		var subt = num.substring((!i) ? 0 : dot + (i - 1) * 3,(!i) ? dot : dot + i * 3);
		if (subt != 0){
			var hdec = (subt.length > 2) ? subt.charAt(0) : 0;
			var ddec = subt.substring(Math.max(subt.length - 2,0),subt.length);
			var odec = subt.charAt(subt.length - 1);
			if (hdec != 0) rslt += ' ' + wnums[hdec][0] + '-Hundred ' + ((fmt && ddec == 0) ? 'th' : '');
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
		//document.chqprn.action ="/budget-management/ChqPrint.do";
		//document.chqprn.submit();
	}

function chkLength(AMT)
{
  
	var i=0;
	for(i=0;i<AMT.length;i++)
	{
		if(i>35)
		{
			if(AMT.charAt(i)==' ')
			{
				if(i>10)
					break;									
			}
		}
	}
	document.write(AMT.substring(0,i)+"<BR>");
	document.write(""+AMT.substring(i,AMT.length));
}
	
  
</script>
<body onLoad="javacript:print();setAction()" >
<form name="chqprn">
<BR><BR><BR><BR><BR><BR><BR><BR><BR><BR>
  <table width="90%" border="0" cellspacing="1" cellpadding="1" align="right" >
    <tr> 

			
     <!-- <td width="100%" height="20" align="center"><font face="Bookman Old Style" size="3"> 
        <%//=Date%>
        </font></td>
		</tr>-->
    <tr> 
      <td width="63%" height="20" align="right" valign="top"><font face="Bookman Old Style" size="3"><br>
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
					if(strAllocate==null)
					  strAllocate="0";
				    if(strexp==null)
					  strexp="0";
					  
					strBalance=Double.parseDouble(strAllocate)-Double.parseDouble(strexp);
			    if(HeadId.equals(strTempId))
			    {
		%>
        <%=strReceiverNm%> 
        <%
			    }
			}
		    }
		            %>
        </font></td>
    </tr>
    <tr> 
      <td width="63%" height="21">&nbsp;</td>
    </tr>
    <tr> 
      <td align="right"  valign="top" width="63%" > 
<div  align="right"><font face="Bookman Old Style" size="3"> 
          <script language="JavaScript">
					//document.write(ChkWord(=//dblAmount%>));
					
					var AT = ChkWord(<%=dblAmount%>);
					
					chkLength(AT);
				</script>
          </font></div></td>
      <td width="37%" height="24" align="center" valign="bottom">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=dblAmount%></td>
    </tr>
    <tr> 
      <td width="63%" align="right" valign="top"><font face="Bookman Old Style" size="3"> 
        <%//=dblAmount%>
        </font></td>
    </tr>
  </table>
</form>
</body></html>