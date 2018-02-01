Compilar con javac un directorio con varios fuentes
===================================================

Crear un ".jar" desde la compilación de varios fuentes ".java" dentro de varios directorios ubicado en el directorio sources. Vamos a utilizar **Apache ANT** Es mucho más fácil que poner directamente el comando javac. Es como un make pero para Java y mucho más sencillo de usar, los archivos son en XML.

Tenemos dos fuentes en la carpeta sources uno llamado "HolaMundo.java".::

	/*
	* Hola Mund..... Ejemplo
	*/

	public class HolaMundo {

		public static void main (String args[]){

			System.out.println("Hola Mundo !!!" + args[0]);
		}
	}

y otro "BuenasMundo.java".::

	/*
	* Hola Mund..... Ejemplo
	*/

	public class BuenasMundo {

		public static void main (String args[]){

			System.out.println("Buenas Mundo !!!");
		}
	}


.::

	<project name="mi proyecto" default="all">
	  <target name="all" depends="build,pack" />

	  <target name="build">
	    <mkdir dir="bin" />
	    <!-- esto indica que compile todo lo que haya bajo sources y ponga las clases resultantes en bin -->
	    <javac srcdir="sources" destdir="bin" includes="**/*.java">
	      <!-- este es un classpath de ejemplo: un directorio lib al mismo nivel que sources, incluimos todos los jars que contenga -->
	      <classpath>
		<fileset dir="lib" includes="*.jar" />
	      </classpath>
	    </javac>
	  </target>

	  <target name="pack">
	    <jar file="SaludandoMundo.jar">
	      <!-- incluimos todas las clases bajo bin -->
	      <fileset dir="bin" includes="**/*.class" />
	      <!-- incluimos tambien los properties que estan directamente bajo sources (sin recursion) -->
	      <fileset dir="sources" includes="*.properties" />
	      <manifest>
		<attribute name="Main-Class" value="HolaMundo" />
	      </manifest>
	    </jar>
	  </target>

	</project>

Ya con el XML guardado con el nombre de  **build.xml** en el mismo nivel que el directorio sources, simplemente en ese directorio teclea "ant" y listo, te va a compilar todas las clases, las pondrá en un directorio bin y al final empaca todo lo compilado en un JAR (junto con los properties que tengas en sources) y hasta puedes definir atributos para el Manifest de tu jar.

Ejecutamos el ant.::

	# ant
	Buildfile: /home/cgomez/tmp/java/build.xml

	build:
	    [javac] /home/cgomez/tmp/java/build.xml:7: warning: 'includeantruntime' was not set, defaulting to build.sysclasspath=last; set to false for repeatable builds

	pack:

	all:

	BUILD SUCCESSFUL
	Total time: 0 seconds

Y probamos el .jar.::

	# java -jar SaludandoMundo.jar Carlos
	Hola Mundo !!!Carlos



