#1.	При помощи WMI перезагрузить все виртуальные машины.

$cred = get-credential administrator #учетная запись администратора (одинаковая на всех VM)
$VM=@("VM1","VM2","VM3") #перечень VM
    #Set-Item WSMan:\localhost\Client\TrustedHosts -Value $VM # добавили в хорошеизвестные на Хосте
Get-WmiObject win32_operatingsystem -ComputerName $VM -Credential $cred | Invoke-WMIMethod -name Reboot #перезагрузили