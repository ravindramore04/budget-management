<% //@page import="java.util.*" %>
<%@ include file="/jsp/adminpanel/header.jsp" %>

<%
	session.setAttribute("itr", "1");
	String strId = "";
	String strName = "";
	String strAccNo = "";
	String strTDS="";
	String strRemark = "";
	
	String strVoucherId = "";
	String strVoucherNo = "";
	String dblTds = "";
	String strType = "";
	String strToAcc = "";
	String voucherNo = "";
	String amt = "";
	String dblAmount = "";
	String bMode="1";
	String strBank="";
	String Date="";
	String strAccountNo="";
	String strReceiverNm="";
	String strCheque="";
	String upstrPONo="";
	
	String strDepartmentNm="";
	String budgetNoteDate="";
	String budget_note_expense="";
	String budget_note_status="";
	String AllocId="";
	String allocated_amount="";
	String dblUtilisedAmount="";
	String HeadId="";
	String strDepartmentId="";
	String budget_head_name="";
	String budget_note_id="";
	String BallanceAmount="";
	
	
	
	
	String strDD="";
	String strMM="";
	String strYY="";
    String Str="";
	String sesn="";	
	
	
	HashMap hmAll=(HashMap)request.getAttribute("hm"); 
	
	HashMap hmData=(HashMap)request.getAttribute("Voucherdata"); 
	
	HashMap budgetData=(HashMap)request.getAttribute("data"); 
	
	//out.print(">>"+budgetData);
	double remain_NoteBallance=0.00;
	if(budgetData!=null && budgetData.size()>0){
		 budget_note_id = (String)budgetData.get("budget_note_id");
		 budgetNoteDate = (String)budgetData.get("create_date");
		 budget_note_expense = (String)budgetData.get("budget_note_expense");
		 budget_note_status= (String)budgetData.get("budget_note_status");
		 AllocId= (String)budgetData.get("AllocId");
		 allocated_amount= (String)budgetData.get("allocated_amount");
		 dblUtilisedAmount = (String)budgetData.get("dblUtilisedAmount");
		 HeadId= (String)budgetData.get("HeadId");
		 budget_head_name= (String)budgetData.get("budget_head_name");
		 strDepartmentNm =  (String)budgetData.get("strDepartmentNm"); 
		 BallanceAmount =  (String)budgetData.get("BallanceAmount");
		 strDepartmentId =  (String)budgetData.get("strDepartmentId");
		 remain_NoteBallance=Double.parseDouble(budget_note_expense)-Double.parseDouble(dblUtilisedAmount);
		  
	}
	
	String strAllocate = "";
	String strexp = "";
	double strBalance=0.00;
	
	if(hmData!=null && hmData.size()>0){
		strVoucherId = (String)hmData.get("voucherId");
		strVoucherNo = (String)hmData.get("voucherNo");
		Date = (String)hmData.get("dt");
		strAccountNo = (String)hmData.get("strAccNo");
		amt = (String)hmData.get("amt");
		dblAmount= (String)hmData.get("dblAmount");
		dblTds= (String)hmData.get("dblTds");
		strType=(String)hmData.get("strType");
		strToAcc= (String)hmData.get("strToAcc");
		strReceiverNm=(String)hmData.get("strReceiverNm");
		bMode=(String)hmData.get("bMode");
		strBank=(String)hmData.get("strBank");
		HeadId=(String)hmData.get("HeadId");
		strTDS=(String)hmData.get("strTDS");
		strCheque=(String)hmData.get("strChequeNo");
		upstrPONo=(String)hmData.get("strPONo");
		strYY=Date.substring(0,4);
		strMM=Date.substring(5,7);
		strDD=Date.substring(8,10);
	}
	else
	{
		Date date = new Date();
		strDD=""+date.getDate();
		strMM=""+date.getMonth();
		strMM=""+(Integer.parseInt(strMM)+1);
		strYY=""+date.getYear();
		strYY=strYY.substring(1,3);
				
		if(Integer.parseInt(strDD)<10)
			strDD="0"+strDD;	
		if(Integer.parseInt(strMM)<10)
			strMM="0"+strMM;
		
		strYY="20"+strYY;

	}
	
	
