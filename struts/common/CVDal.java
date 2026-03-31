package struts.common;
import javax.naming.*;
import java.sql.*;
import javax.transaction.*;
import java.util.*;
import java.io.*;

public class CVDal
{
	private static Connection conn;
	private  static Statement stmt=null;
	private ResultSet rs=null;
	private static HashMap ALLSQL;  //temporarily holds all the SQL's
	private  String finalSql = "";

        public CVDal(String str){
			    try{
							sop("try for database--> " + str);
							String strData = str;
							/*if(str.equalsIgnoreCase("budget")){
								strData = "budget";
							}else */
						//	if(str.equalsIgnoreCase("setting")){
						//		strData = "lcsyssetng";
						//	}
			                sop("database--> " + strData);
			                Class.forName("com.mysql.jdbc.Driver").newInstance();
			                conn = DriverManager.getConnection("jdbc:mysql://localhost/"+strData+"?user=root&password=root");
			                stmt = conn.createStatement();
							setALLSQL();
			            }catch(Exception e)
			            {
			                e.printStackTrace();
            }

		}

	public  static void setALLSQL()
	{
		ALLSQL = new HashMap();
		//***************select query**************//
		ALLSQL.put("insertintoPO","insert into purchaseorder values('?','?','?','?','?','?','?','?')");
		ALLSQL.put("MAxPOId","select max(POId) as LastId from purchaseorder");
		ALLSQL.put("openAllPurchaseOrder","select * from purchaseorder");
		ALLSQL.put("openAllPurchaseOrderWL","select * from purchaseorder  limit ?,?");
		ALLSQL.put("openPOWithId","select * from purchaseorder where POId='?'");
		ALLSQL.put("UpdatePODetails","update purchaseorder set nPONo='?', nBudgetId='?', POdt='?', Consume='?', NonConsume='?', Strparty='?', nAmt='?' where POId='?'");
		ALLSQL.put("getfPOforConDate"," select  purchaseorder.* ,budgethead.strName from purchaseorder left join budgethead on purchaseorder.nbudgetid=budgethead.headid where purchaseorder.Consume='?' and purchaseorder.POdt >= '?' and purchaseorder.POdt <= '?' order by purchaseorder.POdt");
		ALLSQL.put("getfPOforNonConDate"," select  purchaseorder.* ,budgethead.strName from purchaseorder left join budgethead on purchaseorder.nbudgetid=budgethead.headid where purchaseorder.NonConsume='?' and purchaseorder.POdt >= '?' and purchaseorder.POdt <= '?' order by purchaseorder.POdt");
		ALLSQL.put("getfPOforDate"," select  purchaseorder.* ,budgethead.strName from purchaseorder left join budgethead on purchaseorder.nbudgetid=budgethead.headid where purchaseorder.Consume='?' and purchaseorder.NonConsume='?' and purchaseorder.POdt >= '?' and purchaseorder.POdt <= '?' order by purchaseorder.POdt");
		ALLSQL.put("getPOCon"," select  purchaseorder.* ,budgethead.* from purchaseorder left join budgethead on purchaseorder.nbudgetid=budgethead.headid where purchaseorder.Consume='?'  group by purchaseorder.nbudgetid ");
		ALLSQL.put("getPONonCon"," select  purchaseorder.* ,budgethead.* from purchaseorder left join budgethead on purchaseorder.nbudgetid=budgethead.headid where purchaseorder.NonConsume='?' group by purchaseorder.nbudgetid ");
		ALLSQL.put("getPO"," select  purchaseorder.* ,budgethead.* from purchaseorder left join budgethead on purchaseorder.nbudgetid=budgethead.headid where purchaseorder.Consume='?' and purchaseorder.NonConsume='?' group by purchaseorder.nbudgetid ");
		ALLSQL.put("OpenPONOforVoucher"," select * from purchaseorder where nBudgetId='?'");



		//ALLSQL.put("openAllGroup", "select * from budgroup");
		ALLSQL.put("openAllGroup","select * from BUDGROUP order by strBudgroupNm");
		ALLSQL.put("openAllGroupWL", "select * from budgroup limit ?,?");
		ALLSQL.put("checkGroupHead", "select * from budgroup where strBudgroupNm  LIKE '?'");
		ALLSQL.put("lastGroupHeadID","select max(strbudgroupid) as LastId from budgroup" );
		ALLSQL.put("insertGroupHead","insert into budgroup values('?','?','?')");
		ALLSQL.put("updateGroupHead","Update budgroup set strBudgroupNm='?', strRmrk='?' where strbudgroupid='?'");
		ALLSQL.put("openBudGroupHeadWithId", "select * from budgroup where strbudgroupid='?'");

		//Add Budget Head
		ALLSQL.put("openHeadWithId","select * from BudgetHead where HeadId='?'");
		ALLSQL.put("insertHead","insert into BudgetHead values('?','?','?','?','?','?','?','?','?','?')");
		ALLSQL.put("updateHead","Update BudgetHead set strDepartmentId='?',strName='?',strRemark='?', strUptdBy='?',strUptdOn='?',strDepartmentId='?',strBudGroupId='?' where HeadId='?'");

		//Department
		ALLSQL.put("openAllDepartment","select * from departments order by strDepartmentNm");
		ALLSQL.put("openAllDepartmentWL", "select * from departments limit ?,?");
		ALLSQL.put("checkDepartment", "select * from departments where strDepartmentNm  LIKE '?'");
		ALLSQL.put("lastDepartmentID","select max(strDepartmentId) as LastId from departments" );

		ALLSQL.put("insertDepartment","insert into departments values('?','?','?','?','?','?','?')");
		ALLSQL.put("updateDepartment","Update departments set strDepartmentNm='?', strHeadOfDeptNm='?',strRmrk='?',strRmrk1='?',strRmrk2='?',strRmrk3='?' where strDepartmentId='?'");

		ALLSQL.put("openDepartmentWithId", "select * from departments where strDepartmentId='?'");
		ALLSQL.put("getCurrentDate", " select Current_date as Today ");
		ALLSQL.put("openOrg","select * from company");


		//**********************
		ALLSQL.put("openAllHeadwithGid","select * from BudgetHead where strBudgroupId='?' order by strName");
		ALLSQL.put("openAllwithGidHeadWL","select * from BudgetHead where strBudgroupId='?' order by strName limit ?,?");
		ALLSQL.put("ViewAllAllocwithbgid","select budgethead.strBudgroupId,budgethead.strName, budgethead.HeadId, budgethead.strAccNo,sum(budgetalloc.dblAmount) as BSUM from budgethead left join budgetalloc on budgethead.HeadId=budgetalloc.HeadId where budgethead.strBudgroupId='?' group by budgethead.HeadId order by budgethead.strName ");
		//ALLSQL.put("ViewAllVouchwithgid","select budgethead.HeadId, budgethead.strBudgroupId,sum(voucher.dblAmount) as VSUM ,sum(voucher.dblTds) as tds from budgethead left join voucher on budgethead.HeadId=voucher.HeadId where voucher.Dt between '?' and '?' and budgethead.strBudgroupId='?' group by budgethead.HeadId  order by budgethead.strName");
		ALLSQL.put("ViewAllVouchwithgid","select budgethead.HeadId, budgethead.strBudgroupId,sum(voucher.dblAmount) as VSUM ,sum(voucher.dblTds) as tds from budgethead left join voucher on budgethead.HeadId=voucher.HeadId where  budgethead.strBudgroupId='?' group by budgethead.HeadId  order by budgethead.strName");
		//ALLSQL.put("ViewAllVouchwithgid","select budgethead.HeadId,budgethead.strBudgroupId,sum(voucher.dblAmount) as VSUM ,sum(purchaseorder.nAmt) as POSUM ,sum(voucher.dblTds) as tds from budgethead left join voucher on budgethead.HeadId=voucher.HeadId left join purchaseorder on purchaseorder.nBudgetId=budgethead.HeadId where voucher.Dt between '?' and '?' and budgethead.strBudgroupId='?' group by budgethead.HeadId  order by budgethead.strName");



		//***************************
		//Delete Head
		ALLSQL.put("DeleteHead","DELETE FROM budgethead bh WHERE bh.HeadId = '?' AND NOT EXISTS (SELECT 1 FROM budgetalloc ba WHERE ba.HeadId = bh.HeadId )");
		ALLSQL.put("DeleteUser","Delete from Userlst where UId='?'");




		ALLSQL.put("checkUser","select * from userLst where strLogin LIKE '?' and strPwd LIKE '?'");
		ALLSQL.put("checkUserLogin","select * from userLst where strLogin LIKE '?'");
		ALLSQL.put("checkHead","select * from BudgetHead where strName LIKE '?'");

		ALLSQL.put("lastFinanceID","select max(ID) as LastId from finance.finance_year" );
		ALLSQL.put("openAllFinacialYear","select * from finance.finance_year");
		ALLSQL.put("openAllFinacialYearWL","select * from finance.finance_year limit ?,?");
		ALLSQL.put("openAllFinacialYearId","select * from finance.finance_year where ID='?'");
		ALLSQL.put("openAllFinacialYearwithId","select ID from finance.finance_year");
		ALLSQL.put("checkYear","select * from finance.finance_year where F_Year  LIKE '?' and T_Year LIKE '?'");
		ALLSQL.put("insertFinacialYear","insert into finance.finance_year values('?','?','?','?')");
		ALLSQL.put("updateFinacialYear","Update finance.finance_year set F_Year='?',T_Year='?', DBnm='?' where ID='?'");
		ALLSQL.put("CreateDB","Create Database ?");
		ALLSQL.put("CreateTB","Create Table ?");
		ALLSQL.put("CreateUsrlst","insert into ?.userlst values('100000','LTPL','ltpl','0665513306455614231063','0','100000','2005-04-16','100000','2005-04-16')");




		ALLSQL.put("updatePOBalance","Update purchaseorder set nAmt=nAmt-'?' where nBudgetId='?' and nPONo='?'");


		ALLSQL.put("AmtForPO","select sum(nAmt) as POAmt,POId,Strparty from purchaseorder where  nBudgetId='?' Group by nBudgetId");

		ALLSQL.put("openAllUser","select * from userLst where lvl=1 order by strName ");
		ALLSQL.put("openAllUserWL","select * from userLst where lvl=1 order by strName limit ?,?");
		ALLSQL.put("openUserWithId","select * from userLst where lvl=1 AND UId='?'");

		ALLSQL.put("openHead","Select * from budgethead where HeadId='?'");
		ALLSQL.put("openAllHead","select * from BudgetHead order by strName");
		ALLSQL.put("openAllHeadDept","select bh.* from BudgetHead bh left join BudgetAlloc ba on bh.HeadId=ba.HeadId where ba.strDepartmentId=? order by bh.strName");
		ALLSQL.put("openAmount","select * from BUDGETALLOC where  HeadId='?'");
		ALLSQL.put("openVouchse","select * from VOUCHER where  HeadId='?' ");
		ALLSQL.put("openVouchsebytype","select * from VOUCHER where  HeadId='?' and bMode='?'");
		ALLSQL.put("openVouchseForPO","select * from purchaseorder where  nBudgetId='?'");

		ALLSQL.put("openBalance","select * from HEADBAL where  HeadId='?'");
		ALLSQL.put("openAllHeadWL","select * from BudgetHead  order by strName limit ?,?");
		//ALLSQL.put("openAllHeadWL","select * from BudgetHead  order by strName");


		ALLSQL.put("openAllHeadAllocation","select budgetHead.HeadId, sum(budgetalloc.dblAmount) as Allocate from budgetHead left join  budgetalloc on budgetHead.HeadId=budgetalloc.HeadId Group by budgetHead.HeadId order by budgetHead.strName ");
		ALLSQL.put("openHeadAllocation","select budgetHead.HeadId, sum(budgetalloc.dblAmount) as Allocate from budgetHead left join  budgetalloc on budgetHead.HeadId=budgetalloc.HeadId where budgetHead.HeadId='?' Group by budgetHead.HeadId");
		ALLSQL.put("openAllHeadExpanse","select budgetHead.HeadId, sum(voucher.dblAmount + voucher.dblTds) as exp from budgetHead left join voucher on budgetHead.HeadId=voucher.HeadId Group by budgetHead.HeadId order by budgetHead.strName ");
		ALLSQL.put("openHeadExpanse","select budgetHead.HeadId, sum(voucher.dblAmount + voucher.dblTds) as exp from budgetHead left join voucher on budgetHead.HeadId=voucher.HeadId where budgetHead.HeadId='?' Group by budgetHead.HeadId");


		ALLSQL.put("openAllHeadWithBalance","select a.AllocId, a.HeadId, a.dblAmount, b.strName,b.strBudgroupId, d.strDepartmentNm, a.dblReservedAmount, a.dblUtilisedAmount from budgetalloc a, budgethead b, departments d where a.HeadId = b.HeadId and a.strDepartmentId = d.strDepartmentId  and a.strDepartmentId = '?' order by b.strName");
		ALLSQL.put("openAllHeadWithBalanceSearch","select a.AllocId, a.HeadId, a.dblAmount, b.strName,b.strBudgroupId, d.strDepartmentNm, a.dblReservedAmount, a.dblUtilisedAmount from budgetalloc a, budgethead b, departments d where a.HeadId = b.HeadId and a.strDepartmentId = d.strDepartmentId  and a.strDepartmentId = '?' and b.strName like '%?%'  order by b.strName");
		ALLSQL.put("openAllHeadWithBalanceWL","select a.AllocId, a.HeadId, a.dblAmount, b.strName,b.strBudgroupId, d.strDepartmentNm, a.dblReservedAmount, a.dblUtilisedAmount from budgetalloc a, budgethead b, departments d where a.HeadId = b.HeadId and a.strDepartmentId = d.strDepartmentId  and a.strDepartmentId = '?' order by b.strName limit ?,?");
		ALLSQL.put("openAllHeadWithBalanceWLSearch","select a.AllocId, a.HeadId, a.dblAmount, b.strName,b.strBudgroupId, d.strDepartmentNm, a.dblReservedAmount, a.dblUtilisedAmount from budgetalloc a, budgethead b, departments d where a.HeadId = b.HeadId and a.strDepartmentId = d.strDepartmentId  and a.strDepartmentId = '?' and b.strName like '%?%' order by b.strName limit ?,?");


         //view all report
		ALLSQL.put("openAllHeadWithBalanceAllDept","select a.AllocId, a.HeadId, a.dblAmount, b.strName,b.strBudgroupId, d.strDepartmentNm, a.dblReservedAmount, a.dblUtilisedAmount from budgetalloc a, budgethead b, departments d where a.HeadId = b.HeadId and a.strDepartmentId = d.strDepartmentId  order by d.strDepartmentNm");
		ALLSQL.put("openAllHeadWithBalanceAllDeptSearch","select a.AllocId, a.HeadId, a.dblAmount, b.strName,b.strBudgroupId, d.strDepartmentNm, a.dblReservedAmount, a.dblUtilisedAmount from budgetalloc a, budgethead b, departments d where a.HeadId = b.HeadId and a.strDepartmentId = d.strDepartmentId and b.strName like '%?%'  order by b.strName");
		ALLSQL.put("openAllHeadWithBalanceAllDeptWL","select a.AllocId, a.HeadId, a.dblAmount, b.strName,b.strBudgroupId, d.strDepartmentNm, a.dblReservedAmount, a.dblUtilisedAmount from budgetalloc a, budgethead b, departments d where a.HeadId = b.HeadId and a.strDepartmentId = d.strDepartmentId  order by b.strName limit ?,?");
		ALLSQL.put("openAllHeadWithBalanceAllDeptWLSearch","select a.AllocId, a.HeadId, a.dblAmount, b.strName,b.strBudgroupId, d.strDepartmentNm, a.dblReservedAmount, a.dblUtilisedAmount from budgetalloc a, budgethead b, departments d where a.HeadId = b.HeadId and a.strDepartmentId = d.strDepartmentId and b.strName like '%?%'  order by b.strName limit ?,?");



		//new view report group wise
		ALLSQL.put("getAllHeadGroupWiseBallance","SELECT a.AllocId, a.HeadId, a.dblAmount, b.strName, b.strBudgroupId, g.strBudgroupNm, d.strDepartmentNm, a.dblReservedAmount, a.dblUtilisedAmount FROM budgetalloc a JOIN budgethead b ON a.HeadId = b.HeadId JOIN budgroup g ON b.strBudgroupId = g.strBudgroupId JOIN departments d ON a.strDepartmentId = d.strDepartmentId WHERE b.strBudgroupId = '?' ORDER BY g.strBudgroupNm, b.strName");
		ALLSQL.put("getAllHeadGroupWiseBallanceDept","SELECT a.AllocId, a.HeadId, a.dblAmount, b.strName, b.strBudgroupId, g.strBudgroupNm, d.strDepartmentNm, a.dblReservedAmount, a.dblUtilisedAmount FROM budgetalloc a JOIN budgethead b ON a.HeadId = b.HeadId JOIN budgroup g ON b.strBudgroupId = g.strBudgroupId JOIN departments d ON a.strDepartmentId = d.strDepartmentId WHERE b.strBudgroupId = '?' and a.strDepartmentId = '?' ORDER BY g.strBudgroupNm, b.strName");

		ALLSQL.put("getAllGroupId","select strBudgroupId from budgroup where strRmrk='?' order by strBudgroupNm");


		// new query added for view report group wise with voucher datee.g.  between date range
		//ALLSQL.put("getAllHeadGroupWiseBallanceWithDate","SELECT @rownum := @rownum + 1 AS S_No,g.strBudgroupNm, bh.strName, d.strDepartmentNm, ba.dblAmount, IFNULL(bn.total_note_amount, 0) AS Budget_Note_Amount," +
			//	"vd.total_voucher_amount AS dblUtilisedAmount, (ba.dblAmount - (IFNULL(bn.total_note_amount, 0) - vd.total_voucher_amount)) AS dblReservedAmount," +
			//			"(ba.dblAmount - vd.total_voucher_amount) AS Remaining FROM budgetalloc ba JOIN budgethead bh ON bh.HeadId = ba.HeadId JOIN budgroup g ON bh.strBudgroupId = g.strBudgroupId " +
			//			"JOIN departments d ON ba.strDepartmentId = d.strDepartmentId JOIN ( SELECT bn.AllocId, SUM(vd.amount) AS total_voucher_amount " +
			//			"FROM voucher_details vd JOIN budget_note bn ON vd.budget_note_id = bn.budget_note_id " +
			//			"WHERE vd.voucher_date >= '?' AND vd.voucher_date <= '?' GROUP BY bn.AllocId ) vd ON ba.AllocId = vd.AllocId " +
			//			"LEFT JOIN ( SELECT AllocId, SUM(budget_note_expense) AS total_note_amount FROM budget_note GROUP BY AllocId ) " +
			//	"bn ON ba.AllocId = bn.AllocId, (SELECT @rownum := 0) r WHERE bh.strBudgroupId = '?' ORDER BY g.strBudgroupNm, bh.strName");

		//ALLSQL.put("getAllHeadGroupWiseBallanceWithDateDept","SELECT @rownum := @rownum + 1 AS S_No,g.strBudgroupNm, bh.strName, d.strDepartmentNm, ba.dblAmount, IFNULL(bn.total_note_amount, 0) AS Budget_Note_Amount," +
			//	"vd.total_voucher_amount AS dblUtilisedAmount, (ba.dblAmount - (IFNULL(bn.total_note_amount, 0) - vd.total_voucher_amount)) AS dblReservedAmount," +
			//	"(ba.dblAmount - vd.total_voucher_amount) AS Remaining FROM budgetalloc ba JOIN budgethead bh ON bh.HeadId = ba.HeadId JOIN budgroup g ON bh.strBudgroupId = g.strBudgroupId " +
			//	"JOIN departments d ON ba.strDepartmentId = d.strDepartmentId JOIN ( SELECT bn.AllocId, SUM(vd.amount) AS total_voucher_amount " +
			//	"FROM voucher_details vd JOIN budget_note bn ON vd.budget_note_id = bn.budget_note_id " +
			//	"WHERE vd.voucher_date >= '?' AND vd.voucher_date <= '?' GROUP BY bn.AllocId ) vd ON ba.AllocId = vd.AllocId " +
			//	"LEFT JOIN ( SELECT AllocId, SUM(budget_note_expense) AS total_note_amount FROM budget_note GROUP BY AllocId ) " +
			//	"bn ON ba.AllocId = bn.AllocId, (SELECT @rownum := 0) r WHERE bh.strBudgroupId = '?' and ba.strDepartmentId = ? ORDER BY g.strBudgroupNm, bh.strName");

		//All data if no voucher created yet.
		ALLSQL.put("getAllHeadGroupWiseBallanceWithDate","SELECT @rownum := @rownum + 1 AS S_No, g.strBudgroupNm, bh.strName, d.strDepartmentNm, ba.dblAmount, IFNULL(bn.total_note_amount, 0) AS Budget_Note_Amount, IFNULL(vd.total_voucher_amount, 0) AS dblUtilisedAmount, (ba.dblAmount - (IFNULL(bn.total_note_amount, 0) - IFNULL(vd.total_voucher_amount, 0))) AS dblReservedAmount, (ba.dblAmount - IFNULL(vd.total_voucher_amount, 0)) AS Remaining FROM budgetalloc ba JOIN budgethead bh ON bh.HeadId = ba.HeadId JOIN budgroup g ON bh.strBudgroupId = g.strBudgroupId JOIN departments d ON ba.strDepartmentId = d.strDepartmentId LEFT JOIN ( SELECT bn.AllocId, SUM(vd.amount) AS total_voucher_amount FROM voucher_details vd JOIN budget_note bn ON vd.budget_note_id = bn.budget_note_id WHERE vd.voucher_date >= '?' AND vd.voucher_date <= '?' GROUP BY bn.AllocId ) vd ON ba.AllocId = vd.AllocId LEFT JOIN ( SELECT AllocId, SUM(budget_note_expense) AS total_note_amount FROM budget_note GROUP BY AllocId ) bn ON ba.AllocId = bn.AllocId, (SELECT @rownum := 0) r WHERE bh.strBudgroupId = ? ORDER BY g.strBudgroupNm, bh.strName");
		ALLSQL.put("getAllHeadGroupWiseBallanceWithDateDept","SELECT @rownum := @rownum + 1 AS S_No, g.strBudgroupNm, bh.strName, d.strDepartmentNm, ba.dblAmount, IFNULL(bn.total_note_amount, 0) AS Budget_Note_Amount, IFNULL(vd.total_voucher_amount, 0) AS dblUtilisedAmount, (ba.dblAmount - (IFNULL(bn.total_note_amount, 0) - IFNULL(vd.total_voucher_amount, 0))) AS dblReservedAmount, (ba.dblAmount - IFNULL(vd.total_voucher_amount, 0)) AS Remaining FROM budgetalloc ba JOIN budgethead bh ON bh.HeadId = ba.HeadId JOIN budgroup g ON bh.strBudgroupId = g.strBudgroupId JOIN departments d ON ba.strDepartmentId = d.strDepartmentId LEFT JOIN ( SELECT bn.AllocId, SUM(vd.amount) AS total_voucher_amount FROM voucher_details vd JOIN budget_note bn ON vd.budget_note_id = bn.budget_note_id WHERE vd.voucher_date >= '?' AND vd.voucher_date <= '?' GROUP BY bn.AllocId ) vd ON ba.AllocId = vd.AllocId LEFT JOIN ( SELECT AllocId, SUM(budget_note_expense) AS total_note_amount FROM budget_note GROUP BY AllocId ) bn ON ba.AllocId = bn.AllocId, (SELECT @rownum := 0) r WHERE bh.strBudgroupId = ?  ba.strDepartmentId = ? ORDER BY g.strBudgroupNm, bh.strName");



		ALLSQL.put("openHeadBalanceWithId","select * from headbal where HeadId='?'");

		ALLSQL.put("openAllAllocationOfHead","select * from budgetalloc where HeadId='?'");
		ALLSQL.put("openAllAllocationOfHeadWL","select * from budgetalloc where HeadId='?' order by Dt limit ?,?");
		ALLSQL.put("openAllocationWithId","select * from budgetalloc where AllocId='?'");

		ALLSQL.put("lastID","select max(UId) as LastId from userlst" );
		ALLSQL.put("lastHeadID","select max(HeadId) as LastId from BudgetHead" );
		ALLSQL.put("lastAllocationID","select max(AllocId) as LastId from budgetalloc" );
		ALLSQL.put("lastVoucherID","select max(voucherId) as LastId from Voucher" );

		ALLSQL.put("insertUser","insert into userLst values('?','?','?','?','?','?','?','?','?','?')");

		ALLSQL.put("insertHeadBalance","insert into headbal values('?','?')");
		ALLSQL.put("InsertOrg","insert into company values('?','?','?','?','?',?,'?',?,'?')");
		ALLSQL.put("insertintobudgetallocation","insert into budgetalloc values('?','?','?','?','?',?,'?',?,'?','?',0.0,0.0)");
		ALLSQL.put("InsertintoHeadBalance","insert into headbal values('?','?')");
		ALLSQL.put("insertintoVoucher","insert into voucher values('?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?')");
		ALLSQL.put("insertintoCheque","insert into cheque values('?','?','?')");

        //Added for the VouNo////

        ALLSQL.put("SelectVouno","select max(VouNo) as LastId from voucher where HeadId='?'" );
        ALLSQL.put("SelectVounoforCheque","select max(srCvouNO) as LastId from voucher where bMode='?'" );
        //////////////////////

       ALLSQL.put("FindFromVoucher","Select * From voucher where voucherId='?'");
		//ALLSQL.put("UpdateHead","Update Headbal set dblBalance=dblBalance+'?' where HeadId='?'");
		ALLSQL.put("DeleteFromVoucher","Delete From voucher where voucherId='?'");
		ALLSQL.put("DeleteFromCheque","Delete From cheque Where voucherId='?'");


		ALLSQL.put("updateUser","Update userLst set strName='?',strLogin='?',strPwd='?', strUptdBy='?',strUptdOn='?',strDepartmentId='?' where UId='?'");
		//ALLSQL.put("updateHead","Update BudgetHead set strName='?',strRemark='?', strUptdBy='?',strUptdOn='?' where HeadId='?'");
		ALLSQL.put("UpdateOrg","Update company set strName='?', strShortNm ='?', strAddr='?',strPh1='?', strPh2='?', strUptdBy='?', strUptdOn='?'");
		ALLSQL.put("updateintobudgetallocation","Update budgetalloc set HeadId='?', Dt ='?', dblAmount='?',strRemark='?', strInsBy='?',strInsOn='?', strUptdBy='?', strUptdOn='?',strDepartmentId='?' where AllocId='?'");
		ALLSQL.put("updateHeadBalance","Update headbal set dblBalance=dblBalance+'?' where HeadId='?'");


// Voucher Update
		ALLSQL.put("updateintoVoucher","update voucher set voucherNo='?', dt='?',HeadId='?', dblAmount ='?',dblTds ='?',strType='?',strToAcc='?',bMode ='?',strBank ='?',strReceiverNm='?',strInsBy ='?', strInsOn='?', strUptdBy ='?', strUptdOn  ='?' , strTDS='?' where voucherId='?'");


		ALLSQL.put("updateintoCheque","Update cheque set strChequeNo='?' where voucherId='?'");

		ALLSQL.put("checkPassword","select * from userLst where UId='?' and strPwd='?'");
		ALLSQL.put("saveNewPassword","Update userLst set strPwd='?' where UId='?'");

		ALLSQL.put("deleteFromAllocation","delete from budgetalloc where AllocId='?'");
//		ALLSQL.put("ViewAllAlloc","select budgethead.strName, budgethead.HeadId, budgethead.strAccNo, sum(budgetalloc.dblAmount) as BSUM from budgethead,budgetalloc where budgethead.HeadId=budgetalloc.HeadId group by budgethead.HeadId order by budgethead.HeadId where budgethead.HeadId='?'");
//		ALLSQL.put("ViewAllVouch","select budgethead.HeadId, sum(voucher.dblAmount) as VSUM from budgethead,voucher where budgethead.HeadId=voucher.HeadId and  voucher.Dt between '?' and '?' group by budgethead.HeadId order by budgethead.HeadId where budgethead.HeadId='?'");

		//ALLSQL.put("ViewAllAlloc","select budgethead.strName, budgethead.HeadId, budgethead.strAccNo,sum(budgetalloc.dblAmount) as BSUM from budgethead left join budgetalloc on budgethead.HeadId=budgetalloc.HeadId group by budgethead.HeadId order by budgethead.HeadId");
		//*************************
		ALLSQL.put("ViewAllAlloc","select budgethead.strName, budgethead.HeadId, budgethead.strAccNo,sum(budgetalloc.dblAmount) as BSUM from budgethead left join budgetalloc on budgethead.HeadId=budgetalloc.HeadId group by budgethead.HeadId order by budgethead.strName");
		//*************************
		//ALLSQL.put("ViewAllVouch","select budgethead.HeadId, sum(voucher.dblAmount) as VSUM ,sum(voucher.dblTds) as tds from budgethead left join voucher on budgethead.HeadId=voucher.HeadId where voucher.Dt between '?' and '?' group by budgethead.HeadId order by budgethead.HeadId");
		//*************************
		ALLSQL.put("ViewAllVouch","select budgethead.HeadId, sum(voucher.dblAmount) as VSUM ,sum(voucher.dblTds) as tds from budgethead left join voucher on budgethead.HeadId=voucher.HeadId where voucher.Dt between '?' and '?' group by budgethead.HeadId order by budgethead.strName");
		//*************************

		ALLSQL.put("ViewVouchWithoutDateForHeadId","select budgethead.HeadId, sum(voucher.dblAmount) as VSUM, sum(voucher.dblTds) as TSUM from budgethead left join voucher on budgethead.HeadId=voucher.HeadId where  budgethead.HeadId ='?' group by budgethead.HeadId order by budgethead.HeadId");

		//ALLSQL.put("ViewVouchAndPOWithoutDateForHeadId","select budgethead.HeadId, sum(voucher.dblAmount) as VSUM, sum(voucher.dblTds) as TSUM,sum(purchaseorder.nAmt) as POSUM from budgethead left join voucher on budgethead.HeadId=voucher.HeadId left join purchaseorder on budgethead.Headid=purchaseorder.nBudgetId where  budgethead.HeadId ='?' group by budgethead.HeadId order by budgethead.HeadId");

		ALLSQL.put("ViewVouchAndPOWithoutDateForHeadId","select budgethead.HeadId,sum(voucher.dblAmount) as VSUM,sum(voucher.dblTds) as TSUM from budgethead left join voucher on budgethead.HeadId=voucher.HeadId where  budgethead.HeadId ='?' group by budgethead.HeadId order by budgethead.HeadId");


		ALLSQL.put("ViewAllocForHeadId","select budgethead.strName, budgethead.HeadId, budgethead.strAccNo,sum(budgetalloc.dblAmount) as BSUM from budgethead left join budgetalloc on budgethead.HeadId=budgetalloc.HeadId where  budgethead.HeadId ='?' group by budgethead.HeadId order by budgethead.HeadId");

		ALLSQL.put("acode","select count(strAccNo) as code from budgethead");



		ALLSQL.put("A_Amount","Select Sum(budgetalloc.dblAmount) as BSUM from budgetalloc where HeadId='?'");
		ALLSQL.put("V_Amount","Select Sum(voucher.dblAmount) as VSUM from voucher where HeadId='?'");


		// actions from - createbudgetnote.jsp - START
		ALLSQL.put("budget_note_MAX_ID", "SELECT (COALESCE(MAX(budget_note_id), 0)+1) as MAX_ID FROM budget_note");
		ALLSQL.put("budget_note_INSERT", "INSERT INTO budget_note values('?', '?', '?', '?', '?', '?', '?', '?', CURRENT_DATE, '?', CURRENT_DATE,'?','?','?','?')");
		ALLSQL.put("budget_note_UPDATE","update budget_note set budget_note_expense='?',allocation_reserved_amount='?',allocation_balance_amount_after_expense='?',budget_note_remark='?',updated_by_user_id='?',update_date=CURRENT_DATE, budget_note_status='?',ponumber='?',advance='?',advanceReceiverName='?',narration='?' where budget_note_id='?'");

		ALLSQL.put("budget_note_history_MAX_ID", "SELECT (COALESCE(MAX(budget_note_history_id), 0)+1) as MAX_ID FROM budget_note_history");
		ALLSQL.put("budget_note_history_INSERT", "INSERT INTO budget_note_history values('?', '?', '?', '?', '?', '?', '?', '?', CURRENT_DATE)");
		// actions from - createbudgetnote.jsp - END

		ALLSQL.put("listbudgetnote","SELECT bn.budget_note_id, bn.budget_note_status, bn.budget_note_expense, bn.budget_note_status, bn.create_date, bn.ponumber, ba.AllocId, ba.Dt AS allocation_date, ba.dblAmount AS allocated_amount, ba.dblReservedAmount, ba.dblUtilisedAmount, bh.HeadId, bh.strName AS budget_head_name, bh.strBudgroupId AS budget_group_id, dp.strDepartmentNm FROM budget_note bn JOIN budgetalloc ba ON bn.AllocId = ba.AllocId JOIN budgethead bh ON ba.HeadId = bh.HeadId JOIN departments dp ON ba.strDepartmentId = dp.strDepartmentId where ba.strDepartmentId = '?' order by bn.budget_note_id desc");
		ALLSQL.put("listbudgetnotelimit","SELECT bn.budget_note_id, bn.budget_note_status, bn.budget_note_expense, bn.budget_note_status, bn.create_date, bn.ponumber, ba.AllocId, ba.Dt AS allocation_date, ba.dblAmount AS allocated_amount, ba.dblReservedAmount, ba.dblUtilisedAmount, bh.HeadId, bh.strName AS budget_head_name, bh.strBudgroupId AS budget_group_id, dp.strDepartmentNm FROM budget_note bn JOIN budgetalloc ba ON bn.AllocId = ba.AllocId JOIN budgethead bh ON ba.HeadId = bh.HeadId JOIN departments dp ON ba.strDepartmentId = dp.strDepartmentId where ba.strDepartmentId = '?' order by bn.budget_note_id desc limit ?,?");

		ALLSQL.put("listbudgetnote_one_alldept","SELECT bn.budget_note_id, bn.budget_note_status, bn.budget_note_expense, bn.budget_note_status, bn.create_date, bn.ponumber, ba.AllocId, ba.Dt AS allocation_date, ba.dblAmount AS allocated_amount, ba.dblReservedAmount, ba.dblUtilisedAmount, bh.HeadId, bh.strName AS budget_head_name, bh.strBudgroupId AS budget_group_id, dp.strDepartmentNm FROM budget_note bn JOIN budgetalloc ba ON bn.AllocId = ba.AllocId JOIN budgethead bh ON ba.HeadId = bh.HeadId JOIN departments dp ON ba.strDepartmentId = dp.strDepartmentId where bn.budget_note_id = '?' order by bn.budget_note_id desc");
		ALLSQL.put("listbudgetnote_one","SELECT bn.budget_note_id, bn.budget_note_status, bn.budget_note_expense, bn.budget_note_status, bn.create_date, bn.ponumber, ba.AllocId, ba.Dt AS allocation_date, ba.dblAmount AS allocated_amount, ba.dblReservedAmount, ba.dblUtilisedAmount, bh.HeadId, bh.strName AS budget_head_name, bh.strBudgroupId AS budget_group_id, dp.strDepartmentNm FROM budget_note bn JOIN budgetalloc ba ON bn.AllocId = ba.AllocId JOIN budgethead bh ON ba.HeadId = bh.HeadId JOIN departments dp ON ba.strDepartmentId = dp.strDepartmentId where bn.budget_note_id = '?' and  ba.strDepartmentId = '?' order by bn.budget_note_id desc");

		ALLSQL.put("listbudgetnote_headsearch_alldept","SELECT bn.budget_note_id, bn.budget_note_status, bn.budget_note_expense, bn.budget_note_status, bn.create_date, bn.ponumber, ba.AllocId, ba.Dt AS allocation_date, ba.dblAmount AS allocated_amount, ba.dblReservedAmount, ba.dblUtilisedAmount, bh.HeadId, bh.strName AS budget_head_name, bh.strBudgroupId AS budget_group_id, dp.strDepartmentNm FROM budget_note bn JOIN budgetalloc ba ON bn.AllocId = ba.AllocId JOIN budgethead bh ON ba.HeadId = bh.HeadId JOIN departments dp ON ba.strDepartmentId = dp.strDepartmentId where bh.strName like  '%?%' order by bn.budget_note_id desc");
		ALLSQL.put("listbudgetnote_headsearch_dept","SELECT bn.budget_note_id, bn.budget_note_status, bn.budget_note_expense, bn.budget_note_status, bn.create_date, bn.ponumber, ba.AllocId, ba.Dt AS allocation_date, ba.dblAmount AS allocated_amount, ba.dblReservedAmount, ba.dblUtilisedAmount, bh.HeadId, bh.strName AS budget_head_name, bh.strBudgroupId AS budget_group_id, dp.strDepartmentNm FROM budget_note bn JOIN budgetalloc ba ON bn.AllocId = ba.AllocId JOIN budgethead bh ON ba.HeadId = bh.HeadId JOIN departments dp ON ba.strDepartmentId = dp.strDepartmentId where bh.strName like  '%?%' and  ba.strDepartmentId = '?' order by bn.budget_note_id desc");


		ALLSQL.put("listbudgetnoteAllDept","SELECT bn.budget_note_id, bn.budget_note_status, bn.budget_note_expense, bn.budget_note_status, bn.create_date, bn.ponumber, ba.AllocId, ba.Dt AS allocation_date, ba.dblAmount AS allocated_amount, ba.dblReservedAmount, ba.dblUtilisedAmount, bh.HeadId, bh.strName AS budget_head_name, bh.strBudgroupId AS budget_group_id, dp.strDepartmentNm FROM budget_note bn JOIN budgetalloc ba ON bn.AllocId = ba.AllocId JOIN budgethead bh ON ba.HeadId = bh.HeadId JOIN departments dp ON ba.strDepartmentId = dp.strDepartmentId order by bn.budget_note_id desc");
		ALLSQL.put("listbudgetnoteAllDeptlimit","SELECT bn.budget_note_id, bn.budget_note_status, bn.budget_note_expense, bn.budget_note_status, bn.create_date, bn.ponumber, ba.AllocId, ba.Dt AS allocation_date, ba.dblAmount AS allocated_amount, ba.dblReservedAmount, ba.dblUtilisedAmount, bh.HeadId, bh.strName AS budget_head_name, bh.strBudgroupId AS budget_group_id, dp.strDepartmentNm FROM budget_note bn JOIN budgetalloc ba ON bn.AllocId = ba.AllocId JOIN budgethead bh ON ba.HeadId = bh.HeadId JOIN departments dp ON ba.strDepartmentId = dp.strDepartmentId order by bn.budget_note_id desc limit ?,?");
		ALLSQL.put("get_budget_note", "SELECT budget_note_id FROM budget_note where AllocId='?'");
		ALLSQL.put("get_head_id", "SELECT HeadId,strDepartmentId FROM budgetalloc where AllocId='?'");


		//Voucher Detaisl by Budget Note: Start
		ALLSQL.put("openVoucherDetailsWithBudgetNoteId","SELECT bn.budget_note_id, bn.budget_note_expense, bn.budget_note_status, bn.create_date, bn.ponumber, ba.AllocId, ba.Dt AS allocation_date, ba.dblAmount AS allocated_amount, ba.dblReservedAmount, ba.dblUtilisedAmount,(ba.dblAmount-ba.dblUtilisedAmount) as BallanceAmount, bh.HeadId, bh.strName AS budget_head_name, bh.strBudgroupId AS budget_group_id, dp.strDepartmentNm, ba.strDepartmentId FROM budget_note bn JOIN budgetalloc ba ON bn.AllocId = ba.AllocId JOIN budgethead bh ON ba.HeadId = bh.HeadId JOIN departments dp ON ba.strDepartmentId = dp.strDepartmentId where bn.budget_note_id=? ");
		ALLSQL.put("openVoucherDetailsWithVoucherId","SELECT bn.budget_note_id, bn.budget_note_expense, bn.budget_note_status, bn.create_date, bn.ponumber, ba.AllocId, ba.Dt AS allocation_date, ba.dblAmount AS allocated_amount, ba.dblReservedAmount, ba.dblUtilisedAmount, (ba.dblAmount - ba.dblUtilisedAmount) AS BallanceAmount,(bn.budget_note_expense - (vd.amount+vd.tds_amount)) AS RemainingBudgetNoteAmount, bh.HeadId, bh.strName AS budget_head_name, bh.strBudgroupId AS budget_group_id, dp.strDepartmentNm, ba.strDepartmentId, vd.* FROM budget_note AS bn JOIN budgetalloc AS ba ON bn.AllocId = ba.AllocId JOIN budgethead AS bh ON ba.HeadId = bh.HeadId JOIN departments AS dp ON ba.strDepartmentId = dp.strDepartmentId LEFT JOIN voucher_details AS vd ON vd.budget_note_id = bn.budget_note_id WHERE vd.voucher_id = ?");
		ALLSQL.put("getTotalVoucherAmoutForBudgetNote","SELECT SUM(vd.amount + vd.tds_amount) AS BudgetNoteVoucherAmount FROM  voucher_details AS vd JOIN budget_note AS bn ON vd.budget_note_id = bn.budget_note_id WHERE vd.budget_note_id = ? GROUP BY  vd.budget_note_id");
		ALLSQL.put("insertintoBudgetVoucher","insert into voucher_details values('?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?')");
		ALLSQL.put("SelectMaxVouno","select max(voucher_number) as LastId from voucher_details" );
		ALLSQL.put("voucher_details_MAX_ID", "SELECT (COALESCE(MAX(voucher_id), 0)+1) as MAX_ID FROM voucher_details");
		ALLSQL.put("voucher_number_MAX_ID", "SELECT (COALESCE(MAX(voucher_number), 0)+1) as MAX_ID FROM voucher_details");

		ALLSQL.put("updateReservedBalance","Update budgetalloc set dblReservedAmount=dblReservedAmount+'?' where AllocId='?'");
		ALLSQL.put("MinusReservedBalance","Update budgetalloc set dblReservedAmount=(dblReservedAmount-?) where AllocId='?'");
		ALLSQL.put("adjustAllocatedAndReservedAmountOnVoucherDelete","UPDATE budgetalloc b JOIN budget_note n ON b.AllocId = n.AllocId SET b.dblReservedAmount = b.dblReservedAmount + '?',b.dblUtilisedAmount = b.dblUtilisedAmount - '?' WHERE n.budget_note_id = '?'");

		ALLSQL.put("adjustAllocatedAndReservedAmount","Update budgetalloc set dblReservedAmount = dblReservedAmount - '?' , dblUtilisedAmount = dblUtilisedAmount + '?' where HeadId='?' and strDepartmentId = '?'");

		ALLSQL.put("openAllVoucher","select v.voucher_id,v.voucher_number,b.budget_note_id,b.ponumber,v.receiver_name,v.voucher_date,d.strDepartmentNm,bh.strName,v.amount+v.tds_amount as amt from voucher_details v left join budget_note b on  v.budget_note_id = b.budget_note_id  left join  budgetalloc ba on  b.AllocId = ba.AllocId left join BudgetHead bh on ba.HeadId = bh.HeadId left join departments d on ba.strDepartmentId=d.strDepartmentId order by v.voucher_number desc;");
		ALLSQL.put("openAllVoucherWL","select v.voucher_id,v.voucher_number,b.budget_note_id,b.ponumber,v.receiver_name,v.voucher_date,d.strDepartmentNm,bh.strName,v.amount+v.tds_amount as amt from voucher_details v left join budget_note b on  v.budget_note_id = b.budget_note_id  left join  budgetalloc ba on  b.AllocId = ba.AllocId left join BudgetHead bh on ba.HeadId = bh.HeadId left join departments d on ba.strDepartmentId=d.strDepartmentId order by v.voucher_number desc limit ?,?");

		ALLSQL.put("openAllVoucherSearch","select v.voucher_id,v.voucher_number,b.budget_note_id,b.ponumber,v.receiver_name,v.voucher_date,d.strDepartmentNm,bh.strName,v.amount+v.tds_amount as amt from voucher_details v left join budget_note b on  v.budget_note_id = b.budget_note_id  left join  budgetalloc ba on  b.AllocId = ba.AllocId left join BudgetHead bh on ba.HeadId = bh.HeadId left join departments d on ba.strDepartmentId=d.strDepartmentId where v.voucher_date between '?' and '?' and v.receiver_name like '%?%' order by v.voucher_number desc;");
		ALLSQL.put("openAllVoucherSearchWL","select v.voucher_id,v.voucher_number,b.budget_note_id,b.ponumber,v.receiver_name,v.voucher_date,d.strDepartmentNm,bh.strName,v.amount+v.tds_amount as amt from voucher_details v left join budget_note b on  v.budget_note_id = b.budget_note_id  left join  budgetalloc ba on  b.AllocId = ba.AllocId left join BudgetHead bh on ba.HeadId = bh.HeadId left join departments d on ba.strDepartmentId=d.strDepartmentId where v.voucher_date between '?' and '?' and v.receiver_name like '%?%' order by v.voucher_number desc limit ?,?");


		ALLSQL.put("openVoucherWithId","select voucher_details.*, voucher_details.amount+voucher.tds_amount as amt,BudgetHead.* from voucher_details left join BudgetHead on voucher_details.HeadId = BudgetHead.HeadId where voucher_details.voucher_id='?'");
		ALLSQL.put("openVoucherId","select * from voucher_details where voucher_id='?'");
		ALLSQL.put("deletebudgetnote","delete from budget_note where budget_note_id='?'");
		ALLSQL.put("budgetNoteDataWithId","SELECT bd.AllocId AS allocationId,d.strDepartmentNm AS departmentName,b.strName AS headName,a.dblAmount AS allocatedAmount,a.dblReservedAmount AS reservedAmount,a.dblUtilisedAmount AS utilisedAmount,(a.dblAmount - a.dblReservedAmount - a.dblUtilisedAmount) AS availableBalance,bd.budget_note_id,bd.budget_note_expense,bd.allocation_reserved_amount,bd.allocation_balance_amount_after_expense,bd.budget_note_remark,bd.budget_note_status,bd.ponumber,bd.create_date,bd.advance,bd.advanceReceiverName,bd.narration FROM budgetalloc a JOIN budgethead b ON a.HeadId = b.HeadId JOIN departments d ON a.strDepartmentId = d.strDepartmentId JOIN budget_note bd ON a.AllocId = bd.AllocId WHERE bd.budget_note_id = ?");

		// Create Budget Note - Queries - Start
		ALLSQL.put("budgetNoteInputData"," select a.AllocId as allocationId, d.strDepartmentNm as departmentName, b.strName as headName, a.dblAmount as allocatedAmount, a.dblReservedAmount as reservedAmount, a.dblUtilisedAmount as utilisedAmount, (a.dblAmount-a.dblReservedAmount-a.dblUtilisedAmount) as availableBalance from budgetalloc a, budgethead b, departments d where a.HeadId = b.HeadId and a.strDepartmentId = d.strDepartmentId  and a.AllocId = ?");
		// Create Budget Note - Queries - End
		ALLSQL.put("checkVoucherForBudgetNote","select * from voucher_details where budget_note_id='?'");
		ALLSQL.put("getBudgetExpense","select budget_note_expense,AllocId from budget_note where budget_note_id='?'");



		ALLSQL.put("VoucherDelete","Delete from voucher_details where voucher_id='?'");

		ALLSQL.put("get_All_Allocation_Status_Report", "SELECT H.strName AS HEAD_NAME, D.strDepartmentNm AS DEPARTMENT_NAME, BA.dblAmount AS ALLOCATED_AMOUNT, BA.dblReservedAmount AS RESERVED_AMOUNT, BA.dblUtilisedAmount AS UTILISED_AMOUNT, (BA.dblAmount-BA.dblUtilisedAmount-BA.dblReservedAmount) AS REMAINING_AMOUNT FROM budgetalloc BA, departments D, budgethead H WHERE BA.strDepartmentId = D.strDepartmentId AND BA.HeadId = H.HeadId ORDER BY H.strName");
		ALLSQL.put("get_All_Allocation_Status_Report_Department", "SELECT H.strName AS HEAD_NAME, D.strDepartmentNm AS DEPARTMENT_NAME, BA.dblAmount AS ALLOCATED_AMOUNT, BA.dblReservedAmount AS RESERVED_AMOUNT, BA.dblUtilisedAmount AS UTILISED_AMOUNT, (BA.dblAmount-BA.dblUtilisedAmount-BA.dblReservedAmount) AS REMAINING_AMOUNT FROM budgetalloc BA, departments D, budgethead H WHERE BA.strDepartmentId = D.strDepartmentId AND BA.HeadId = H.HeadId AND BA.strDepartmentId ='?' ORDER BY H.strName");


		// Reports - START
		ALLSQL.put("ALL_VOUCHER_REPORT", "SELECT VD.voucher_id, VD.voucher_date, (VD.amount+VD.tds_amount) AS VOUCHER_AMOUNT, VD.receiver_name, D.strDepartmentNm, H.strName FROM VOUCHER_DETAILS VD, BUDGET_NOTE BN, budgetalloc BA, departments D, budgethead H WHERE VD.budget_note_id = BN.budget_note_id AND BN.AllocId = BA.AllocId AND BA.strDepartmentId = D.strDepartmentId AND BA.HeadId = H.HeadId AND VD.voucher_date BETWEEN '?' AND '?' order by VD.voucher_date desc");
		ALLSQL.put("ALL_VOUCHER_REPORT_BY_DEPT", "SELECT VD.voucher_id, VD.voucher_date, (VD.amount+VD.tds_amount) AS VOUCHER_AMOUNT, VD.receiver_name, D.strDepartmentNm, H.strName FROM VOUCHER_DETAILS VD, BUDGET_NOTE BN, budgetalloc BA, departments D, budgethead H WHERE VD.budget_note_id = BN.budget_note_id AND BN.AllocId = BA.AllocId AND BA.strDepartmentId = D.strDepartmentId AND BA.HeadId = H.HeadId AND VD.voucher_date BETWEEN '?' AND '?' AND BA.strDepartmentId = '?' order by VD.voucher_date desc");
		ALLSQL.put("ALL_VOUCHER_REPORT_BY_HEAD", "SELECT VD.voucher_id, VD.voucher_date, (VD.amount+VD.tds_amount) AS VOUCHER_AMOUNT, VD.receiver_name, D.strDepartmentNm, H.strName FROM VOUCHER_DETAILS VD, BUDGET_NOTE BN, budgetalloc BA, departments D, budgethead H WHERE VD.budget_note_id = BN.budget_note_id AND BN.AllocId = BA.AllocId AND BA.strDepartmentId = D.strDepartmentId AND BA.HeadId = H.HeadId AND VD.voucher_date BETWEEN '?' AND '?' AND BA.HeadId = '?' order by VD.voucher_date desc");
		ALLSQL.put("ALL_VOUCHER_REPORT_BY_HEAD_PAY_METHOD", "SELECT VD.voucher_id, VD.voucher_date, (VD.amount+VD.tds_amount) AS VOUCHER_AMOUNT, VD.receiver_name, D.strDepartmentNm, H.strName FROM VOUCHER_DETAILS VD, BUDGET_NOTE BN, budgetalloc BA, departments D, budgethead H WHERE VD.budget_note_id = BN.budget_note_id AND BN.AllocId = BA.AllocId AND BA.strDepartmentId = D.strDepartmentId AND BA.HeadId = H.HeadId AND VD.voucher_date BETWEEN '?' AND '?' AND BA.HeadId = '?' and VD.payment_mode in (?) order by VD.voucher_date desc");

		ALLSQL.put("ALL_VOUCHER_REPORT_BY_DEPT_AND_HEAD", "SELECT VD.voucher_id, VD.voucher_date, (VD.amount+VD.tds_amount) AS VOUCHER_AMOUNT, VD.receiver_name, D.strDepartmentNm, H.strName FROM VOUCHER_DETAILS VD, BUDGET_NOTE BN, budgetalloc BA, departments D, budgethead H WHERE VD.budget_note_id = BN.budget_note_id AND BN.AllocId = BA.AllocId AND BA.strDepartmentId = D.strDepartmentId AND BA.HeadId = H.HeadId AND VD.voucher_date BETWEEN '?' AND '?' AND BA.strDepartmentId = '?' AND BA.HeadId = '?' AND VD.payment_mode in (?) order by VD.voucher_date desc");
		ALLSQL.put("ALL_VOUCHER_REPORT_BY_ALL_HEAD_DEPT_PAY_METHOD", "SELECT VD.voucher_id, VD.voucher_date, (VD.amount+VD.tds_amount) AS VOUCHER_AMOUNT, VD.receiver_name, D.strDepartmentNm, H.strName FROM VOUCHER_DETAILS VD, BUDGET_NOTE BN, budgetalloc BA, departments D, budgethead H WHERE VD.budget_note_id = BN.budget_note_id AND BN.AllocId = BA.AllocId AND BA.strDepartmentId = D.strDepartmentId AND BA.HeadId = H.HeadId AND VD.voucher_date BETWEEN '?' AND '?' AND BA.strDepartmentId = '?' AND VD.payment_mode in (?) order by VD.voucher_date desc");


		ALLSQL.put("ALL_VOUCHER_REPORT_PAY_METHOD", "SELECT VD.voucher_id, VD.voucher_date, (VD.amount+VD.tds_amount) AS VOUCHER_AMOUNT, VD.receiver_name, D.strDepartmentNm, H.strName FROM VOUCHER_DETAILS VD, BUDGET_NOTE BN, budgetalloc BA, departments D, budgethead H WHERE VD.budget_note_id = BN.budget_note_id AND BN.AllocId = BA.AllocId AND BA.strDepartmentId = D.strDepartmentId AND BA.HeadId = H.HeadId AND VD.voucher_date BETWEEN '?' AND '?' and VD.payment_mode in (?) order by VD.voucher_date desc");
		// Reports - END

		ALLSQL.put("GET_VOUCHER_DETAILS_FOR_PRINT","SELECT vd.voucher_id, vd.voucher_number, vd.voucher_date, vd.amount, vd.tds_amount, vd.strType, vd.payment_mode, vd.bank_name,vd.chequeno, vd.receiver_name, vd.narration, bn.budget_note_id, bn.budget_note_expense, bn.allocation_reserved_amount, bn.allocation_balance_amount_after_expense, bn.ponumber, ba.AllocId, ba.dblAmount, ba.dblReservedAmount, ba.dblUtilisedAmount, bh.strName AS budget_head_name, d.strDepartmentNm AS department_name FROM voucher_details vd JOIN budget_note bn ON vd.budget_note_id = bn.budget_note_id JOIN budgetalloc ba ON bn.AllocId = ba.AllocId JOIN budgethead bh ON ba.HeadId = bh.HeadId JOIN departments d ON ba.strDepartmentId = d.strDepartmentId WHERE vd.voucher_id='?';");
		//End

	}


