<%@ include file="/jsp/adminpanel/header.jsp" %>
<%@ page import="java.util.Calendar,java.util.HashMap" %>
<%
    Calendar cal = Calendar.getInstance();
    int year  = cal.get(Calendar.YEAR);
    int month = cal.get(Calendar.MONTH) + 1;
    int day   = cal.get(Calendar.DAY_OF_MONTH);
    String today = String.format("%04d-%02d-%02d", year, month, day);
    int nCurrent_Page = 0, nTotal_pages = 0;
    String bgNm = (String)request.getAttribute("deptId");
	String readOnlyDept="";
	if(!SessionUtils.isAccountUser(session)){
	 readOnlyDept="disabled";
	}
    @SuppressWarnings("unchecked")
    HashMap<String,Object> hmGroup = (HashMap<String,Object>) request.getAttribute("department");
    @SuppressWarnings("unchecked")
    HashMap<String,Object> hmData  = (HashMap<String,Object>) request.getAttribute("data");
    @SuppressWarnings("unchecked")
    HashMap<String,String> hmPage  = (HashMap<String,String>) request.getAttribute("page");

    if (hmPage != null && !hmPage.isEmpty()) {
        nCurrent_Page = Integer.parseInt(hmPage.get("current_page"));
        nTotal_pages  = Integer.parseInt(hmPage.get("total_page"));
    }
%>

<script type="text/javascript">
function navigation(code) {
  document.HeadList.NAV.value = code;
  document.HeadList.action = "<%=strPath + "AllHead.do"%>";
  document.HeadList.submit();
}

function setAction(code, id) {
  document.HeadList.id.value = id;
  document.HeadList.opr.value = code;
  switch(code) {
    case 1:
      document.HeadList.action = "<%=strPath + "viewheadrept.do"%>";
      break;
    case 2:
      document.HeadList.action = "<%=strPath + "viewheadrept.do"%>";
	  document.HeadList.NAV.value = "print";
      break;
    case 3:
      document.HeadList.action = "<%=strPath + "DeleteHead.do"%>";
      break;
    case 4:
      document.HeadList.action = "<%=strPath + "jsp/adminpanel/panel.jsp"%>";
      break;
	case 5:
      document.HeadList.action = "<%=strPath + "RptParam.do"%>";
      break;
  }
  document.HeadList.submit();
}
</script>

<form name="HeadList" method="post" action="#">
  <input type="hidden" name="id" value="" />
  <input type="hidden" name="opr" value="" />
  <input type="hidden" name="NAV" value="" />
  <input type="hidden" name="strDepartmentIdOtherDept" value="<%=bgNm%>" />
<td width="80%" valign="top" align="center">
  <table width="80%" border="0" cellspacing="1" cellpadding="1" align="center">
    <tr bgcolor="<%=strColHd%>">
      <td colspan="4" class="titles" align="center">
        <!-- You can put a heading here -->
      </td>
    </tr>

    <!-- Department Selection -->
	
    <tr>
      <td width="37%" class="innertitle" align="right">Department Name</td>
      <td width="63%" colspan="3">
        <select name="strDepartmentId" <%=readOnlyDept%> class="formfield">
          <option value="0">-------Select---------</option>
          <%
            if (hmGroup != null) {
              for (int i = 0; i < hmGroup.size(); i++) {
                @SuppressWarnings("unchecked")
                HashMap<String,String> h = (HashMap<String,String>) hmGroup.get(""+i);
                String id   = h.get("strDepartmentId");
                String name = h.get("strDepartmentNm");
          %>
            <option value="<%=id%>" <%= id.equals(bgNm) ? "selected" : "" %>>
              <%=name%>
            </option>
          <%
              }
            }
          %>
        </select>
      </td>
    </tr>

    <!-- Date Range -->
    <tr>
      <td colspan="4" align="center">
        <label for="fromDate" class="innertitle">From Date:</label>
        <input type="date" class="formfield" id="fromDate" name="fromDate" value="<%=today%>" />
        &nbsp;&nbsp;
        <label for="toDate" class="innertitle">To Date:</label>
        <input type="date" class="formfield" id="toDate" name="toDate" value="<%=today%>" />
      </td>
    </tr>

    <!-- Head Selection -->
    <tr>
      <td colspan="4" align="center" class="innertitle"></td>
    </tr>
    <tr>
	  <td width="37%" class="innertitle" align="right">Select The Head from List</td>
      <td colspan="3" align="left">
        <select class="formfield" name="txtBGid">
          <option value="0">-------------------Select Head---------------------</option>
          <%
            if (hmData != null) {
              for (int i = 0; i < hmData.size(); i++) {
                @SuppressWarnings("unchecked")
                HashMap<String,String> d = (HashMap<String,String>) hmData.get(""+i);
                String hid  = d.get("HeadId");
                String hnm  = d.get("strName");
          %>
            <option value="<%=hid%>"><%=hnm%></option>
          <%
              }
            }
          %>
        </select>
      </td>
    </tr>

    <!-- Payment Type -->
    <tr>
      <td colspan="4" align="center">
        <input type="radio" name="rd" value="1" /> Cash
        <input type="radio" name="rd" value="2" /> Cheque
        <input type="radio" name="rd" value="3" checked /> Both
      </td>
    </tr>

    <!-- Buttons -->
    <tr bgcolor="<%=strColHd%>">
      <td colspan="4" align="center">
        <input type="button" name="btnSubmit" value="Submit" onClick="setAction(1,0)" class="PPRSbmtBtn" />
        &nbsp;
		<input type="button" name="btnSubmit" value="Print" onClick="setAction(2,0)" class="PPRSbmtBtn" />
		&nbsp;
        <input type="button" name="btnClose"  value="Close"  onClick="setAction(4,0)" class="PPRSbmtBtn" />
      </td>
    </tr>
  </table>
  </td>
</form>

<%@ include file="/jsp/include/footer.jsp" %>