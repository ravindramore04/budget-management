<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%
   	String strPath = "/budget-management/";
    pageContext.setAttribute("strPath", strPath);
%>

<%@ include file="/jsp/include/header.jsp" %>
<%
    HashMap hmUser1 = (HashMap)session.getAttribute("user");
    //out.println("hmUser1--"+hmUser1);
	String lvl="1";
	if(hmUser1!=null && hmUser1.size()>0){
    	lvl = (String)hmUser1.get("lvl");
    }
	//out.println("lvl--"+lvl);
%>
<%if("2".equals(lvl)){%>
<%@ include file="/jsp/adminpanel/headerdir.jsp" %>
<%}else{%>
<%@ include file="/jsp/adminpanel/headermain.jsp" %>
<%}%>