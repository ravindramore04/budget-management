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

public class SaveUserHandler extends org.apache.struts.action.Action
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
                    int nItr = Integer.parseInt((String)session.getAttribute("itr"));
                    if(nItr>0){
						int lvl = 2;
                        session.setAttribute("itr", "0");
                        HashMap hmUser = (HashMap)session.getAttribute("user");
                        String strUserId = (String)hmUser.get("UId");

                        CommonLogic cl = new CommonLogic();
                        String strToday = (String)cl.getToday();
                        CVDal cvdal = new CVDal(DBnm );
                        HashMap hmFinal = new HashMap();
                        Vector vec = new Vector();
                        boolean bDuplicate = false;
                        DynaActionForm daf = (DynaActionForm)form;
						sop("milin jain--->"+daf);
                       	String strId=(String)daf.get("txtId");
                        String strName=(String)daf.get("txtName");
                        String strLogin=(String)daf.get("txtLogin");
                        String strPwd=(String)daf.get("txtPassword");

						HashMap hData = new HashMap();


					  if(strId == null || strId.length()==0){
							//new record
							//test for duplication
							vec.addElement(strLogin);
							cvdal.setSQL("checkUserLogin",vec);
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
									String strLoginNm = (String)hmt.get("strLogin");
									if(strLoginNm.equals(strLogin)){
										//not update do nothing
									}else{
										//updated
										//test for duplication
										vec.clear();
										vec.addElement(strLogin);
										cvdal.setSQL("checkUserLogin",vec);
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
						}

						if(bDuplicate){
							String err = eh.getError("147530");
							String nxtpg = "AllUser.do";
							HashMap hmErr = new HashMap();
							hmErr.put("no","147530");
							hmErr.put("Source","SaveUserHandler");
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
                        }

                        vec.addElement(strName);
                        vec.addElement(strLogin);

                        if(strId == null || strId.length()==0){
							//insert time
							vec.addElement(cl.encryptValue(strPwd));
							vec.addElement(""+lvl);
							vec.addElement(strUserId);
							vec.addElement(strToday);
						}

                        vec.addElement(strUserId);
                        vec.addElement(strToday);

                        if(strId == null || strId.length()==0){
                            //insert
                            cvdal.setSQL("insertUser",vec);
                        }else{
                            //update record
                            vec.addElement(strId);
                            cvdal.setSQL("updateUser",vec);
							System.out.println("\n\n Updated!!!!!!!!!!!");
                        }
                        int row_num=cvdal.executeUpdate();
                        if(row_num>0)
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
                    }
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
