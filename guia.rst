.. contents::
   :depth: 3
..

**Guía - de instalación y configuración de prerrequisitos para el
servidor srvscm02**

|image0|

**Headquarters USA**:

10650 W Sate Rd 84,

Suite 204, Davie FL 33324.

|image1|

Master (001954) 2173035

Fax\ **.** (001954) 2173036

|image2|

**Venezuela:**

| Edificio LANEX, piso 3
| Av. Principal de Los Ruices
| Caracas 1071.

|image3|

Telf. (58212) 2384980

(58212) 2374212

Fax. Ext. 135

`*http://www.consisint.com* <http://www.consisint.com/>`__

`*info@consisint.com* <mailto:info@consisint.com>`__

Ninguna parte de este documento puede ser copiado, reproducido, adaptado
o traspasado en alguna forma o bajo ningún medio físico o electrónico,
para ningún propósito sin  previo consentimiento escrito y formal de
Consis International, LLC. La protección a los derechos de autor incluye
todo material e información, más no limitada a la generada de los
aplicativos mostrados en las pantallas, tales como íconos, diseño
gráfico, logos, etc.

Copyright © 1987-2015. `*Consis
International* <http://www.consisint.com/>`__. Derechos Reservados.

Este documento está organizado conforme a la estructura mencionada en el
estándar 1063-2001 de la IEEE (*IEEE Standard 1063-2001 Software User
Documentation*).

\ **versionamiento del documento**

\ **lista de validación**

+----------------------+-------------------+-------------+--------------+
|                      | **Nombre**        | **Cargo**   | **Fecha**    |
+----------------------+-------------------+-------------+--------------+
| **Elaborado por:**   | Carlos Gómez G.   | SCM         | 05/01/2018   |
+----------------------+-------------------+-------------+--------------+
| **Aprobado por:**    |                   |             |              |
+----------------------+-------------------+-------------+--------------+
| **Revisado por.**    |                   |             |              |
+----------------------+-------------------+-------------+--------------+

\ **Tabla de Contenido**

Sumario

`versionamiento del documento 3 <#__RefHeading___Toc442288098>`__

`lista de validación 3 <#__RefHeading___Toc442288099>`__

`Tabla de Contenido 4 <#__RefHeading___Toc442288100>`__

`INTRODUCCIÓN 5 <#__RefHeading___Toc442288101>`__

`INFORMACIÓN DE USO DE DOCUMENTACIÓN
5 <#__RefHeading___Toc35_232130029>`__

`Deshabilitar el selinux 6 <#__RefHeading___Toc123_69026468>`__

`Cantidad de Hilos que se le permite al usuario
7 <#__RefHeading___Toc37_232130029>`__

`Deshabilitar el Firewalld 8 <#__RefHeading___Toc125_69026468>`__

`Instalar wget 10 <#__RefHeading___Toc127_69026468>`__

`Instalar las actualizaciones de RedHat
11 <#__RefHeading___Toc129_69026468>`__

`Instalar los repositorios EPEL para RedHat
11 <#__RefHeading___Toc131_69026468>`__

`Instalación de la librería libXtst
12 <#__RefHeading___Toc45_1181803815>`__

`Instalación de la librería gtk2-2.24.31-1
15 <#__RefHeading___Toc67_596609316>`__

`Instalación de la librería libcanberra-gtk2
21 <#__RefHeading___Toc69_596609316>`__

`Instalar openvpn 28 <#__RefHeading___Toc133_69026468>`__

`Creando la clave rsa publica. 33 <#__RefHeading___Toc135_69026468>`__

`Instalar Apache. 35 <#__RefHeading___Toc137_69026468>`__

`Instalar el java jdk 8 y jdk 7 38 <#__RefHeading___Toc139_69026468>`__

`Configurar del SSH para que X11 haga forward.
39 <#__RefHeading___Toc141_69026468>`__

`Instalando las versiones de JAVA utilizadas por CONSIS para compilar y
crear los EAR 41 <#__RefHeading___Toc143_69026468>`__

`Configuración de las variables de entorno para el usuario “oracle”
42 <#__RefHeading___Toc145_69026468>`__

`Configuración el “.bashrc” para el usuario “oracle”
48 <#__RefHeading___Toc147_69026468>`__

`Instalación y configuración del Agente ZABBIX
50 <#__RefHeading___Toc149_69026468>`__

`Crear un script para Systemd para zabbix.
52 <#__RefHeading___Toc46_232130029>`__

`Crear un script para Systemd para openvpn.
54 <#__RefHeading___Toc41_232130029>`__

\ **INTRODUCCIÓN**

El siguiente documento, tiene como objetivo servir de guía en el proceso
de instalación y configuración de prerrequisitos para el servidor
srvscm02

En este se indicaran los pasos recomendados para la instalación y
configuración de prerrequisitos para el servidor srvscm02

\ **INFORMACIÓN DE USO DE DOCUMENTACIÓN **

Los íconos que a continuación se muestran facilitan la navegabilidad y
ubicación de secciones dentro del documento:

REGRESAR: sirve para regresar al título del tema principal. Se acciona
al hacer Ctrl+Clic sobre el mismo.

TABLA DE CONTENIDO: permite regresar a la tabla de contenido del
documento. Se acciona al hacer Ctrl+Clic sobre el

mismo.

Instalación y configuración de prerrequisitos para el servidor srvscm02

A continuación se describirán cada unos de los pasos que se ejecutaron
para la instalación y configuración de prerrequisitos en el servidor
srvscm02.

Deshabilitar el selinux

Debemos editar el archivo de configuración de selinux y deshabilitarlo.

+---------------------------------------------------+
| # vi /etc/sysconfig/selinux                       |
|                                                   |
| #Cambiar SELINUX=enforcing por SELINUX=disabled   |
|                                                   |
| y reiniciar el equipo                             |
+---------------------------------------------------+

Cantidad de Hilos que se le permite al usuario

Si consultamos el usuario oracle tiene muy bajo la cantidad de hilos que
tiene permitido y esto puede generar los errores de JavaOutOfMemory

+------------------------------------+
| [oracle@srvscm02 IBM]$ ulimit -u   |
|                                    |
| 4096                               |
+------------------------------------+

Para mejorar esto editamos el archivo “/etc/security/limits.conf” y
agregamos solo estas dos lineas al final del archivo.

+-------------------------------------------------------+
| [oracle@srvscm02 IBM]# vi /etc/security/limits.conf   |
|                                                       |
| oracle hard nproc 256472                              |
|                                                       |
| oracle soft nproc 256472                              |
+-------------------------------------------------------+

+----------------------------------+
| [oracle@srvscm02 ~]$ ulimit -u   |
|                                  |
| 256472                           |
+----------------------------------+

Deshabilitar el Firewalld

Deshabilitamos el firewalld motivado que estamos en ambientes de
Desarrollo y QA. Esto no es recomendable en ambientes de producción.

+-----------------------------------------------------------------------------------------------------------------------------------------------------+
| [root@srvscm02 tmp]# systemctl status firewalld                                                                                                     |
|                                                                                                                                                     |
| ● firewalld.service - firewalld - dynamic firewall daemon                                                                                           |
|                                                                                                                                                     |
| Loaded: loaded (/usr/lib/systemd/system/firewalld.service; enabled; vendor preset: enabled)                                                         |
|                                                                                                                                                     |
| Active: active (running) since Mon 2017-12-18 15:23:26 EST; 2 weeks 3 days ago                                                                      |
|                                                                                                                                                     |
| Docs: man:firewalld(1)                                                                                                                              |
|                                                                                                                                                     |
| Main PID: 1196 (firewalld)                                                                                                                          |
|                                                                                                                                                     |
| CGroup: /system.slice/firewalld.service                                                                                                             |
|                                                                                                                                                     |
| └─1196 /usr/bin/python -Es /usr/sbin/firewalld --nofork --nopid                                                                                     |
|                                                                                                                                                     |
| Dec 18 15:23:25 srvscm02.consis.local systemd[1]: Starting firewalld - dynamic firewall daemon...                                                   |
|                                                                                                                                                     |
| Dec 18 15:23:26 srvscm02.consis.local systemd[1]: Started firewalld - dynamic firewall daemon.                                                      |
|                                                                                                                                                     |
| Dec 18 15:23:28 srvscm02.consis.local firewalld[1196]: WARNING: ICMP type 'beyond-scope' is not supported by the kernel for ipv6.                   |
|                                                                                                                                                     |
| Dec 18 15:23:28 srvscm02.consis.local firewalld[1196]: WARNING: beyond-scope: INVALID\_ICMPTYPE: No supported ICMP type., ignoring for run-time.    |
|                                                                                                                                                     |
| Dec 18 15:23:28 srvscm02.consis.local firewalld[1196]: WARNING: ICMP type 'failed-policy' is not supported by the kernel for ipv6.                  |
|                                                                                                                                                     |
| Dec 18 15:23:28 srvscm02.consis.local firewalld[1196]: WARNING: failed-policy: INVALID\_ICMPTYPE: No supported ICMP type., ignoring for run-time.   |
|                                                                                                                                                     |
| Dec 18 15:23:28 srvscm02.consis.local firewalld[1196]: WARNING: ICMP type 'reject-route' is not supported by the kernel for ipv6.                   |
|                                                                                                                                                     |
| Dec 18 15:23:28 srvscm02.consis.local firewalld[1196]: WARNING: reject-route: INVALID\_ICMPTYPE: No supported ICMP type., ignoring for run-time.    |
|                                                                                                                                                     |
| [root@srvscm02 tmp]# systemctl disabled firewalld                                                                                                   |
|                                                                                                                                                     |
| Unknown operation 'disabled'.                                                                                                                       |
|                                                                                                                                                     |
| [root@srvscm02 tmp]# systemctl disable firewalld                                                                                                    |
|                                                                                                                                                     |
| Removed symlink /etc/systemd/system/dbus-org.fedoraproject.FirewallD1.service.                                                                      |
|                                                                                                                                                     |
| Removed symlink /etc/systemd/system/basic.target.wants/firewalld.service.                                                                           |
|                                                                                                                                                     |
| [root@srvscm02 tmp]#                                                                                                                                |
|                                                                                                                                                     |
| [root@srvscm02 tmp]#                                                                                                                                |
|                                                                                                                                                     |
| [root@srvscm02 tmp]#                                                                                                                                |
|                                                                                                                                                     |
| [root@srvscm02 tmp]#                                                                                                                                |
|                                                                                                                                                     |
| [root@srvscm02 tmp]# systemctl status firewalld                                                                                                     |
|                                                                                                                                                     |
| ● firewalld.service - firewalld - dynamic firewall daemon                                                                                           |
|                                                                                                                                                     |
| Loaded: loaded (/usr/lib/systemd/system/firewalld.service; disabled; vendor preset: enabled)                                                        |
|                                                                                                                                                     |
| Active: active (running) since Mon 2017-12-18 15:23:26 EST; 2 weeks 3 days ago                                                                      |
|                                                                                                                                                     |
| Docs: man:firewalld(1)                                                                                                                              |
|                                                                                                                                                     |
| Main PID: 1196 (firewalld)                                                                                                                          |
|                                                                                                                                                     |
| CGroup: /system.slice/firewalld.service                                                                                                             |
|                                                                                                                                                     |
| └─1196 /usr/bin/python -Es /usr/sbin/firewalld --nofork --nopid                                                                                     |
|                                                                                                                                                     |
| Dec 18 15:23:25 srvscm02.consis.local systemd[1]: Starting firewalld - dynamic firewall daemon...                                                   |
|                                                                                                                                                     |
| Dec 18 15:23:26 srvscm02.consis.local systemd[1]: Started firewalld - dynamic firewall daemon.                                                      |
|                                                                                                                                                     |
| Dec 18 15:23:28 srvscm02.consis.local firewalld[1196]: WARNING: ICMP type 'beyond-scope' is not supported by the kernel for ipv6.                   |
|                                                                                                                                                     |
| Dec 18 15:23:28 srvscm02.consis.local firewalld[1196]: WARNING: beyond-scope: INVALID\_ICMPTYPE: No supported ICMP type., ignoring for run-time.    |
|                                                                                                                                                     |
| Dec 18 15:23:28 srvscm02.consis.local firewalld[1196]: WARNING: ICMP type 'failed-policy' is not supported by the kernel for ipv6.                  |
|                                                                                                                                                     |
| Dec 18 15:23:28 srvscm02.consis.local firewalld[1196]: WARNING: failed-policy: INVALID\_ICMPTYPE: No supported ICMP type., ignoring for run-time.   |
|                                                                                                                                                     |
| Dec 18 15:23:28 srvscm02.consis.local firewalld[1196]: WARNING: ICMP type 'reject-route' is not supported by the kernel for ipv6.                   |
|                                                                                                                                                     |
| Dec 18 15:23:28 srvscm02.consis.local firewalld[1196]: WARNING: reject-route: INVALID\_ICMPTYPE: No supported ICMP type., ignoring for run-time.    |
|                                                                                                                                                     |
| [root@srvscm02 tmp]# systemctl stop firewalld                                                                                                       |
|                                                                                                                                                     |
| [root@srvscm02 tmp]# systemctl status firewalld                                                                                                     |
|                                                                                                                                                     |
| ● firewalld.service - firewalld - dynamic firewall daemon                                                                                           |
|                                                                                                                                                     |
| Loaded: loaded (/usr/lib/systemd/system/firewalld.service; disabled; vendor preset: enabled)                                                        |
|                                                                                                                                                     |
| Active: inactive (dead)                                                                                                                             |
|                                                                                                                                                     |
| Docs: man:firewalld(1)                                                                                                                              |
+-----------------------------------------------------------------------------------------------------------------------------------------------------+

Instalar wget

Instalamos este componente porque lo vamos a utilizar para instalar
otros componentes.

+-----------------------------------------+
| [root@srvscm02 tmp]# yum install wget   |
+-----------------------------------------+

Instalar lsof

Instalamos este componente porque lo vamos a utilizar en los scripts

+-----------------------------------------+
| [root@srvscm02 tmp]# yum install lsof   |
+-----------------------------------------+

Instalar las actualizaciones de RedHat

Esto siempre se debe realizar en cualquier servidor que se este
inicializando.

+----------------+
| # yum update   |
+----------------+

Instalar los repositorios EPEL para RedHat

Los repositorios EPEL son necesarios para la instalación de paquetes que
no se encuentran en los repositorios oficiales de RedHat.

+-------------------------------------------------------------------------------------------------------------------------------------------+
| [root@srvscm02 tmp]# wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm                                          |
|                                                                                                                                           |
| --2018-01-05 14:38:03-- https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm                                            |
|                                                                                                                                           |
| Resolving dl.fedoraproject.org (dl.fedoraproject.org)... 209.132.181.24, 209.132.181.23, 209.132.181.25                                   |
|                                                                                                                                           |
| Connecting to dl.fedoraproject.org (dl.fedoraproject.org)\|209.132.181.24\|:443... connected.                                             |
|                                                                                                                                           |
| HTTP request sent, awaiting response... 200 OK                                                                                            |
|                                                                                                                                           |
| Length: 15080 (15K) [application/x-rpm]                                                                                                   |
|                                                                                                                                           |
| Saving to: ‘epel-release-latest-7.noarch.rpm’                                                                                             |
|                                                                                                                                           |
| 100%[=========================================================================================================>] 15,080 --.-K/s in 0.1s   |
|                                                                                                                                           |
| 2018-01-05 14:38:04 (103 KB/s) - ‘epel-release-latest-7.noarch.rpm’ saved [15080/15080]                                                   |
|                                                                                                                                           |
| [root@srvscm02 tmp]# ls                                                                                                                   |
|                                                                                                                                           |
| epel-release-latest-7.noarch.rpm                                                                                                          |
|                                                                                                                                           |
| [root@srvscm02 tmp]# rpm -ivh epel-release-latest-7.noarch.rpm                                                                            |
|                                                                                                                                           |
| warning: epel-release-latest-7.noarch.rpm: Header V3 RSA/SHA256 Signature, key ID 352c64e5: NOKEY                                         |
|                                                                                                                                           |
| Preparing... ################################# [100%]                                                                                     |
|                                                                                                                                           |
| Updating / installing...                                                                                                                  |
|                                                                                                                                           |
| 1:epel-release-7-11 ################################# [100%]                                                                              |
|                                                                                                                                           |
| [root@srvscm02 tmp]# rpm -qa \| grep epel                                                                                                 |
|                                                                                                                                           |
| epel-release-7-11.noarch                                                                                                                  |
|                                                                                                                                           |
| [root@srvscm02 tmp]# yum repolist                                                                                                         |
|                                                                                                                                           |
| Loaded plugins: ulninfo                                                                                                                   |
|                                                                                                                                           |
| repo id repo name status                                                                                                                  |
|                                                                                                                                           |
| \*epel/x86\_64 Extra Packages for Enterprise Linux 7 - x86\_64 12,198                                                                     |
|                                                                                                                                           |
| ol7\_UEKR4/x86\_64 Latest Unbreakable Enterprise Kernel Release 4 for Oracle Linux 7Server (x86\_64) 523                                  |
|                                                                                                                                           |
| ol7\_latest/x86\_64 Oracle Linux 7Server Latest (x86\_64) 23,647                                                                          |
|                                                                                                                                           |
| repolist: 36,368                                                                                                                          |
+-------------------------------------------------------------------------------------------------------------------------------------------+

Instalación de la librería libXtst

