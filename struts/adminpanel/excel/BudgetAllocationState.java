package struts.adminpanel.excel;

/**
 * Created by morer on 11-05-2025.
 */
public class BudgetAllocationState {
    private String headName;
    private String departmentName;
    private String allocatedAmount;
    private String reservedAmount;
    private String utilisedAmount;
    private String remainingAmount;

    public String getHeadDepartmentKey(){
        return headName + "-I_AM_MAK-" + departmentName;
    }

    public String getHeadName() {
        return headName;
    }

    public String getDepartmentName() {
        return departmentName;
    }

    public String getAllocatedAmount() {
        return allocatedAmount;
    }

    public String getReservedAmount() {
        return reservedAmount;
    }

    public String getUtilisedAmount() {
        return utilisedAmount;
    }

    public String getRemainingAmount() {
        return remainingAmount;
    }

    public BudgetAllocationState(String headName, String departmentName, String allocatedAmount, String reservedAmount, String utilisedAmount, String remainingAmount) {
        this.headName = headName;
        this.departmentName = departmentName;
        this.allocatedAmount = allocatedAmount;
        this.reservedAmount = reservedAmount;
        this.utilisedAmount = utilisedAmount;
        this.remainingAmount = remainingAmount;
    }

    @Override
    public String toString() {
        return "BudgetAllocationState{" +
                "headName='" + headName + '\'' +
                ", departmentName='" + departmentName + '\'' +
                ", allocatedAmount='" + allocatedAmount + '\'' +
                ", reservedAmount='" + reservedAmount + '\'' +
                ", utilisedAmount='" + utilisedAmount + '\'' +
                ", remainingAmount='" + remainingAmount + '\'' +
                '}';
    }
}
