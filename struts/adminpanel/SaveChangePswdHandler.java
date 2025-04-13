package struts.adminpanel;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionError;
import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionServlet;
import org.apache.struts.action.DynaActionForm;

import javax.servlet.*;
import javax.servlet.http.*;

import java.util.HashMap;
import struts.common.CVDal;
import struts.common.CommonLogic;
import struts.common.ErrorHandler;
import java.util.*;
import java.sql.*;

public class SaveChangePswdHandler extends org.apache.struts.action.Action
{
	private static final String Success = "success";
	public static final String GLOBAL_FORWARD_failure = "failure";
	private static String FORWARD_final = GLOBAL_FORWARD_failure;

    public ActionForward execute(ActionMapping mapping, ActionForm form,HttpServletRequest request,
	HttpServletResponse response) throws RuntimeException,Exception
	{
			ErrorHandler eh = new ErrorHandler();
			HttpSession session = request.getSession(true);
			HashMap My = (HashMap)session.getAttribute("user");
			String DBnm = (String)My.get("DBnm");

		try{
			DynaActionForm daf = (DynaActionForm)form;
            sop("at the begning");
            String oldpswd="";
			String newpswd="";
			String id="";
			oldpswd= (String)daf.get("txtOldPassword");
			newpswd= (String)daf.get("txtPassword");
			id= (String)daf.get("txtId");
			CommonLogic cl = new CommonLogic();
			CVDal cvdal = new CVDal(DBnm);
			Vector vec = new Vector();
			vec.addElement(id);
			vec.addElement(cl.encryptValue(oldpswd));
			cvdal.setSQL("checkPassword", vec);
			Vector vec1 = (Vector)cvdal.executeQuery();
			if(vec1==null||vec1.size()==0){
				FORWARD_final = GLOBAL_FORWARD_failure;
			}else{
				sop("in update"+newpswd+"---"+id);
				vec.clear();
				vec.addElement(cl.encryptValue(newpswd));
				vec.addElement(id);
				cvdal.setSQL("saveNewPassword", vec);
				int i = cvdal.executeUpdate();
				FORWARD_final=Success;
			}
		}catch(Exception e){
			e.printStackTrace();
			String err = eh.getError("138620");
			String nxtpg = "ValidatedLogin.do";
			HashMap hmErr = new HashMap();
			hmErr.put("no","138620");
			hmErr.put("Source","SaveChangePswdHandler");
			hmErr.put("err",err);
			hmErr.put("nxtpg",nxtpg);
			request.setAttribute("err",hmErr);
			request.setAttribute("eDetail",e);
			FORWARD_final = GLOBAL_FORWARD_failure;
		}
		return (mapping.findForward(FORWARD_final));
	}//End of execute()
	public void sop(String msg){
		System.out.println(msg);
	}
}
