<%@ include file="/jsp/include/header.jsp" %>
<%
    HashMap hmUser = (HashMap)session.getAttribute("user");
  //  out.println("inside company header --> "+hmUser);
    String User="Not Define";
    if(hmUser!=null && hmUser.size()>0){
    	User = (String)hmUser.get("UNm");
    }
%>
<td width="20%" class="innertitle" bgcolor="#E6F3FF" height="100%" valign="top">
	<table width="100%">
		<tr valign="top">
			<td width="100%" class="heading">
				<%=User%>
			</td>
		</tr>
		<tr valign="top">
			<td width="100%">
				&nbsp;&nbsp;&nbsp;&nbsp;<a class="linktext" href="<%=strPath+"NewAdminUser.do"%>">Users</a> 
			</td>
		</tr>
		<tr valign="top">
			<td width="100%">
				&nbsp;&nbsp;&nbsp;&nbsp;<a class="linktext" href="<%=strPath+"Logout.do"%>">Logout</a> 
			</td>
		</tr>
	</table>
</td>
