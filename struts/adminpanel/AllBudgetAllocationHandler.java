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

public class AllBudgetAllocationHandler extends org.apache.struts.action.Action
{

	private static final String Success = "success";
	public static final String GLOBAL_FORWARD_failure = "failure";
	private static String FORWARD_final = GLOBAL_FORWARD_failure;


    public ActionForward execute(ActionMapping mapping, ActionForm form,HttpServletRequest request,
	HttpServletResponse response) throws RuntimeException,Exception
	{
            HttpSession session = request.getSession(true);
            HashMap My = (HashMap)session.getAttribute("user");
			String DBnm = (String)My.get("DBnm");
            ErrorHandler eh = new ErrorHandler();
            try{
                    int nNum_Per_Page = 10;
                    CommonLogic cl = new CommonLogic();
                    CVDal cvdal = new CVDal(DBnm);
                    HashMap hmFinal = new HashMap();
                    Vector vec = new Vector();
					String strHeadId="";
                    DynaActionForm daf = (DynaActionForm)form;
                    String strPage_num ="";
	sop("milin jain daf---> "+daf);
                    String strNavOpr = "";
                    cvdal = new CVDal(DBnm);
                    if(daf!=null){
                        strPage_num = (String)daf.get("Newcurrent_page");
                        strNavOpr = (String)daf.get("NAV");

                    }
                    sop("----------------------------------------");
                    sop("_____________Sanjeev Request------------");
                    sop("milin jain request---> "+request);
                    sop("milin jain daf---> "+daf);
                    String strId=request.getParameter("HeadId");
                    sop("milin jain----->"+strId);
					cvdal = new CVDal(DBnm);
					if(strId==null || strId.length()==0)
						strHeadId=(String)daf.get("id");
					else
						strHeadId=strId;

                    double nPage = 1;
                    double nTotalPage = 0;
                    int nOpr = 0;
					cvdal = new CVDal(DBnm);
                    if(!(strNavOpr == null || strNavOpr.length()==0))
                        nOpr = Integer.parseInt(strNavOpr);

                    if(!(strPage_num == null || strPage_num.length()==0))
                        nPage = Double.parseDouble(strPage_num);

                    cvdal = new CVDal(DBnm);
                    vec.clear();
                    vec.addElement(strHeadId);
                    cvdal.setSQL("openAllAllocationOfHead", vec);
                    Vector vec1 = (Vector)cvdal.executeQuery();
                    cvdal = new CVDal(DBnm);
                    if(vec1!=null && vec1.size()>0){
                        nTotalPage = Math.ceil(vec1.size()/(double)nNum_Per_Page);
                    }
                    sop("total--> "+vec1.size());
                    sop("total pages-->" + nTotalPage);

                    switch (nOpr){
                        case 1:
                            //first
                            nPage = 1;
                            break;
                        case 2:
                            //next
                            nPage++;
                            break;
                        case 3:
                            //privious
                            nPage--;
                            break;
                        case 4:
                            //last
                            nPage = nTotalPage;
                    	   }

                    long nLowLimit = (long)(nNum_Per_Page * (nPage-1));

                    sop(""+nPage);
                    sop(""+nTotalPage);

					cvdal = new CVDal(DBnm);
                    if(nPage<=nTotalPage){
                        vec.clear();
                        vec.addElement(strHeadId);
                        vec.addElement(""+nLowLimit);
                        vec.addElement(""+nNum_Per_Page);
                        cvdal.setSQL("openAllAllocationOfHeadWL", vec);
                        vec1 = (Vector)cvdal.executeQuery();
                        sop(""+vec1);
                        if(vec1!=null && vec1.size()>0){
                            for(int indx=0;indx<vec1.size();indx++){
                                HashMap hmt = (HashMap)vec1.elementAt(indx);
                                hmFinal.put(""+indx, hmt);
                            }
                        }
                    }
                    sop("00000000000000000000000000000000000000000");
                    sop(""+hmFinal);
                    sop("00000000000000000000000000000000000000000");
                    request.setAttribute("data", hmFinal);
                    HashMap hmPage = new HashMap();
                    hmPage.put("Newcurrent_page", ""+(long)nPage);
                    hmPage.put("total_page", ""+(long)nTotalPage);
                    request.setAttribute("page", hmPage);
                    FORWARD_final = Success;
            }catch(Exception e){
                e.printStackTrace();
                String err = eh.getError("138530");
				String nxtpg = "ValidatedLogin.do";
				HashMap hmErr = new HashMap();
				hmErr.put("no","138530");
				hmErr.put("Source","AllHeadHandler");
				hmErr.put("err",err);
				hmErr.put("nxtpg",nxtpg);
				request.setAttribute("err",hmErr);
				request.setAttribute("eDetail",e);
                FORWARD_final = GLOBAL_FORWARD_failure;
            }
            sop("forward value is--> "+FORWARD_final);
            return (mapping.findForward(FORWARD_final));
	}//End of execute()

	public void sop(String msg){
		System.out.println(msg);
	}
}
