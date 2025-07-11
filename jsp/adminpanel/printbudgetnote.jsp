<%@ page import="java.util.*,java.text.*" %>
<html>
<title>Budget Note</title>
<head>
    <style>
        body {
            font-family: Arial, sans-serif;
            line-height: 1.5;
            margin: 30px;
        }
        .header {
            text-align: center;
        }
        .header img {
            width: 600px;
            height: 100px;
        }
        .title {
            font-size: 24px;
            font-weight: bold;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        td {
            padding: 10px;
        }
        .section-header {
            font-weight: bold;
            font-size: 16px;
        }
        .value {
            font-weight: bold;
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
            margin-top: 10px;
            font-weight: bold;
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
            <img src="<%=strPath+ "html/_images/budget_note.jpg"%>" alt="Budget Note Logo">
            <div class="title">BUDGET NOTE 2025-2026</div>
        </div>

        <table border="1">
            <tr>
                <td class="section-header">Sr.No.</td>
                <td><%=budget_note_id%></td>
				<td class="section-header">Date.</td>
                <td><%=formatIsoToEuropean(create_date)%></td>
            </tr>
            <tr>
                <td class="section-header">Department.</td>
                <td colspan="3"><%=departmentName%></td>
            </tr>
            <tr>
                <td class="section-header">Budget Head</td>
                <td colspan="3"><%=headName%></td>
            </tr>
            <tr>
                <td class="section-header">Budget Sanctioned</td>
                <td>Rs</td>
                <td class="value" colspan="2"><%=allocatedAmount%></td>
            </tr>
            <tr>
                <td class="section-header">Budget Already spend</td>
                <td>Rs</td>
                <td class="value" colspan="2"><%=utilisedAmount%></td>
            </tr>
            <tr>
                <td class="section-header">Balance Budget</td>
                <td>Rs</td>
                <td class="value" colspan="2"><%=availableBalance%></td>
            </tr>
            <tr>
                <td class="section-header">This Expenditure</td>
                <td>Rs</td>
                <td class="value" colspan="2"><%=budget_note_expense%></td>
            </tr>
            <tr>
                <td class="section-header">Balance after Current Expenditure</td>
                <td>Rs</td>
                <td class="value" colspan="2"><%=balance_after_expense%></td>
              </tr>
			<tr>
                <td class="section-header" colspan="3">&nbsp;</td>
				<td class="section-header" align="center">
				<% if("APPROVED".equals(budget_note_status)){ %>
                        APPROVED: Yes
                    <% } else { %>
                        APPROVED: Yes / No
                    <% } %></td>
            </tr>
        </table>
		        
  <div class="signature-section">
    <table border="1" style="border-collapse: collapse; width:100%;">
		 <tr>
            <td style="height: 100px; border-bottom: none;" >
                <div class="signature-title">Store &amp; Purchase Assistant</div>
            </td>
            <td valign="middle" style="border-bottom: none;">
                <div class="signature-title">Head of Department</div>
            </td>
        </tr>
		 <tr style="border-top: none;">
            <td style="border-top: none;">
                <div class="signature-title">Chief Accounts &amp; Finance Officer</div>
            </td>
            <td style="border-top: none;">
                <div class="signature-title">Director</div>
            </td>
        </tr>
    </table>
</div>
    </form>
</body>
</html>