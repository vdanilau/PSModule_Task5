#2.	При помощи WMI просмотреть список запущенных служб на удаленном компьютере. 

#Set-Item WSMan:\localhost\Client\TrustedHosts -Value $VM # добавили в хорошеизвестные на Хосте
$cred = get-credential administrator #учетная запись администратора (одинаковая на всех VM)
#$VM=@("VM1","VM2","VM3") #перечень VM
gwmi win32_service  -ComputerName VM1 -Credential $cred | where state -eq running |ft #берем запущенные службы



