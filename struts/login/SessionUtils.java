package login;

import javax.servlet.http.HttpSession;

/**
 * Created by morer on 06-05-2025.
 */
public class SessionUtils {

    private static String USER_OBJECT_KEY = "USER_OBJECT";

    public static User addUserToSession(HttpSession session, String strUserId, String strLogin, String departmentId){
        User user = new User(strUserId, strLogin, departmentId);
        session.setAttribute(USER_OBJECT_KEY, user);
        System.out.println("user_object SET IN SESSION ========================>" + user);

        return user;
    }

    public static boolean isAccountORStoreUser(HttpSession session){

        boolean accountORStoreUser = false;

        User user = (User)session.getAttribute(USER_OBJECT_KEY);

        if (null != user && ( user.isAccountUser() || user.isStoreUser() )){
            accountORStoreUser = true;
        }

        return accountORStoreUser;
    }

    public static boolean isAccountUser(HttpSession session){

        boolean accountUser = false;

        User user = (User)session.getAttribute(USER_OBJECT_KEY);

        if (null != user && ( user.isAccountUser()  )){
            accountUser = true;
        }

        return accountUser;
    }


    public static String getDepartmentId(HttpSession session){
        String departmentId = "100001";

        User user = (User)session.getAttribute(USER_OBJECT_KEY);

        if (null != user && null != user.getDepartmentId()){
            departmentId = user.getDepartmentId();
        }else{
            System.err.println("User found without DEPARTMENT_ID, Using ACCOUNT DEPARTMENT_ID ----------------->" + user);
        }


        return departmentId;

    }
}