+----------------------------------------------------------------------------------------------------------------------------+
| [root@srvscm02 ~]# yum install -y libXtst.x86\_64                                                                          |
|                                                                                                                            |
| ol7\_UEKR4 \| 1.2 kB 00:00:00                                                                                              |
|                                                                                                                            |
| ol7\_latest \| 1.4 kB 00:00:00                                                                                             |
|                                                                                                                            |
| ol7\_UEKR4 544/544                                                                                                         |
|                                                                                                                            |
| ol7\_latest 23671/23671                                                                                                    |
|                                                                                                                            |
| Resolving Dependencies                                                                                                     |
|                                                                                                                            |
| --> Running transaction check                                                                                              |
|                                                                                                                            |
| ---> Package libXtst.x86\_64 0:1.2.3-1.el7 will be installed                                                               |
|                                                                                                                            |
| --> Processing Dependency: libXi.so.6()(64bit) for package: libXtst-1.2.3-1.el7.x86\_64                                    |
|                                                                                                                            |
| --> Running transaction check                                                                                              |
|                                                                                                                            |
| ---> Package libXi.x86\_64 0:1.7.9-1.el7 will be installed                                                                 |
|                                                                                                                            |
| --> Finished Dependency Resolution                                                                                         |
|                                                                                                                            |
| Dependencies Resolved                                                                                                      |
|                                                                                                                            |
| ========================================================================================================================   |
|                                                                                                                            |
| Package Arch Version Repository Size                                                                                       |
|                                                                                                                            |
| ========================================================================================================================   |
|                                                                                                                            |
| Installing:                                                                                                                |
|                                                                                                                            |
| libXtst x86\_64 1.2.3-1.el7 ol7\_latest 20 k                                                                               |
|                                                                                                                            |
| Installing for dependencies:                                                                                               |
|                                                                                                                            |
| libXi x86\_64 1.7.9-1.el7 ol7\_latest 40 k                                                                                 |
|                                                                                                                            |
| Transaction Summary                                                                                                        |
|                                                                                                                            |
| ========================================================================================================================   |
|                                                                                                                            |
| Install 1 Package (+1 Dependent package)                                                                                   |
|                                                                                                                            |
| Total download size: 59 k                                                                                                  |
|                                                                                                                            |
| Installed size: 98 k                                                                                                       |
|                                                                                                                            |
| Downloading packages:                                                                                                      |
|                                                                                                                            |
| (1/2): libXtst-1.2.3-1.el7.x86\_64.rpm \| 20 kB 00:00:00                                                                   |
|                                                                                                                            |
| (2/2): libXi-1.7.9-1.el7.x86\_64.rpm \| 40 kB 00:00:00                                                                     |
|                                                                                                                            |
| ------------------------------------------------------------------------------------------------------------------------   |
|                                                                                                                            |
| Total 158 kB/s \| 59 kB 00:00:00                                                                                           |
|                                                                                                                            |
| Running transaction check                                                                                                  |
|                                                                                                                            |
| Running transaction test                                                                                                   |
|                                                                                                                            |
| Transaction test succeeded                                                                                                 |
|                                                                                                                            |
| Running transaction                                                                                                        |
|                                                                                                                            |
| Warning: RPMDB altered outside of yum.                                                                                     |
|                                                                                                                            |
| Installing : libXi-1.7.9-1.el7.x86\_64 1/2                                                                                 |
|                                                                                                                            |
| Installing : libXtst-1.2.3-1.el7.x86\_64 2/2                                                                               |
|                                                                                                                            |
| Verifying : libXi-1.7.9-1.el7.x86\_64 1/2                                                                                  |
|                                                                                                                            |
| Verifying : libXtst-1.2.3-1.el7.x86\_64 2/2                                                                                |
|                                                                                                                            |
| Installed:                                                                                                                 |
|                                                                                                                            |
| libXtst.x86\_64 0:1.2.3-1.el7                                                                                              |
|                                                                                                                            |
| Dependency Installed:                                                                                                      |
|                                                                                                                            |
| libXi.x86\_64 0:1.7.9-1.el7                                                                                                |
|                                                                                                                            |
| Complete!                                                                                                                  |
+----------------------------------------------------------------------------------------------------------------------------+

Instalación de la librería gtk2-2.24.31-1

+----------------------------------------------------------------------------------------------------------------------------+
| [root@srvscm02 ~]# yum install -y gtk2-2.24.31-1.el7.x86\_64                                                               |
|                                                                                                                            |
| Loaded plugins: ulninfo                                                                                                    |
|                                                                                                                            |
| Resolving Dependencies                                                                                                     |
|                                                                                                                            |
| --> Running transaction check                                                                                              |
|                                                                                                                            |
| ---> Package gtk2.x86\_64 0:2.24.31-1.el7 will be installed                                                                |
|                                                                                                                            |
| --> Processing Dependency: libXrandr >= 1.2.99.4-2 for package: gtk2-2.24.31-1.el7.x86\_64                                 |
|                                                                                                                            |
| --> Processing Dependency: atk >= 1.29.4-2 for package: gtk2-2.24.31-1.el7.x86\_64                                         |
|                                                                                                                            |
| --> Processing Dependency: pango >= 1.20.0-1 for package: gtk2-2.24.31-1.el7.x86\_64                                       |
|                                                                                                                            |
| --> Processing Dependency: libtiff >= 3.6.1 for package: gtk2-2.24.31-1.el7.x86\_64                                        |
|                                                                                                                            |
| --> Processing Dependency: gtk-update-icon-cache for package: gtk2-2.24.31-1.el7.x86\_64                                   |
|                                                                                                                            |
| --> Processing Dependency: hicolor-icon-theme for package: gtk2-2.24.31-1.el7.x86\_64                                      |
|                                                                                                                            |
| --> Processing Dependency: libpangoft2-1.0.so.0()(64bit) for package: gtk2-2.24.31-1.el7.x86\_64                           |
|                                                                                                                            |
| --> Processing Dependency: libcairo.so.2()(64bit) for package: gtk2-2.24.31-1.el7.x86\_64                                  |
|                                                                                                                            |
| --> Processing Dependency: libatk-1.0.so.0()(64bit) for package: gtk2-2.24.31-1.el7.x86\_64                                |
|                                                                                                                            |
| --> Processing Dependency: libXrandr.so.2()(64bit) for package: gtk2-2.24.31-1.el7.x86\_64                                 |
|                                                                                                                            |
| --> Processing Dependency: libpangocairo-1.0.so.0()(64bit) for package: gtk2-2.24.31-1.el7.x86\_64                         |
|                                                                                                                            |
| --> Processing Dependency: libXcomposite.so.1()(64bit) for package: gtk2-2.24.31-1.el7.x86\_64                             |
|                                                                                                                            |
| --> Processing Dependency: libXinerama.so.1()(64bit) for package: gtk2-2.24.31-1.el7.x86\_64                               |
|                                                                                                                            |
| --> Processing Dependency: libXdamage.so.1()(64bit) for package: gtk2-2.24.31-1.el7.x86\_64                                |
|                                                                                                                            |
| --> Processing Dependency: libpango-1.0.so.0()(64bit) for package: gtk2-2.24.31-1.el7.x86\_64                              |
|                                                                                                                            |
| --> Processing Dependency: libcups.so.2()(64bit) for package: gtk2-2.24.31-1.el7.x86\_64                                   |
|                                                                                                                            |
| --> Processing Dependency: libgdk\_pixbuf-2.0.so.0()(64bit) for package: gtk2-2.24.31-1.el7.x86\_64                        |
|                                                                                                                            |
| --> Running transaction check                                                                                              |
|                                                                                                                            |
| ---> Package atk.x86\_64 0:2.22.0-3.el7 will be installed                                                                  |
|                                                                                                                            |
| ---> Package cairo.x86\_64 0:1.14.8-2.el7 will be installed                                                                |
|                                                                                                                            |
| --> Processing Dependency: libGL.so.1()(64bit) for package: cairo-1.14.8-2.el7.x86\_64                                     |
|                                                                                                                            |
| --> Processing Dependency: libpixman-1.so.0()(64bit) for package: cairo-1.14.8-2.el7.x86\_64                               |
|                                                                                                                            |
| --> Processing Dependency: libEGL.so.1()(64bit) for package: cairo-1.14.8-2.el7.x86\_64                                    |
|                                                                                                                            |
| ---> Package cups-libs.x86\_64 1:1.6.3-29.el7 will be installed                                                            |
|                                                                                                                            |
| ---> Package gdk-pixbuf2.x86\_64 0:2.36.5-1.el7 will be installed                                                          |
|                                                                                                                            |
| --> Processing Dependency: libjasper.so.1()(64bit) for package: gdk-pixbuf2-2.36.5-1.el7.x86\_64                           |
|                                                                                                                            |
| ---> Package gtk-update-icon-cache.x86\_64 0:3.22.10-4.el7 will be installed                                               |
|                                                                                                                            |
| ---> Package hicolor-icon-theme.noarch 0:0.12-7.el7 will be installed                                                      |
|                                                                                                                            |
| ---> Package libXcomposite.x86\_64 0:0.4.4-4.1.el7 will be installed                                                       |
|                                                                                                                            |
| ---> Package libXdamage.x86\_64 0:1.1.4-4.1.el7 will be installed                                                          |
|                                                                                                                            |
| ---> Package libXinerama.x86\_64 0:1.1.3-2.1.el7 will be installed                                                         |
|                                                                                                                            |
| ---> Package libXrandr.x86\_64 0:1.5.1-2.el7 will be installed                                                             |
|                                                                                                                            |
| ---> Package libtiff.x86\_64 0:4.0.3-27.el7\_3 will be installed                                                           |
|                                                                                                                            |
| --> Processing Dependency: libjbig.so.2.0()(64bit) for package: libtiff-4.0.3-27.el7\_3.x86\_64                            |
|                                                                                                                            |
| ---> Package pango.x86\_64 0:1.40.4-1.el7 will be installed                                                                |
|                                                                                                                            |
| --> Processing Dependency: harfbuzz(x86-64) >= 1.0.3 for package: pango-1.40.4-1.el7.x86\_64                               |
|                                                                                                                            |
| --> Processing Dependency: libthai(x86-64) >= 0.1.9 for package: pango-1.40.4-1.el7.x86\_64                                |
|                                                                                                                            |
| --> Processing Dependency: libthai.so.0(LIBTHAI\_0.1)(64bit) for package: pango-1.40.4-1.el7.x86\_64                       |
|                                                                                                                            |
| --> Processing Dependency: libthai.so.0()(64bit) for package: pango-1.40.4-1.el7.x86\_64                                   |
|                                                                                                                            |
| --> Processing Dependency: libharfbuzz.so.0()(64bit) for package: pango-1.40.4-1.el7.x86\_64                               |
|                                                                                                                            |
| --> Running transaction check                                                                                              |
|                                                                                                                            |
| ---> Package harfbuzz.x86\_64 0:1.3.2-1.el7 will be installed                                                              |
|                                                                                                                            |
| --> Processing Dependency: libgraphite2.so.3()(64bit) for package: harfbuzz-1.3.2-1.el7.x86\_64                            |
|                                                                                                                            |
| ---> Package jasper-libs.x86\_64 0:1.900.1-31.el7 will be installed                                                        |
|                                                                                                                            |
| ---> Package jbigkit-libs.x86\_64 0:2.0-11.el7 will be installed                                                           |
|                                                                                                                            |
| ---> Package libthai.x86\_64 0:0.1.14-9.el7 will be installed                                                              |
|                                                                                                                            |
| ---> Package mesa-libEGL.x86\_64 0:17.0.1-6.20170307.el7 will be installed                                                 |
|                                                                                                                            |
| --> Processing Dependency: mesa-libgbm = 17.0.1-6.20170307.el7 for package: mesa-libEGL-17.0.1-6.20170307.el7.x86\_64      |
|                                                                                                                            |
| --> Processing Dependency: libgbm.so.1()(64bit) for package: mesa-libEGL-17.0.1-6.20170307.el7.x86\_64                     |
|                                                                                                                            |
| --> Processing Dependency: libxshmfence.so.1()(64bit) for package: mesa-libEGL-17.0.1-6.20170307.el7.x86\_64               |
|                                                                                                                            |
| ---> Package mesa-libGL.x86\_64 0:17.0.1-6.20170307.el7 will be installed                                                  |
|                                                                                                                            |
| --> Processing Dependency: mesa-libglapi = 17.0.1-6.20170307.el7 for package: mesa-libGL-17.0.1-6.20170307.el7.x86\_64     |
|                                                                                                                            |
| --> Processing Dependency: libglapi.so.0()(64bit) for package: mesa-libGL-17.0.1-6.20170307.el7.x86\_64                    |
|                                                                                                                            |
| ---> Package pixman.x86\_64 0:0.34.0-1.el7 will be installed                                                               |
|                                                                                                                            |
| --> Running transaction check                                                                                              |
|                                                                                                                            |
| ---> Package graphite2.x86\_64 0:1.3.10-1.el7\_3 will be installed                                                         |
|                                                                                                                            |
| ---> Package libxshmfence.x86\_64 0:1.2-1.el7 will be installed                                                            |
|                                                                                                                            |
| ---> Package mesa-libgbm.x86\_64 0:17.0.1-6.20170307.el7 will be installed                                                 |
|                                                                                                                            |
| ---> Package mesa-libglapi.x86\_64 0:17.0.1-6.20170307.el7 will be installed                                               |
|                                                                                                                            |
| --> Finished Dependency Resolution                                                                                         |
|                                                                                                                            |
| Dependencies Resolved                                                                                                      |
|                                                                                                                            |
| ========================================================================================================================   |
|                                                                                                                            |
| Package Arch Version Repository Size                                                                                       |
|                                                                                                                            |
| ========================================================================================================================   |
|                                                                                                                            |
| Installing:                                                                                                                |
|                                                                                                                            |
| gtk2 x86\_64 2.24.31-1.el7 ol7\_latest 3.4 M                                                                               |
|                                                                                                                            |
| Installing for dependencies:                                                                                               |
|                                                                                                                            |
| atk x86\_64 2.22.0-3.el7 ol7\_latest 258 k                                                                                 |
|                                                                                                                            |
| cairo x86\_64 1.14.8-2.el7 ol7\_latest 713 k                                                                               |
|                                                                                                                            |
| cups-libs x86\_64 1:1.6.3-29.el7 ol7\_latest 356 k                                                                         |
|                                                                                                                            |
| gdk-pixbuf2 x86\_64 2.36.5-1.el7 ol7\_latest 566 k                                                                         |
|                                                                                                                            |
| graphite2 x86\_64 1.3.10-1.el7\_3 ol7\_latest 115 k                                                                        |
|                                                                                                                            |
| gtk-update-icon-cache x86\_64 3.22.10-4.el7 ol7\_latest 27 k                                                               |
|                                                                                                                            |
| harfbuzz x86\_64 1.3.2-1.el7 ol7\_latest 176 k                                                                             |
|                                                                                                                            |
| hicolor-icon-theme noarch 0.12-7.el7 ol7\_latest 42 k                                                                      |
|                                                                                                                            |
| jasper-libs x86\_64 1.900.1-31.el7 ol7\_latest 150 k                                                                       |
|                                                                                                                            |
| jbigkit-libs x86\_64 2.0-11.el7 ol7\_latest 46 k                                                                           |
|                                                                                                                            |
| libXcomposite x86\_64 0.4.4-4.1.el7 ol7\_latest 22 k                                                                       |
|                                                                                                                            |
| libXdamage x86\_64 1.1.4-4.1.el7 ol7\_latest 20 k                                                                          |
|                                                                                                                            |
| libXinerama x86\_64 1.1.3-2.1.el7 ol7\_latest 13 k                                                                         |
|                                                                                                                            |
| libXrandr x86\_64 1.5.1-2.el7 ol7\_latest 27 k                                                                             |
|                                                                                                                            |
| libthai x86\_64 0.1.14-9.el7 ol7\_latest 185 k                                                                             |
|                                                                                                                            |
| libtiff x86\_64 4.0.3-27.el7\_3 ol7\_latest 169 k                                                                          |
|                                                                                                                            |
| libxshmfence x86\_64 1.2-1.el7 ol7\_latest 6.5 k                                                                           |
|                                                                                                                            |
| mesa-libEGL x86\_64 17.0.1-6.20170307.el7 ol7\_latest 82 k                                                                 |
|                                                                                                                            |
| mesa-libGL x86\_64 17.0.1-6.20170307.el7 ol7\_latest 155 k                                                                 |
|                                                                                                                            |
| mesa-libgbm x86\_64 17.0.1-6.20170307.el7 ol7\_latest 32 k                                                                 |
|                                                                                                                            |
| mesa-libglapi x86\_64 17.0.1-6.20170307.el7 ol7\_latest 41 k                                                               |
|                                                                                                                            |
| pango x86\_64 1.40.4-1.el7 ol7\_latest 274 k                                                                               |
|                                                                                                                            |
| pixman x86\_64 0.34.0-1.el7 ol7\_latest 247 k                                                                              |
|                                                                                                                            |
| Transaction Summary                                                                                                        |
|                                                                                                                            |
| ========================================================================================================================   |
|                                                                                                                            |
| Install 1 Package (+23 Dependent packages)                                                                                 |
|                                                                                                                            |
| Total download size: 7.0 M                                                                                                 |
|                                                                                                                            |
| Installed size: 24 M                                                                                                       |
|                                                                                                                            |
| Downloading packages:                                                                                                      |
|                                                                                                                            |
| (1/24): atk-2.22.0-3.el7.x86\_64.rpm \| 258 kB 00:00:01                                                                    |
|                                                                                                                            |
| (2/24): cairo-1.14.8-2.el7.x86\_64.rpm \| 713 kB 00:00:01                                                                  |
|                                                                                                                            |
| (3/24): cups-libs-1.6.3-29.el7.x86\_64.rpm \| 356 kB 00:00:01                                                              |
|                                                                                                                            |
| (4/24): graphite2-1.3.10-1.el7\_3.x86\_64.rpm \| 115 kB 00:00:00                                                           |
|                                                                                                                            |
| (5/24): gtk-update-icon-cache-3.22.10-4.el7.x86\_64.rpm \| 27 kB 00:00:00                                                  |
|                                                                                                                            |
| (6/24): gdk-pixbuf2-2.36.5-1.el7.x86\_64.rpm \| 566 kB 00:00:01                                                            |
|                                                                                                                            |
| (7/24): harfbuzz-1.3.2-1.el7.x86\_64.rpm \| 176 kB 00:00:00                                                                |
|                                                                                                                            |
| (8/24): hicolor-icon-theme-0.12-7.el7.noarch.rpm \| 42 kB 00:00:00                                                         |
|                                                                                                                            |
| (9/24): jasper-libs-1.900.1-31.el7.x86\_64.rpm \| 150 kB 00:00:00                                                          |
|                                                                                                                            |
| (10/24): jbigkit-libs-2.0-11.el7.x86\_64.rpm \| 46 kB 00:00:00                                                             |
|                                                                                                                            |
| (11/24): libXcomposite-0.4.4-4.1.el7.x86\_64.rpm \| 22 kB 00:00:00                                                         |
|                                                                                                                            |
| (12/24): libXdamage-1.1.4-4.1.el7.x86\_64.rpm \| 20 kB 00:00:01                                                            |
|                                                                                                                            |
| (13/24): libXinerama-1.1.3-2.1.el7.x86\_64.rpm \| 13 kB 00:00:00                                                           |
|                                                                                                                            |
| (14/24): libXrandr-1.5.1-2.el7.x86\_64.rpm \| 27 kB 00:00:00                                                               |
|                                                                                                                            |
| (15/24): gtk2-2.24.31-1.el7.x86\_64.rpm \| 3.4 MB 00:00:05                                                                 |
|                                                                                                                            |
| (16/24): libthai-0.1.14-9.el7.x86\_64.rpm \| 185 kB 00:00:00                                                               |
|                                                                                                                            |
| (17/24): libxshmfence-1.2-1.el7.x86\_64.rpm \| 6.5 kB 00:00:00                                                             |
|                                                                                                                            |
| (18/24): mesa-libEGL-17.0.1-6.20170307.el7.x86\_64.rpm \| 82 kB 00:00:00                                                   |
|                                                                                                                            |
| (19/24): libtiff-4.0.3-27.el7\_3.x86\_64.rpm \| 169 kB 00:00:00                                                            |
|                                                                                                                            |
| (20/24): mesa-libgbm-17.0.1-6.20170307.el7.x86\_64.rpm \| 32 kB 00:00:00                                                   |
|                                                                                                                            |
| (21/24): mesa-libGL-17.0.1-6.20170307.el7.x86\_64.rpm \| 155 kB 00:00:00                                                   |
|                                                                                                                            |
| (22/24): mesa-libglapi-17.0.1-6.20170307.el7.x86\_64.rpm \| 41 kB 00:00:00                                                 |
|                                                                                                                            |
| (23/24): pixman-0.34.0-1.el7.x86\_64.rpm \| 247 kB 00:00:00                                                                |
|                                                                                                                            |
| (24/24): pango-1.40.4-1.el7.x86\_64.rpm \| 274 kB 00:00:00                                                                 |
|                                                                                                                            |
| ------------------------------------------------------------------------------------------------------------------------   |
|                                                                                                                            |
| Total 725 kB/s \| 7.0 MB 00:00:09                                                                                          |
|                                                                                                                            |
| Running transaction check                                                                                                  |
|                                                                                                                            |
| Running transaction test                                                                                                   |
|                                                                                                                            |
| Transaction test succeeded                                                                                                 |
|                                                                                                                            |
| Running transaction                                                                                                        |
|                                                                                                                            |
| Installing : libXdamage-1.1.4-4.1.el7.x86\_64 1/24                                                                         |
|                                                                                                                            |
| Installing : libxshmfence-1.2-1.el7.x86\_64 2/24                                                                           |
|                                                                                                                            |
| Installing : mesa-libglapi-17.0.1-6.20170307.el7.x86\_64 3/24                                                              |
|                                                                                                                            |
| Installing : mesa-libGL-17.0.1-6.20170307.el7.x86\_64 4/24                                                                 |
|                                                                                                                            |
| Installing : mesa-libgbm-17.0.1-6.20170307.el7.x86\_64 5/24                                                                |
|                                                                                                                            |
| Installing : mesa-libEGL-17.0.1-6.20170307.el7.x86\_64 6/24                                                                |
|                                                                                                                            |
| Installing : graphite2-1.3.10-1.el7\_3.x86\_64 7/24                                                                        |
|                                                                                                                            |
| Installing : harfbuzz-1.3.2-1.el7.x86\_64 8/24                                                                             |
|                                                                                                                            |
| Installing : jbigkit-libs-2.0-11.el7.x86\_64 9/24                                                                          |
|                                                                                                                            |
| Installing : libtiff-4.0.3-27.el7\_3.x86\_64 10/24                                                                         |
|                                                                                                                            |
| Installing : pixman-0.34.0-1.el7.x86\_64 11/24                                                                             |
|                                                                                                                            |
| Installing : cairo-1.14.8-2.el7.x86\_64 12/24                                                                              |
|                                                                                                                            |
| Installing : libXrandr-1.5.1-2.el7.x86\_64 13/24                                                                           |
|                                                                                                                            |
| Installing : libthai-0.1.14-9.el7.x86\_64 14/24                                                                            |
|                                                                                                                            |
| Installing : pango-1.40.4-1.el7.x86\_64 15/24                                                                              |
|                                                                                                                            |
| Installing : libXcomposite-0.4.4-4.1.el7.x86\_64 16/24                                                                     |
|                                                                                                                            |
| Installing : jasper-libs-1.900.1-31.el7.x86\_64 17/24                                                                      |
|                                                                                                                            |
| Installing : gdk-pixbuf2-2.36.5-1.el7.x86\_64 18/24                                                                        |
|                                                                                                                            |
| Installing : gtk-update-icon-cache-3.22.10-4.el7.x86\_64 19/24                                                             |
|                                                                                                                            |
| Installing : hicolor-icon-theme-0.12-7.el7.noarch 20/24                                                                    |
|                                                                                                                            |
| Installing : 1:cups-libs-1.6.3-29.el7.x86\_64 21/24                                                                        |
|                                                                                                                            |
| Installing : libXinerama-1.1.3-2.1.el7.x86\_64 22/24                                                                       |
|                                                                                                                            |
| Installing : atk-2.22.0-3.el7.x86\_64 23/24                                                                                |
|                                                                                                                            |
| Installing : gtk2-2.24.31-1.el7.x86\_64 24/24                                                                              |
|                                                                                                                            |
| Verifying : atk-2.22.0-3.el7.x86\_64 1/24                                                                                  |
|                                                                                                                            |
| Verifying : libtiff-4.0.3-27.el7\_3.x86\_64 2/24                                                                           |
|                                                                                                                            |
| Verifying : libXinerama-1.1.3-2.1.el7.x86\_64 3/24                                                                         |
|                                                                                                                            |
| Verifying : 1:cups-libs-1.6.3-29.el7.x86\_64 4/24                                                                          |
|                                                                                                                            |
| Verifying : harfbuzz-1.3.2-1.el7.x86\_64 5/24                                                                              |
|                                                                                                                            |
| Verifying : gtk2-2.24.31-1.el7.x86\_64 6/24                                                                                |
|                                                                                                                            |
| Verifying : hicolor-icon-theme-0.12-7.el7.noarch 7/24                                                                      |
|                                                                                                                            |
| Verifying : cairo-1.14.8-2.el7.x86\_64 8/24                                                                                |
|                                                                                                                            |
| Verifying : jasper-libs-1.900.1-31.el7.x86\_64 9/24                                                                        |
|                                                                                                                            |
| Verifying : libXcomposite-0.4.4-4.1.el7.x86\_64 10/24                                                                      |
|                                                                                                                            |
| Verifying : libthai-0.1.14-9.el7.x86\_64 11/24                                                                             |
|                                                                                                                            |
| Verifying : mesa-libEGL-17.0.1-6.20170307.el7.x86\_64 12/24                                                                |
|                                                                                                                            |
| Verifying : gtk-update-icon-cache-3.22.10-4.el7.x86\_64 13/24                                                              |
|                                                                                                                            |
| Verifying : mesa-libGL-17.0.1-6.20170307.el7.x86\_64 14/24                                                                 |
|                                                                                                                            |
| Verifying : pango-1.40.4-1.el7.x86\_64 15/24                                                                               |
|                                                                                                                            |
| Verifying : libXrandr-1.5.1-2.el7.x86\_64 16/24                                                                            |
|                                                                                                                            |
| Verifying : mesa-libglapi-17.0.1-6.20170307.el7.x86\_64 17/24                                                              |
|                                                                                                                            |
| Verifying : pixman-0.34.0-1.el7.x86\_64 18/24                                                                              |
|                                                                                                                            |
| Verifying : mesa-libgbm-17.0.1-6.20170307.el7.x86\_64 19/24                                                                |
|                                                                                                                            |
| Verifying : jbigkit-libs-2.0-11.el7.x86\_64 20/24                                                                          |
|                                                                                                                            |
| Verifying : gdk-pixbuf2-2.36.5-1.el7.x86\_64 21/24                                                                         |
|                                                                                                                            |
| Verifying : libxshmfence-1.2-1.el7.x86\_64 22/24                                                                           |
|                                                                                                                            |
| Verifying : graphite2-1.3.10-1.el7\_3.x86\_64 23/24                                                                        |
|                                                                                                                            |
| Verifying : libXdamage-1.1.4-4.1.el7.x86\_64 24/24                                                                         |
|                                                                                                                            |
| Installed:                                                                                                                 |
|                                                                                                                            |
| gtk2.x86\_64 0:2.24.31-1.el7                                                                                               |
|                                                                                                                            |
| Dependency Installed:                                                                                                      |
|                                                                                                                            |
| atk.x86\_64 0:2.22.0-3.el7 cairo.x86\_64 0:1.14.8-2.el7                                                                    |
|                                                                                                                            |
| cups-libs.x86\_64 1:1.6.3-29.el7 gdk-pixbuf2.x86\_64 0:2.36.5-1.el7                                                        |
|                                                                                                                            |
| graphite2.x86\_64 0:1.3.10-1.el7\_3 gtk-update-icon-cache.x86\_64 0:3.22.10-4.el7                                          |
|                                                                                                                            |
| harfbuzz.x86\_64 0:1.3.2-1.el7 hicolor-icon-theme.noarch 0:0.12-7.el7                                                      |
|                                                                                                                            |
| jasper-libs.x86\_64 0:1.900.1-31.el7 jbigkit-libs.x86\_64 0:2.0-11.el7                                                     |
|                                                                                                                            |
| libXcomposite.x86\_64 0:0.4.4-4.1.el7 libXdamage.x86\_64 0:1.1.4-4.1.el7                                                   |
|                                                                                                                            |
| libXinerama.x86\_64 0:1.1.3-2.1.el7 libXrandr.x86\_64 0:1.5.1-2.el7                                                        |
|                                                                                                                            |
| libthai.x86\_64 0:0.1.14-9.el7 libtiff.x86\_64 0:4.0.3-27.el7\_3                                                           |
|                                                                                                                            |
| libxshmfence.x86\_64 0:1.2-1.el7 mesa-libEGL.x86\_64 0:17.0.1-6.20170307.el7                                               |
|                                                                                                                            |
| mesa-libGL.x86\_64 0:17.0.1-6.20170307.el7 mesa-libgbm.x86\_64 0:17.0.1-6.20170307.el7                                     |
|                                                                                                                            |
| mesa-libglapi.x86\_64 0:17.0.1-6.20170307.el7 pango.x86\_64 0:1.40.4-1.el7                                                 |
|                                                                                                                            |
| pixman.x86\_64 0:0.34.0-1.el7                                                                                              |
|                                                                                                                            |
| Complete!                                                                                                                  |
+----------------------------------------------------------------------------------------------------------------------------+

