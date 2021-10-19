package com;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;


/**
 * Web application lifecycle listener.
 *
 * @author birse
 */
public class DbListener implements ServletContextListener {

    public static final String CLASS_NAME = "org.postgresql.Driver";
    public static final String URL = "jdbc:postgresql://ec2-52-2-118-38.compute-1.amazonaws.com:5432/ddjohqsrmuc971";
    public static Exception exception = null;
    private static String user = "bhdutwlwnveisa";
    private static String password = "b702952d8acf0eed9f760aa30fb51bd026e4d16b7c045caec88336687b9f51cf";
    
    public static Connection getConnection() throws Exception{
        Class.forName(CLASS_NAME);
        return DriverManager.getConnection(URL, user, password);
    }

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        try {
            Class.forName(CLASS_NAME);
            Connection con = getConnection();
            Statement stmt = con.createStatement();
            
            stmt.close();
            con.close();
        }catch(Exception ex){
            exception = ex;
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
    }
}
