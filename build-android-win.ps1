# -----------------------------------------------------------------------------
# Este script gera um Android APK Debug nao assinado
# 
# Requisitos:
# * Ter instalado o JAVA SDK 17 ou 21, e configurado a variavel de ambiente JAVA_HOME
#   consulte:
#       https://adoptium.net/installation/
#       https://diegocastro.ar/how-to-properly-install-temurin-jdk-with-update-alternatives/
#       https://www.edivaldobrito.com.br/como-instalar-o-java-no-ubuntu-24-04-lts-e-derivados/
#
#   consulte também a tabela de compatibilidade entre Gradle e a versão do JAVA
#       https://docs.gradle.org/current/userguide/compatibility.html
#
#
# * Ter instalado as ferramentas de linha de comando do Android SDK, 
#   e configurado a variavel de ambiente ANDROID_SDK_ROOT
#   consulte: 
#       https://thanhtunguet.info/posts/how-to-install-android-sdk-android-cmdline-tools-without-android-studio/
#       https://developer.android.com/tools/sdkmanager
#
# -----------------------------------------------------------------------------

$StartTime = $(get-date)
Write-Host "Stage - Build Android ---------------------------------------------------------"

try {
    Set-Location .\android\
    $env:JAVA_HOME = 'C:\programas\java\jdk21' # JAVA21
    $env:ANDROID_HOME = 'C:\programas\Android\SDK\'
    
    Write-Host "Starting Android APK Debug Build -------------------------------------------"
    $cmd = ".\gradlew.bat assembleAppstoreDebug --stacktrace"
    Invoke-Expression $cmd
    Write-Host "Android APK Build Debug Complete."

    # Write-Host "Starting Android MIN Debug Build ------------------------------------------"
    # $cmd = ".\gradlew.bat assembleDevDebug --stacktrace"
    # Invoke-Expression $cmd
    # Write-Host "Android MIN Build Debug Complete."

    # Write-Host "Starting Android APK Release Build -----------------------------------------"
    # $cmd = ".\gradlew.bat assembleAppstoreRelease --stacktrace"
    # Invoke-Expression $cmd
    # Write-Host "Android APK Build Release Complete."

    # Write-Host "Starting Android AAB Release Unsigned Build -------------------------------"
    # $cmd = ".\gradlew.bat bundleAppstoreRelease --stacktrace"
    # Invoke-Expression $cmd
    # Write-Host "Android AAB Build Release Unsigned Complete."
}
catch {
    Write-Error "Error when executing Gradle"
}

Set-Location .\..\
$elapsedTime = $(get-date) - $StartTime
Write-Host "Elapsed Time: $elapsedTime"
exit $LASTEXITCODE # 0 for success and 1 for failure
