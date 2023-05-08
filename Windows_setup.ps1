Write-Host "[Started] Burp Suite Pro by LTP #lucthienphong1120"
Set-ExecutionPolicy -ExecutionPolicy bypass -Scope process
$ProgressPreference = 'SilentlyContinue'

Write-Host "Checking JDK-18 Availability . . ."
$jdkVersion = (Get-WmiObject -Class Win32_Product -Filter "Vendor='Oracle Corporation' AND Name LIKE 'Java(TM) SE Development Kit %'").Version
Write-Host "jdk version: " + $jdkVersion
if ($jdkVersion -lt "18") {
    Write-Host "Error: JDK-18 or higher is not installed. Please install JDK-18 or a higher version."
    Read-Host "Press any key to exit"
    return
}

Write-Host "Checking JRE-8 Availability . . ."
$jreVersion = (Get-WmiObject -Class Win32_Product -Filter "Vendor='Oracle Corporation' AND Name LIKE 'Java % Update %'").Version
Write-Host "jre version: " + $jreVersion
if ($jreVersion -lt "8") {
    Write-Host "Error: JRE-8 or higher is not installed. Please install JRE-8 or a higher version."
    Read-Host "Press any key to exit"
    return
}

Write-Host "1. Burp Suite Professional 2022.8.2"
Write-Host "2. Burp Suite Professional 2022.3.9"
switch (Read-Host "Choose your version: ") {
    "1" {
        $burpFile = "burpsuite_pro_v2022.8.2.jar"
    }
    "2" {
        $burpFile = "burpsuite_pro_v2022.3.9.jar"
    }
    default {
        Read-Host "Invalid selection. Please choose a valid option."
        return
    }
}

Write-Host "Creating run.bat with execution command . . ."
if (-not (Test-Path run.bat)) {
    New-Item -Path run.bat -ItemType File
}
$runCmd = "java -noverify -javaagent:`"$pwd\burploader.jar`" --add-opens=java.base/java.lang=ALL-UNNAMED --add-opens=java.desktop/javax.swing=ALL-UNNAMED -jar `"$pwd\$burpFile`""
Set-Content -Path run.bat -Value $runCmd

Write-Host "Creating Burp Suite Pro.vbs with shortcut execute . . ."
if (-not (Test-Path "Burp Suite Pro.vbs")) {
    New-Item -Path "Burp Suite Pro.vbs" -ItemType File
}
$script = @"
Set objShell = CreateObject("Wscript.Shell")
objShell.Run `"$pwd\run.bat`", 0
Set objShell = Nothing
"@
Set-Content -Path "Burp Suite Pro.vbs" -Value $script

Write-Host "[Finished] Burp Suite Pro by LTP #lucthienphong1120"
Read-Host "Please give a star if you feel it useful"