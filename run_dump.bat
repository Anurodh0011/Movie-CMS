@echo off
C:\Windows\Microsoft.NET\Framework64\v4.0.30319\csc.exe dump_schema.cs /r:System.Data.dll /r:System.Data.OracleClient.dll /r:System.Xml.dll /r:System.Configuration.dll
if %errorlevel% neq 0 exit /b %errorlevel%
dump_schema.exe
