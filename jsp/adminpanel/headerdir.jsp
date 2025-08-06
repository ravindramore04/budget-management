<%@ page import="java.util.*,login.*" %>
<%
    HashMap hmUser = (HashMap)session.getAttribute("user");
    String User="Not Define";
	if(hmUser!=null && hmUser.size()>0){
    	User = (String)hmUser.get("UNm");
    }
	 String strPathDir = "/budget-management/";
%>
<td width="20%" class="innertitle" bgcolor="#fff" height="100%" valign="top" >
	<table width="100%" bgcolor="#e2e2e2" cellspacing="1">
		<tr valign="top">
			<td width="100%" class="heading" bgcolor="#d4dae2" style="padding:8px 7px; text-transform: capitalize;"><b>
				<%=User%></b>
			</td>
		</tr>
		<tr valign="top">
			<td width="100%" bgcolor="#95A5A6" onMouseOver="this.style.backgroundColor='#d4dae2'" onMouseOut="this.style.backgroundColor='#95A5A6'" style="padding:7px 10px;">
				<a class="linktext" href="<%=strPathDir+"ViewRpt.do"%>">View Reports</a>
			</td>
		</tr>
		<tr valign="top">
			<td width="100%" bgcolor="#95A5A6" onMouseOver="this.style.backgroundColor='#d4dae2'" onMouseOut="this.style.backgroundColor='#95A5A6'" style="padding:7px 10px;">
				<a class="linktext" href="<%=strPathDir+"ExcelReport.do"%>">Excel Report</a>
			</td>
		</tr>
		<tr valign="top">
			<td width="100%" bgcolor="#95A5A6" onMouseOver="this.style.backgroundColor='#d4dae2'" onMouseOut="this.style.backgroundColor='#95A5A6'" style="padding:7px 10px;">
				<a class="linktext" href="<%=strPathDir+"RptHeadWise.do"%>">View Head Wise Reports</a>
			</td>
		</tr>
		
		<tr valign="top">
			<td width="100%" bgcolor="#95A5A6" onMouseOver="this.style.backgroundColor='#d4dae2'" onMouseOut="this.style.backgroundColor='#95A5A6'" style="padding:7px 10px;">
				<a class="linktext" href="<%=strPathDir+"Logout.do"%>">Logout</a>
			</td>
		</tr>
	</table>
</td>