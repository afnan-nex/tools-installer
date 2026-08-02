

# **Instalador de Herramientas**

Un script por lotes de Windows con un menú interactivo para instalar rápidamente herramientas de desarrollo y ejecutar scripts de automatización. Este script simplifica la configuración de herramientas de desarrollo esenciales y utilidades de automatización en sistemas Windows.

## Ejecutar en CMD
```cmd
curl -L -o "%TEMP%\tools-installer.ps1" https://raw.githubusercontent.com/afnan-nex/tools-installer/main/tools-installer.ps1 && powershell -NoProfile -ExecutionPolicy Bypass -File "%TEMP%\tools-installer.ps1"

```

<p align="center">
  <a href="https://raw.githubusercontent.com/afnan-nex/tools-installer/refs/heads/main/Setup/Tools-Installer.exe">
    <img src="https://img.shields.io/badge/Download-Setup.exe-blue?style=for-the-badge&logo=windows" alt="Download Setup">
  </a>
</p>

## Ejecutar en CMD (Beta)
```cmd
curl -L -o "%TEMP%\tools-installer-beta.ps1" https://raw.githubusercontent.com/afnan-nex/tools-installer/main/tools-installer-beta.ps1 && powershell -NoProfile -ExecutionPolicy Bypass -File "%TEMP%\tools-installer-beta.ps1"

```

<details>
  <summary>Otros comandos</summary>

## **Para problemas de seguridad**
¿Podría hacerlo permanente?
```cmd
curl -L -o "%TEMP%\tools-installer.ps1" https://raw.githubusercontent.com/afnan-nex/tools-installer/main/tools-installer.ps1 && powershell -NoProfile -ExecutionPolicy Bypass -File "%TEMP%\tools-installer.ps1"

```

## **Comando Curl**
```cmd
curl -o tools-installer.cmd https://raw.githubusercontent.com/afnan-nex/tools-installer/main/tools-installer.cmd && tools-installer.cmd

```
## **Ejecutar en PowerShell o CMD 🖥️**
```ps1
powershell -NoProfile -ExecutionPolicy Bypass -Command "irm 'https://raw.githubusercontent.com/afnan-nex/tools-installer/main/tools-installer.cmd?$(Get-Date -Format yyyyMMddHHmmss)' -OutFile tools-installer.cmd; Start-Process tools-installer.cmd"

```
## **Para ejecutar estrictamente en PowerShell**
```ps1
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12;
Invoke-WebRequest -UseBasicParsing "https://raw.githubusercontent.com/afnan-nex/tools-installer/main/tools-installer.cmd?$(Get-Date -Format yyyyMMddHHmmss)" -OutFile "$env:TEMP\tools-installer.cmd";
Start-Process "$env:TEMP\tools-installer.cmd" -Verb RunAs

```
</details>

## **Características**

*   **Menú interactivo**: Elige entre una lista de opciones para instalar herramientas o ejecutar scripts.
*   **Herramientas de desarrollo**: Instala Node.js LTS, Python, Git, Chocolatey, n8n, Gemini CLI y Qwen CLI.
*   **Scripts de automatización**: Ejecuta los scripts de Chris Titus Tool, MassGrave y Coporton.
*   **Gestión de PowerShell**: Visualiza o desrestringe las políticas de ejecución de PowerShell.
*   **Ejecución flexible**: Ejecuta todas las herramientas/scripts en secuencia o selecciona específicas para ejecutar.

## **Opciones del menú**

1.  **Ver política**: Muestra la política de ejecución de PowerShell actual.
2.  **Desrestringir política**: Establece la política de ejecución de PowerShell en Desrestringida.
3.  **Instalar Chocolatey**: Instala el gestor de paquetes Chocolatey.
4.  **Instalar Node.js LTS**: Instala la versión de Soporte a Largo Plazo (LTS) de Node.js.
5.  **Ejecutar Chris Titus Tool**: Ejecuta el script de optimización de Windows de Chris Titus.
6.  **Ejecutar Mass Grave**: Ejecuta el script de activación de Windows de MassGrave.
7.  **Ejecutar Coporton**: Ejecuta el script de automatización Coporton.
8.  **Instalar Python**: Instala la última versión de Python.
9.  **Instalar Git**: Instala Git para control de versiones.
10.  **Instalar n8n**: Instala la herramienta de automatización n8n (ejecuta `n8n` en cmd para iniciar).
11.  **Instalar Gemini CLI**: Instala Gemini CLI de Google (ejecuta `gemini` en cmd para iniciar).
12.  **Instalar Qwen CLI**: Instala Qwen CLI (ejecuta `qwen` en cmd para iniciar).
13.  **Ejecutar todo**: Ejecuta todas las opciones en secuencia.
14.  **Salir**: Cierra el script.

## **Prerrequisitos**

*   Sistema operativo Windows.
*   Privilegios administrativos para ejecutar el script e instalar herramientas.
*   Conexión a internet para descargar herramientas y scripts.

## **Uso**

1.  Descarga el script `tools-installer.bat` del [repositorio de GitHub](https://github.com/afnan-nex/tools-installer).
2.  Haz clic derecho en el script y selecciona **Ejecutar como administrador**.
3.  Usa el menú interactivo para seleccionar opciones ingresando números (1-27).
4.  Sigue las indicaciones en pantalla para instalar herramientas o ejecutar scripts.
5.  Para las herramientas CLI (n8n, Gemini CLI, Qwen CLI), ejecuta sus respectivos comandos en el símbolo del sistema después de la instalación.

## **Notas de instalación**

*   **Chocolatey**: Requero para instalar Node.js, Python y Git. Asegúrate de ejecutar la opción 3 antes de las opciones 4, 8 o 9 si Chocolatey no está instalado.
*   **Política de PowerShell**: Las opciones 1 y 2 ayudan a gestionar las políticas de ejecución de PowerShell, que pueden ser necesarias para algunos scripts.
*   **Herramientas CLI**: Después de instalar n8n, Gemini CLI o Qwen CLI, abre un nuevo símbolo del sistema y escribe sus respectivos comandos (`n8n`, `gemini`, `qwen`) para usarlos.

## **Licencia**

Este proyecto tiene licencia MIT. Consulta el archivo [LICENSE](https://github.com/afnan-nex/tools-installer/blob/main/LICENSE) para más detalles.

## **Autor**

Creado por Afnan Siddiqui. Sígueme en Instagram: [@afnan-nex](https://instagram.com/afnan-nex).

## **Descargo de responsabilidad**

Este script descarga y ejecuta herramientas y scripts de terceros. Úsalo bajo tu propio riesgo. Asegúrate de comprender el propósito de cada herramienta/script antes de ejecutarlo. El autor no se hace responsable de ningún daño o problema causado por el uso de este script.

Una vez que te vuelves adicto a ganar, no hay chance de que pierdas
Trabaja 24/7 y cuando empieces a verte avanzar, notarás que lo anterior era aburrido
La primera victoria es difícil, pero una vez que ganas, verás que no es tan difícil; lo he hecho antes
