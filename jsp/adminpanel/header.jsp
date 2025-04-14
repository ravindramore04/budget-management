<%@ include file="/jsp/include/header.jsp" %>
<%
    HashMap hmUser = (HashMap)session.getAttribute("user");
    String User="Not Define";
   // out.println("hmUser--"+hmUser);
	if(hmUser!=null && hmUser.size()>0){
    	User = (String)hmUser.get("UNm");
    }
%>
<td width="20%" class="innertitle" bgcolor="#E6F3FF" height="100%" valign="top" >
	<table width="100%" bgcolor="#333399" cellspacing="1">
		<tr valign="top">
			<td width="100%" class="heading" bgcolor="#99CCFF"><b>
				<%=User%></b>
			</td>
		</tr>
		<tr valign="top">

		    <td width="100%" bgcolor="#99CCFF" onMouseOver="this.style.backgroundColor='#cccccc'" onMouseOut="this.style.backgroundColor='#99CCFF'" > &nbsp;&nbsp;&nbsp;&nbsp;<a class="linktext" href="<%=strPath+"Organisation.do"%>">Organisation 
		      </a> </td>
		</tr>
		<tr valign="top" >

		    <td width="100%" bgcolor="#99CCFF" onMouseOver="this.style.backgroundColor='#cccccc'" onMouseOut="this.style.backgroundColor='#99CCFF'"> &nbsp;&nbsp;&nbsp;&nbsp;<a class="linktext" href="<%=strPath+"AllUser.do"%>">Users 
		      </a> </td>
		</tr>
		<tr valign="top">
			<td width="100%" bgcolor="#99CCFF" onMouseOver="this.style.backgroundColor='#cccccc'" onMouseOut="this.style.backgroundColor='#99CCFF'">
				&nbsp;&nbsp;&nbsp;&nbsp;<a class="linktext" href="<%=strPath+"AllGroup.do"%>">Department</a>
			</td>
		</tr>
		<tr valign="top">
			<td width="100%" bgcolor="#99CCFF" onMouseOver="this.style.backgroundColor='#cccccc'" onMouseOut="this.style.backgroundColor='#99CCFF'">
				&nbsp;&nbsp;&nbsp;&nbsp;<a class="linktext" href="<%=strPath+"AllHead.do"%>">Budget Heads</a>
			</td>
		</tr>
		<tr valign="top">
			<td width="100%" bgcolor="#99CCFF" onMouseOver="this.style.backgroundColor='#cccccc'" onMouseOut="this.style.backgroundColor='#99CCFF'">
				&nbsp;&nbsp;&nbsp;&nbsp;<a class="linktext" href="<%=strPath+"AllBudgetAllocation.do"%>">Budget Allocation</a>
			</td>
		</tr>
		<tr valign="top">
			<td width="100%" bgcolor="#99CCFF" onMouseOver="this.style.backgroundColor='#cccccc'" onMouseOut="this.style.backgroundColor='#99CCFF'">
				&nbsp;&nbsp;&nbsp;&nbsp;<a class="linktext" href="<%=strPath+"ChngPswd.do"%>">Change Password</a>
			</td>
		</tr>
		<tr valign="top">
			<td width="100%" bgcolor="#99CCFF" onMouseOver="this.style.backgroundColor='#cccccc'" onMouseOut="this.style.backgroundColor='#99CCFF'">
				&nbsp;&nbsp;&nbsp;&nbsp;<a class="linktext" href="<%=strPath+"RptGtp.do"%>">View Reports</a>
			</td>
		</tr>
		<tr valign="top">
			<td width="100%" bgcolor="#99CCFF" onMouseOver="this.style.backgroundColor='#cccccc'" onMouseOut="this.style.backgroundColor='#99CCFF'">
				&nbsp;&nbsp;&nbsp;&nbsp;<a class="linktext" href="<%=strPath+"RptHeadWise.do"%>">View Head Wise Reports</a>
			</td>
		</tr>
		<tr valign="top">
			<td width="100%" bgcolor="#99CCFF" onMouseOver="this.style.backgroundColor='#cccccc'" onMouseOut="this.style.backgroundColor='#99CCFF'">
				&nbsp;&nbsp;&nbsp;&nbsp;<a class="linktext" href="<%=strPath+"RptPO.do"%>">PO Reports</a>
			</td>
		</tr>
		<tr valign="top">
			<td width="100%" bgcolor="#99CCFF" onMouseOver="this.style.backgroundColor='#cccccc'" onMouseOut="this.style.backgroundColor='#99CCFF'">
				&nbsp;&nbsp;&nbsp;&nbsp;<a class="linktext" href="<%=strPath+"MainRptPO.do"%>">Main PO Reports</a>
			</td>
		</tr>
		<tr valign="top">
		    <td width="100%" bgcolor="#99CCFF" onMouseOver="this.style.backgroundColor='#cccccc'" onMouseOut="this.style.backgroundColor='#99CCFF'"> &nbsp;&nbsp;&nbsp;&nbsp;<a class="linktext" href="<%=strPath+"jsp/userpanel/panel.jsp"%>">User 
		      Area</a> </td>
		</tr>
		<tr valign="top">
		    
      <td width="100%" bgcolor="#99CCFF" onMouseOver="this.style.backgroundColor='#cccccc'" onMouseOut="this.style.backgroundColor='#99CCFF'"> &nbsp;&nbsp;&nbsp;&nbsp;<a class="linktext" href="<%=strPath+"NewFinanceYear.do"%>">Finance Year</a> </td>
		</tr>
		
		<tr valign="top">
		    
      <td width="100%" bgcolor="#99CCFF" onMouseOver="this.style.backgroundColor='#cccccc'" onMouseOut="this.style.backgroundColor='#99CCFF'"> &nbsp;&nbsp;&nbsp;&nbsp;<a class="linktext" href="<%=strPath+"CrtRptGtp.do"%>">Create 
        Budget<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Note</a> </td>
		</tr>
		
		<td width="100%" bgcolor="#99CCFF" onMouseOver="this.style.backgroundColor='#cccccc'" onMouseOut="this.style.backgroundColor='#99CCFF'"> &nbsp;&nbsp;&nbsp;&nbsp;<a class="linktext" href="<%=strPath+"AllHeadForBudgetNote.do"%>">Create 
        Budget New<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Note</a> </td>
		</tr>
		
		<tr valign="top">
			<td width="100%" bgcolor="#99CCFF" onMouseOver="this.style.backgroundColor='#cccccc'" onMouseOut="this.style.backgroundColor='#99CCFF'">
				&nbsp;&nbsp;&nbsp;&nbsp;<a class="linktext" href="<%=strPath+"Logout.do"%>">Logout</a> 
			</td>
		</tr>
	</table>
</td>
