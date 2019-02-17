#5.	Создать конфигурацию сессии с целью ограничения использования всех команд, кроме просмотра содержимого дисков.

######### Это прописываем на удаленном хосте ##############
Param (
$path="C:"
       )
if (Test-Path $path)
{
New-PSSessionConfigurationFile -Path $path\Danilau.pssc -VisibleCmdlets get-childitem, dir, ls, Get-Help, Exit-PSSession, Get-Command, Get-FormatData, Measure-Object, Out-Default, Select-Object
Test-PSSessionConfigurationFile $path\Danilau.pssc
}
else
{
Write-Output "Directory doesn't exist"
}
$cred = get-credential administrator
Register-PSSessionConfiguration -Name DanilauSes -Path $path\Danilau.pssc -RunAsCredential $cred -ShowSecurityDescriptorUI -Force

#Get-PSSessionConfiguration -Name * 
#Unregister-PSSessionConfiguration -Name DanilauSes

######################        #######################################

###################### Теперь команду вводим на хосте с которого ходим устанавливать сессию ###############

Enter-PSSession -ComputerName VM2 -Credential $cred -ConfigurationName DanilauSes 
#Exit-PSSession