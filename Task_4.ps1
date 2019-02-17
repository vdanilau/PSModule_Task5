#4.	Для одной из виртуальных машин установить для прослушивания порт 42658. 
#Проверить работоспособность PS Remoting.

Set-Item WSMan:\localhost\listener\listener*\port -Value 42658 #команду прописываем на удаленной машине (я прописал на VM1)
Invoke-Command -ScriptBlock {Get-Service} -ComputerName VM1 -Credential administrator -Port 42658 #для проверки 
