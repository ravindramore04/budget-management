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

public class SaveNewYearHandler extends org.apache.struts.action.Action
{
	private static final String Success = "success";
	public static final String GLOBAL_FORWARD_failure = "failure";
	private static String FORWARD_final = GLOBAL_FORWARD_failure;
	HashMap hmTB = new HashMap();

    public ActionForward execute(ActionMapping mapping, ActionForm form,HttpServletRequest request,
	HttpServletResponse response) throws RuntimeException,Exception
	{
            HttpSession session = request.getSession(true);
            HashMap My = (HashMap)session.getAttribute("user");
			String DBnm = (String)My.get("DBnm");
            ErrorHandler eh = new ErrorHandler();
            try{

					hmTB.put("0",".budgetalloc (AllocId int(6),HeadId int(6),Dt date,dblAmount double(10,2),strRemark varchar(100),strInsBy int(6),strInsOn date,strUptdBy int(6),strUptdOn date)");
					hmTB.put("1",".budgethead (HeadId int(6),strBudgroupId varchar(10),strName varchar(40),strAccNo varchar(10),strRemark varchar(100),strInsBy int(6),strInsOn date,strUptdBy int(6),strUptdOn date)");
					hmTB.put("2",".budgroup (strBudgroupId varchar(10),strBudgroupNm varchar(30),strRmrk varchar(50))");
					hmTB.put("3",".cheque (voucherId int(6),strChequeNo varchar(6),strPONo int(10))");
					hmTB.put("4",".company (strName varchar(40),strShortNm varchar(20),strAddr varchar(100),strPh1 varchar(15),strPh2 varchar(15),strInsBy int(6),strInsOn date,strUptdBy int(6),strUptdOn date)");
					hmTB.put("5",".headbal (HeadId int(6),dblBalance double(10,2))");
					hmTB.put("6",".userlst (UId int(6),strName varchar(40),strLogin varchar(50),strPwd varchar(50),lvl tinyint(1),strInsBy int(6),strInsOn date,strUptdBy int(6),strUptdOn date) ");
					hmTB.put("7",".voucher (voucherId int(6),voucherNo int(10) NOT NULL,dt date,HeadId int(6),dblAmount double(10,2),dblTds double(10,2),strType varchar(100),strToAcc varchar(250),bMode tinyint(1),strBank varchar(100),strReceiverNm varchar(100),strInsBy int(6),strInsOn date,strUptdBy int(6),strUptdOn date,strTDS varchar(200),strPONo int(10),VouNo int(6),srCvouNO int(10))");
					hmTB.put("8",".purchaseorder (nPONo decimal(10,0),POId int(5),nBudgetId decimal(10,0),POdt date,Consume decimal(1,0),NonConsume decimal(1,0),Strparty varchar(25),nAmt decimal(15,0))");


                    int nItr = Integer.parseInt((String)session.getAttribute("itr"));
                    if(nItr>0){
						int lvl = 2;
                        session.setAttribute("itr", "0");
                        HashMap hmUser = (HashMap)session.getAttribute("user");
                        String strUserId = (String)hmUser.get("UId");

                        CommonLogic cl = new CommonLogic();
                        String strToday = (String)cl.getToday();
                        CVDal cvdal = new CVDal(DBnm);
                        HashMap hmFinal = new HashMap();
                        Vector vec = new Vector();
                        boolean bDuplicate = false;
                        DynaActionForm daf = (DynaActionForm)form;
						sop("milin jain--->"+daf);
                       	String strId=(String)daf.get("txtId");
                       	sop("strId=============>"+strId);
                        String strYear=(String)daf.get("txtYear");
                        sop("strYear=============>"+strYear);
                        String strYear1=(String)daf.get("txtYear1");
                        sop("strYear1=============>"+strYear1);
                        String strDBName=(String)daf.get("txtDBName");
                        sop("strDBName=============>"+strDBName);
                        //String strPwd=(String)daf.get("txtPassword");

						HashMap hData = new HashMap();


					/*  if(strId == null || strId.length()==0){
							//new record
							//test for duplication
							vec.addElement(strYear);
							vec.addElement(strYear1);
							cvdal.setSQL("checkYear",vec);
							Vector vec12=(Vector)cvdal.executeQuery();
							if(vec12 != null && vec12.size()!=0)
									bDuplicate=true;
							else
									bDuplicate=false;
						}else{
							//update record
							//test for update name
							vec.clear();
							vec.addElement(strId);
							cvdal.setSQL("openUserWithId",vec);
							Vector vec12=(Vector)cvdal.executeQuery();
							if(vec12 != null && vec12.size()!=0){
								HashMap hmt = (HashMap)vec12.elementAt(0);
								if(hmt!=null && hmt.size()>0){
									String strYearNm = (String)hmt.get("strYear");
									if(strYearNm.equals(strYear)){
										//not update do nothing
									}else{
										//updated
										//test for duplication
										vec.clear();
										vec.addElement(strYear);
										cvdal.setSQL("checkyear",vec);
										vec12=(Vector)cvdal.executeQuery();
										if(vec12 != null && vec12.size()!=0){
											bDuplicate=true;
										}else{
											bDuplicate=false;
										}
									}
								}else{
									//Error
								}
							}else{
								//Error
							}
						}*/

						/*if(bDuplicate){
							String err = eh.getError("147530");
							String nxtpg = "AllUser.do";
							HashMap hmErr = new HashMap();
							hmErr.put("no","147530");
							hmErr.put("Source","SaveNewYearHandler");
							hmErr.put("err",err);
							hmErr.put("nxtpg",nxtpg);
							request.setAttribute("err",hmErr);
							//request.setAttribute("eDetail",e);
							FORWARD_final = GLOBAL_FORWARD_failure;
						}else{
                       	  vec.clear();
                          if(strId == null || strId.length()==0){
                            //insert record
                            int iNewId = 100001;
                            vec.clear();
                            cvdal.setSQL("lastID",vec);
                            Vector vec1 = (Vector)cvdal.executeQuery();

                           if(vec1 != null && vec1.size()!=0){
                                HashMap hm = (HashMap)vec1.elementAt(0);
                                String strTemp = (String)hm.get("LastId");
                                if(strTemp != null){
                                    iNewId = Integer.parseInt(strTemp);
                                    iNewId++;
                                }
                            }

                            vec.addElement(""+iNewId);
                        }*/
/*
                        if(strId == null || strId.length()==0){*/
                        int iNewId=10001;
							vec.clear();
							vec.addElement(strDBName);
							cvdal.setSQL("CreateDB",vec);
                        	int row=cvdal.executeUpdate();
                        	if(row>0){
								for(int i=0;i<hmTB.size();i++){
									String TB = strDBName+(String)hmTB.get(""+i);
									vec.clear();
									vec.addElement(TB);
									cvdal.setSQL("CreateTB",vec);
									int row1=cvdal.executeUpdate();
								}
								vec.clear();
								vec.addElement(strDBName);
								cvdal.setSQL("CreateUsrlst",vec);
								int row2=cvdal.executeUpdate();




							vec.clear();
							cvdal.setSQL("lastFinanceID",vec);
							Vector vec1 = (Vector)cvdal.executeQuery();
							sop("vec1 vec1 =================>>"+vec1 );
						   if(vec1 != null && vec1.size()!=0){
								HashMap hm = (HashMap)vec1.elementAt(0);
								String strTemp = (String)hm.get("LastId");
								if(strTemp != null){
									iNewId = Integer.parseInt(strTemp);
									iNewId++;
									vec.addElement(iNewId+"");
								}
							}


						//vec.addElement(iNewId+"");
                        vec.addElement(strYear);
                        vec.addElement(strYear1);
                        vec.addElement(strDBName);
                        if(strId == null || strId.length()==0){
                            //insert
                            cvdal.setSQL("insertFinacialYear",vec);
                        }else{
                            //update record
                            vec.addElement(strId);
                            cvdal.setSQL("updateFinacialYear",vec);
							System.out.println("\n\n Updated!!!!!!!!!!!");
                        }
                        int row_num=cvdal.executeUpdate();
                        }

                        if(row>0)
                            FORWARD_final = Success;
                        else{
							String err = eh.getError("138620");
							String nxtpg = "AllUser.do";
							HashMap hmErr = new HashMap();
							hmErr.put("no","138620");
							hmErr.put("Source","SaveUserHandler");
							hmErr.put("err",err);
							hmErr.put("nxtpg",nxtpg);
							request.setAttribute("err",hmErr);
							//request.setAttribute("eDetail",e);
                            FORWARD_final = GLOBAL_FORWARD_failure;
					   }
                   // }
                    }else{
                        FORWARD_final = Success;
                    }
            }catch(Exception e){
                e.printStackTrace();
                String err = eh.getError("138620");
				String nxtpg = "AllUser.do";
				HashMap hmErr = new HashMap();
				hmErr.put("no","138620");
				hmErr.put("Source","SaveUserHandler");
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
