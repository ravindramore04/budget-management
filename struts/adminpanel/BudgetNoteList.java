package struts.adminpanel;

import login.SessionUtils;
import org.apache.struts.action.*;
import struts.common.CVDal;
import struts.common.ErrorHandler;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Vector;

public class BudgetNoteList extends Action
{

    private static final String Success = "success";
    public static final String GLOBAL_FORWARD_failure = "failure";
    private static String FORWARD_final = GLOBAL_FORWARD_failure;


    public ActionForward execute(ActionMapping mapping, ActionForm form,HttpServletRequest request,
                                 HttpServletResponse response) throws RuntimeException,Exception
    {
        HttpSession session = request.getSession(true);
        HashMap My = (HashMap)session.getAttribute("user");
        sop("User Session  +  " + My.get("departmentId"));
        SessionUtils.addUserToSession(session,(String)My.get("UId"),(String)My.get("UNm"),(String)My.get("departmentId"));
        String DBnm = (String)My.get("DBnm");
        CVDal cvdal = new CVDal(DBnm);
        ErrorHandler eh = new ErrorHandler();
        try{
            int nNum_Per_Page = 10;
            HashMap hmFinal = new HashMap();
            Vector vec = new Vector();

            DynaActionForm daf = (DynaActionForm)form;
            sop("DynaActionForm Details --->"+daf.getMap().entrySet());
            String operation=(String)daf.get("operation");
           // String operation=(String)daf.get("opr");
            String budget_note_id=(String)daf.get("id");
            sop( "operation-->" + operation);
            String strPage_num ="";
            String strNavOpr = "";
            if(daf!=null){
                strPage_num = (String)daf.get("current_page");
                strNavOpr = (String)daf.get("NAV");
            }

            double nPage = 1;
            double nTotalPage = 0;
            int nOpr = 0;

            if(!(strNavOpr == null || strNavOpr.length()==0))
                nOpr = Integer.parseInt(strNavOpr);

            if(!(strPage_num == null || strPage_num.length()==0))
                nPage = Double.parseDouble(strPage_num);
            vec.clear();
            //cvdal.setSQL("openAllVoucher", vec);

            if(SessionUtils.isAccountORStoreUser(session)){
                cvdal.setSQL("listbudgetnoteAllDept", vec);
            }else{
                vec.addElement(SessionUtils.getDepartmentId(session));
                cvdal.setSQL("listbudgetnote", vec);

            }

            Vector vec1 = (Vector)cvdal.executeQuery();
            if(vec1!=null && vec1.size()>0){
                nTotalPage = Math.ceil(vec1.size()/(double)nNum_Per_Page);
            }
            sop("total--> " + vec1.size());
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

            if(nPage<=nTotalPage){
                vec.clear();

                if (SessionUtils.isAccountORStoreUser(session)){
                    vec.addElement(""+nLowLimit);
                    vec.addElement(""+nNum_Per_Page);
                    cvdal.setSQL("listbudgetnoteAllDeptlimit", vec);

                }else{
                    vec.addElement(SessionUtils.getDepartmentId(session));
                    vec.addElement("" + nLowLimit);
                    vec.addElement(""+nNum_Per_Page);
                    cvdal.setSQL("listbudgetnotelimit", vec);

                }

                if("search_BN".equals(operation)){
                    sop("i am in search >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
                    vec.clear();
                    vec.addElement(budget_note_id);
                    if(SessionUtils.isAccountORStoreUser(session)) {
                        cvdal.setSQL("listbudgetnote_one_alldept", vec);
                    }else{
                        vec.addElement(SessionUtils.getDepartmentId(session));
                        cvdal.setSQL("listbudgetnote_one", vec);
                    }
                }

                vec1 = (Vector)cvdal.executeQuery();
                if(vec1!=null && vec1.size()>0){
                    for(int indx=0;indx<vec1.size();indx++){
                        HashMap hmt = (HashMap) vec1.elementAt(indx);
                        hmFinal.put(""+indx, hmt);
                    }
                }
            }
            request.setAttribute("data", hmFinal);
            HashMap hmPage = new HashMap();
            hmPage.put("current_page", "" + (long) nPage);
            hmPage.put("total_page", ""+(long)nTotalPage);
            request.setAttribute("page", hmPage);
            FORWARD_final = Success;
        }catch(Exception e){
            e.printStackTrace();
            String err = eh.getError("138530");
            String nxtpg = "ValidatedLogin.do";
            HashMap hmErr = new HashMap();
            hmErr.put("no","138530");
            hmErr.put("Source","BudgetNoteList");
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