Instalación de la librería libcanberra-gtk2

+----------------------------------------------------------------------------------------------------------------------------+
| [root@srvscm02 ~]# yum install libcanberra-gtk2.x86\_64                                                                    |
|                                                                                                                            |
| Loaded plugins: ulninfo                                                                                                    |
|                                                                                                                            |
| Resolving Dependencies                                                                                                     |
|                                                                                                                            |
| --> Running transaction check                                                                                              |
|                                                                                                                            |
| ---> Package libcanberra-gtk2.x86\_64 0:0.30-5.el7 will be installed                                                       |
|                                                                                                                            |
| --> Processing Dependency: libcanberra(x86-64) = 0.30-5.el7 for package: libcanberra-gtk2-0.30-5.el7.x86\_64               |
|                                                                                                                            |
| --> Processing Dependency: libcanberra-gtk3(x86-64) = 0.30-5.el7 for package: libcanberra-gtk2-0.30-5.el7.x86\_64          |
|                                                                                                                            |
| --> Processing Dependency: libcanberra.so.0()(64bit) for package: libcanberra-gtk2-0.30-5.el7.x86\_64                      |
|                                                                                                                            |
| --> Processing Dependency: libogg.so.0()(64bit) for package: libcanberra-gtk2-0.30-5.el7.x86\_64                           |
|                                                                                                                            |
| --> Processing Dependency: libvorbisfile.so.3()(64bit) for package: libcanberra-gtk2-0.30-5.el7.x86\_64                    |
|                                                                                                                            |
| --> Processing Dependency: libltdl.so.7()(64bit) for package: libcanberra-gtk2-0.30-5.el7.x86\_64                          |
|                                                                                                                            |
| --> Processing Dependency: libtdb.so.1()(64bit) for package: libcanberra-gtk2-0.30-5.el7.x86\_64                           |
|                                                                                                                            |
| --> Processing Dependency: libvorbis.so.0()(64bit) for package: libcanberra-gtk2-0.30-5.el7.x86\_64                        |
|                                                                                                                            |
| --> Running transaction check                                                                                              |
|                                                                                                                            |
| ---> Package libcanberra.x86\_64 0:0.30-5.el7 will be installed                                                            |
|                                                                                                                            |
| --> Processing Dependency: pulseaudio-libs >= 0.9.15 for package: libcanberra-0.30-5.el7.x86\_64                           |
|                                                                                                                            |
| --> Processing Dependency: libpulse.so.0(PULSE\_0)(64bit) for package: libcanberra-0.30-5.el7.x86\_64                      |
|                                                                                                                            |
| --> Processing Dependency: sound-theme-freedesktop for package: libcanberra-0.30-5.el7.x86\_64                             |
|                                                                                                                            |
| --> Processing Dependency: libpulse.so.0()(64bit) for package: libcanberra-0.30-5.el7.x86\_64                              |
|                                                                                                                            |
| --> Processing Dependency: libgstreamer-1.0.so.0()(64bit) for package: libcanberra-0.30-5.el7.x86\_64                      |
|                                                                                                                            |
| ---> Package libcanberra-gtk3.x86\_64 0:0.30-5.el7 will be installed                                                       |
|                                                                                                                            |
| --> Processing Dependency: libgdk-3.so.0()(64bit) for package: libcanberra-gtk3-0.30-5.el7.x86\_64                         |
|                                                                                                                            |
| --> Processing Dependency: libgtk-3.so.0()(64bit) for package: libcanberra-gtk3-0.30-5.el7.x86\_64                         |
|                                                                                                                            |
| --> Processing Dependency: libcairo-gobject.so.2()(64bit) for package: libcanberra-gtk3-0.30-5.el7.x86\_64                 |
|                                                                                                                            |
| ---> Package libogg.x86\_64 2:1.3.0-7.el7 will be installed                                                                |
|                                                                                                                            |
| ---> Package libtdb.x86\_64 0:1.3.12-2.el7 will be installed                                                               |
|                                                                                                                            |
| ---> Package libtool-ltdl.x86\_64 0:2.4.2-22.el7\_3 will be installed                                                      |
|                                                                                                                            |
| ---> Package libvorbis.x86\_64 1:1.3.3-8.el7 will be installed                                                             |
|                                                                                                                            |
| --> Running transaction check                                                                                              |
|                                                                                                                            |
| ---> Package cairo-gobject.x86\_64 0:1.14.8-2.el7 will be installed                                                        |
|                                                                                                                            |
| ---> Package gstreamer1.x86\_64 0:1.10.4-2.el7 will be installed                                                           |
|                                                                                                                            |
| ---> Package gtk3.x86\_64 0:3.22.10-4.el7 will be installed                                                                |
|                                                                                                                            |
| --> Processing Dependency: libepoxy(x86-64) >= 1.0 for package: gtk3-3.22.10-4.el7.x86\_64                                 |
|                                                                                                                            |
| --> Processing Dependency: dconf(x86-64) for package: gtk3-3.22.10-4.el7.x86\_64                                           |
|                                                                                                                            |
| --> Processing Dependency: adwaita-icon-theme for package: gtk3-3.22.10-4.el7.x86\_64                                      |
|                                                                                                                            |
| --> Processing Dependency: librest-0.7.so.0()(64bit) for package: gtk3-3.22.10-4.el7.x86\_64                               |
|                                                                                                                            |
| --> Processing Dependency: libatk-bridge-2.0.so.0()(64bit) for package: gtk3-3.22.10-4.el7.x86\_64                         |
|                                                                                                                            |
| --> Processing Dependency: libjson-glib-1.0.so.0()(64bit) for package: gtk3-3.22.10-4.el7.x86\_64                          |
|                                                                                                                            |
| --> Processing Dependency: libepoxy.so.0()(64bit) for package: gtk3-3.22.10-4.el7.x86\_64                                  |
|                                                                                                                            |
| --> Processing Dependency: libcolord.so.2()(64bit) for package: gtk3-3.22.10-4.el7.x86\_64                                 |
|                                                                                                                            |
| ---> Package pulseaudio-libs.x86\_64 0:10.0-3.el7 will be installed                                                        |
|                                                                                                                            |
| --> Processing Dependency: libsndfile.so.1(libsndfile.so.1.0)(64bit) for package: pulseaudio-libs-10.0-3.el7.x86\_64       |
|                                                                                                                            |
| --> Processing Dependency: libasyncns.so.0()(64bit) for package: pulseaudio-libs-10.0-3.el7.x86\_64                        |
|                                                                                                                            |
| --> Processing Dependency: libsndfile.so.1()(64bit) for package: pulseaudio-libs-10.0-3.el7.x86\_64                        |
|                                                                                                                            |
| ---> Package sound-theme-freedesktop.noarch 0:0.8-3.el7 will be installed                                                  |
|                                                                                                                            |
| --> Running transaction check                                                                                              |
|                                                                                                                            |
| ---> Package adwaita-icon-theme.noarch 0:3.22.0-1.el7 will be installed                                                    |
|                                                                                                                            |
| --> Processing Dependency: adwaita-cursor-theme = 3.22.0-1.el7 for package: adwaita-icon-theme-3.22.0-1.el7.noarch         |
|                                                                                                                            |
| ---> Package at-spi2-atk.x86\_64 0:2.22.0-2.el7 will be installed                                                          |
|                                                                                                                            |
| --> Processing Dependency: at-spi2-core(x86-64) >= 2.17.90 for package: at-spi2-atk-2.22.0-2.el7.x86\_64                   |
|                                                                                                                            |
| --> Processing Dependency: libatspi.so.0()(64bit) for package: at-spi2-atk-2.22.0-2.el7.x86\_64                            |
|                                                                                                                            |
| ---> Package colord-libs.x86\_64 0:1.3.4-1.el7 will be installed                                                           |
|                                                                                                                            |
| --> Processing Dependency: libgusb.so.2(LIBGUSB\_0.1.1)(64bit) for package: colord-libs-1.3.4-1.el7.x86\_64                |
|                                                                                                                            |
| --> Processing Dependency: libgusb.so.2(LIBGUSB\_0.1.0)(64bit) for package: colord-libs-1.3.4-1.el7.x86\_64                |
|                                                                                                                            |
| --> Processing Dependency: libusb-1.0.so.0()(64bit) for package: colord-libs-1.3.4-1.el7.x86\_64                           |
|                                                                                                                            |
| --> Processing Dependency: liblcms2.so.2()(64bit) for package: colord-libs-1.3.4-1.el7.x86\_64                             |
|                                                                                                                            |
| --> Processing Dependency: libgusb.so.2()(64bit) for package: colord-libs-1.3.4-1.el7.x86\_64                              |
|                                                                                                                            |
| ---> Package dconf.x86\_64 0:0.26.0-2.el7 will be installed                                                                |
|                                                                                                                            |
| ---> Package json-glib.x86\_64 0:1.2.6-1.el7 will be installed                                                             |
|                                                                                                                            |
| ---> Package libasyncns.x86\_64 0:0.8-7.el7 will be installed                                                              |
|                                                                                                                            |
| ---> Package libepoxy.x86\_64 0:1.3.1-1.el7 will be installed                                                              |
|                                                                                                                            |
| ---> Package libsndfile.x86\_64 0:1.0.25-10.el7 will be installed                                                          |
|                                                                                                                            |
| --> Processing Dependency: libgsm.so.1()(64bit) for package: libsndfile-1.0.25-10.el7.x86\_64                              |
|                                                                                                                            |
| --> Processing Dependency: libFLAC.so.8()(64bit) for package: libsndfile-1.0.25-10.el7.x86\_64                             |
|                                                                                                                            |
| ---> Package rest.x86\_64 0:0.8.0-1.el7 will be installed                                                                  |
|                                                                                                                            |
| --> Running transaction check                                                                                              |
|                                                                                                                            |
| ---> Package adwaita-cursor-theme.noarch 0:3.22.0-1.el7 will be installed                                                  |
|                                                                                                                            |
| ---> Package at-spi2-core.x86\_64 0:2.22.0-1.el7 will be installed                                                         |
|                                                                                                                            |
| ---> Package flac-libs.x86\_64 0:1.3.0-5.el7\_1 will be installed                                                          |
|                                                                                                                            |
| ---> Package gsm.x86\_64 0:1.0.13-11.el7 will be installed                                                                 |
|                                                                                                                            |
| ---> Package lcms2.x86\_64 0:2.6-3.el7 will be installed                                                                   |
|                                                                                                                            |
| ---> Package libgusb.x86\_64 0:0.2.9-1.el7 will be installed                                                               |
|                                                                                                                            |
| ---> Package libusbx.x86\_64 0:1.0.20-1.el7 will be installed                                                              |
|                                                                                                                            |
| --> Finished Dependency Resolution                                                                                         |
|                                                                                                                            |
| Dependencies Resolved                                                                                                      |
|                                                                                                                            |
| ========================================================================================================================   |
|                                                                                                                            |
| Package Arch Version Repository Size                                                                                       |
|                                                                                                                            |
| ========================================================================================================================   |
|                                                                                                                            |
| Installing:                                                                                                                |
|                                                                                                                            |
| libcanberra-gtk2 x86\_64 0.30-5.el7 ol7\_latest 24 k                                                                       |
|                                                                                                                            |
| Installing for dependencies:                                                                                               |
|                                                                                                                            |
| adwaita-cursor-theme noarch 3.22.0-1.el7 ol7\_latest 641 k                                                                 |
|                                                                                                                            |
| adwaita-icon-theme noarch 3.22.0-1.el7 ol7\_latest 11 M                                                                    |
|                                                                                                                            |
| at-spi2-atk x86\_64 2.22.0-2.el7 ol7\_latest 80 k                                                                          |
|                                                                                                                            |
| at-spi2-core x86\_64 2.22.0-1.el7 ol7\_latest 157 k                                                                        |
|                                                                                                                            |
| cairo-gobject x86\_64 1.14.8-2.el7 ol7\_latest 24 k                                                                        |
|                                                                                                                            |
| colord-libs x86\_64 1.3.4-1.el7 ol7\_latest 185 k                                                                          |
|                                                                                                                            |
| dconf x86\_64 0.26.0-2.el7 ol7\_latest 106 k                                                                               |
|                                                                                                                            |
| flac-libs x86\_64 1.3.0-5.el7\_1 ol7\_latest 169 k                                                                         |
|                                                                                                                            |
| gsm x86\_64 1.0.13-11.el7 ol7\_latest 28 k                                                                                 |
|                                                                                                                            |
| gstreamer1 x86\_64 1.10.4-2.el7 ol7\_latest 1.1 M                                                                          |
|                                                                                                                            |
| gtk3 x86\_64 3.22.10-4.el7 ol7\_latest 4.2 M                                                                               |
|                                                                                                                            |
| json-glib x86\_64 1.2.6-1.el7 ol7\_latest 133 k                                                                            |
|                                                                                                                            |
| lcms2 x86\_64 2.6-3.el7 ol7\_latest 150 k                                                                                  |
|                                                                                                                            |
| libasyncns x86\_64 0.8-7.el7 ol7\_latest 25 k                                                                              |
|                                                                                                                            |
| libcanberra x86\_64 0.30-5.el7 ol7\_latest 81 k                                                                            |
|                                                                                                                            |
| libcanberra-gtk3 x86\_64 0.30-5.el7 ol7\_latest 30 k                                                                       |
|                                                                                                                            |
| libepoxy x86\_64 1.3.1-1.el7 ol7\_latest 196 k                                                                             |
|                                                                                                                            |
| libgusb x86\_64 0.2.9-1.el7 ol7\_latest 40 k                                                                               |
|                                                                                                                            |
| libogg x86\_64 2:1.3.0-7.el7 ol7\_latest 23 k                                                                              |
|                                                                                                                            |
| libsndfile x86\_64 1.0.25-10.el7 ol7\_latest 149 k                                                                         |
|                                                                                                                            |
| libtdb x86\_64 1.3.12-2.el7 ol7\_latest 46 k                                                                               |
|                                                                                                                            |
| libtool-ltdl x86\_64 2.4.2-22.el7\_3 ol7\_latest 48 k                                                                      |
|                                                                                                                            |
| libusbx x86\_64 1.0.20-1.el7 ol7\_latest 60 k                                                                              |
|                                                                                                                            |
| libvorbis x86\_64 1:1.3.3-8.el7 ol7\_latest 203 k                                                                          |
|                                                                                                                            |
| pulseaudio-libs x86\_64 10.0-3.el7 ol7\_latest 650 k                                                                       |
|                                                                                                                            |
| rest x86\_64 0.8.0-1.el7 ol7\_latest 63 k                                                                                  |
|                                                                                                                            |
| sound-theme-freedesktop noarch 0.8-3.el7 ol7\_latest 376 k                                                                 |
|                                                                                                                            |
| Transaction Summary                                                                                                        |
|                                                                                                                            |
| ========================================================================================================================   |
|                                                                                                                            |
| Install 1 Package (+27 Dependent packages)                                                                                 |
|                                                                                                                            |
| Total download size: 20 M                                                                                                  |
|                                                                                                                            |
| Installed size: 57 M                                                                                                       |
|                                                                                                                            |
| Is this ok [y/d/N]: y                                                                                                      |
|                                                                                                                            |
| Downloading packages:                                                                                                      |
|                                                                                                                            |
| (1/28): adwaita-cursor-theme-3.22.0-1.el7.noarch.rpm \| 641 kB 00:00:01                                                    |
|                                                                                                                            |
| (2/28): at-spi2-atk-2.22.0-2.el7.x86\_64.rpm \| 80 kB 00:00:00                                                             |
|                                                                                                                            |
| (3/28): at-spi2-core-2.22.0-1.el7.x86\_64.rpm \| 157 kB 00:00:00                                                           |
|                                                                                                                            |
| (4/28): cairo-gobject-1.14.8-2.el7.x86\_64.rpm \| 24 kB 00:00:00                                                           |
|                                                                                                                            |
| (5/28): colord-libs-1.3.4-1.el7.x86\_64.rpm \| 185 kB 00:00:00                                                             |
|                                                                                                                            |
| (6/28): dconf-0.26.0-2.el7.x86\_64.rpm \| 106 kB 00:00:00                                                                  |
|                                                                                                                            |
| (7/28): flac-libs-1.3.0-5.el7\_1.x86\_64.rpm \| 169 kB 00:00:00                                                            |
|                                                                                                                            |
| (8/28): gsm-1.0.13-11.el7.x86\_64.rpm \| 28 kB 00:00:00                                                                    |
|                                                                                                                            |
| (9/28): gstreamer1-1.10.4-2.el7.x86\_64.rpm \| 1.1 MB 00:00:01                                                             |
|                                                                                                                            |
| (10/28): gtk3-3.22.10-4.el7.x86\_64.rpm \| 4.2 MB 00:00:07                                                                 |
|                                                                                                                            |
| (11/28): json-glib-1.2.6-1.el7.x86\_64.rpm \| 133 kB 00:00:00                                                              |
|                                                                                                                            |
| (12/28): lcms2-2.6-3.el7.x86\_64.rpm \| 150 kB 00:00:00                                                                    |
|                                                                                                                            |
| (13/28): libasyncns-0.8-7.el7.x86\_64.rpm \| 25 kB 00:00:00                                                                |
|                                                                                                                            |
| (14/28): libcanberra-0.30-5.el7.x86\_64.rpm \| 81 kB 00:00:00                                                              |
|                                                                                                                            |
| (15/28): libcanberra-gtk2-0.30-5.el7.x86\_64.rpm \| 24 kB 00:00:00                                                         |
|                                                                                                                            |
| (16/28): libcanberra-gtk3-0.30-5.el7.x86\_64.rpm \| 30 kB 00:00:00                                                         |
|                                                                                                                            |
| (17/28): libepoxy-1.3.1-1.el7.x86\_64.rpm \| 196 kB 00:00:01                                                               |
|                                                                                                                            |
| (18/28): libgusb-0.2.9-1.el7.x86\_64.rpm \| 40 kB 00:00:00                                                                 |
|                                                                                                                            |
| (19/28): libogg-1.3.0-7.el7.x86\_64.rpm \| 23 kB 00:00:00                                                                  |
|                                                                                                                            |
| (20/28): libsndfile-1.0.25-10.el7.x86\_64.rpm \| 149 kB 00:00:01                                                           |
|                                                                                                                            |
| (21/28): libtdb-1.3.12-2.el7.x86\_64.rpm \| 46 kB 00:00:00                                                                 |
|                                                                                                                            |
| (22/28): libtool-ltdl-2.4.2-22.el7\_3.x86\_64.rpm \| 48 kB 00:00:00                                                        |
|                                                                                                                            |
| (23/28): libusbx-1.0.20-1.el7.x86\_64.rpm \| 60 kB 00:00:00                                                                |
|                                                                                                                            |
| (24/28): libvorbis-1.3.3-8.el7.x86\_64.rpm \| 203 kB 00:00:02                                                              |
|                                                                                                                            |
| (25/28): adwaita-icon-theme-3.22.0-1.el7.noarch.rpm \| 11 MB 00:00:25                                                      |
|                                                                                                                            |
| (26/28): rest-0.8.0-1.el7.x86\_64.rpm \| 63 kB 00:00:00                                                                    |
|                                                                                                                            |
| (27/28): pulseaudio-libs-10.0-3.el7.x86\_64.rpm \| 650 kB 00:00:03                                                         |
|                                                                                                                            |
| (28/28): sound-theme-freedesktop-0.8-3.el7.noarch.rpm \| 376 kB 00:00:00                                                   |
|                                                                                                                            |
| ------------------------------------------------------------------------------------------------------------------------   |
|                                                                                                                            |
| Total 755 kB/s \| 20 MB 00:00:27                                                                                           |
|                                                                                                                            |
| Running transaction check                                                                                                  |
|                                                                                                                            |
| Running transaction test                                                                                                   |
|                                                                                                                            |
| Transaction test succeeded                                                                                                 |
|                                                                                                                            |
| Running transaction                                                                                                        |
|                                                                                                                            |
| Installing : 2:libogg-1.3.0-7.el7.x86\_64 1/28                                                                             |
|                                                                                                                            |
| Installing : 1:libvorbis-1.3.3-8.el7.x86\_64 2/28                                                                          |
|                                                                                                                            |
| Installing : libtdb-1.3.12-2.el7.x86\_64 3/28                                                                              |
|                                                                                                                            |
| Installing : libtool-ltdl-2.4.2-22.el7\_3.x86\_64 4/28                                                                     |
|                                                                                                                            |
| Installing : libusbx-1.0.20-1.el7.x86\_64 5/28                                                                             |
|                                                                                                                            |
| Installing : cairo-gobject-1.14.8-2.el7.x86\_64 6/28                                                                       |
|                                                                                                                            |
| Installing : libgusb-0.2.9-1.el7.x86\_64 7/28                                                                              |
|                                                                                                                            |
| Installing : flac-libs-1.3.0-5.el7\_1.x86\_64 8/28                                                                         |
|                                                                                                                            |
| Installing : at-spi2-core-2.22.0-1.el7.x86\_64 9/28                                                                        |
|                                                                                                                            |
| Installing : at-spi2-atk-2.22.0-2.el7.x86\_64 10/28                                                                        |
|                                                                                                                            |
| Installing : lcms2-2.6-3.el7.x86\_64 11/28                                                                                 |
|                                                                                                                            |
| Installing : colord-libs-1.3.4-1.el7.x86\_64 12/28                                                                         |
|                                                                                                                            |
| Installing : rest-0.8.0-1.el7.x86\_64 13/28                                                                                |
|                                                                                                                            |
| Installing : gsm-1.0.13-11.el7.x86\_64 14/28                                                                               |
|                                                                                                                            |
| Installing : libsndfile-1.0.25-10.el7.x86\_64 15/28                                                                        |
|                                                                                                                            |
| Installing : json-glib-1.2.6-1.el7.x86\_64 16/28                                                                           |
|                                                                                                                            |
| Installing : libepoxy-1.3.1-1.el7.x86\_64 17/28                                                                            |
|                                                                                                                            |
| Installing : sound-theme-freedesktop-0.8-3.el7.noarch 18/28                                                                |
|                                                                                                                            |
| Installing : dconf-0.26.0-2.el7.x86\_64 19/28                                                                              |
|                                                                                                                            |
| Installing : libasyncns-0.8-7.el7.x86\_64 20/28                                                                            |
|                                                                                                                            |
| Installing : pulseaudio-libs-10.0-3.el7.x86\_64 21/28                                                                      |
|                                                                                                                            |
| Installing : gstreamer1-1.10.4-2.el7.x86\_64 22/28                                                                         |
|                                                                                                                            |
| Installing : libcanberra-0.30-5.el7.x86\_64 23/28                                                                          |
|                                                                                                                            |
| Installing : adwaita-cursor-theme-3.22.0-1.el7.noarch 24/28                                                                |
|                                                                                                                            |
| Installing : adwaita-icon-theme-3.22.0-1.el7.noarch 25/28                                                                  |
|                                                                                                                            |
| Installing : gtk3-3.22.10-4.el7.x86\_64 26/28                                                                              |
|                                                                                                                            |
| Installing : libcanberra-gtk3-0.30-5.el7.x86\_64 27/28                                                                     |
|                                                                                                                            |
| Installing : libcanberra-gtk2-0.30-5.el7.x86\_64 28/28                                                                     |
|                                                                                                                            |
| Verifying : cairo-gobject-1.14.8-2.el7.x86\_64 1/28                                                                        |
|                                                                                                                            |
| Verifying : adwaita-cursor-theme-3.22.0-1.el7.noarch 2/28                                                                  |
|                                                                                                                            |
| Verifying : gstreamer1-1.10.4-2.el7.x86\_64 3/28                                                                           |
|                                                                                                                            |
| Verifying : colord-libs-1.3.4-1.el7.x86\_64 4/28                                                                           |
|                                                                                                                            |
| Verifying : libasyncns-0.8-7.el7.x86\_64 5/28                                                                              |
|                                                                                                                            |
| Verifying : flac-libs-1.3.0-5.el7\_1.x86\_64 6/28                                                                          |
|                                                                                                                            |
| Verifying : dconf-0.26.0-2.el7.x86\_64 7/28                                                                                |
|                                                                                                                            |
| Verifying : libcanberra-gtk3-0.30-5.el7.x86\_64 8/28                                                                       |
|                                                                                                                            |
| Verifying : sound-theme-freedesktop-0.8-3.el7.noarch 9/28                                                                  |
|                                                                                                                            |
| Verifying : libtool-ltdl-2.4.2-22.el7\_3.x86\_64 10/28                                                                     |
|                                                                                                                            |
| Verifying : libusbx-1.0.20-1.el7.x86\_64 11/28                                                                             |
|                                                                                                                            |
| Verifying : adwaita-icon-theme-3.22.0-1.el7.noarch 12/28                                                                   |
|                                                                                                                            |
| Verifying : libepoxy-1.3.1-1.el7.x86\_64 13/28                                                                             |
|                                                                                                                            |
| Verifying : json-glib-1.2.6-1.el7.x86\_64 14/28                                                                            |
|                                                                                                                            |
| Verifying : libcanberra-0.30-5.el7.x86\_64 15/28                                                                           |
|                                                                                                                            |
| Verifying : gsm-1.0.13-11.el7.x86\_64 16/28                                                                                |
|                                                                                                                            |
| Verifying : libtdb-1.3.12-2.el7.x86\_64 17/28                                                                              |
|                                                                                                                            |
| Verifying : 2:libogg-1.3.0-7.el7.x86\_64 18/28                                                                             |
|                                                                                                                            |
| Verifying : libcanberra-gtk2-0.30-5.el7.x86\_64 19/28                                                                      |
|                                                                                                                            |
| Verifying : rest-0.8.0-1.el7.x86\_64 20/28                                                                                 |
|                                                                                                                            |
| Verifying : lcms2-2.6-3.el7.x86\_64 21/28                                                                                  |
|                                                                                                                            |
| Verifying : libgusb-0.2.9-1.el7.x86\_64 22/28                                                                              |
|                                                                                                                            |
| Verifying : 1:libvorbis-1.3.3-8.el7.x86\_64 23/28                                                                          |
|                                                                                                                            |
| Verifying : at-spi2-atk-2.22.0-2.el7.x86\_64 24/28                                                                         |
|                                                                                                                            |
| Verifying : gtk3-3.22.10-4.el7.x86\_64 25/28                                                                               |
|                                                                                                                            |
| Verifying : pulseaudio-libs-10.0-3.el7.x86\_64 26/28                                                                       |
|                                                                                                                            |
| Verifying : at-spi2-core-2.22.0-1.el7.x86\_64 27/28                                                                        |
|                                                                                                                            |
| Verifying : libsndfile-1.0.25-10.el7.x86\_64 28/28                                                                         |
|                                                                                                                            |
| Installed:                                                                                                                 |
|                                                                                                                            |
| libcanberra-gtk2.x86\_64 0:0.30-5.el7                                                                                      |
|                                                                                                                            |
| Dependency Installed:                                                                                                      |
|                                                                                                                            |
| adwaita-cursor-theme.noarch 0:3.22.0-1.el7 adwaita-icon-theme.noarch 0:3.22.0-1.el7                                        |
|                                                                                                                            |
| at-spi2-atk.x86\_64 0:2.22.0-2.el7 at-spi2-core.x86\_64 0:2.22.0-1.el7                                                     |
|                                                                                                                            |
| cairo-gobject.x86\_64 0:1.14.8-2.el7 colord-libs.x86\_64 0:1.3.4-1.el7                                                     |
|                                                                                                                            |
| dconf.x86\_64 0:0.26.0-2.el7 flac-libs.x86\_64 0:1.3.0-5.el7\_1                                                            |
|                                                                                                                            |
| gsm.x86\_64 0:1.0.13-11.el7 gstreamer1.x86\_64 0:1.10.4-2.el7                                                              |
|                                                                                                                            |
| gtk3.x86\_64 0:3.22.10-4.el7 json-glib.x86\_64 0:1.2.6-1.el7                                                               |
|                                                                                                                            |
| lcms2.x86\_64 0:2.6-3.el7 libasyncns.x86\_64 0:0.8-7.el7                                                                   |
|                                                                                                                            |
| libcanberra.x86\_64 0:0.30-5.el7 libcanberra-gtk3.x86\_64 0:0.30-5.el7                                                     |
|                                                                                                                            |
| libepoxy.x86\_64 0:1.3.1-1.el7 libgusb.x86\_64 0:0.2.9-1.el7                                                               |
|                                                                                                                            |
| libogg.x86\_64 2:1.3.0-7.el7 libsndfile.x86\_64 0:1.0.25-10.el7                                                            |
|                                                                                                                            |
| libtdb.x86\_64 0:1.3.12-2.el7 libtool-ltdl.x86\_64 0:2.4.2-22.el7\_3                                                       |
|                                                                                                                            |
| libusbx.x86\_64 0:1.0.20-1.el7 libvorbis.x86\_64 1:1.3.3-8.el7                                                             |
|                                                                                                                            |
| pulseaudio-libs.x86\_64 0:10.0-3.el7 rest.x86\_64 0:0.8.0-1.el7                                                            |
|                                                                                                                            |
| sound-theme-freedesktop.noarch 0:0.8-3.el7                                                                                 |
|                                                                                                                            |
| Complete!                                                                                                                  |
+----------------------------------------------------------------------------------------------------------------------------+

