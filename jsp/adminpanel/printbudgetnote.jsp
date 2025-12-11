<%@ page import="java.util.*,java.text.*" %>
<html>
<title>Budget Note</title>
<head>
    <style>
        body {
            font-family: Arial, sans-serif;
            line-height: 1.5;
            margin-left: 50px;
			margin-left: 30px;
        }
        .header {
            text-align: center;
			margin-bottom: -20px;
        }
        .header img {
            width: 450px;
            height: 80px;
        }
        .title {
            font-size: 16px;
            font-weight: bold;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        td {
            padding: 5px;
        }
        .section-header {
            font-weight: bold;
            font-size: 12px;
        }
        .value {
            font-weight: bold;
			font-size: 12px;
        }
        .signature-section {
            margin-top: 50px;
            text-align: center;
        }
        .signature-section td {
            width: 33%;
            text-align: center;
        }
        .signature-title {
            margin-top: 0px;
			margin-bottom: 0px;
            font-weight: bold;
			font-size: 12px;
        }
    </style>
</head>

<%
DecimalFormat d = new DecimalFormat("##0.00");
String strPath="/budget-management/";
HashMap hmData=(HashMap)request.getAttribute("budgetNoteInputData");
//out.println("budgetNoteInputData====>" + hmData);

String departmentName = "";
String headName = "";
String allocatedAmount = "";
String allocation_reserved_amount = "";
String utilisedAmount = "";
String availableBalance = "";
String budget_note_remark = "";
String budget_note_expense = "";
String balance_after_expense="";
String budget_note_status="";
String budget_note_id="";
String bal="";
String vou="";
String create_date="";
double expafterCurrentExpense=0.00;
double reverveAmt=0.00;
double balAmt=0.00;

String ponumber="";
String narration="";
String advanceReceiverName="";
String advance="0";

if(hmData!=null && hmData.size()>0){
         departmentName = (String)hmData.get("departmentName");
         headName = (String)hmData.get("headName");
         allocatedAmount = (String)hmData.get("allocatedAmount");
         allocation_reserved_amount = (String)hmData.get("reservedAmount");
         utilisedAmount = (String)hmData.get("utilisedAmount");
         availableBalance = (String)hmData.get("availableBalance");
		 budget_note_status=(String)hmData.get("budget_note_status");
		  budget_note_expense= (String)hmData.get("budget_note_expense");
	 	budget_note_remark=(String)hmData.get("budget_note_remark");
	 	balance_after_expense= (String)hmData.get("allocation_balance_amount_after_expense");
		budget_note_id=(String)hmData.get("budget_note_id");
		create_date=(String)hmData.get("create_date");
		narration=(String)hmData.get("narration");
		advanceReceiverName=(String)hmData.get("advanceReceiverName");
		advance=(String)hmData.get("advance");
		ponumber=(String)hmData.get("ponumber");
		
		reverveAmt=Double.parseDouble(allocation_reserved_amount)-Double.parseDouble(budget_note_expense);
			
		if(reverveAmt<0){
		reverveAmt=Double.parseDouble(allocation_reserved_amount);
		}
		balAmt=Double.parseDouble(allocatedAmount)-reverveAmt-Double.parseDouble(utilisedAmount);
		
		expafterCurrentExpense=balAmt-Double.parseDouble(budget_note_expense);
}


%>

<%!
public String formatIsoToEuropean(String isoDate) {
    try {
      SimpleDateFormat inFmt  = new SimpleDateFormat("yyyy-MM-dd");
      SimpleDateFormat outFmt = new SimpleDateFormat("dd-MM-yyyy");
      Date date = inFmt.parse(isoDate);
      return outFmt.format(date);
    } catch (Exception e) {
      return isoDate; // fallback on parse error
    }
  }
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
            document.HeadList.action = "<%=strPath+"PrintSingHead.do"%>";
            break;
        case 3:
            //delete done later
            document.HeadList.action = "<%=strPath+"OpenHead.do"%>";
            break;
        case 4:
            document.HeadList.action = "<%=strPath+"Close.do"%>";
            break;
        case 5:
            document.HeadList.action = "<%=strPath+"budgetNote.do"%>";
            break;
			
			
    }
    document.HeadList.opr.value=code;
    //document.HeadList.submit();
}

