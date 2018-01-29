import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;

public class DemoServlet extends HttpServlet {

 public void doGet(HttpServletRequest request, 
  HttpServletResponse response) 
  throws ServletException, IOException {
  
  PrintWriter out = response.getWriter();
  out.println("<HTML>");
  out.println("<HEAD>");
  out.println("<TITLE>Servlet Testing</TITLE>");
  out.println("</HEAD>");
  out.println("<BODY>");
  out.println("<table border=0>");
  out.println("<tr>");
  out.println("<td>");
  out.println("<img src=images/CONSIS.png>");
  out.println("</td>");
  out.println("<td>");
  out.println("<h1>Sample Hello, World Application</h1>");
  out.println("<p>This is the home page for a sample application used to illustrate the source directory organization of a web application utilizing the principles outlined in the Application Developer's Guide.");
  out.println("</td>");
  out.println("</tr>");
  out.println("</table>");

  out.println("Welcome to the Servlet Testing Center");
  out.println("</BODY>");
  out.println("</HTML>");
 }
}
