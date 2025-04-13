package struts.common;
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
import java.util.*;

public class CloseHandler extends org.apache.struts.action.Action
{
	public static final String GLOBAL_FORWARD_failure = "failure";
	private static String FORWARD_final =GLOBAL_FORWARD_failure;

        public ActionForward execute(ActionMapping mapping,ActionForm form,HttpServletRequest request,
	HttpServletResponse response) throws RuntimeException,Exception
	{
            HttpSession session = request.getSession(true);
            try{
                session.setAttribute("itr", "0");
                DynaActionForm daf = (DynaActionForm)form;
                String strPage = (String)daf.get("page");
                FORWARD_final=strPage;
            }catch(Exception e){
                e.printStackTrace();
                FORWARD_final = GLOBAL_FORWARD_failure;
            }
            sop("Before returning success***--> "+FORWARD_final);
            return (mapping.findForward(FORWARD_final));
	}

	public void sop(String msg)
	{
            System.out.println(msg);
	}
}