Instalar openvpn

Se debe tener los certificados y el archivo de configuración ".ovpn"
(podemos utilizar estos archivos de los otros servidores)

+--------------------------------------------------------------------------------------------------------------------------------------------------------+
| [root@srvscm02 tmp]# yum install openvpn.x86\_64                                                                                                       |
|                                                                                                                                                        |
| Loaded plugins: ulninfo                                                                                                                                |
|                                                                                                                                                        |
| Resolving Dependencies                                                                                                                                 |
|                                                                                                                                                        |
| --> Running transaction check                                                                                                                          |
|                                                                                                                                                        |
| ---> Package openvpn.x86\_64 0:2.4.4-1.el7 will be installed                                                                                           |
|                                                                                                                                                        |
| --> Processing Dependency: liblz4.so.1()(64bit) for package: openvpn-2.4.4-1.el7.x86\_64                                                               |
|                                                                                                                                                        |
| --> Processing Dependency: libpkcs11-helper.so.1()(64bit) for package: openvpn-2.4.4-1.el7.x86\_64                                                     |
|                                                                                                                                                        |
| --> Running transaction check                                                                                                                          |
|                                                                                                                                                        |
| ---> Package lz4.x86\_64 0:1.7.3-1.el7 will be installed                                                                                               |
|                                                                                                                                                        |
| ---> Package pkcs11-helper.x86\_64 0:1.11-3.el7 will be installed                                                                                      |
|                                                                                                                                                        |
| --> Finished Dependency Resolution                                                                                                                     |
|                                                                                                                                                        |
| Dependencies Resolved                                                                                                                                  |
|                                                                                                                                                        |
| ===================================================================================================================================================    |
|                                                                                                                                                        |
| Package Arch Version Repository Size                                                                                                                   |
|                                                                                                                                                        |
| ===================================================================================================================================================    |
|                                                                                                                                                        |
| Installing:                                                                                                                                            |
|                                                                                                                                                        |
| openvpn x86\_64 2.4.4-1.el7 epel 457 k                                                                                                                 |
|                                                                                                                                                        |
| Installing for dependencies:                                                                                                                           |
|                                                                                                                                                        |
| lz4 x86\_64 1.7.3-1.el7 epel 82 k                                                                                                                      |
|                                                                                                                                                        |
| pkcs11-helper x86\_64 1.11-3.el7 epel 56 k                                                                                                             |
|                                                                                                                                                        |
| Transaction Summary                                                                                                                                    |
|                                                                                                                                                        |
| ===================================================================================================================================================    |
|                                                                                                                                                        |
| Install 1 Package (+2 Dependent packages)                                                                                                              |
|                                                                                                                                                        |
| Total download size: 594 k                                                                                                                             |
|                                                                                                                                                        |
| Installed size: 1.4 M                                                                                                                                  |
|                                                                                                                                                        |
| Is this ok [y/d/N]: y                                                                                                                                  |
|                                                                                                                                                        |
| Downloading packages:                                                                                                                                  |
|                                                                                                                                                        |
| warning: /var/cache/yum/x86\_64/7Server/epel/packages/lz4-1.7.3-1.el7.x86\_64.rpm: Header V3 RSA/SHA256 Signature, key ID 352c64e5: NOKEY-:--:-- ETA   |
|                                                                                                                                                        |
| Public key for lz4-1.7.3-1.el7.x86\_64.rpm is not installed                                                                                            |
|                                                                                                                                                        |
| (1/3): lz4-1.7.3-1.el7.x86\_64.rpm \| 82 kB 00:00:00                                                                                                   |
|                                                                                                                                                        |
| (2/3): openvpn-2.4.4-1.el7.x86\_64.rpm \| 457 kB 00:00:00                                                                                              |
|                                                                                                                                                        |
| (3/3): pkcs11-helper-1.11-3.el7.x86\_64.rpm \| 56 kB 00:00:00                                                                                          |
|                                                                                                                                                        |
| ---------------------------------------------------------------------------------------------------------------------------------------------------    |
|                                                                                                                                                        |
| Total 491 kB/s \| 594 kB 00:00:01                                                                                                                      |
|                                                                                                                                                        |
| Retrieving key from file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7                                                                                         |
|                                                                                                                                                        |
| Importing GPG key 0x352C64E5:                                                                                                                          |
|                                                                                                                                                        |
| Userid : "Fedora EPEL (7) <epel@fedoraproject.org>"                                                                                                    |
|                                                                                                                                                        |
| Fingerprint: 91e9 7d7c 4a5e 96f1 7f3e 888f 6a2f aea2 352c 64e5                                                                                         |
|                                                                                                                                                        |
| Package : epel-release-7-11.noarch (installed)                                                                                                         |
|                                                                                                                                                        |
| From : /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7                                                                                                             |
|                                                                                                                                                        |
| Is this ok [y/N]: y                                                                                                                                    |
|                                                                                                                                                        |
| Running transaction check                                                                                                                              |
|                                                                                                                                                        |
| Running transaction test                                                                                                                               |
|                                                                                                                                                        |
| Transaction test succeeded                                                                                                                             |
|                                                                                                                                                        |
| Running transaction                                                                                                                                    |
|                                                                                                                                                        |
| Warning: RPMDB altered outside of yum.                                                                                                                 |
|                                                                                                                                                        |
| Installing : pkcs11-helper-1.11-3.el7.x86\_64 1/3                                                                                                      |
|                                                                                                                                                        |
| Installing : lz4-1.7.3-1.el7.x86\_64 2/3                                                                                                               |
|                                                                                                                                                        |
| Installing : openvpn-2.4.4-1.el7.x86\_64 3/3                                                                                                           |
|                                                                                                                                                        |
| Verifying : lz4-1.7.3-1.el7.x86\_64 1/3                                                                                                                |
|                                                                                                                                                        |
| Verifying : openvpn-2.4.4-1.el7.x86\_64 2/3                                                                                                            |
|                                                                                                                                                        |
| Verifying : pkcs11-helper-1.11-3.el7.x86\_64 3/3                                                                                                       |
|                                                                                                                                                        |
| Installed:                                                                                                                                             |
|                                                                                                                                                        |
| openvpn.x86\_64 0:2.4.4-1.el7                                                                                                                          |
|                                                                                                                                                        |
| Dependency Installed:                                                                                                                                  |
|                                                                                                                                                        |
| lz4.x86\_64 0:1.7.3-1.el7 pkcs11-helper.x86\_64 0:1.11-3.el7                                                                                           |
|                                                                                                                                                        |
| Complete!                                                                                                                                              |
+--------------------------------------------------------------------------------------------------------------------------------------------------------+

