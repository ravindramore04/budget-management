package struts.adminpanel;

import login.SessionUtils;
import org.apache.commons.lang.StringUtils;
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

public class BudgetNote extends Action
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
        String user_id = (String)My.get("UId");

        ErrorHandler eh = new ErrorHandler();
        try{
            int nNum_Per_Page = 10;

           CVDal cvdal = new CVDal(DBnm);
            HashMap hmFinal = new HashMap();
            Vector vec = new Vector();

            DynaActionForm daf = (DynaActionForm)form;
            String strPage_num ="";
            String strNavOpr = "";
            String operation=(String)daf.get("opr");
            String searchThis=(String)daf.get("searchBN");
            sop( "Form     -->" + daf.getMap().entrySet());
            sop( "operation-->" + operation);

            if ("insert_budget_note".equals(operation)){
                // save_budget_note - START
                insertBudgetNote(cvdal, user_id, daf);

                FORWARD_final = Success;
                // save_budget_note - END
            }else if("update_budget_note".equals(operation)){
                // update_budget_note - START
               updateBudgetNote(cvdal, user_id, daf);

                FORWARD_final = Success;
                // update_budget_note - END
            }
             else{
                //
                String budgetAllocationId=(String)daf.get("id");
                sop("budgetAllocationId-->" + budgetAllocationId);

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

                if ("create".equals(operation)){

                    vec.add(budgetAllocationId);

                    cvdal.setSQL("budgetNoteInputData", vec);
                    Vector vec1 = (Vector)cvdal.executeQuery();
                    sop("vec1====================>" + vec1);


                    sop("create budget note..................");
                    request.setAttribute("budgetNoteInputData", vec1.get(0));

                    FORWARD_final = "createnote";

                } else if ("edit".equals(operation)){
                    //budget_note_id
                    vec.add(budgetAllocationId);

                    cvdal.setSQL("checkVoucherForBudgetNote", vec);
                    Vector vec2 = (Vector)cvdal.executeQuery();

                    if(vec2.size()>0)
                    {
                        request.setAttribute("message","Voucher Created for This Note , You cant update.");
                        FORWARD_final = "budgetnotelist";
                    }else{

                        cvdal.setSQL("budgetNoteDataWithId", vec);
                        Vector vec1 = (Vector)cvdal.executeQuery();
                        sop("vec1====================>" + vec1);
                        request.setAttribute("budgetNoteInputData", vec1.get(0));
                        FORWARD_final = "createnote";
                    }

                } else if("delete".equals(operation)){
                    vec.clear();
                    vec.add(budgetAllocationId);

                    cvdal.setSQL("checkVoucherForBudgetNote", vec);
                    Vector vec2 = (Vector)cvdal.executeQuery();

                    sop(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>"+vec2.toString());

                    if(vec2.size()>0) {
                        sop(">>>>>>>>>>>>>>>>>>>>>>Delete>>>>>>>"+vec2.size());
                        request.setAttribute("message","Voucher Created for This Note , You cant Delete.");
                        FORWARD_final = "budgetnotelist";
                    }else {
                        cvdal.setSQL("getBudgetExpense", vec);
                        Vector vec3 = (Vector)cvdal.executeQuery();

                        String budget_note_expense=(String)(((Map) vec3.get(0)).get("budget_note_expense")) ;
                        String AllocId=(String)(((Map) vec3.get(0)).get("AllocId")) ;

                        sop("budget_note_expense >  for delete budget AllocId >  "+AllocId);

                        cvdal.setSQL("deletebudgetnote", vec);
                        int i = cvdal.executeUpdate();

                        if(i>0){
                            Vector queryParams=new Vector();
                            queryParams.add(budget_note_expense);
                            queryParams.add(AllocId);
                            adjustReserveBallance(cvdal, queryParams);
                            request.setAttribute("message", " Budget Note Deleted Successfully.");
                        }
                        FORWARD_final = "budgetnotelist";
                    }
                } else if("print".equals(operation)){
                    vec.clear();
                    //budget note id
                    vec.add(budgetAllocationId);
                    cvdal.setSQL("budgetNoteDataWithId", vec);
                    Vector vec1 = (Vector)cvdal.executeQuery();
                    sop("vec1====================>" + vec1);
                    request.setAttribute("budgetNoteInputData", vec1.get(0));
                    FORWARD_final = "printnote";
                } else{
                    if(SessionUtils.isAccountORStoreUser(session)){
                        if("search_BN".equals(operation) || StringUtils.isNotEmpty(searchThis)){
                            vec.addElement(searchThis);
                            cvdal.setSQL("openAllHeadWithBalanceAllDeptSearch", vec);
                        }else {
                            cvdal.setSQL("openAllHeadWithBalanceAllDept", vec);
                        }
                    }else{

                        if("search_BN".equals(operation) || StringUtils.isNotEmpty(searchThis)){
                            vec.addElement(SessionUtils.getDepartmentId(session));
                            vec.addElement(searchThis);
                            cvdal.setSQL("openAllHeadWithBalanceSearch", vec);
                        }else {
                            vec.addElement(SessionUtils.getDepartmentId(session));
                            cvdal.setSQL("openAllHeadWithBalance", vec);
                        }

                    }

                    Vector vec1 = (Vector)cvdal.executeQuery();
                    sop("vec1====================>"+vec1);
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

                    if(nPage<=nTotalPage){
                        vec.clear();

                        if(SessionUtils.isAccountORStoreUser(session)){
                            if("search_BN".equals(operation) || StringUtils.isNotEmpty(searchThis)){
                                vec.addElement(searchThis);
                                vec.addElement("" + nLowLimit);
                                vec.addElement("" + nNum_Per_Page);
                                cvdal.setSQL("openAllHeadWithBalanceAllDeptWLSearch", vec);
                            }else {
                                vec.addElement("" + nLowLimit);
                                vec.addElement("" + nNum_Per_Page);
                                cvdal.setSQL("openAllHeadWithBalanceAllDeptWL", vec);
                            }
                        }else{
                            if("search_BN".equals(operation) || StringUtils.isNotEmpty(searchThis)){
                                vec.addElement(SessionUtils.getDepartmentId(session));
                                vec.addElement(searchThis);
                                vec.addElement("" + nLowLimit);
                                vec.addElement("" + nNum_Per_Page);
                                cvdal.setSQL("openAllHeadWithBalanceWLSearch", vec);
                            }else {
                                vec.addElement(SessionUtils.getDepartmentId(session));
                                vec.addElement("" + nLowLimit);
                                vec.addElement("" + nNum_Per_Page);
                                cvdal.setSQL("openAllHeadWithBalanceWL", vec);
                            }
                        }




                        vec1 = (Vector)cvdal.executeQuery();
                        if(vec1!=null && vec1.size()>0){
                            for(int indx=0;indx<vec1.size();indx++){
                                HashMap hmt = (HashMap)vec1.elementAt(indx);
                                hmFinal.put(""+indx, hmt);
                            }
                        }
                    }


                    sop("-------------------------------------------------");
                    sop("-------------------------------------------------");
                    sop(""+hmFinal);
                    request.setAttribute("data", hmFinal);
                    request.setAttribute("search_BN",searchThis);
                    HashMap hmPage = new HashMap();
                    hmPage.put("current_page", ""+(long)nPage);
                    hmPage.put("total_page", ""+(long)nTotalPage);
                    request.setAttribute("page", hmPage);
                    FORWARD_final = Success;

                }
            }



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


    private void adjustReserveBallance(CVDal cvdal, Vector param){
        cvdal.setSQL("MinusReservedBalance", param);
        int j= cvdal.executeUpdate();
        sop("budget_note_expense >  minus ballance successfully >  "+j);
    }

    private void insertBudgetNote(CVDal cvdal, String user_id, DynaActionForm daf) {
        String budget_note_id = cvdal.getMaxId("budget_note_MAX_ID");

        Vector queryParams = new Vector();
        queryParams.add(budget_note_id);
        queryParams.add(daf.get("allocationId"));
        queryParams.add(daf.get("budget_note_expense"));
        queryParams.add(daf.get("budget_note_expense"));
        queryParams.add(daf.get("allocation_balance_amount_after_expense"));
        queryParams.add(daf.get("budget_note_remark"));
        queryParams.add("DRAFT");
        queryParams.add(user_id);
        queryParams.add(user_id);
        queryParams.add(daf.get("ponumber"));
        cvdal.setSQL("budget_note_INSERT", queryParams);
        cvdal.executeUpdate();
        insertBudgetNoteHistory(cvdal, user_id, daf, budget_note_id);
        queryParams.clear();
        queryParams.add(daf.get("budget_note_expense"));
        queryParams.add(daf.get("allocationId"));
        cvdal.setSQL("updateReservedBalance",queryParams);
        cvdal.executeUpdate();
    }

    private void updateBudgetNote(CVDal cvdal, String user_id, DynaActionForm daf) {
        //update budget_note set budget_note_expense='?',allocation_reserved_amount='?',allocation_balance_amount_after_expense='?',budget_note_remark='?',updated_by_user_id='?',update_date=CURRENT_DATE where budget_note_id='?'
        String budget_note_id = (String)daf.get("id");
        String previousBudgetNoteAmount=(String)daf.get("previousBudgetNoteAmount");
        String approval=(String)daf.get("approval");
        String status="DRAFT";
        if ("yes".equals(approval)) {
         status="APPROVED";
        }

        Vector queryParams = new Vector();
        queryParams.add(daf.get("budget_note_expense"));
        queryParams.add(daf.get("budget_note_expense"));
        queryParams.add(daf.get("allocation_balance_amount_after_expense"));
        queryParams.add(daf.get("budget_note_remark"));
         queryParams.add(user_id);
        queryParams.add(status);
        queryParams.add(daf.get("ponumber"));
        queryParams.add(budget_note_id);

        cvdal.setSQL("budget_note_UPDATE", queryParams);
        cvdal.executeUpdate();
        insertBudgetNoteHistory(cvdal, user_id, daf, budget_note_id);

        queryParams.clear();
        queryParams.add(previousBudgetNoteAmount);
        queryParams.add(daf.get("allocationId"));
        adjustReserveBallance(cvdal, queryParams);

        queryParams.clear();
        queryParams.add(daf.get("budget_note_expense"));
        queryParams.add(daf.get("allocationId"));
        cvdal.setSQL("updateReservedBalance",queryParams);
        cvdal.executeUpdate();
    }



    private void insertBudgetNoteHistory(CVDal cvdal, String user_id, DynaActionForm daf, String budget_note_id){
        Vector queryParams = new Vector();

        String budget_note_history_id = cvdal.getMaxId("budget_note_history_MAX_ID");
        queryParams.clear();
        queryParams.add(budget_note_history_id);
        queryParams.add(budget_note_id);
        queryParams.add(daf.get("budget_note_expense"));
        queryParams.add(daf.get("budget_note_expense"));
        queryParams.add(daf.get("allocation_balance_amount_after_expense"));
        queryParams.add(daf.get("budget_note_remark"));
        queryParams.add("DRAFT");
        queryParams.add(user_id);

        cvdal.setSQL("budget_note_history_INSERT", queryParams);
        cvdal.executeUpdate();
    }


    public void sop(String msg){
        System.out.println(this.getClass().getSimpleName() + " : " + msg);
    }
    public void sop(DynaActionForm daf, String key){
        sop(key + "--->" + daf.get(key));
    }
}