%>
<script language="javascript">



    function setSesn(code){
	//alert(code);
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
		if(code!=""){
		 // alert("1"+code);
		
		ddObj=document.all.item(code);
		//alert("ddObj--->"+document.all.item(""+code));
	//	alert("2---"+ddObj);
		if(ddObj!=null){
	//	alert("3--3-"+code);
			if(ddObj.options.length>=0){
		//	alert("3---"+code);
				BudgetHead.session.options.length=ddObj.options.length;	
				for(i=0;i<ddObj.options.length;i++){
					BudgetHead.session.options[i].value=ddObj.options[i].value;
					BudgetHead.session.options[i].text=ddObj.options[i].text;
				}
			}else{
		//	alert("4---"+code);
				BudgetHead.session.options.length=1;
				BudgetHead.session.options[0].value="";
				BudgetHead.session.options[0].text="----Select----";
			}
		}else{
//		alert("5---"+code);
			BudgetHead.session.options.length=1;
			BudgetHead.session.options[0].value="";
			BudgetHead.session.options[0].text="----Select----";
		}
	}else{
	//alert("6---"+code);
		BudgetHead.session.options.length=1;
		BudgetHead.session.options[0].value="";
		BudgetHead.session.options[0].text="----Select----";
	}
  }
    
    function calcAmount(){
	
    	with(document.BudgetHead){
    	if((txtAmt.value).toString()=="")
    		txtAmt.value="0.00";
    	if((txtTds.value).toString()=="")
    		txtTds.value="0.00";
    		
    	    n1 = isNaN(parseFloat(txtAmt.value))?0:parseFloat(txtAmt.value);
    	    n2 = isNaN(parseFloat(txtTds.value))?0:parseFloat(txtTds.value);
    	    if(n1>0  || n2 >0)
    	    	txtNetAmt.value = n1+n2;   
    
    	    txtWord.value=numberToWordsIndian(txtNetAmt.value);
//    	    txtNetAmt
//    	    txtAmt
    	}
    }
    
    function setVoucherNo(){
    	with(document.BudgetHead){
			if(isNaN(txtChqno.value)){
				//alert("Enter Numeric Value for Cheque Number");
				txtChqno.focus();
				return;
			}
		    txtNo.value = txtChqno.value;	
    	}
    }
    
function changeVisible(code){
	//arrr = document.all.tags("div");
	var showHide = document.getElementById("kk");
	var showText = document.getElementById("kk1");
	
	document.BudgetHead.txtMode.value=code;
	      if(code==2){
				showHide.style.visibility="visible";
				showText.style.visibility="visible";
				}
			else{
				showHide.style.visibility="hidden";
				showText.style.visibility="hidden";
				}
	if(code==2)
		document.BudgetHead.txtNo.disabled = false;
	else
		document.BudgetHead.txtNo.disabled = false;
}

function numberToWordsIndian(num) {
    num = Math.round(num); // Round to nearest whole number

    if (num === 0) return "zero";
				  
	const ones = ["", "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine"];
    const teens = ["Ten", "Eleven", "Twelve", "Thirteen", "Fourteen", "Fifteen", "Sixteen", "Seventeen", "Eighteen", "Nineteen"];
    const tens = ["", "", "Twenty", "Thirty", "Forty", "Fifty", "Sixty", "Seventy", "Eighty", "Ninety"];

    const parts = [];

    function getTwoDigitWords(n) {
        if (n < 10) return ones[n];
        if (n < 20) return teens[n - 10];
        return tens[Math.floor(n / 10)] + (n % 10 ? "-" + ones[n % 10] : "");
    }

    const crore = Math.floor(num / 10000000);
    num %= 10000000;
    if (crore > 0) parts.push(getTwoDigitWords(crore) + " Crore");

    const lakh = Math.floor(num / 100000);
    num %= 100000;
    if (lakh > 0) parts.push(getTwoDigitWords(lakh) + " Lakh");

    const thousand = Math.floor(num / 1000);
    num %= 1000;
    if (thousand > 0) parts.push(getTwoDigitWords(thousand) + " Thousand");

    const hundred = Math.floor(num / 100);
    num %= 100;
    if (hundred > 0) parts.push(ones[hundred] + " Hundred");

    if (num > 0) {
        if (parts.length > 0) parts.push("and");
        parts.push(getTwoDigitWords(num));
    }

    return parts.join(" ");
}


