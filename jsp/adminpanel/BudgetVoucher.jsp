<% //@page import="java.util.*" %>
<%@ include file="/jsp/userpanel/header.jsp" %>

<%
	session.setAttribute("itr", "1");
	String strId = "";
	String strName = "";
	String strAccNo = "";
	String strTDS="";
	String strRemark = "";
	
	String strVoucherId = "";
	String strVoucherNo = "";
	String HeadId = "";
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
	
	String strDD="";
	String strMM="";
	String strYY="";
        String Str="";
		String sesn="";	
	
	
	
	
	HashMap hmAll=(HashMap)request.getAttribute("all"); 
	//out.println("--hmAll--"+hmAll);
	HashMap PONo=(HashMap)request.getAttribute("PONo");
	//out.println("PONo--"+PONo); 
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
    
    	    txtWord.value=Num2Word(txtNetAmt.value);
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


   <form name="BudgetHead" method="post" action="../userpanel/SaveVoucher.do">
   <input type="hidden" name="txtMode" value="<%=bMode%>">
   <input type="hidden" name="txtId" value="<%=strVoucherId%>">  
   <input type="hidden" name="txtDt" value="">
	<td width="80%" valign="top">
    <table width="100%" border="0" cellspacing="1" cellpadding="1" align="center" >
      <tr> 
        <td colspan=5>&nbsp;</td>
      </tr>
      <tr> 
        <td width="200" class="innertitle" align="left">Department:</td>
        <td width="350" align="left">&nbsp;</td>
        <td width="100" class="innertitle" align="right">Voucher No</td>
        <td width="150" colspan="18" align="right"> <input type="text" name="txtNo" size="12" class="formfield" value=<%=strVoucherNo%>></td>
      </tr>
      <tr> 
        <td width="200" class="innertitle" align="left">Head Name</td>
        <td width="350" align="left"> <div align="right"> 
            <select name="txtHeadId" class="formfield"  onchange="setSesn(value)">
              <option value="">Select Budget Head</option>
              <%
				    if(hmAll!=null && hmAll.size()>0){
				    	for(int indx=0;indx<hmAll.size();indx++){
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
  
							%>
							
              <OPTION value="<%=strTempId%>" <%=strTempId.equals(HeadId)?"selected":"" %> ><%=strTempName%></option>
              <%
 				
				    	}

				    }
	
 		
		
				%>
            </select>
          </div></td>
        <td width="100" class="innertitle" align="left"> <div align="right">Date</div></td>
        <td colspan="2" align="right" width="150"> <select name="DD">
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
          </select> <select name="MM">
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
          </select> <select name="YY">
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
        <td   width="350" align="left"> <div align="right"> 
             Number
          </div></td>
        <td width="100" class="innertitle" align="left"> <div align="right">Acc No</div></td>
		<td  class="innertitle" align="right"> <input type="text" name="txtAccNo" size="25" class="formfield" value="<%=strAccountNo%>" onKeyPress="handleEnter('txtReceiver','BudgetHead')"> 
        </td>

      </tr>
      <tr> 
        <td colspan="2" align="center" > <table width="65%" border="1" cellspacing="1" cellpadding="1" align="Right" bgcolor="<%=strCol2%>">
            <tr> 
              <td width="64%" align="left" class="innertitle" > Allocate <font size="1">(Rs.)</font> 
              </td>
              <td width="36%" align="left" class="innertitle"> <input type="text" name="txtAllo" size="12" class="formfield" value="<%=strAllocate%>" disabled>	
              </td>
            </tr>
            <tr> 
              <td align="left" class="innertitle"> Already spend <font size="1">(Rs.)</font> 
              </td>
              <td align="left" class="innertitle"> <input type="text" name="txtExp" size="12" class="formfield" value="<%=strexp%>" disabled>	
              </td>
            </tr>
            <tr> 
              <td align="left" class="innertitle"> Balance <font size="1">(Rs.)</font> 
              </td>
              <td align="left" class="innertitle"> <input type="text" name="txtBal" size="12" class="formfield" value="<%=strBalance%>" disabled>	
              </td>
            </tr>
			<tr> 
              <td align="left" class="innertitle"> Budget Note Amount <font size="1">(Rs.)</font> 
              </td>
              <td align="left" class="innertitle"> <input type="text" name="budgetNoteAmount" size="12" class="formfield" value="<%=strBalance%>" disabled>	
              </td>
            </tr>
          </table></td>
        <td colspan=3 align="center"> <table width="65%" border="1" cellspacing="1" cellpadding="1" align="center">
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
                <input type="text" name="txtTds" size="12" class="formfield" value="<%=dblTds%>"  onKeyPress="handleEnter('txtAmt','BudgetHead')"> 
                <% }else{ %>
                <input type="text" name="txtTds" size="12" class="formfield" value="0" onKeyPress="handleEnter('txtAmt','BudgetHead')" >	
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
        <td colspan=3 class="innertitle" align="right"> <input type="text" name="txtWord" size="52" class="formfield" value="" disabled> 
        </td>
      </tr>
      <tr> 
        <td align="left" class="innertitle" width="200"> On Account Of </td>
        <td colspan=3 class="innertitle" align="right"> <input type="text" name="txtAcc" size="52" class="formfield" value="<%=strToAcc%>" onKeyPress="handleEnter('txtReceiver','BudgetHead')"> 
        </td>
      </tr>
      <tr> 
        <td align="left" class="innertitle" width="200">TDS Narration</td>
        <td colspan=3 class="innertitle" align="right"><input type="text" name="txtTDS" size="52" class="formfield" value="<%=strTDS%>" onKeyPress="handleEnter('txtReceiver','BudgetHead')"></td>
      </tr>
      <tr> 
        <td align="left" class="innertitle" width="200"> Receiver </td>
        <td colspan=3 class="innertitle" align="right"> <input type="text" name="txtReceiver" size="52" class="formfield" value="<%=strReceiverNm%>" > 
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
          </select> </div>
		  <div id="val" style="position:relative; visibility:hidden; width: 96px; height: 60px;"> 
            <%
	 System.out.println("milin----> po ----> "+PONo);
	 if(hmAll!=null && hmAll.size()>0){
		for(int indx=0;indx<hmAll.size();indx++){
			HashMap hmt2 = (HashMap)hmAll.get(""+indx);
			String strTempId = (String)hmt2.get("HeadId");
			//System.out.println("milin----"+indx+"----> "+strTempId);
			if(PONo!=null && PONo.size()>0){
				System.out.println("milin----"+strTempId+"----> "+PONo);
				HashMap hmt = (HashMap)PONo.get(strTempId);
				if(hmt!=null && hmt.size()>0){
				System.out.println("milin----"+2+"----> inside" +hmt);
					%>
            <Select name="<%=strTempId%>">
              <option value="">----Select----</option>
              <%
						//out.println("The Sisssion Id= "+strTempId);
						for(int j=0;j<hmt.size();j++){
							String nPONo = (String)hmt.get(""+j);
							 //String nPONo = (String)hmmt.get("nPONo");
							 System.out.println("---PO No---"+nPONo);
							
							%>
              <option value="<%=strTempId%>" <%=nPONo.equals(upstrPONo)?"selected":"" %>><%=nPONo%></option>
              <%
						}
					%>
            </Select>
            <%
				}
			}
		}
	}
%>
          </div></td>
      </tr>
      <tr> 
        <td colspan=4 align="center"> <input name="btnSub" type="Reset" value=" Reset " class="PPRSbmtBtn"> 
          &nbsp; <input name="btnSub" type="Button" value="Submit" class="PPRSbmtBtn" onClick="return ChkDt()"> 
        </td>
      </tr>
    </table>
  
</td>
   </form>
<%@ include file="/jsp/include/footer.jsp" %>
