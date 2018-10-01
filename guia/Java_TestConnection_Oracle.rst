Java Test Connection with Oracle
=================================

Creamos el archivo
+++++++++++++++++++

,::

	$ vi OracleConnection.java

	import java.util.ArrayList;
	import java.sql.*;

	public class OracleConnection {

	    public static void main(String[] args) throws Exception {
		//connect to database
		Class.forName("oracle.jdbc.driver.OracleDriver");
		ArrayList<String> serverNames = new ArrayList<String>();
		serverNames.add("192.168.1.52");
		serverNames.add("192.168.1.52");
		serverNames.add("192.168.1.52");
		serverNames.add("192.168.1.52");
		String portNumber = "1521";
		String sid = "oracsel";
		String url = "jdbc:oracle:thin:@(DESCRIPTION=(ADDRESS_LIST=(LOAD_BALANCE=ON)(FAILOVER=ON)" ;
		for (String serverName : serverNames) { 
		    url += "(ADDRESS=(PROTOCOL=tcp)(HOST="+serverName+")(PORT="+portNumber+"))";
		}
		url += ")(CONNECT_DATA=(SID="+sid+")))";
		String username = "aQA_RIMACUNGU_V138_I";
		String password = "QA_RIMACUNGU_V138_I";
		// System.out.println(url); //
		Connection conn = DriverManager.getConnection(url, username, password);
		if (conn != null) {
		    System.out.println("You made it, take control your database now!");
		} else {
		    System.out.println("Failed to make connection!");
		}
	    }
	}

Compilamos
++++++++++
.::

	$ javac OracleConnection.java

Ejecutamos el test
++++++++++++++++++

Debe estar el archivo "ojdbc6.jar" en la misma ruta

Para UNIX.::

	$ java -cp .:./ojdbc6.jar OracleConnection
	You made it, take control your database now!

	$ java -classpath ".:./ojdbc7.jar" OracleConnection 
	You made it, take control your database now!

Para Windows.::

	$ java -classpath ".;./ojdbc7.jar;lib/*" OracleConnection 
	You made it, take control your database now!