Ejecutamos el openvpn.

+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| [root@srvscm02 VPN]# openvpn /instaladores/VPN/consis-colombia.ovpn                                                                                                                                                      |
|                                                                                                                                                                                                                          |
| Fri Jan 5 14:48:27 2018 DEPRECATED OPTION: --max-routes option ignored.The number of routes is unlimited as of OpenVPN 2.4. This option will be removed in a future version, please remove it from your configuration.   |
|                                                                                                                                                                                                                          |
| Fri Jan 5 14:48:27 2018 OpenVPN 2.4.4 x86\_64-redhat-linux-gnu [Fedora EPEL patched] [SSL (OpenSSL)] [LZO] [LZ4] [EPOLL] [PKCS11] [MH/PKTINFO] [AEAD] built on Sep 26 2017                                               |
|                                                                                                                                                                                                                          |
| Fri Jan 5 14:48:27 2018 library versions: OpenSSL 1.0.2k-fips 26 Jan 2017, LZO 2.06                                                                                                                                      |
|                                                                                                                                                                                                                          |
| Fri Jan 5 14:48:27 2018 WARNING: --ns-cert-type is DEPRECATED. Use --remote-cert-tls instead.                                                                                                                            |
|                                                                                                                                                                                                                          |
| Fri Jan 5 14:48:27 2018 TCP/UDP: Preserving recently used remote address: [AF\_INET]190.146.129.73:1194                                                                                                                  |
|                                                                                                                                                                                                                          |
| Fri Jan 5 14:48:27 2018 UDP link local: (not bound)                                                                                                                                                                      |
|                                                                                                                                                                                                                          |
| Fri Jan 5 14:48:27 2018 UDP link remote: [AF\_INET]190.146.129.73:1194                                                                                                                                                   |
|                                                                                                                                                                                                                          |
| Fri Jan 5 14:48:28 2018 [server] Peer Connection Initiated with [AF\_INET]190.146.129.73:1194                                                                                                                            |
|                                                                                                                                                                                                                          |
| Fri Jan 5 14:48:29 2018 TUN/TAP device tun0 opened                                                                                                                                                                       |
|                                                                                                                                                                                                                          |
| Fri Jan 5 14:48:29 2018 do\_ifconfig, tt->did\_ifconfig\_ipv6\_setup=0                                                                                                                                                   |
|                                                                                                                                                                                                                          |
| Fri Jan 5 14:48:29 2018 /sbin/ip link set dev tun0 up mtu 1500                                                                                                                                                           |
|                                                                                                                                                                                                                          |
| Fri Jan 5 14:48:29 2018 /sbin/ip addr add dev tun0 local 192.168.120.158 peer 192.168.120.157                                                                                                                            |
|                                                                                                                                                                                                                          |
| Fri Jan 5 14:48:29 2018 WARNING: this configuration may cache passwords in memory -- use the auth-nocache option to prevent this                                                                                         |
|                                                                                                                                                                                                                          |
| Fri Jan 5 14:48:29 2018 Initialization Sequence Completed                                                                                                                                                                |
+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+

Cuidado con las rutas...!!! (Tenemos que agregar una ruta manual)

+---------------------------------------------------------------------------+
| [root@srvscm02 ~]# route add -net 192.168.1.0/24 gw 192.168.1.5 dev em1   |
+---------------------------------------------------------------------------+

Y las rutas nos queda así.

+-------------------------------------------------------------+
| [root@srvscm02 ~]# route -n                                 |
|                                                             |
| Kernel IP routing table                                     |
|                                                             |
| Destination Gateway Genmask Flags Metric Ref Use Iface      |
|                                                             |
| 0.0.0.0 192.168.1.5 0.0.0.0 UG 100 0 0 em1                  |
|                                                             |
| 192.168.0.0 0.0.0.0 255.255.254.0 U 0 0 0 em1               |
|                                                             |
| 192.168.0.0 0.0.0.0 255.255.254.0 U 100 0 0 em1             |
|                                                             |
| 192.168.1.0 192.168.1.5 255.255.255.0 UG 0 0 0 em1          |
|                                                             |
| 192.168.111.0 192.168.120.157 255.255.255.0 UG 0 0 0 tun0   |
|                                                             |
| 192.168.120.0 192.168.120.157 255.255.252.0 UG 0 0 0 tun0   |
|                                                             |
| 192.168.120.157 0.0.0.0 255.255.255.255 UH 0 0 0 tun0       |
+-------------------------------------------------------------+

Ya se puede desde el servidor llegar al servidor Git de Colombia
192.168.111.5 y desde la red de Consis continua la conexión hacia el
servidor srvscm02.

Creando la clave rsa publica.

Se crean estas llaves porque más adelante u en otras configuraciones
serán requeridas, un ejemplo son las validaciones de ssh.

+-----------------------------------------------------------------------------------+
| [oracle@srvscm02 .ssh]$ ssh-keygen -t rsa                                         |
|                                                                                   |
| Generating public/private rsa key pair.                                           |
|                                                                                   |
| Enter file in which to save the key (/home/oracle/.ssh/id\_rsa):                  |
|                                                                                   |
| Enter passphrase (empty for no passphrase):                                       |
|                                                                                   |
| Enter same passphrase again:                                                      |
|                                                                                   |
| Your identification has been saved in /home/oracle/.ssh/id\_rsa.                  |
|                                                                                   |
| Your public key has been saved in /home/oracle/.ssh/id\_rsa.pub.                  |
|                                                                                   |
| The key fingerprint is:                                                           |
|                                                                                   |
| SHA256:JS7OLY+G+E7YYa3gsD4ruXXftHVLW6Nn8RY06ZjOTL4 oracle@srvscm02.consis.local   |
|                                                                                   |
| The key's randomart image is:                                                     |
|                                                                                   |
| +---[RSA 2048]----+                                                               |
|                                                                                   |
| \| \|                                                                             |
|                                                                                   |
| \| \|                                                                             |
|                                                                                   |
| \| . . .\|                                                                        |
|                                                                                   |
| \| . . o + \|                                                                     |
|                                                                                   |
| \|. . o o S = .\|                                                                 |
|                                                                                   |
| \| + = = o +.o \|                                                                 |
|                                                                                   |
| \|..+.=.+ o . O oo.\|                                                             |
|                                                                                   |
| \|+o.o...\* o o Xo.o\|                                                            |
|                                                                                   |
| \|o+ooo.o + +E.. \|                                                               |
|                                                                                   |
| +----[SHA256]-----+                                                               |
+-----------------------------------------------------------------------------------+

