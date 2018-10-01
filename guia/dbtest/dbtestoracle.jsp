<%@page import="java.sql.*, javax.sql.*, javax.naming.*"%>
<html>
<head>
<title>Using a DataSource</title>
</head>
<body>
<h1>Using a DataSource</h1>
<%
    DataSource ds = null;
    Connection conn = null;
    ResultSet result = null;
    Statement stmt = null;
    ResultSetMetaData rsmd = null;
    try{
      Context context = new InitialContext();
      Context envCtx = (Context) context.lookup("java:comp/env");
      ds =  (DataSource)envCtx.lookup("jdbc/myoracle");
      if (ds != null) {
        conn = ds.getConnection();
        stmt = conn.createStatement();
        result = stmt.executeQuery("SELECT * FROM CDSE_USER");
       }
     }
     catch (SQLException e) {
        System.out.println("Error occurred " + e);
      }
      int columns=0;
      try {
        rsmd = result.getMetaData();
        columns = rsmd.getColumnCount();
      }
      catch (SQLException e) {
         System.out.println("Error occurred " + e);
      }
 %>
 <table width="90%" border="1">
   <tr>
   <% // write out the header cells containing the column labels
      try {
         for (int i=1; i<=columns; i++) {
              out.write("<th>" + rsmd.getColumnLabel(i) + "</th>");
         }
   %>
   </tr>
   <% // now write out one row for each entry in the database table
         while (result.next()) {
            out.write("<tr>");
            for (int i=1; i<=columns; i++) {
              out.write("<td>" + result.getString(i) + "</td>");
            }
            out.write("</tr>");
         }
 
         // close the connection, resultset, and the statement
         result.close();
         stmt.close();
         conn.close();
      } // end of the try block
      catch (SQLException e) {
         System.out.println("Error " + e);
      }
      // ensure everything is closed
    finally {
     try {
       if (stmt != null)
        stmt.close();
       }  catch (SQLException e) {}
       try {
        if (conn != null)
         conn.close();
        } catch (SQLException e) {}
    }
 
    %>
</table>
</body>
</html>
