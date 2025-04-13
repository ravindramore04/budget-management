<%@ page import="java.util.*" %>
<%
	String strPath = "/budget0.1/";
	String strColHd = "#3366CC";
	String strCol1 = "#ffffff";
	String strCol2 = "#E6F3FF";
	
	
        HashMap hmComp = (HashMap)session.getAttribute("user");
        //out.println("inside include header --> "+hmComp);
	String strCompName = "Company Name";
	String strCompAddr = "Company contact details";
	String dtToday= "";
	
	if(hmComp!=null && hmComp.size()>0){
		strCompName = (String)hmComp.get("comp");
		strCompAddr = (String)hmComp.get("addr");
		dtToday = (String)hmComp.get("Date");
	}
        if(strCompName==null||strCompName.equals("null")){
            strCompName = "Company Name";
        }
        if(strCompAddr==null||strCompAddr.equals("null")){
            strCompAddr = "Company contact details";
        }
	if(dtToday==null||dtToday.equals("null")){
		dtToday= "";
	}else{
		dtToday=dtToday.replace('-','/');
	}
%>

<html>
<head>
<title>Luscious Technologies Pvt. Ltd.</title>
<link href="<%=strPath+"html/ndgold.css"%>" rel="stylesheet" type="text/css">
<link href="<%=strPath+"html/css/link.css"%>" rel="stylesheet" type="text/css">

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"></head>
<body leftmargin="0" topmargin="0" >
<table width="100%" bgcolor="#E6F3FF"> 
	<tr>
		<td width="15%" rowspan="2">
			<img src="<%=strPath+ "html/_images/award.gif"%>" width="55" height="55">
		</td>
		<td width="70%" class="innertitle" align="center" valign="top">
			<h3><%=strCompName%></h3>
		</td>
		<td width="15%" rowspan="2" class="innertitle">
			<%=dtToday%>
		</td>
	</tr>
	<tr>
		<td class="innertitle" align="center">
			<%=strCompAddr%>
		</td>
	</tr>
</table>
<div id="t1" style="left:1px;top:1px;width:780px;height:370px;z-index:1;Overflow:Scroll">
	<table width="100%" height="100%">
		<tr>