Realizamos las verificaciones que se crearan y la consulta de la llave
publica.

+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| [oracle@srvscm02 .ssh]$ cd /home/oracle                                                                                                                                                                                                                                                                                                                                                                                     |
|                                                                                                                                                                                                                                                                                                                                                                                                                             |
| [oracle@srvscm02 ~]$ cd .ssh/                                                                                                                                                                                                                                                                                                                                                                                               |
|                                                                                                                                                                                                                                                                                                                                                                                                                             |
| [oracle@srvscm02 .ssh]$ ls                                                                                                                                                                                                                                                                                                                                                                                                  |
|                                                                                                                                                                                                                                                                                                                                                                                                                             |
| id\_rsa id\_rsa.pub known\_hosts                                                                                                                                                                                                                                                                                                                                                                                            |
|                                                                                                                                                                                                                                                                                                                                                                                                                             |
| [oracle@srvscm02 .ssh]$ cat id\_rsa.pub                                                                                                                                                                                                                                                                                                                                                                                     |
|                                                                                                                                                                                                                                                                                                                                                                                                                             |
| ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDB5aoHCgVhXjxOJXl0eBXAKB5KmsYUDRHHS9HFBgU6i9MhsIJ/lHRdtJSXjPmN2hVNpuMP5tTRcLcqPxx71Zx4MEbkIIAz8s6CesB8zTen/R/oU34zc4ouHF4fus4GK4ejNdQum89Kyvwfou3yM1nXQzIsApcRcvGQbc7RO/XmeexO1VCmnmfzGHosRaCgUKX7JuzjI9/WvL4hVyAwkBfc9hJOl/JNZD1JI91Gq0laZ2u+rRUWUlLe8+n9CIbMPzJG3CUrqK/pVOx52S25bXt/hLXcyfajxYmuH1TBHrOxo5Pxg2hQB6hIwiSYM6RGnUJEKLyplNWvekUvzhZjB/+t oracle@srvscm02.consis.local   |
+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+

Instalar Apache.

Instalamos apache.

+-------------------------------------------------------------------------------------------------------------------------------------------------------+
| root@srvscm02 ~]# yum install -y httpd.x86\_64                                                                                                        |
|                                                                                                                                                       |
| Loaded plugins: ulninfo                                                                                                                               |
|                                                                                                                                                       |
| Resolving Dependencies                                                                                                                                |
|                                                                                                                                                       |
| --> Running transaction check                                                                                                                         |
|                                                                                                                                                       |
| ---> Package httpd.x86\_64 0:2.4.6-67.0.1.el7\_4.6 will be installed                                                                                  |
|                                                                                                                                                       |
| --> Processing Dependency: httpd-tools = 2.4.6-67.0.1.el7\_4.6 for package: httpd-2.4.6-67.0.1.el7\_4.6.x86\_64                                       |
|                                                                                                                                                       |
| --> Running transaction check                                                                                                                         |
|                                                                                                                                                       |
| ---> Package httpd-tools.x86\_64 0:2.4.6-67.0.1.el7\_4.6 will be installed                                                                            |
|                                                                                                                                                       |
| --> Finished Dependency Resolution                                                                                                                    |
|                                                                                                                                                       |
| Dependencies Resolved                                                                                                                                 |
|                                                                                                                                                       |
| ===================================================================================================================================================   |
|                                                                                                                                                       |
| Package Arch Version Repository Size                                                                                                                  |
|                                                                                                                                                       |
| ===================================================================================================================================================   |
|                                                                                                                                                       |
| Installing:                                                                                                                                           |
|                                                                                                                                                       |
| httpd x86\_64 2.4.6-67.0.1.el7\_4.6 ol7\_latest 1.2 M                                                                                                 |
|                                                                                                                                                       |
| Installing for dependencies:                                                                                                                          |
|                                                                                                                                                       |
| httpd-tools x86\_64 2.4.6-67.0.1.el7\_4.6 ol7\_latest 87 k                                                                                            |
|                                                                                                                                                       |
| Transaction Summary                                                                                                                                   |
|                                                                                                                                                       |
| ===================================================================================================================================================   |
|                                                                                                                                                       |
| Install 1 Package (+1 Dependent package)                                                                                                              |
|                                                                                                                                                       |
| Total download size: 1.3 M                                                                                                                            |
|                                                                                                                                                       |
| Installed size: 3.9 M                                                                                                                                 |
|                                                                                                                                                       |
| Downloading packages:                                                                                                                                 |
|                                                                                                                                                       |
| (1/2): httpd-tools-2.4.6-67.0.1.el7\_4.6.x86\_64.rpm \| 87 kB 00:00:00                                                                                |
|                                                                                                                                                       |
| (2/2): httpd-2.4.6-67.0.1.el7\_4.6.x86\_64.rpm \| 1.2 MB 00:00:00                                                                                     |
|                                                                                                                                                       |
| ---------------------------------------------------------------------------------------------------------------------------------------------------   |
|                                                                                                                                                       |
| Total 1.5 MB/s \| 1.3 MB 00:00:00                                                                                                                     |
|                                                                                                                                                       |
| Running transaction check                                                                                                                             |
|                                                                                                                                                       |
| Running transaction test                                                                                                                              |
|                                                                                                                                                       |
| Transaction test succeeded                                                                                                                            |
|                                                                                                                                                       |
| Running transaction                                                                                                                                   |
|                                                                                                                                                       |
| Installing : httpd-tools-2.4.6-67.0.1.el7\_4.6.x86\_64 1/2                                                                                            |
|                                                                                                                                                       |
| Installing : httpd-2.4.6-67.0.1.el7\_4.6.x86\_64 2/2                                                                                                  |
|                                                                                                                                                       |
| Verifying : httpd-tools-2.4.6-67.0.1.el7\_4.6.x86\_64 1/2                                                                                             |
|                                                                                                                                                       |
| Verifying : httpd-2.4.6-67.0.1.el7\_4.6.x86\_64 2/2                                                                                                   |
|                                                                                                                                                       |
| Installed:                                                                                                                                            |
|                                                                                                                                                       |
| httpd.x86\_64 0:2.4.6-67.0.1.el7\_4.6                                                                                                                 |
|                                                                                                                                                       |
| Dependency Installed:                                                                                                                                 |
|                                                                                                                                                       |
| httpd-tools.x86\_64 0:2.4.6-67.0.1.el7\_4.6                                                                                                           |
|                                                                                                                                                       |
| Complete!                                                                                                                                             |
+-------------------------------------------------------------------------------------------------------------------------------------------------------+

Verificamos el status y lo iniciamos.

+---------------------------------------------------------------------------------------------+
| [root@srvscm02 ~]# systemctl status httpd                                                   |
|                                                                                             |
| ● httpd.service - The Apache HTTP Server                                                    |
|                                                                                             |
| Loaded: loaded (/usr/lib/systemd/system/httpd.service; disabled; vendor preset: disabled)   |
|                                                                                             |
| Active: inactive (dead)                                                                     |
|                                                                                             |
| Docs: man:httpd(8)                                                                          |
|                                                                                             |
| man:apachectl(8)                                                                            |
|                                                                                             |
| [root@srvscm02 ~]# systemctl start httpd                                                    |
+---------------------------------------------------------------------------------------------+

Instalar el java jdk 8 y jdk 7

Instalamos el java JDK 7.

+------------------------------------------------------------------------------------------+
| [root@srvscm02 instaladores]# rpm -ivh /instaladores/java/jdk/jdk-7u79-linux-x64.rpm     |
|                                                                                          |
| Preparing... ################################# [100%]                                    |
|                                                                                          |
| Updating / installing...                                                                 |
|                                                                                          |
| 1:jdk-2000:1.7.0\_79-fcs warning: /etc/init.d/jexec saved as /etc/init.d/jexec.rpmorig   |
|                                                                                          |
| ################################# [100%]                                                 |
|                                                                                          |
| Unpacking JAR files...                                                                   |
|                                                                                          |
| rt.jar...                                                                                |
|                                                                                          |
| jsse.jar...                                                                              |
|                                                                                          |
| charsets.jar...                                                                          |
|                                                                                          |
| tools.jar...                                                                             |
|                                                                                          |
| localedata.jar...                                                                        |
|                                                                                          |
| jfxrt.jar...                                                                             |
+------------------------------------------------------------------------------------------+

Instalamos el java JDK 8.

+-----------------------------------------------------------------------------------------+
| [root@srvscm02 instaladores]# rpm -ivh /instaladores/java/jdk/jdk-8u101-linux-x64.rpm   |
|                                                                                         |
| Preparing... ################################# [100%]                                   |
|                                                                                         |
| Updating / installing...                                                                |
|                                                                                         |
| 1:jdk1.8.0\_101-2000:1.8.0\_101-fcs ################################# [100%]            |
|                                                                                         |
| Unpacking JAR files...                                                                  |
|                                                                                         |
| tools.jar...                                                                            |
|                                                                                         |
| plugin.jar...                                                                           |
|                                                                                         |
| javaws.jar...                                                                           |
|                                                                                         |
| deploy.jar...                                                                           |
|                                                                                         |
| rt.jar...                                                                               |
|                                                                                         |
| jsse.jar...                                                                             |
|                                                                                         |
| charsets.jar...                                                                         |
|                                                                                         |
| localedata.jar...                                                                       |
+-----------------------------------------------------------------------------------------+

Verificamos la versión del JAVA predeterminado.

+--------------------------------------------------------------------+
| [root@srvscm02 instaladores]# java -version                        |
|                                                                    |
| java version "1.8.0\_101"                                          |
|                                                                    |
| Java(TM) SE Runtime Environment (build 1.8.0\_101-b13)             |
|                                                                    |
| Java HotSpot(TM) 64-Bit Server VM (build 25.101-b13, mixed mode)   |
+--------------------------------------------------------------------+

La ruta de la instalación es:

+---------------------------------------------+
| [root@srvscm02 /]# ls /usr/java/            |
|                                             |
| default jdk1.7.0\_79 jdk1.8.0\_101 latest   |
+---------------------------------------------+

Configurar del SSH para que X11 haga forward.

Esta configuración es requerida, para las configuraciones que se
realizan desde el servidor y se necesita el ambiente gráfico (X11)

Debemos instalar

+-----------------------------------+
| sudo yum install xorg-x11-xauth   |
+-----------------------------------+

Debemos editar el archivo de configuración y asegurarnos que tenga la
siguiente linea activa.

+-----------------------------------------------+
| [root@srvscm02 /]# vi /etc/ssh/sshd\_config   |
|                                               |
| X11Forwarding yes                             |
+-----------------------------------------------+

Reiniciamos el SSH

+---------------------------------------------+
| [root@srvscm02 /]# systemctl restart sshd   |
+---------------------------------------------+

Nos desconectamos e Ingresamos nuevamente con el ssh agregando el
argumento “-X”

+---------------------------------------------------------------------------------+
| user@scm01:$ ssh -X oracle@192.168.1.54                                         |
|                                                                                 |
| oracle@192.168.1.54's password:                                                 |
|                                                                                 |
| Permission denied, please try again.                                            |
|                                                                                 |
| oracle@192.168.1.54's password:                                                 |
|                                                                                 |
| Last failed login: Fri Jan 5 16:28:35 EST 2018 from 192.168.1.66 on ssh:notty   |
|                                                                                 |
| There were 2 failed login attempts since the last successful login.             |
|                                                                                 |
| Last login: Fri Jan 5 15:44:53 2018 from 192.168.1.66                           |
+---------------------------------------------------------------------------------+

Verificamos la variable DISPLAY

+--------------------------------------+
| [oracle@srvscm02 ~]$ echo $DISPLAY   |
|                                      |
| localhost:10.0                       |
+--------------------------------------+

Hacemos una prueba de X11 y se debe visualizar el reloj en el ambiente
gráfico

+-------------------------------+
| [oracle@srvscm02 ~]$ xclock   |
+-------------------------------+

Esto es lo que debemos ver.

|image4|

Instalando las versiones de JAVA utilizadas por CONSIS para compilar y
crear los EAR

Descomprimimos el JDK 1.6.0

+-----------------------------------------------------------------+
| [oracle@srvscm02 jdk]$ tar xvf jdk1.6.0\_45.tar -C /scm/java/   |
|                                                                 |
| jdk1.6.0\_45/jre/bin/orbd                                       |
|                                                                 |
| jdk1.6.0\_45/jre/bin/servertool                                 |
|                                                                 |
| [...]                                                           |
|                                                                 |
| jdk1.6.0\_45/THIRDPARTYLICENSEREADME.txt                        |
+-----------------------------------------------------------------+

Descomprimimos el JDK 1.7.0

+-----------------------------------------------------------------+
| [oracle@srvscm02 jdk]$ tar xvf jdk1.7.0\_79.tar -C /scm/java/   |
|                                                                 |
| jdk1.7.0\_79/man/ja\_JP.UTF-8/man1/orbd.1                       |
|                                                                 |
| jdk1.7.0\_79/man/ja\_JP.UTF-8/man1/javafxpackager.1             |
|                                                                 |
| [...]                                                           |
|                                                                 |
| jdk1.7.0\_79/man/ja\_JP.UTF-8/man1/wsimport.1                   |
+-----------------------------------------------------------------+

Descomprimimos el JDK 1.8.0

+-----------------------------------------------------------------+
| [oracle@srvscm02 jdk]$ tar xvf jdk1.8.0\_92.tar -C /scm/java/   |
|                                                                 |
| jdk1.8.0\_92/jre/bin/orbd                                       |
|                                                                 |
| jdk1.8.0\_92/jre/bin/servertool                                 |
|                                                                 |
| [...]                                                           |
|                                                                 |
| jdk1.8.0\_92/jre/bin/pack200                                    |
+-----------------------------------------------------------------+

Verificamos

+---------------------------------------------------------------+
| [oracle@srvscm02 jdk]$ ls -ltr /scm/java/                     |
|                                                               |
| total 12                                                      |
|                                                               |
| drwxr-xr-x. 8 oracle oinstall 4096 mar 26 2013 jdk1.6.0\_45   |
|                                                               |
| drwxr-xr-x. 8 oracle oinstall 4096 abr 10 2015 jdk1.7.0\_79   |
|                                                               |
| drwxr-xr-x. 8 oracle oinstall 4096 abr 1 2016 jdk1.8.0\_92    |
+---------------------------------------------------------------+

Configuración de las variables de entorno para el usuario “oracle”

Estas variables de entorno se deben establecer en el profile del usuario
“oracle” y se debe respetar dicha configuración motivado que son las
mejores practicas que hasta los momentos a CONSIS le resulta para la
compilación de los paquetes y despliegue de los mismos.

Esta configuración la realizamos en el archivo “.bash\_profile” ubicado
en “/home/oracle”

