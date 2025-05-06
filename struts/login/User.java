package login;

/**
 * Created by morer on 06-05-2025.
 */
public class User {
    public User(String userId, String userName, String departmentId) {
        this.userId = userId;
        this.userName = userName;
        this.departmentId = departmentId;
    }

    private String userId;

    public String getUserId() {
        return userId;
    }

    public String getUserName() {
        return userName;
    }

    public String getDepartmentId() {
        return departmentId;
    }

    private String userName;
    private String departmentId;

    private boolean isStoreUser(){
        return "100002".equals(departmentId);
    }

    private boolean isAccountUser(){
        return "100001".equals(departmentId);
    }

    @Override
    public String toString() {
        return "User{" +
                "userId='" + userId + '\'' +
                ", userName='" + userName + '\'' +
                ", departmentId='" + departmentId + '\'' +
                ", isStoreUser='" + isStoreUser() + '\'' +
                ", isAccountUser='" + isAccountUser() + '\'' +
                '}';
    }
}