	public  void setCustomSQL(String sql){
		finalSql = sql;
	}

	public  void setSQL(String sql,Vector vec)
	{
		sop("sql--"+sql+"--");
		sop("vec--"+vec+"--");

		finalSql = "";

		String strTemp = (String)ALLSQL.get(sql);


		int paramIndex = 0;
        	System.out.println("strTemp is------"+strTemp);

		for(int i=0;i<strTemp.length();i++)
		{
			if(strTemp.charAt(i)== '?')
			{

//				sop("inside if of setsql()------");

				finalSql = finalSql + (String)vec.elementAt(paramIndex);
//				sop("finalsql------"+finalSql);
				paramIndex++;
			}
			else
			{

				finalSql = finalSql + strTemp.charAt(i);
//				sop("inside else of setsql()------"+finalSql);

			}
		}
	sop("\n\nfinalSql--"+finalSql+"--\n\n");
	}



	public Collection executeQuery()
	{
			sop("inside executeQuery---");
			try
			{
				Vector vec = new Vector();
				ResultSet rs = stmt.executeQuery(finalSql);

				ResultSetMetaData md = rs.getMetaData();


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

						vec.add(hm);

					}
				return vec;


			} catch(Exception e)
			{
				sop("Failed while Executing Query");
				e.printStackTrace();
			}
			return null;
		}


	public Vector executeQueryGetList()
	{
		sop("inside executeQueryGetList---");
		try
		{
			Vector vec = new Vector();
			ResultSet rs = stmt.executeQuery(finalSql);

			ResultSetMetaData md = rs.getMetaData();


			int cc = md.getColumnCount();
			while (rs.next())
			{
				HashMap hm = new HashMap();
				for(int i=0;i<cc;i++)
				{
					int ii = i+1;

					String strData = rs.getString(ii);
					//String strColumn = md.getColumnName(ii);
					//hm.put(strColumn, strData);
					vec.add(strData);
				}



			}
			return vec;


		} catch(Exception e)
		{
			sop("Failed while Executing Query");
			e.printStackTrace();
		}
		return null;
	}


	public int executeUpdate()
	{
		int u=0 ;
		try
		{
			Vector vec = new Vector();
			u = stmt.executeUpdate(finalSql);

		}
		catch(Exception e)
		{
			sop("Failed while Executing update");
			e.printStackTrace();
		}
		return u;

	}



	public void sop(String msg)
	{
		System.out.println(this.getClass().getSimpleName() + " : " + msg);
        }

	public String getMaxId(String queryName){
		String result = null;

		HashMap hmFinal = new HashMap();
		Vector queryParams = new Vector();

		setSQL(queryName, queryParams);
		Vector queryResult = (Vector)executeQuery();

		result = (String)(((Map) queryResult.get(0)).get("MAX_ID")) ;

		sop(queryName + "-------->" + result);

		return result;
	}
}