+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| $ vi .bash\_profile                                                                                                                                                                                    |
|                                                                                                                                                                                                        |
| # .bash\_profile                                                                                                                                                                                       |
|                                                                                                                                                                                                        |
| # Get the aliases and functions                                                                                                                                                                        |
|                                                                                                                                                                                                        |
| if [ -f ~/.bashrc ]; then                                                                                                                                                                              |
|                                                                                                                                                                                                        |
| . ~/.bashrc                                                                                                                                                                                            |
|                                                                                                                                                                                                        |
| fi                                                                                                                                                                                                     |
|                                                                                                                                                                                                        |
| # User specific environment and startup programs                                                                                                                                                       |
|                                                                                                                                                                                                        |
| #export PATH=$PATH:/home/oracle/scm:$HOME/bin                                                                                                                                                          |
|                                                                                                                                                                                                        |
| umask 000                                                                                                                                                                                              |
|                                                                                                                                                                                                        |
| echo "Seleccione La Instancia: "                                                                                                                                                                       |
|                                                                                                                                                                                                        |
| echo "ORACSEL [BD ] [0]"                                                                                                                                                                               |
|                                                                                                                                                                                                        |
| echo "WLS10.3.6 [u01] [1]"                                                                                                                                                                             |
|                                                                                                                                                                                                        |
| echo "WLS12.1.3 [u02] [2]"                                                                                                                                                                             |
|                                                                                                                                                                                                        |
| echo "WLS12.1.2 [u03] [3]"                                                                                                                                                                             |
|                                                                                                                                                                                                        |
| echo "WLS12.1.1 [u04] [4]"                                                                                                                                                                             |
|                                                                                                                                                                                                        |
| echo "acselx11g [u05] [5]"                                                                                                                                                                             |
|                                                                                                                                                                                                        |
| export Opcion="0"                                                                                                                                                                                      |
|                                                                                                                                                                                                        |
| read -r Opcion                                                                                                                                                                                         |
|                                                                                                                                                                                                        |
| echo ""                                                                                                                                                                                                |
|                                                                                                                                                                                                        |
| case $Opcion in                                                                                                                                                                                        |
|                                                                                                                                                                                                        |
| 0) # Base de datos ORACSEL                                                                                                                                                                             |
|                                                                                                                                                                                                        |
| #====================================================================                                                                                                                                  |
|                                                                                                                                                                                                        |
| # variables de BD                                                                                                                                                                                      |
|                                                                                                                                                                                                        |
| export ORACLE\_HOSTNAME=srvscm03                                                                                                                                                                       |
|                                                                                                                                                                                                        |
| export ORACLE\_UNQNAME=orcl12c                                                                                                                                                                         |
|                                                                                                                                                                                                        |
| export ORACLE\_BASE=/oracle                                                                                                                                                                            |
|                                                                                                                                                                                                        |
| export ORACLE\_HOME=$ORACLE\_BASE/product/12.1.0/dbhome\_1                                                                                                                                             |
|                                                                                                                                                                                                        |
| export ORACLE\_SID=orcl12c                                                                                                                                                                             |
|                                                                                                                                                                                                        |
| export PATH=/usr/sbin:$PATH                                                                                                                                                                            |
|                                                                                                                                                                                                        |
| export PATH=$ORACLE\_HOME/bin:$PATH                                                                                                                                                                    |
|                                                                                                                                                                                                        |
| export LD\_LIBRARY\_PATH=$ORACLE\_HOME/lib:/lib:/usr/lib                                                                                                                                               |
|                                                                                                                                                                                                        |
| export CLASSPATH=$ORACLE\_HOME/jlib:$ORACLE\_HOME/rdbms/jlib                                                                                                                                           |
|                                                                                                                                                                                                        |
| ;;                                                                                                                                                                                                     |
|                                                                                                                                                                                                        |
| 1) # WLS10.3.6 11g                                                                                                                                                                                     |
|                                                                                                                                                                                                        |
| #=====================================================================                                                                                                                                 |
|                                                                                                                                                                                                        |
| export ORACLE\_BASE=/u01/app/oracle                                                                                                                                                                    |
|                                                                                                                                                                                                        |
| export ORACLE\_HOME=/u01/app/product/w\_11                                                                                                                                                             |
|                                                                                                                                                                                                        |
| export WL\_HOME=$ORACLE\_HOME/wlserver\_10.3                                                                                                                                                           |
|                                                                                                                                                                                                        |
| export DOMAIN\_HOME=$ORACLE\_BASE/domain                                                                                                                                                               |
|                                                                                                                                                                                                        |
| export ORACLE\_COMMON\_HOME=$WL\_HOME/common                                                                                                                                                           |
|                                                                                                                                                                                                        |
| ;;                                                                                                                                                                                                     |
|                                                                                                                                                                                                        |
| 2) #WLS12.1.3 12c                                                                                                                                                                                      |
|                                                                                                                                                                                                        |
| #=====================================================================                                                                                                                                 |
|                                                                                                                                                                                                        |
| export ORACLE\_BASE=/u02/app/oracle                                                                                                                                                                    |
|                                                                                                                                                                                                        |
| export ORACLE\_HOME=/u02/app/product/W\_12c                                                                                                                                                            |
|                                                                                                                                                                                                        |
| export WL\_HOME=$ORACLE\_HOME/wlserver                                                                                                                                                                 |
|                                                                                                                                                                                                        |
| export DOMAIN\_HOME=$ORACLE\_BASE/domain                                                                                                                                                               |
|                                                                                                                                                                                                        |
| ;;                                                                                                                                                                                                     |
|                                                                                                                                                                                                        |
| 3) #WLS12.1.1 12c                                                                                                                                                                                      |
|                                                                                                                                                                                                        |
| #=====================================================================                                                                                                                                 |
|                                                                                                                                                                                                        |
| export ORACLE\_BASE=/u03/app/oracle/                                                                                                                                                                   |
|                                                                                                                                                                                                        |
| export ORACLE\_HOME=/u03/app/product                                                                                                                                                                   |
|                                                                                                                                                                                                        |
| export WL\_HOME=$ORACLE\_HOME/w\_11/wlserver\_12.1                                                                                                                                                     |
|                                                                                                                                                                                                        |
| export DOMAIN\_HOME=$ORACLE\_BASE/domain                                                                                                                                                               |
|                                                                                                                                                                                                        |
| ;;                                                                                                                                                                                                     |
|                                                                                                                                                                                                        |
| 4) #WLS12.1.2 12c                                                                                                                                                                                      |
|                                                                                                                                                                                                        |
| #=====================================================================                                                                                                                                 |
|                                                                                                                                                                                                        |
| export ORACLE\_BASE=/u04/app/oracle                                                                                                                                                                    |
|                                                                                                                                                                                                        |
| export ORACLE\_HOME=/u04/app/oracle/product                                                                                                                                                            |
|                                                                                                                                                                                                        |
| export WL\_HOME=$ORACLE\_HOME/wls1212/wlserver                                                                                                                                                         |
|                                                                                                                                                                                                        |
| export DOMAIN\_HOME=$ORACLE\_BASE/domain                                                                                                                                                               |
|                                                                                                                                                                                                        |
| ;;                                                                                                                                                                                                     |
|                                                                                                                                                                                                        |
| 5) #WLS12.1.3 12c ACSEL-X                                                                                                                                                                              |
|                                                                                                                                                                                                        |
| #=====================================================================                                                                                                                                 |
|                                                                                                                                                                                                        |
| export ORACLE\_BASE=/u05/app/oracle/                                                                                                                                                                   |
|                                                                                                                                                                                                        |
| export ORACLE\_HOME=/u05/app/oracle/product/acselx11g/                                                                                                                                                 |
|                                                                                                                                                                                                        |
| export WL\_HOME=/u02/app/product/w\_1213/wlserver                                                                                                                                                      |
|                                                                                                                                                                                                        |
| export DOMAIN\_HOME=/u01/app/oracle/domain/sonar                                                                                                                                                       |
|                                                                                                                                                                                                        |
| ;;                                                                                                                                                                                                     |
|                                                                                                                                                                                                        |
| \*)                                                                                                                                                                                                    |
|                                                                                                                                                                                                        |
| echo "Por default se carga /u02"                                                                                                                                                                       |
|                                                                                                                                                                                                        |
| #WLS12.1.3 12c                                                                                                                                                                                         |
|                                                                                                                                                                                                        |
| #=====================================================================                                                                                                                                 |
|                                                                                                                                                                                                        |
| export ORACLE\_BASE=/u02/app/oracle                                                                                                                                                                    |
|                                                                                                                                                                                                        |
| export ORACLE\_HOME=/u02/app/product/W\_12c                                                                                                                                                            |
|                                                                                                                                                                                                        |
| export WL\_HOME=$ORACLE\_HOME/wlserver                                                                                                                                                                 |
|                                                                                                                                                                                                        |
| export DOMAIN\_HOME=$ORACLE\_BASE/domain                                                                                                                                                               |
|                                                                                                                                                                                                        |
| ;;                                                                                                                                                                                                     |
|                                                                                                                                                                                                        |
| esac                                                                                                                                                                                                   |
|                                                                                                                                                                                                        |
| export ORACLE\_COMMON\_HOME=$WL\_HOME/common                                                                                                                                                           |
|                                                                                                                                                                                                        |
| export TMP=/tmp                                                                                                                                                                                        |
|                                                                                                                                                                                                        |
| export TMPDIR=$TMP                                                                                                                                                                                     |
|                                                                                                                                                                                                        |
| export JAVA\_HOME=/u02/app/product/jdk1.8.0\_92                                                                                                                                                        |
|                                                                                                                                                                                                        |
| export JAVA\_DESP=/u02/app/product/jdk1.7.0\_79                                                                                                                                                        |
|                                                                                                                                                                                                        |
| export JAVA\_COMP=/home/scm/svn/jdk1.6.0\_45                                                                                                                                                           |
|                                                                                                                                                                                                        |
| echo " Variables de entorno cargadas"                                                                                                                                                                  |
|                                                                                                                                                                                                        |
| echo " ORACLE\_HOME: "$ORACLE\_HOME                                                                                                                                                                    |
|                                                                                                                                                                                                        |
| echo " ORACLE\_BASE: "$ORACLE\_BASE                                                                                                                                                                    |
|                                                                                                                                                                                                        |
| echo " WL\_HOME: "$WL\_HOME                                                                                                                                                                            |
|                                                                                                                                                                                                        |
| echo " ORACLE\_COMMON: "$ORACLE\_COMMON\_HOME                                                                                                                                                          |
|                                                                                                                                                                                                        |
| echo " DOMAIN\_HOME: "$DOMAIN\_HOME                                                                                                                                                                    |
|                                                                                                                                                                                                        |
| echo " TMPDIR: "$TMPDIR                                                                                                                                                                                |
|                                                                                                                                                                                                        |
| echo " JAVA\_HOME: "$JAVA\_HOME                                                                                                                                                                        |
|                                                                                                                                                                                                        |
| echo " JAVA\_DESP: "$JAVA\_DESP                                                                                                                                                                        |
|                                                                                                                                                                                                        |
| echo " JAVA\_COMP: "$JAVA\_COMP                                                                                                                                                                        |
|                                                                                                                                                                                                        |
| #=====================================================================                                                                                                                                 |
|                                                                                                                                                                                                        |
| # if running bash                                                                                                                                                                                      |
|                                                                                                                                                                                                        |
| if [ -n "$BASH\_VERSION" ]; then                                                                                                                                                                       |
|                                                                                                                                                                                                        |
| # include .bashrc if it exists                                                                                                                                                                         |
|                                                                                                                                                                                                        |
| if [ -f "$HOME/.bashrc" ]; then                                                                                                                                                                        |
|                                                                                                                                                                                                        |
| . "$HOME/.bashrc"                                                                                                                                                                                      |
|                                                                                                                                                                                                        |
| fi                                                                                                                                                                                                     |
|                                                                                                                                                                                                        |
| fi                                                                                                                                                                                                     |
|                                                                                                                                                                                                        |
| # set PATH so it includes user's private bin if it exists                                                                                                                                              |
|                                                                                                                                                                                                        |
| if [ -d "$HOME/bin" ] ; then                                                                                                                                                                           |
|                                                                                                                                                                                                        |
| PATH="$HOME/bin:$PATH"                                                                                                                                                                                 |
|                                                                                                                                                                                                        |
| fi                                                                                                                                                                                                     |
|                                                                                                                                                                                                        |
| export PATH=$PATH:$HOME/scm:$HOME/scm/OracleClient:.                                                                                                                                                   |
|                                                                                                                                                                                                        |
| #=====================================================================                                                                                                                                 |
|                                                                                                                                                                                                        |
| # alias                                                                                                                                                                                                |
|                                                                                                                                                                                                        |
| alias l="ls -ltra"                                                                                                                                                                                     |
|                                                                                                                                                                                                        |
| alias l.='ls -d .\* '                                                                                                                                                                                  |
|                                                                                                                                                                                                        |
| alias ll='ls -l'                                                                                                                                                                                       |
|                                                                                                                                                                                                        |
| alias ls='ls '                                                                                                                                                                                         |
|                                                                                                                                                                                                        |
| #alias domain="cd /u01/app/oracle/domain/sonar"                                                                                                                                                        |
|                                                                                                                                                                                                        |
| alias domain="cd /u02/app/oracle/domain"                                                                                                                                                               |
|                                                                                                                                                                                                        |
| alias domain2="cd /u03/app/oracle/domain"                                                                                                                                                              |
|                                                                                                                                                                                                        |
| #alias external="cd /u01/app/oracle/domain/sonar/external"                                                                                                                                             |
|                                                                                                                                                                                                        |
| alias external="cd /u02/app/oracle/domain/external"                                                                                                                                                    |
|                                                                                                                                                                                                        |
| #alias ear="cd /u01/app/oracle/domain/sonar/EAR\_WEBLOGIC"                                                                                                                                             |
|                                                                                                                                                                                                        |
| alias ear="cd /u02/app/oracle/domain/EAR\_Weblogic"                                                                                                                                                    |
|                                                                                                                                                                                                        |
| alias webapps="cd /home/oracle/apache/webapps"                                                                                                                                                         |
|                                                                                                                                                                                                        |
| #====================================================================                                                                                                                                  |
|                                                                                                                                                                                                        |
| # funciones                                                                                                                                                                                            |
|                                                                                                                                                                                                        |
| catalina()                                                                                                                                                                                             |
|                                                                                                                                                                                                        |
| {                                                                                                                                                                                                      |
|                                                                                                                                                                                                        |
| var=$1                                                                                                                                                                                                 |
|                                                                                                                                                                                                        |
| case $var in                                                                                                                                                                                           |
|                                                                                                                                                                                                        |
| start\|START\|str\|STR)                                                                                                                                                                                |
|                                                                                                                                                                                                        |
| /home/oracle/apache/bin/catalina.sh start                                                                                                                                                              |
|                                                                                                                                                                                                        |
| ;;                                                                                                                                                                                                     |
|                                                                                                                                                                                                        |
| stop\|STOP\|STP\|stp)                                                                                                                                                                                  |
|                                                                                                                                                                                                        |
| /home/oracle/apache/bin/catalina.sh stop                                                                                                                                                               |
|                                                                                                                                                                                                        |
| ;;                                                                                                                                                                                                     |
|                                                                                                                                                                                                        |
| restar\|RESTAR\|rst\|RST)                                                                                                                                                                              |
|                                                                                                                                                                                                        |
| /home/oracle/apache/bin/catalina.sh stop                                                                                                                                                               |
|                                                                                                                                                                                                        |
| sleep 10                                                                                                                                                                                               |
|                                                                                                                                                                                                        |
| /home/oracle/apache/bin/catalina.sh start                                                                                                                                                              |
|                                                                                                                                                                                                        |
| ;;                                                                                                                                                                                                     |
|                                                                                                                                                                                                        |
| \*)                                                                                                                                                                                                    |
|                                                                                                                                                                                                        |
| echo "ejecutar: catalina.sh [start\|START\|str\|STR / stop\|STOP\|STP\|stp]"                                                                                                                           |
|                                                                                                                                                                                                        |
| ;;                                                                                                                                                                                                     |
|                                                                                                                                                                                                        |
| esac                                                                                                                                                                                                   |
|                                                                                                                                                                                                        |
| }                                                                                                                                                                                                      |
|                                                                                                                                                                                                        |
| memoriaDomain()                                                                                                                                                                                        |
|                                                                                                                                                                                                        |
| {                                                                                                                                                                                                      |
|                                                                                                                                                                                                        |
| v\_temp=\`pwd\`                                                                                                                                                                                        |
|                                                                                                                                                                                                        |
| #cd /u01/app/oracle/domain/sonar                                                                                                                                                                       |
|                                                                                                                                                                                                        |
| cd /u02/app/oracle/domain                                                                                                                                                                              |
|                                                                                                                                                                                                        |
| ls \| grep -v "EAR\_Weblogic" \| grep -v "external" \| grep -v "7001.tar" \| while read line ; do                                                                                                      |
|                                                                                                                                                                                                        |
| var1=\`cat $line/bin/setDomainEnv.sh \| grep -v \\# \| grep -v "export" \| grep -v "{WLS\_MEM\_ARGS\_64BIT}" \| grep WLS\_MEM\_ARGS\_64BIT\`                                                           |
|                                                                                                                                                                                                        |
| var2=\`cat $line/bin/setDomainEnv.sh \| grep -v \\# \| grep -v "export" \| grep -v "{MEM\_PERM\_SIZE\_64BIT}" \| grep MEM\_PERM\_SIZE\_64BIT\`                                                         |
|                                                                                                                                                                                                        |
| var3=\`cat $line/bin/setDomainEnv.sh \| grep -v \\# \| grep -v "export" \| grep -v "{MEM\_MAX\_PERM\_SIZE\_64BIT}" \| grep MEM\_MAX\_PERM\_SIZE\_64BIT\`                                               |
|                                                                                                                                                                                                        |
| echo $line":"                                                                                                                                                                                          |
|                                                                                                                                                                                                        |
| echo "........... "$var1                                                                                                                                                                               |
|                                                                                                                                                                                                        |
| echo "........... "$var2                                                                                                                                                                               |
|                                                                                                                                                                                                        |
| echo "........... "$var3                                                                                                                                                                               |
|                                                                                                                                                                                                        |
| echo " "                                                                                                                                                                                               |
|                                                                                                                                                                                                        |
| done                                                                                                                                                                                                   |
|                                                                                                                                                                                                        |
| cd $v\_temp                                                                                                                                                                                            |
|                                                                                                                                                                                                        |
| }                                                                                                                                                                                                      |
|                                                                                                                                                                                                        |
| memoriaDomain2()                                                                                                                                                                                       |
|                                                                                                                                                                                                        |
| {                                                                                                                                                                                                      |
|                                                                                                                                                                                                        |
| v\_temp=\`pwd\`                                                                                                                                                                                        |
|                                                                                                                                                                                                        |
| #cd /u01/app/oracle/domain/sonar                                                                                                                                                                       |
|                                                                                                                                                                                                        |
| cd /u03/app/oracle/domain                                                                                                                                                                              |
|                                                                                                                                                                                                        |
| ls \| grep -v "EAR\_Weblogic" \| grep -v "external" \| grep -v "7001.tar" \| while read line ; do                                                                                                      |
|                                                                                                                                                                                                        |
| var1=\`cat $line/bin/setDomainEnv.sh \| grep -v \\# \| grep -v "export" \| grep -v "{WLS\_MEM\_ARGS\_64BIT}" \| grep WLS\_MEM\_ARGS\_64BIT\`                                                           |
|                                                                                                                                                                                                        |
| var2=\`cat $line/bin/setDomainEnv.sh \| grep -v \\# \| grep -v "export" \| grep -v "{MEM\_PERM\_SIZE\_64BIT}" \| grep MEM\_PERM\_SIZE\_64BIT\`                                                         |
|                                                                                                                                                                                                        |
| var3=\`cat $line/bin/setDomainEnv.sh \| grep -v \\# \| grep -v "export" \| grep -v "{MEM\_MAX\_PERM\_SIZE\_64BIT}" \| grep MEM\_MAX\_PERM\_SIZE\_64BIT\`                                               |
|                                                                                                                                                                                                        |
| echo $line":"                                                                                                                                                                                          |
|                                                                                                                                                                                                        |
| echo "........... "$var1                                                                                                                                                                               |
|                                                                                                                                                                                                        |
| echo "........... "$var2                                                                                                                                                                               |
|                                                                                                                                                                                                        |
| echo "........... "$var3                                                                                                                                                                               |
|                                                                                                                                                                                                        |
| echo " "                                                                                                                                                                                               |
|                                                                                                                                                                                                        |
| done                                                                                                                                                                                                   |
|                                                                                                                                                                                                        |
| cd $v\_temp                                                                                                                                                                                            |
|                                                                                                                                                                                                        |
| }                                                                                                                                                                                                      |
|                                                                                                                                                                                                        |
| log()                                                                                                                                                                                                  |
|                                                                                                                                                                                                        |
| {                                                                                                                                                                                                      |
|                                                                                                                                                                                                        |
| var1=$1                                                                                                                                                                                                |
|                                                                                                                                                                                                        |
| dir\_domain="/"\`cat /home/oracle/scm/port\_list.txt \| grep $var1 \| awk '{print$2}'\`"/app/oracle/domain/D"                                                                                          |
|                                                                                                                                                                                                        |
| if [ "$var1" = "" ] ; then                                                                                                                                                                             |
|                                                                                                                                                                                                        |
| echo " Error debe indicar el numero de puerto"                                                                                                                                                         |
|                                                                                                                                                                                                        |
| fi                                                                                                                                                                                                     |
|                                                                                                                                                                                                        |
| #tail -f "/u01/app/oracle/domain/sonar/"$var1"/servers/AdminServer/logs/log\_start.log"                                                                                                                |
|                                                                                                                                                                                                        |
| tail -500f $dir\_domain$var1"/servers/AdminServer/logs/log\_start.log"                                                                                                                                 |
|                                                                                                                                                                                                        |
| }                                                                                                                                                                                                      |
|                                                                                                                                                                                                        |
| unset SSH\_ASKPASS                                                                                                                                                                                     |
|                                                                                                                                                                                                        |
| export DISPLAY=""                                                                                                                                                                                      |
|                                                                                                                                                                                                        |
| export PATH=/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin:/home/oracle/scm:/home/oracle/scm/OracleClient:$HOME/scm/Git/Generate-UpdateVersionNumberTool-jar/dist:.:/usr/local/git/bin   |
+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+

Configuración el “.bashrc” para el usuario “oracle”

En el profile del usuario “oracle” editamos el “.bashrc” para agregar
algunas funciones y alias que CONSIS utiliza para agilizar el proceso de
compilación de los paquetes y despliegue de los mismos.

Esta configuración la realizamos en el archivo “.bashrc” ubicado en
“/home/oracle”

+--------------------------------------------------------------------+
| $ vi .bashrc                                                       |
|                                                                    |
| # .bashrc                                                          |
|                                                                    |
| # Source global definitions                                        |
|                                                                    |
| if [ -f /etc/bashrc ]; then                                        |
|                                                                    |
| . /etc/bashrc                                                      |
|                                                                    |
| fi                                                                 |
|                                                                    |
| # User specific aliases and functions                              |
|                                                                    |
| # set a fancy prompt (non-color, unless we know we "want" color)   |
|                                                                    |
| case "$TERM" in                                                    |
|                                                                    |
| xterm-color) color\_prompt=yes;;                                   |
|                                                                    |
| esac                                                               |
|                                                                    |
| proceso()                                                          |
|                                                                    |
| {                                                                  |
|                                                                    |
| var=$1                                                             |
|                                                                    |
| lsof -u oracle \| awk '{print$1" "$2" "$9}' \| grep "D"$var        |
|                                                                    |
| }                                                                  |
|                                                                    |
| ambientes()                                                        |
|                                                                    |
| {                                                                  |
|                                                                    |
| cat /home/scm/pto-ambientes.txt                                    |
|                                                                    |
| }                                                                  |
|                                                                    |
| portlist()                                                         |
|                                                                    |
| {                                                                  |
|                                                                    |
| cat /home/oracle/scm/port\_list.txt                                |
|                                                                    |
| }                                                                  |
|                                                                    |
| viportlist()                                                       |
|                                                                    |
| {                                                                  |
|                                                                    |
| vi /home/oracle/scm/port\_list.txt                                 |
|                                                                    |
| }                                                                  |
|                                                                    |
| zonaHoraria()                                                      |
|                                                                    |
| {                                                                  |
|                                                                    |
| system-config-date                                                 |
|                                                                    |
| }                                                                  |
|                                                                    |
| alias l="ls -ltra"                                                 |
|                                                                    |
| alias workspace="cd /home/scm/svn/workspace"                       |
|                                                                    |
| alias procesador="lscpu"                                           |
|                                                                    |
| alias usb="lsusb"                                                  |
|                                                                    |
| alias pci="lspci"                                                  |
|                                                                    |
| alias discos="lsblk"                                               |
|                                                                    |
| alias discos2="lsscsi"                                             |
|                                                                    |
| alias cpuinfo="cat /proc/cpuinfo"                                  |
|                                                                    |
| alias meminfo="cat /proc/meminfo"                                  |
|                                                                    |
| alias zoneinfo="cat /proc/zoneinfo"                                |
|                                                                    |
| alias mountinfo="cat /proc/mounts"                                 |
|                                                                    |
| alias netdata="/usr/sbin/netdata -p 999"                           |
|                                                                    |
| alias grep="grep --color"                                          |
|                                                                    |
| alias egrep="egrep --color"                                        |
|                                                                    |
| if [ -t 1 ]                                                        |
|                                                                    |
| then                                                               |
|                                                                    |
| bind -m vi-insert "\\C-l":clear-screen                             |
|                                                                    |
| fi                                                                 |
|                                                                    |
| set -o vi                                                          |
|                                                                    |
| alias SO="lsb\_release -a"                                         |
|                                                                    |
| alias releases="cat /etc/\*-release"                               |
|                                                                    |
| alias kernel="cat /etc/issue"                                      |
+--------------------------------------------------------------------+

Instalación y configuración del Agente ZABBIX

El agente lo podemos descargar de la pagina oficial de ZABBIX.
`*http://repo.zabbix.com/zabbix/3.0/rhel/7/x86\_64/* <http://repo.zabbix.com/zabbix/3.0/rhel/7/x86_64/>`__

Procedemos a instalarlo con el usuario root

+----------------------------------------------------------------------------------------------------------------------+
| # rpm -ivh /instaladores/zabbix-agent-3.0.14-1.el7.x86\_64.rpm                                                       |
|                                                                                                                      |
| warning: /instaladores/zabbix-agent-3.0.14-1.el7.x86\_64.rpm: Header V4 DSA/SHA1 Signature, key ID 79ea5ed4: NOKEY   |
|                                                                                                                      |
| Preparing... ################################# [100%]                                                                |
|                                                                                                                      |
| Updating / installing...                                                                                             |
|                                                                                                                      |
| 1:zabbix-agent-3.0.14-1.el7 ################################# [100%]                                                 |
+----------------------------------------------------------------------------------------------------------------------+

Editamos y configuramos el archivo de configuración con los siguientes
datos.

+----------------------------------------------+
| # vi /etc/zabbix/zabbix\_agentd.conf         |
|                                              |
| PidFile=/var/run/zabbix/zabbix\_agentd.pid   |
|                                              |
| LogFile=/var/log/zabbix/zabbix\_agentd.log   |
|                                              |
| LogFileSize=0                                |
|                                              |
| Server=192.168.0.21                          |
|                                              |
| ListenPort=10050                             |
|                                              |
| ListenIP=192.168.1.54                        |
|                                              |
| ServerActive=192.168.0.21                    |
|                                              |
| Hostname=srvscmlab                           |
|                                              |
| Include=/etc/zabbix/zabbix\_agentd.d/        |
+----------------------------------------------+

Editamos el archivo hosts para agregar la linea de la dirección del
ervidor ZABBIX.

+--------------------------+
| # vi /etc/hosts          |
|                          |
| 192.168.0.21 srvscmlab   |
+--------------------------+

Iniciamos el servido de ZABBIX.

+-------------------------------------------------------------+
| # /sbin/zabbix\_agentd -c /etc/zabbix/zabbix\_agentd.conf   |
+-------------------------------------------------------------+

Verificamos que este en memoria el agente del ZABBIX.

+--------------------------------------------------------------------------------------------------+
| # ps -ef \| grep zabbix                                                                          |
|                                                                                                  |
| zabbix 4980 1 0 15:45 ? 00:00:00 /sbin/zabbix\_agentd -c /etc/zabbix/zabbix\_agentd.conf         |
|                                                                                                  |
| zabbix 4981 4980 0 15:45 ? 00:00:00 /sbin/zabbix\_agentd: collector [idle 1 sec]                 |
|                                                                                                  |
| zabbix 4982 4980 0 15:45 ? 00:00:00 /sbin/zabbix\_agentd: listener #1 [waiting for connection]   |
|                                                                                                  |
| zabbix 4983 4980 0 15:45 ? 00:00:00 /sbin/zabbix\_agentd: listener #2 [waiting for connection]   |
|                                                                                                  |
| zabbix 4984 4980 0 15:45 ? 00:00:00 /sbin/zabbix\_agentd: listener #3 [waiting for connection]   |
|                                                                                                  |
| zabbix 4985 4980 0 15:45 ? 00:00:00 /sbin/zabbix\_agentd: active checks #1 [idle 1 sec]          |
+--------------------------------------------------------------------------------------------------+

Verificamos el puerto de escucha del agente del ZABBIX.

+--------------------------------------------------+
| $ netstat -nat \| grep -i listen \| grep 10050   |
|                                                  |
| tcp 0 0 192.168.1.11:10050 0.0.0.0:\* LISTEN     |
+--------------------------------------------------+

Verificamos en la herramienta del ZABBIX que el agente se este
reportando.

|image5|

Crear un script para Systemd para zabbix.

Este script nos facilita que zabbix levante de forma automática si el
servidor es reiniciado.

Creamos este archivo con este contenido

+--------------------------------------------------------------------------------------+
| [root@srvscm02 ~]# vi /usr/local/bin/zabbix.service.sh                               |
|                                                                                      |
| #!/bin/bash                                                                          |
|                                                                                      |
| start() {                                                                            |
|                                                                                      |
| /sbin/zabbix\_agentd -c /etc/zabbix/zabbix\_agentd.conf                              |
|                                                                                      |
| }                                                                                    |
|                                                                                      |
| stop() {                                                                             |
|                                                                                      |
| PROCESS=\`ps -ef \| grep zabbix\_agentd \| grep -v grep \| wc -l\`                   |
|                                                                                      |
| if [ $PROCESS -ge 1 ] ; then                                                         |
|                                                                                      |
| ps -ef \| grep zabbix\_agentd \| grep -v grep \| awk '{print $2}' \| xargs kill -9   |
|                                                                                      |
| fi                                                                                   |
|                                                                                      |
| }                                                                                    |
|                                                                                      |
| case $1 in                                                                           |
|                                                                                      |
| start\|stop) "$1"                                                                    |
|                                                                                      |
| ;;                                                                                   |
|                                                                                      |
| \*) echo "Usage <start\|stop>"                                                       |
|                                                                                      |
| ;;                                                                                   |
|                                                                                      |
| esac                                                                                 |
+--------------------------------------------------------------------------------------+

Creamos este archivo con este contenido

+------------------------------------------------------------+
| [root@srvscm02 ~]# vi /etc/systemd/system/zabbix.service   |
|                                                            |
| [Unit]                                                     |
|                                                            |
| Description=Start & Stop zabbix\_agentd                    |
|                                                            |
| [Service]                                                  |
|                                                            |
| Type=oneshot                                               |
|                                                            |
| ExecStart=/usr/local/bin/zabbix.service.sh start           |
|                                                            |
| ExecStop=/usr/local/bin/zabbix.service.sh stop             |
|                                                            |
| RemainAfterExit=yes                                        |
|                                                            |
| [Install]                                                  |
|                                                            |
| WantedBy=multi-user.target                                 |
+------------------------------------------------------------+

Habilitamos el servicio y lo iniciamos.

+--------------------------------------------------------------------------------------------------------------------------+
| [root@srvscm02 ~]# systemctl enable zabbix                                                                               |
|                                                                                                                          |
| Created symlink from /etc/systemd/system/multi-user.target.wants/zabbix.service to /etc/systemd/system/zabbix.service.   |
|                                                                                                                          |
| [root@srvscm02 ~]# systemctl status zabbix                                                                               |
|                                                                                                                          |
| [root@srvscm02 ~]# systemctl start zabbix                                                                                |
+--------------------------------------------------------------------------------------------------------------------------+

Crear un script para Systemd para openvpn.

Este script nos facilita que openvpn levante de forma automática si el
servidor es reiniciado.

Creamos este archivo con este contenido

+------------------------------------------------------------------------------------------+
| #!/bin/bash                                                                              |
|                                                                                          |
| start() {                                                                                |
|                                                                                          |
| /bin/nohup /sbin/openvpn /instaladores/VPN/consis-colombia.ovpn > /var/log/openvpnmy &   |
|                                                                                          |
| echo $! > /run/openvpnmy.pid                                                             |
|                                                                                          |
| echo "Paso el por el PID"                                                                |
|                                                                                          |
| sleep 5                                                                                  |
|                                                                                          |
| route add -net 192.168.1.0/24 gw 192.168.1.5 dev em1                                     |
|                                                                                          |
| route del -net 192.168.1.0/24 gw 192.168.120.157 dev tun0                                |
|                                                                                          |
| }                                                                                        |
|                                                                                          |
| stop() {                                                                                 |
|                                                                                          |
| PROCESS=\`ps -ef \| grep openvpn \| grep -v grep \| wc -l\`                              |
|                                                                                          |
| echo "i$PROCESS"                                                                         |
|                                                                                          |
| if [ $PROCESS -ge 1 ] ; then                                                             |
|                                                                                          |
| ps -ef \| grep openvpn \| grep -v grep \| awk '{print $2}' \| xargs kill -9              |
|                                                                                          |
| fi                                                                                       |
|                                                                                          |
| }                                                                                        |
|                                                                                          |
| case $1 in                                                                               |
|                                                                                          |
| start\|stop) "$1"                                                                        |
|                                                                                          |
| ;;                                                                                       |
|                                                                                          |
| \*) echo "Usage <start\|stop>"                                                           |
|                                                                                          |
| ;;                                                                                       |
|                                                                                          |
| esac                                                                                     |
+------------------------------------------------------------------------------------------+

Creamos este archivo con este contenido

+-------------------------------------------------------------+
| [root@srvscm02 ~]# vi /etc/systemd/system/openvpn.service   |
|                                                             |
| [Unit]                                                      |
|                                                             |
| Description=OpenVPN start and stop                          |
|                                                             |
| [Service]                                                   |
|                                                             |
| Type=oneshot                                                |
|                                                             |
| ExecStart=/usr/local/bin/openvpn.service.sh start           |
|                                                             |
| ExecStop=/usr/local/bin/openvpn.service.sh stop             |
|                                                             |
| RemainAfterExit=yes                                         |
|                                                             |
| [Install]                                                   |
|                                                             |
| WantedBy=multi-user.target                                  |
+-------------------------------------------------------------+

Habilitamos el servicio y lo iniciamos.

+----------------------------------------------------------------------------------------------------------------------------+
| [root@srvscm02 ~]# systemctl enable openvpn                                                                                |
|                                                                                                                            |
| Created symlink from /etc/systemd/system/multi-user.target.wants/openvpn.service to /etc/systemd/system/openvpn.service.   |
|                                                                                                                            |
| [root@srvscm02 ~]# systemctl status openvpn                                                                                |
|                                                                                                                            |
| [root@srvscm02 ~]# systemctl start openvpn                                                                                 |
+----------------------------------------------------------------------------------------------------------------------------+

Instalar Apache Tomcat Version 7.0.64.

Instalamos el tomcat en “/scm/apache” y es básicamente utilizado para la
URL
`*http://srvscm/monitor/Estado.php* <http://srvscm/monitor/Estado.php>`__

pueda mostrar los “logs portinfo branch\_UDP”

Esta configuración la hacemos por el puerto 8000

Configurar en el crontab la ejecución web\_portinf.sh

Este script es el que va alimentar los directorios ““logs portinfo
branch\_UDP” que son utilizados por el tomcat

/scm/scripts/web\_portinf.sh

Para que tomcat permita los symlink debemos editar el “context.xml” y
agregar el siguiente parámetro “allowLinking="true">”

+---------------------------------------------------------------------------------+
| <Context **allowLinking="true"**>                                               |
|                                                                                 |
| <!-- Default set of monitored resources -->                                     |
|                                                                                 |
| <WatchedResource>WEB-INF/web.xml</WatchedResource>                              |
|                                                                                 |
| <!-- Uncomment this to disable session persistence across Tomcat restarts -->   |
|                                                                                 |
| <!--                                                                            |
|                                                                                 |
| <Manager pathname="" />                                                         |
|                                                                                 |
| -->                                                                             |
|                                                                                 |
| <!-- Uncomment this to enable Comet connection tacking (provides events         |
|                                                                                 |
| on session expiration as well as webapp lifecycle) -->                          |
|                                                                                 |
| <!--                                                                            |
|                                                                                 |
| <Valve className="org.apache.catalina.valves.CometConnectionManagerValve" />    |
|                                                                                 |
| -->                                                                             |
|                                                                                 |
| <!--allowLinking="true"/-->                                                     |
|                                                                                 |
| </Context>                                                                      |
+---------------------------------------------------------------------------------+

.. |image0| image:: media/image3.wmf
   :width: 1.67708in
   :height: 0.11389in
.. |image1| image:: media/image4.wmf
   :width: 1.17639in
   :height: 0.11389in
.. |image2| image:: media/image5.wmf
   :width: 1.67708in
   :height: 0.11389in
.. |image3| image:: media/image6.wmf
   :width: 1.17639in
   :height: 0.11389in
.. |image4| image:: media/image11.png
   :width: 2.77083in
   :height: 3.09375in
.. |image5| image:: media/image12.png
   :width: 7.78264in
   :height: 2.74028in
