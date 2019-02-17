#1.	При помощи WMI перезагрузить все виртуальные машины.
$cred = get-credential administrator #учетная запись администратора (одинаковая на всех VM)
$VM=@("VM1","VM2","VM3") #перечень VM
    #Set-Item WSMan:\localhost\Client\TrustedHosts -Value $VM # добавили в хорошеизвестные на Хосте
Get-WmiObject win32_operatingsystem -ComputerName $VM -Credential $cred | Invoke-WMIMethod -name Reboot #перезагрузили


#2.	При помощи WMI просмотреть список запущенных служб на удаленном компьютере. 
#Set-Item WSMan:\localhost\Client\TrustedHosts -Value $VM # добавили в хорошеизвестные на Хосте
$cred = get-credential administrator #учетная запись администратора (одинаковая на всех VM)
#$VM=@("VM1","VM2","VM3") #перечень VM
gwmi win32_service  -ComputerName VM1 -Credential $cred | where state -eq running |ft #берем запущенные службы


#3.	Настроить PowerShell Remoting, для управления всеми виртуальными машинами с хостовой.
#$VM=@("VM1","VM2","VM3")
$cred = get-credential administrator #учетная запись администратора (одинаковая на всех VM)
Enter-PSSession -ComputerName VM2 -Credential $cred  #имя нужной машины вводим руками!
#Exit-PSSession


#4.	Для одной из виртуальных машин установить для прослушивания порт 42658. 
#Проверить работоспособность PS Remoting.
Set-Item WSMan:\localhost\listener\listener*\port -Value 42658 #команду прописываем на удаленной машине (я прописал на VM1)
Invoke-Command -ScriptBlock {Get-Service} -ComputerName VM1 -Credential administrator -Port 42658 #для проверки 


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