function ActionSet(id){
alert(id);
	switch(id)
	{
		case 1:
				alert(document.BudgetHead.id);
				//alert(document.OpenVehicleAvailForm.Lorry_Id.value);
				document.BudgetHead.action="<%=strPath%>OpenVoucher.do";
				break;
	}
	document.BudgetHead.submit();
	}
function ChkDt()
{
	var tyy =document.BudgetHead.YY.value;
	var tmm = document.BudgetHead.MM.value;
	var tdd =document.BudgetHead.DD.value;
	var _TDS =document.BudgetHead.Typetxt.value;
	var _txtTDS =document.BudgetHead.txtType.value;
	if(document.BudgetHead.txtAmt.value=="0" || document.BudgetHead.txtAmt.value=="0.00")
	{
		document.BudgetHead.txtAmt.value=document.BudgetHead.txtNetAmt.value;
	}
	if(_txtTDS.toString()=="")
	{
		document.BudgetHead.txtType.value = document.BudgetHead.Typetxt.value;
	}
	document.BudgetHead.txtDt.value=tyy+"-"+tmm+"-"+tdd;
	
	//alert(document.BudgetHead.txtNetAmt.value);
	if((document.BudgetHead.txtNetAmt.value).toString()=="")
	{
		alert("Enter Net Amount Value");
		document.BudgetHead.txtNetAmt.focus();
		return false;

	}
	else
	{
		
		//alert(document.BudgetHead.txtNetAmt.value);
		if(isNaN(document.BudgetHead.txtNetAmt.value))
		{
			alert("Enter Numaric Value only");
			document.BudgetHead.txtNetAmt.focus();
			return false;
		}
	}
	
	//alert(document.BudgetHead.txtNetAmt.value);
	//alert(document.BudgetHead.txtTds.value);
	if(document.BudgetHead.txtTds.value=="")
	{
		alert("Enter TDS/Bank Amount Value");
		document.BudgetHead.txtTds.focus();
		return false;
	}
	else
	{
	//	alert(document.BudgetHead.txtTds.value);
		if(isNaN(document.BudgetHead.txtTds.value))
		{
			alert("Enter Numaric Value only");
			document.BudgetHead.txtTds.focus();
			return false;
		}
	}
	
	//BudgetHead.txtsession.value = BudgetHead.session(BudgetHead.session.selectedIndex).text;
	document.BudgetHead.submit();
}
    

