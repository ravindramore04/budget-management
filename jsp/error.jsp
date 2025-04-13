<%@ include file="/jsp/include/header.jsp" %>
<%
HashMap hmErr=(HashMap)request.getAttribute("err");
Exception eh = (Exception)request.getAttribute("eDetail");
String strSource = strPath;
String strNo = "100";
String strAction = "StartPage.do";
String strErr = "Some unknown Error....!";
if(hmErr!=null && hmErr.size()>0){
	strSource = (String)hmErr.get("Source");
	strNo = (String)hmErr.get("no");
	strAction = (String)hmErr.get("nxtpg");
	strErr = (String)hmErr.get("err");
}
//out.println(eh);
%>
<SCRIPT language="Javascript">
  function changeVisible(){
	if(err.visible.value==2){
		aa.style.visibility="hidden";
		err.visible.value=1;
    	}else{
		aa.style.visibility="visible";
		err.visible.value=2;
	}
   }	
</SCRIPT>
   <form name="err" method="post" action="<%=strPath+strAction%>">
        <input type="hidden" name="page" value="login">
        <input type="hidden" name="visible" value="1">
        <table width="70%" valign="middle">
        	<tr>
        		<td width="100%" colspan=2><div align="center"><font size="+2" face="Verdana, Arial, Helvetica, sans-serif"><strong>
            			<br><%="Error...!"%>
            		</strong></font></div></td>
        	</tr>
        	<tr>
        		<td width="100%" colspan=2><div align="center"><font size="+2" face="Verdana, Arial, Helvetica, sans-serif"><strong>
            			&nbsp;
            		</strong></font></div></td>
        	</tr>
        	<tr>
        		<td width="100%" colspan=2 valign="top"><div align="center"><strong><font size="2" face="Verdana, Arial, Helvetica, sans-serif">
             			<%=strErr%>
            		</font></strong></div></td>
        	</tr>
        	<tr>
        		<td width="100%" colspan=2><div align="center"><font size="+2" face="Verdana, Arial, Helvetica, sans-serif"><strong>
            			&nbsp;
            		</strong></font></div></td>
        	</tr>
        	<tr>
        		<td width="100%" colspan=2 align="center" >
        			<table width="30%">
        				<tr>
        					<td>
            						<input type="submit" name="ok" value="     OK     " onclick=setAction();>
            					</td>
        					<td>
            						<input type="button" name="ok" value="  Detail  " onclick=changeVisible();>
            					</td>
            				</tr>
            				
            			</table>
            		</td>
        	</tr>
        	<tr>
        		<td width="100%" colspan=2><div align="center"><font size="+2" face="Verdana, Arial, Helvetica, sans-serif"><strong>
            			&nbsp;
            		</strong></font></div></td>
        	</tr>
        	
            <tr>
                <td width="100%" colspan=2>
                    <div id="aa" style="visibility:hidden"> 
                    	<table width="100%" valign="middle" bgcolor="#ffffff">
				<tr>
					<td width="30%" valign="top"><div align="left"><strong><font size="2" face="Verdana, Arial, Helvetica, sans-serif">
						Number &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: 
					</font></strong></div></td>
					<td width="70%" valign="top"><div align="left"><strong><font size="2" face="Verdana, Arial, Helvetica, sans-serif">
						<%=strNo%>
					</font></strong></div></td>
				</tr>
				<tr>
					<td width="30%" valign="top"><div align="left"><strong><font size="2" face="Verdana, Arial, Helvetica, sans-serif">
						Source&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : 
					</font></strong></div></td>
					<td width="70%" valign="top"><div align="left"><strong><font size="2" face="Verdana, Arial, Helvetica, sans-serif">
						<%=strSource%>
					</font></strong></div></td>
				</tr>
				<tr>
					<td width="30%" valign="top"><div align="left"><strong><font size="2" face="Verdana, Arial, Helvetica, sans-serif">
						Exception&nbsp;&nbsp; : 
					</font></strong></div></td>
					<td width="70%" valign="top"><div align="left"><strong><font size="2" face="Verdana, Arial, Helvetica, sans-serif">
						<%=eh%>
					</font></strong></div></td>
				</tr>
				
                    	</table>
		    </div>
		</td>
	    </tr>	
        	
        </table>
    </form>
<%@ include file="/jsp/include/footer.jsp" %>
