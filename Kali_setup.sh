#!/bin/bash

echo "[Started] Burp Suite Pro by LTP #lucthienphong1120"

if [[ $EUID -eq 0 ]]; then
    echo "Checking JDK-18 Availability . . ."
    jdkVersion=$(dpkg-query -W -f='${Version}' openjdk-11-jdk)
    echo "jdk version: $jdkVersion"
    if [[ "$jdkVersion" < "18" ]]; then
        echo "Error: JDK-18 or higher is not installed. Please install JDK-18 or a higher version."
        read -p "Press enter to exit"
        exit 1
    fi

    echo "Checking JRE-8 Availability . . ."
    jreVersion=$(dpkg-query -W -f='${Version}' openjdk-11-jre)
    echo "jre version: $jreVersion"
    if [[ "$jreVersion" < "8" ]]; then
        echo "Error: JRE-8 or higher is not installed. Please install JRE-8 or a higher version."
        read -p "Press enter to exit"
        exit 1
    fi

    echo "1. Burp Suite Professional 2022.8.2"
    echo "2. Burp Suite Professional 2022.3.9"
    read -p "Choose your version: " version
    case $version in
        1)
            burpFile="burpsuite_pro_v2022.8.2.jar"
            ;;
        2)
            burpFile="burpsuite_pro_v2022.3.9.jar"
            ;;
        *)
            read -p "Invalid selection. Please choose a valid option."
            exit 1
            ;;
    esac

    echo "Creating Burp Suite Pro with shortcut execute command . . ."
    echo "java -noverify --illegal-access=permit -Dfile.encoding=utf-8 -javaagent:$(pwd)/burploader.jar -jar $(pwd)/$burpFile &" > burp
    chmod +x burp
    cp burp /bin/burp 
    (./burp)

else
    echo "Execute Command as Root User"
    exit
fi

echo "[Finished] Burp Suite Pro by LTP #lucthienphong1120"
echo "Please give a star if you feel it useful"