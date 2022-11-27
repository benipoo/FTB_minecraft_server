@echo off
IF EXIST eula.txt (
  goto CHECKEULA
) ELSE (
  goto ASKEULA
)
IF %errlevel% EQU 1 goto END
:CHECKEULA
>nul find "eula=false" eula.txt && (
  goto ASKEULA
) || (
  goto END
)
:ASKEULA
echo "Do you agree to the Mojang EULA available at https://account.mojang.com/documents/minecraft_eula ?"
set /p EULA=[y/n]
IF /I "%EULA%" NEQ "y" GOTO END
echo eula=true>eula.txt
:END
start "FTB Server" "jre\jdk8u312-b07-jre\bin\java.exe" -javaagent:log4jfix/Log4jPatcher-1.0.0.jar -Xms16g -Xmx16g -XX:+UseShenandoahGC -XX:+AggressiveOpts -XX:+UnlockExperimentalVMOptions -XX:+AlwaysPreTouch -XX:+UseStringDeduplication -Dfml.ignorePatchDiscrepancies=true -Dfml.ignoreInvalidMinecraftCertificates=true -XX:-OmitStackTraceInFastThrow -XX:+OptimizeStringConcat -Dfml.readTimeout=180 -XX:+UseFastAccessorMethods -jar forge-1.12.2-14.23.5.2858.jar nogui