<%@ include file="/jsp/include/header.jsp" %>
<%
    HashMap hmUser = (HashMap)session.getAttribute("user");
    String User="Not Define";
    if(hmUser!=null && hmUser.size()>0){
    	User = (String)hmUser.get("UNm");
    }
%>
<td width="20%" class="innertitle" bgcolor="#E6F3FF" height="100%" valign="top">
	<table width="100%" bgcolor="#333399" cellspacing="1">
    <tr valign="top"> 
      <td width="100%" class="heading" bgcolor="#99CCFF"> <%=User%> </td>
    </tr>
    <tr valign="top"> 
      <td width="100%" bgcolor="#99CCFF" onMouseOver="this.style.backgroundColor='#cccccc'" onMouseOut="this.style.backgroundColor='#99CCFF'"> &nbsp;&nbsp;&nbsp;&nbsp;<a class="linktext" href="<%=strPath+"AllVoucher.do"%>">Voucher 
        Creation</a> </td>
    </tr>
    <tr valign="top"> 
      <td width="100%" bgcolor="#99CCFF" onMouseOver="this.style.backgroundColor='#cccccc'" onMouseOut="this.style.backgroundColor='#99CCFF'"> &nbsp;&nbsp;&nbsp;&nbsp;<a class="linktext" href="<%=strPath+"CnlVoucher.do"%>">Voucher 
        Cancel</a> </td>
    </tr>
    <tr valign="top"> 
      <td width="100%" bgcolor="#99CCFF" onMouseOver="this.style.backgroundColor='#cccccc'" onMouseOut="this.style.backgroundColor='#99CCFF'"> &nbsp;&nbsp;&nbsp;&nbsp;<a class="linktext" href="<%=strPath+"VoucherPrint.do"%>">Voucher 
        Printing</a> </td>
    </tr>
    <tr valign="top"> 
      <td width="100%" bgcolor="#99CCFF" onMouseOver="this.style.backgroundColor='#cccccc'" onMouseOut="this.style.backgroundColor='#99CCFF'"> &nbsp;&nbsp;&nbsp;&nbsp;<a class="linktext" href="<%=strPath+"ChqPrint.do"%>">Cheque 
        Printing</a> </td>
    </tr>
    <tr valign="top"> 
      <td width="100%" bgcolor="#99CCFF" onMouseOver="this.style.backgroundColor='#cccccc'" onMouseOut="this.style.backgroundColor='#99CCFF'"> &nbsp;&nbsp;&nbsp;&nbsp;<a class="linktext" href="<%=strPath+"ChngUserPswd.do"%>">Change 
        Password</a> </td>
    </tr>
	<tr valign="top"> 
      <td width="100%" bgcolor="#99CCFF" onMouseOver="this.style.backgroundColor='#cccccc'" onMouseOut="this.style.backgroundColor='#99CCFF'"> &nbsp;&nbsp;&nbsp;&nbsp;<a class="linktext" href="<%=strPath+"OpenPurchaseOrder.do"%>">Purchase 
        Order</a> </td>
    </tr>
    <tr valign="top"> 
      <td width="100%" bgcolor="#99CCFF" onMouseOver="this.style.backgroundColor='#cccccc'" onMouseOut="this.style.backgroundColor='#99CCFF'"> &nbsp;&nbsp;&nbsp;&nbsp;<a class="linktext" href="<%=strPath+"Logout.do"%>">Logout</a> 
      </td>
    </tr>
  </table>
</td>
