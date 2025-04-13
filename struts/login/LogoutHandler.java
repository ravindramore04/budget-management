package struts.login;

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
import java.util.*;
import java.sql.*;

public class LogoutHandler extends org.apache.struts.action.Action
{
	private static final String Success = "success";
	public static final String GLOBAL_FORWARD_failure = "failure";
	private static String FORWARD_final = GLOBAL_FORWARD_failure;

    public ActionForward execute(ActionMapping mapping, ActionForm form,HttpServletRequest request,
	HttpServletResponse response) throws RuntimeException,Exception
	{
            HttpSession session = request.getSession(true);
            try{
                    HashMap hmFinal = new HashMap();
					hmFinal.put("lvl",null);
					hmFinal.put("UId",null);
					hmFinal.put("UNm",null);
					hmFinal.put("comp",null);
					hmFinal.put("addr",null);

                    session.setAttribute("user",hmFinal);
                    FORWARD_final = Success;
            }catch(Exception e){
                e.printStackTrace();
                FORWARD_final = GLOBAL_FORWARD_failure;
            }

            return (mapping.findForward(FORWARD_final));
	}//End of execute()

	public void sop(String msg){
		System.out.println(msg);
	}
}