</script>
<body onLoad="javascript:print();setAction(5,0)">
    <form name="HeadList" method="post" action="#">
        <input type="hidden" name="page" value="PrintList">
        <input type="hidden" name="NAV" value="">
        <input type="hidden" name="txtBGid" value="<%=budget_note_id%>">
        <input type="hidden" name="id" value="">
        <input type="hidden" name="opr" value="">

        <div class="header">
            <img width="421" height="80" src="<%=strPath+ "html/_images/budget_note.jpg"%>" alt="Budget Note Logo">
            <div class="title">BUDGET NOTE 2025-2026</div>
        </div>

        <table border="1">
            <tr>
                <td  style="width: 350px;" class="section-header">Budget Note No.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=budget_note_id%></td>
                <td class="section-header" colspan="2">Date.</td>
                <td class="section-header"><%=formatIsoToEuropean(create_date)%></td>
            </tr>
            <tr>
                <td class="section-header">Department.</td>
                <td class="section-header" colspan="3"><%=departmentName%></td>
            </tr>
            <tr>
                <td class="section-header">Budget Head</td>
                <td class="section-header" colspan="3"><%=headName%></td>
            </tr>
            <tr>
                <td class="section-header">Budget Sanctioned</td>
                <td>Rs</td>
                <td class="value" colspan="2"><%=d.format(Double.parseDouble(allocatedAmount))%></td>
            </tr>
			<tr>
                <td class="section-header">Reserved Amount</td>
                <td>Rs</td>
                
      <td class="value" colspan="2"><%=d.format(reverveAmt)%></td>
            </tr>
            <tr>
                <td class="section-header">Budget Already spend</td>
                <td>Rs</td>
                <td class="value" colspan="2"><%=d.format(Double.parseDouble(utilisedAmount))%></td>
            </tr>
            <tr>
                <td class="section-header">Balance Budget</td>
                <td>Rs</td>
                <td class="value" colspan="2"><%=d.format(balAmt)%></td>
            </tr>
            <tr>
                <td class="section-header">This Expenditure</td>
                <td>Rs</td>
                <td class="value" colspan="2"><%=d.format(Double.parseDouble(budget_note_expense))%></td>
            </tr>
            <tr>
                <td class="section-header">Balance after Current Expenditure</td>
                <td>Rs</td>
                <td class="value" colspan="2"><%=availableBalance%></td>
              </tr>
			<tr>
                <td style="height: 60px; border: none;" valign="bottom" class="section-header" colspan="1" align="center">
				<div class="signature-title">
				<%
	if(ponumber != null){
	%>
	 Store &amp; Purchase Assistant
	<%}%>
				&nbsp;</div></td>
				<td style="height: 60px; border: none;" valign="bottom" class="section-header" colspan="3" align="center">
				<div class="signature-title">Head of Department</div>
				</td>
            </tr>
		 <tr>
            <td style="height: 50px;border-bottom: none;"  colspan="1">
                <div class="signature-title">&nbsp;</div>
            </td>
            <td valign="middle" style="border-bottom: none;"  colspan="3">
                <div class="signature-title">
				<% if("APPROVED".equals(budget_note_status)){ %>
                        Approved: Yes
                    <% } else { %>
                        Approved: Yes / No
                    <% } %>
				</div>
            </td>
        </tr>
		 <tr style="border-top: none;">
            <td style="border-top: none;" colspan="1" align="center">
                <div class="signature-title">Chief Accounts &amp; Finance Officer</div>
            </td>
            <td style="border-top: none;"  colspan="3" align="center">
                <div class="signature-title">Director</div>
            </td>
        </tr>
    </table>
	<%
	if(advance != null && "1".equals(advance)){
	%>
	<br>
	<br>
	<br>
	<br>
	
	<div class="header">
            <div class="title">ADVANCE REQUISITION NOTE<br>
(Expenditure details to be submitted and advance cleared within a week)</div>
        </div>
	<table border="1">
            <tr>
                <td  style="width: 300px;" class="section-header">Contact No.</td>
                <td class="section-header" colspan="2">&nbsp;</td>
                <td class="section-header">&nbsp;</td>
            </tr>
            <tr>
                <td class="section-header">Please Pay Rs.</td>
                <td class="section-header" colspan="3"><%=d.format(Double.parseDouble(budget_note_expense))%></td>
            </tr>
            <tr>
                <td class="section-header">Mr./Mrs.</td>
                <td class="section-header" colspan="3"><%=advanceReceiverName%></td>
            </tr>
            <tr>
                <td class="section-header">As an Advance for the purpose  of</td>
               <td class="section-header" colspan="3"><%=narration%></td>
            </tr>
			<tr>
                <td class="section-header">To Be Paid by Cash/Cheque No.</td>
              
      <td class="value" colspan="3">&nbsp;</td>
            </tr>
            <tr>
                <td class="section-header">Advance of Rs</td>
                <td>&nbsp;</td>
                <td class="section-header" colspan="2">is sanctioned</td>
            </tr>
           <tr>
                <td class="section-header">&nbsp;</td>
               <td class="value" colspan="3">&nbsp;</td>
            </tr>
             <tr>
                <td class="section-header" align="center">&nbsp;</td>
               <td class="value" colspan="3">&nbsp;</td>
            </tr> <tr>
                <td class="section-header" style="height: 60px;" valign="bottom"  colspan="1"  rowspan="" align="center">Signature Head of Dept.</td>
               <td class="value" colspan="3">&nbsp;</td>
            </tr>
			<tr>
                <td style="height: 60px;" valign="bottom"  colspan="1" align="center">
				<div class="signature-title">Signature of Receiver </div></td>
				<td style="height: 60px;" valign="bottom"  colspan="3" align="center">
				<div class="signature-title">Registrar</div>
				</td>
            </tr>
		 <tr>
            <td style="height: 50px;border-bottom: none;"  colspan="1">
                <div class="signature-title">&nbsp;</div>
            </td>
            <td valign="middle" style="border-bottom: none;"  colspan="3">&nbsp;
               
            </td>
        </tr>
		 <tr style="border-top: none;">
            <td style="border-top: none;" colspan="1" align="center">
                <div class="signature-title">Chief Accounts &amp; Finance Officer</div>
            </td>
            <td style="border-top: none;"  colspan="3" align="center">
                <div class="signature-title">Director</div>
            </td>
        </tr>
    </table>
	<%
	}
	%>
    </form>
</body>
</html>