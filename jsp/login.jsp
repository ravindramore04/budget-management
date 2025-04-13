<%@page import="javax.naming.*,java.sql.*,javax.transaction.*,java.util.*,java.io.*" errorPage="" %>

<%
	HashMap MyMap = new HashMap();		
	String strPath = "/budget0.1/";
	try{
			Class.forName("com.mysql.jdbc.Driver").newInstance();
			Connection conn  = DriverManager.getConnection("jdbc:mysql://localhost:3307/finance?user=root&password=root");
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery("Select * from finance.Finance_Year order by F_Year");
			ResultSetMetaData md = rs.getMetaData();
			int j=0;
			int cc = md.getColumnCount();
			while (rs.next())
			{
				HashMap hm = new HashMap();
				for(int i=0;i<cc;i++)
				{
					int ii = i+1;
					String strData = rs.getString(ii);
					String strColumn = md.getColumnName(ii);
					hm.put(strColumn, strData);
				}
				MyMap.put(""+j,hm);				
				j++;
			}
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		//out.println("MyMap"+MyMap);
%>
<html>
<head>
<title>Luscious Technologies Pvt. Ltd.</title>
<script language="JavaScript">
	function setAction(){
		with (document.login){
			if(txtuser.value.length>0){
				if(txtpassword.value.length>0){
					submit();	
				}else{
					alert("Please Enter Password");
				}
			}else{
				alert("Please Enter Login Name");
			}
		}
	}
</script>

<link href="<%=strPath+"html/ndgold.css"%>" rel="stylesheet" type="text/css">
<link href="<%=strPath+"html/css/link.css"%>" rel="stylesheet" type="text/css">
</head>
<body >
<form name="login"  method="post"  action="<%=strPath+"ValidatedLogin.do"%>">
<table width="100%" background="<%=strPath+"html/_images/login_bg.jpg" %>">
<Tr>
<td align="Center"><Strong><font face="Bookman Old Style" color="BLUE" size="3">MAEER'S</font></Strong>
</td>
<TR><td align="Center"><Strong><font face="Bookman Old Style" color="BLUE" size="3">MIT Arts,Commerce & Science College, Alandi Pune </font></Strong></td></TR>
<TR><td align="Center"><Strong><font face="Bookman Old Style" color="BLUE" size="3">Annual Budget</font></Strong></Td></tr>	

<tr><td><table width="50%" border="0" cellspacing="1" cellpadding="4" align="center" >
          <tr> 
            <td width="26%" class="link">User Name:</td>
            <td colspan="3"><input type="text" name="txtuser" size="25" class="formfield"> 
            </td>
          </tr>
          <tr> 
            <td width="26%"  class="link">Password:</td>
            <td  colspan="3"><input type="password" name="txtpassword" size="25" class="formfield"></td>
          </tr>
          <tr>
            <td  class="link">Year</td>
            <td  colspan="3">
			<select name="Year">
			<option value="0">[ Select Finance Year]</option>
			
			<%
					
					for(int i=0;i<MyMap.size();i++)				
					{
						HashMap my = (HashMap)MyMap.get(""+i);
						String strID = (String)my.get("ID");
						String strFyear = (String)my.get("F_Year");
						String strTyear = (String)my.get("T_Year");
						String strDBnm = (String)my.get("DBnm");
						%>
						<option value="<%=strDBnm%>"><%=strFyear%>-<%=strTyear%></option>
						<%
					}			
			
			%>
              </select>
</td>
          </tr>
        </table>
        <p align="center"> 
          <input type="button" name="logintype" value="Login" class="PPRSbmtBtn" onClick="setAction()">
        </p>
        <table width="80%" border="0" align="center" cellpadding="2" cellspacing="2">
          <tr> 
            <td colspan="2"><div align="center"><font size="2">Concept of</font></div></td>
            <td width="51%" colspan="2"> 
              <div align="center"><font size="2">Design by </font></div></td>
          </tr>
          <tr> 
            <td colspan="2"><HR></td>
            <td colspan="2"><HR></td>
          </tr>
          <tr> 
            <td colspan="2"><div align="center"><font size="2"><strong>&nbsp;&nbsp;Mr. 
                S.M.Rohinkar</strong></font></div></td>
            <td colspan="2"><div align="center"><font size="2"><strong>&nbsp;&nbsp;Luscious 
                Technologies Pvt. Ltd.(www.ltpl.com)</strong></font></div></td>
          </tr>
          <tr> 
            <td colspan="2"><div align="center"><font size="2"><strong>&nbsp;&nbsp;Account 
                Officer MAE College, Pune</strong></font></div></td>
            <td colspan="2"><div align="center"><font size="2"><strong>&nbsp;&nbsp;Our 
                Products</strong></font></div></td>
          </tr>
        </table>
        <p align="center">&nbsp;</p>
<!--        <p align="center">&nbsp;</p>
        <p align="center">&nbsp;</p> 
        <p align="center">&nbsp;</p> -->
        <p align="center">&nbsp;</p>
        <p align="center">&nbsp;</p>
        <p align="center">&nbsp;</p>
        <p align="center">&nbsp;</p>
        <p align="center">&nbsp;</p>
<table width="100%"><tbody><tr>
        <td><div align="center"></div></td>
</tr></tbody></table>
</td></tr>
</table>
</form>
</body>
</html>