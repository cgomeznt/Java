Crear un Servlet
===================

Crear primero la estructura de trabajo
++++++++++++++++++++++++++++++++++++++

	$ mkdir demo
	$ mkdir -p demo/WEB-INF/lib
	$ mkdir -p demo/WEB-INF/classes
	$ mkdir -p demo/images


Crear un bytecode en java
++++++++++++++++++++++++++

Creamos un codigo java.::
	
	$ cd demo

	$ vi DemoServlet.java 

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

Descargar el servlet-api.jar
++++++++++++++++++++++++++++

Si no tenemos un tomcat o un jboss instalado descargamos el artefacto **servlet-api.jar**.::

	$ wget http://www.java2s.com/Code/JarDownload/servlet/servlet-api.jar.zip


Declarar las variables de entorno
++++++++++++++++++++++++++++++++++

Debemos estar seguros que tenemos configurado el JAVA_HOME y el CLASSPATH.::

	$ export JAVA_HOME="/u02/app/product/jdk1.7.0_79"

	$ export CLASSPATH=/u02/EAR_Weblogic/demo/servlet-api.jar


Compilamos el codigo java
+++++++++++++++++++++++++

	$ /u02/app/product/jdk1.7.0_79/bin/javac DemoServlet.java

y lo movemos a su ruta.::

	$ mv DemoServlet.class WEB-INF/classes


Creamos el archivo de control
+++++++++++++++++++++++++++++

Este archivo **web.xml** debe ir en WEB-INF.::

	$ vi WEB-INF/web.xml

	<?xml version="1.0" encoding="ISO-8859-1"?>
	<web-app xmlns="http://java.sun.com/xml/ns/j2ee"
	    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	    xsi:schemaLocation="http://java.sun.com/xml/ns/j2ee http://java.sun.com/xml/ns/j2ee/web-app_2_4.xsd"
	    version="2.4">

	    <display-name>Hello, World Application</display-name>
	    <description>
		This is a simple web application with a source code organization
		based on the recommendations of the Application Developer's Guide.
	    </description>

	    <servlet>
		<servlet-name>DemoServlet</servlet-name>
		<servlet-class>DemoServlet</servlet-class>
	    </servlet>

	    <servlet-mapping>
		<servlet-name>DemoServlet</servlet-name>
		<url-pattern>/demo</url-pattern>
	    </servlet-mapping>

	</web-app>


Creamos un archivo index.html
+++++++++++++++++++++++++++++++++

Creamos este archivo para tener un ejemplo mas claro.::

	$ vi index.html 

	<html>
	<head>
	<title>Sample "Hello, World" Application</title>
	</head>
	<body bgcolor=white>

	<table border="0">
	<tr>
	<td>
	<img src="images/CONSIS.png">
	</td>
	<td>
	<h1>Sample "Hello, World" Application</h1>
	<p>This is the home page for a sample application used to illustrate the
	source directory organization of a web application utilizing the principles
	outlined in the Application Developer's Guide.
	</td>
	</tr>
	</table>

	<p>To prove that they work, you can execute either of the following links:
	<ul>
	<li>To a <a href="demo">DemoServlet</a>.
	</ul>

	</body>

Colocamos una imagen 
+++++++++++++++++++++++

Colocamos una imagen llamada CONSIS.png en el directorio images


Creamos el WAR
+++++++++++++++

Procedemos a crear el war.::

	$ zip -r  demo.war *

Se creara un archivo llamado **demo.war**  y ese es el que vamos a utilizar en cualquier application server.