function handleEnter(fieldname,frm){
	 var keyCode = event.keyCode ? event.keyCode : event.which ? event.which : event.charCode;
	 if (keyCode == 13){
		eval('document.'+frm+'.'+fieldname+'.focus()');
	}
}
</script>


   <form name="BudgetHead" method="post" action="SaveVoucher.do">
   <input type="hidden" name="txtMode" value="<%=bMode%>">
   <input type="hidden" name="txtId" value="<%=strVoucherId%>">  
   <input type="hidden" name="txtDt" value="">
   <input  type="hidden" name="budget_note_id" value="<%=budget_note_id%>"/>
   <input  type="hidden" name="HeadId" value="<%=HeadId%>"/>
   <input  type="hidden" name="strDepartmentId" value="<%=strDepartmentId%>"/>
	<td width="80%" valign="top">
    <table width="100%" border="0" cellspacing="1" cellpadding="1" align="center" style="padding-left:20px;">
      <tr> 
        <td colspan=5>&nbsp;</td>
      </tr>
      <tr> 
        <td width="200" class="innertitle" align="left">Department:</td>
        <td width="350" align="left"><%=strDepartmentNm%></td>
        <td width="100" class="innertitle" align="left">Voucher No</td>
        <td width="150" colspan="18" align="left"> <input type="text" name="txtNo" size="12" class="formfield" value=<%=strVoucherNo%>></td>
      </tr>
      <tr> 
        <td width="200" class="innertitle" align="left">Head Name</td>
        <td width="350" align="left"> <div align="left"> 
            <%=budget_head_name%>
          </div></td>
        <td width="100" class="innertitle" align="left"> <div align="left">Date</div></td>
        <td colspan="2" align="left" width="150"> <select name="DD" class="formfield" >
            <% for(int i=1;i<=31;i++)
	            { 

	             if(i<10)
	             	Str="0"+(""+i).trim();
	             else
	             	Str=(""+i).trim();
	             	
	             	
	             if(strDD.equals(Str))
	             {
	    		%>
            <option value="<%=Str%>" selected><%=Str%></option>
            <% } else { %>
            <option value="<%=Str%>"><%=Str%></option>
            <% } } %>
          </select> <select name="MM" class="formfield" >
            <% for(int i=1;i<=12;i++)
		    { 
		     if(i<10)
			Str="0"+(""+i).trim();
		     else
			Str=(""+i).trim();
			
	             if(strMM.equals(Str))
	             {
	    		%>
            <option value="<%=Str%>" selected><%=Str%></option>
            <% } else { %>
            <option value="<%=Str%>"><%=Str%></option>
            <% } } %>
          </select> <select name="YY" class="formfield" >
            <% for(int i=2000;i<=2050;i++)
            { 
	        Str=""+i;
	     	if(strYY.equals(Str.trim()))
	     	{
		%>
            <option value="<%=Str%>" selected><%=Str%></option>
            <% } else { %>
            <option value="<%=i%>"><%=i%></option>
            <% }  } %>
          </select></td>
      </tr>
      <tr> 
        <td width="100" class="innertitle" align="left">Budget Note Number
		<Input type = "hidden" Name= "txtsession">
		</td>
        <td   width="350" align="left"> <div align="left"> 
             <%=budget_note_id%>
          </div></td>
        <td width="100" class="innertitle" align="left"> <div align="left">Acc No</div></td>
		<td  class="innertitle" align="left"> <input type="text" name="txtAccNo" size="25" class="formfield" value="<%=strAccountNo%>" onKeyPress="handleEnter('txtReceiver','BudgetHead')"> 
        </td>

      </tr>
      <tr> 
        <td colspan="2" align="center" > <table width="65%" border="1" cellspacing="1" cellpadding="1" align="left" style="<%=strCol2%>">
            <tr> 
              <td width="64%" align="left" class="innertitle" > Allocate <font size="1">(Rs.)</font> 
              </td>
              <td width="36%" align="left" class="innertitle"> <input type="text" name="allocated_amount" size="12" class="formfield" value="<%=allocated_amount%>" readonly></td>
            </tr>
            <tr> 
              <td align="left" class="innertitle"> Already spend <font size="1">(Rs.)</font> 
              </td>
              <td align="left" class="innertitle"> <input type="text" name="dblUtilisedAmount" size="12" class="formfield" value="<%=dblUtilisedAmount%>" readonly></td>
            </tr>
            <tr> 
              <td align="left" class="innertitle"> Balance <font size="1">(Rs.)</font> 
              </td>
              <td align="left" class="innertitle"> <input type="text" name="BallanceAmount" size="12" class="formfield" value="<%=BallanceAmount%>" readonly></td>
            </tr>
			<tr> 
              <td align="left" class="innertitle"> Budget Note Amount <font size="1">(Rs.)</font> 
              </td>
              <td align="left" class="innertitle"> <input type="text" name="budget_note_expense" size="12" class="formfield" value="<%=remain_NoteBallance%>0" readonly>	
              </td>
            </tr>
          </table></td>
        <td colspan=3 align="left"> <table width="65%" border="1" cellspacing="1" cellpadding="1" align="left">
            <tr> 
              <td width="37%" align="left" class="innertitle">Amount <font size="1">(Rs.)</font> 
              </td>
              <td width="63%" align="left" class="innertitle"> <input type="text" name="txtAmt" size="12" class="formfield" value="<%=bMode.equals("1")?"0.00":dblAmount%>" onKeyPress="handleEnter('txtAcc','BudgetHead')" > 
              </td>
            </tr>
            <tr> 
              <td align="left" class="innertitle"> <select name="Typetxt">
                  <%
              	boolean Stat=true;
              	if(strType.equals("TDS") || strType.equals("Bank Commission") || strType.equals("Deduction") || strType.equals("Adjusted to fees A/c"))
              		Stat=false;     
              %>
                  <Option value="TDS" <%=strType.equals("TDS")?"Selected":""%> >TDS</Option>
                  <Option value="Bank Commission" <%=strType.equals("Bank Commission")?"Selected":""%>>Bank 
                  Commission</Option>
                  <Option value="Deduction" <%=strType.equals("Deduction")?"Selected":""%>>Deduction</Option>
				  <Option value="Adjusted to fees A/c" <%=strType.equals("Adjusted to fees A/c")?"Selected":""%>>Adjusted to fees A/c</Option>
                </select> <input type="text" name="txtType" value="<%=Stat?strType:""%>"></td>
              <td align="left"> 
                <% if( dblTds.length()>0){ %>
                <input type="text" name="txtTds" size="12" class="formfield" value="<%=dblTds%>"  onBlur="calcAmount()" onKeyPress="handleEnter('txtAmt','BudgetHead')"> 
                <% }else{ %>
                <input type="text" name="txtTds" size="12" class="formfield" value="0" onBlur="calcAmount()" onKeyPress="handleEnter('txtAmt','BudgetHead')" >	
                <% }%>
              </td>
            </tr>
            <tr> 
              <td align="left" class="heading"><font size="2">Net Amount </font><font size="1">(Rs.)</font> 
              </td>
              <td align="left"> <input type="text" name="txtNetAmt" size="12" class="formfield" value="<%=bMode.equals("1")?dblAmount:amt%>" onKeyPress="handleEnter('txtTds','BudgetHead')" onBlur="calcAmount()"> 
              </td>
            </tr>
          </table></td>
      </tr>
      <tr> 
        <td align="left" class="innertitle" width="200"> Rupees <font size="1">(in 
          words)</font> </td>
        <td colspan=3 class="innertitle" align="left"> <input type="text" name="txtWord" size="52" class="formfield" value="" disabled> 
        </td>
      </tr>
      <tr> 
        <td align="left" class="innertitle" width="200"> On Account Of </td>
        <td colspan=3 class="innertitle" align="left"> <input type="text" name="txtAcc" size="52" class="formfield" value="<%=strToAcc%>" onKeyPress="handleEnter('txtReceiver','BudgetHead')"> 
        </td>
      </tr>
      <tr> 
        <td align="left" class="innertitle" width="200">TDS Narration</td>
        <td colspan=3 class="innertitle" align="left"><input type="text" name="txtTDS" size="52" class="formfield" value="<%=strTDS%>" onKeyPress="handleEnter('txtReceiver','BudgetHead')"></td>
      </tr>
      <tr> 
        <td width="200" height="81" align="left" class="innertitle"> Receiver </td>
        <td colspan=3 class="innertitle" align="left"> <input type="text" name="txtReceiver" size="52" class="formfield" value="<%=strReceiverNm%>" > 
        </td>
      </tr>
      <tr> 
        <td align="left" class="innertitle" width="200"> Payment Mode </td>
        <td colspan=2 class="innertitle" align="right"> <input type="radio" name="rd" value="1" onClick="changeVisible(1)" <%=bMode.equals("1")?"Checked":""%> >
          Cash &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input type="radio" name="rd" value="2" onClick="changeVisible(2)" <%=bMode.equals("2")?"Checked":""%> >
          Cheque </td>
        <td align="left" class="innertitle">&nbsp; </td>
      </tr>
      <tr> 
        <td align="left" class="innertitle" width="200"> <div id="kk" style="visibility:<%=bMode.equals("1")?"hidden":""%>"> 
            Cheque No </div></td>
        <td colspan=3 class="innertitle" align="left"> <div align="left"></div>
          <div id="kk1" style="visibility:<%=bMode.equals("1")?"hidden":""%>"> 
            <input type="text" name="txtChqno" size="8" class="formfield" value="<%=strCheque%>"   onKeyPress="handleEnter('txtBank','BudgetHead')" onBlur="setVoucherNo()">
            Bank Details 
            <input type="text" name="txtBank" size="29" class="formfield" value="<%=strBank%>">
          </div></td>
      </tr>
      <tr> 
        <td colspan=4 align="center"> <div id="abc" style="visibility:hidden"> 
 </div>
		  <div id="val" style="position:relative; visibility:hidden; width: 96px; height: 60px;"> 
          </div></td>
      </tr>
      <tr> 
        <td colspan=4 align="center">
           <input name="btnSub" type="Button" value="Submit" class="PPRSbmtBtn" onClick="return ChkDt()"> 
		   &nbsp; <input name="btnSub" type="Reset" value=" Reset " class="PPRSbmtBtn"> 
        </td>
      </tr>
    </table>
  
</td>
   </form>
<%@ include file="/jsp/include/footer.jsp" %>
