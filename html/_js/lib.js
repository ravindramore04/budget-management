function handleEnter(fieldname,frm) 
	{
	alert("hello");
	 	 var keyCode = event.keyCode ? event.keyCode : event.which ? event.which : event.charCode;
		 if (keyCode == 13) 
		 {eval('document.'+frm+'.'+fieldname+'.focus()');}
		
     }
