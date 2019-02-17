#3.	Настроить PowerShell Remoting, для управления всеми виртуальными машинами с хостовой.

#$VM=@("VM1","VM2","VM3")
$cred = get-credential administrator #учетная запись администратора (одинаковая на всех VM)
Enter-PSSession -ComputerName VM2 -Credential $cred  #имя нужной машины вводим руками!

#Exit-PSSession