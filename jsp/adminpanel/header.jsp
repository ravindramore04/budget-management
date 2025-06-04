*<%@ include file="/jsp/include/header.jsp" %>
<%
    HashMap hmUser = (HashMap)session.getAttribute("user");
    String User="Not Define";
   // out.println("hmUser--"+hmUser);
	if(hmUser!=null && hmUser.size()>0){
    	User = (String)hmUser.get("UNm");
    }
%>
<td width="20%" class="innertitle" bgcolor="#fff" height="100%" valign="top" >
	<table width="100%" bgcolor="#e2e2e2" cellspacing="1">
		<tr valign="top">
			<td width="100%" class="heading" bgcolor="#d4dae2" style="padding:8px 7px; text-transform: capitalize;"><b>
				<%=User%></b>
			</td>
		</tr>
		<%if(isAccount){%>
		<tr valign="top">

		    <td width="100%" bgcolor="#95A5A6" onMouseOver="this.style.backgroundColor='#d4dae2'" onMouseOut="this.style.backgroundColor='#95A5A6'" style="padding:7px 10px;"><a class="linktext" href="<%=strPath+"Organisation.do"%>">Organisation
		      </a> </td>
		</tr>
		<tr valign="top" >

		    <td width="100%" bgcolor="#95A5A6" onMouseOver="this.style.backgroundColor='#d4dae2'" onMouseOut="this.style.backgroundColor='#95A5A6'" style="padding:7px 10px;"><a class="linktext" href="<%=strPath+"AllUser.do"%>">Users
		      </a> </td>
		</tr>
		<tr valign="top">
			<td width="100%" bgcolor="#95A5A6" onMouseOver="this.style.backgroundColor='#d4dae2'" onMouseOut="this.style.backgroundColor='#95A5A6'" style="padding:7px 10px;">
				<a class="linktext" href="<%=strPath+"AllGroup.do"%>">Department</a>
			</td>
		</tr>
		<tr valign="top">
			<td width="100%" bgcolor="#95A5A6" onMouseOver="this.style.backgroundColor='#d4dae2'" onMouseOut="this.style.backgroundColor='#95A5A6'" style="padding:7px 10px;">
				<a class="linktext" href="<%=strPath+"AllHead.do"%>">Budget Heads</a>
			</td>
		</tr>
		<tr valign="top">
			<td width="100%" bgcolor="#95A5A6" onMouseOver="this.style.backgroundColor='#d4dae2'" onMouseOut="this.style.backgroundColor='#95A5A6'" style="padding:7px 10px;">
				<a class="linktext" href="<%=strPath+"AllBudgetAllocation.do"%>">Budget Allocation</a>
			</td>
		</tr>
		<tr valign="top">
			<td width="100%" bgcolor="#95A5A6" onMouseOver="this.style.backgroundColor='#d4dae2'" onMouseOut="this.style.backgroundColor='#95A5A6'" style="padding:7px 10px;">
				<a class="linktext" href="<%=strPath+"ChngPswd.do"%>">Change Password</a>
			</td>
		</tr>
		<!--tr valign="top">
        <td width="100%" bgcolor="#95A5A6" onMouseOver="this.style.backgroundColor='#d4dae2'" onMouseOut="this.style.backgroundColor='#95A5A6'" style="padding:7px 10px;"> <a class="linktext" href="<%=strPath+"NewFinanceYear.do"%>">Finance Year</a> </td>
		</tr-->
		<%}%>
		<tr>
		<td width="100%" bgcolor="#95A5A6" onMouseOver="this.style.backgroundColor='#d4dae2'" onMouseOut="this.style.backgroundColor='#95A5A6'" style="padding:7px 10px;"> <a class="linktext" href="<%=strPath+"AllHeadForBudgetNote.do"%>">Create
        Budget Note</a> </td>
		</tr>
		<tr>
		<td width="100%" bgcolor="#95A5A6" onMouseOver="this.style.backgroundColor='#d4dae2'" onMouseOut="this.style.backgroundColor='#95A5A6'" style="padding:7px 10px;"><a class="linktext" href="<%=strPath+"BudgetNoteList.do"%>">Budget Note List</a> </td>
		</tr>
		<%if(isAccount){%>
		<tr>
		<td width="100%" bgcolor="#95A5A6" onMouseOver="this.style.backgroundColor='#d4dae2'" onMouseOut="this.style.backgroundColor='#95A5A6'" style="padding:7px 10px;"><a class="linktext" href="<%=strPath+"AllVoucher.do"%>">Voucher</a> </td>
		</tr>
		<%}%>
		<tr valign="top">
			<td width="100%" bgcolor="#95A5A6" onMouseOver="this.style.backgroundColor='#d4dae2'" onMouseOut="this.style.backgroundColor='#95A5A6'" style="padding:7px 10px;">
				<a class="linktext" href="<%=strPath+"RptGtp.do"%>">View Reports</a>
			</td>
		</tr>
		<tr valign="top">
			<td width="100%" bgcolor="#95A5A6" onMouseOver="this.style.backgroundColor='#d4dae2'" onMouseOut="this.style.backgroundColor='#95A5A6'" style="padding:7px 10px;">
				<a class="linktext" href="<%=strPath+"ExcelReport.do"%>">Excel Report</a>
			</td>
		</tr>
		<tr valign="top">
			<td width="100%" bgcolor="#95A5A6" onMouseOver="this.style.backgroundColor='#d4dae2'" onMouseOut="this.style.backgroundColor='#95A5A6'" style="padding:7px 10px;">
				<a class="linktext" href="<%=strPath+"RptHeadWise.do"%>">View Head Wise Reports</a>
			</td>
		</tr>
		<tr valign="top">
			<td width="100%" bgcolor="#95A5A6" onMouseOver="this.style.backgroundColor='#d4dae2'" onMouseOut="this.style.backgroundColor='#95A5A6'" style="padding:7px 10px;">
				<a class="linktext" href="<%=strPath+"Logout.do"%>">Logout</a>
			</td>
		</tr>
	</table>
</td>