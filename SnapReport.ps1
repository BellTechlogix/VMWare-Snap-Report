##Add Code Here##
Get-Module –ListAvailable VM* | Import-Module

Connect-VIServer -Server JAXVC01

Get-VM | where {$_.ExtensionData.Runtime.consolidationNeeded} | Select Name | export-csv .\JAXVC01.ConsolidationNeeded.csv -notype

get-vm | get-snapshot | Select-Object -Property vm,created,sizeGB,name,description | Export-Csv -Path .\JAXVC01.ActiveSnaps.csv -notype

Disconnect-VIServer -Server JAXVC01 -Force -confirm:$false

Connect-VIServer -Server SEAA1-VCA01

Get-VM | where {$_.ExtensionData.Runtime.consolidationNeeded} | Select Name | export-csv .\SEAA1-VCA01.ConsolidationNeeded.csv -notype

get-vm | get-snapshot | Select-Object -Property vm,created,sizeGB,name,description | Export-Csv -Path .\SEAA1-VCA01.ActiveSnaps.csv -notype

Disconnect-VIServer -Server SEAA1-VCA01 -Force -confirm:$false

Connect-VIServer -Server ANCVCA01

Get-VM | where {$_.ExtensionData.Runtime.consolidationNeeded} | Select Name | export-csv .\ANCVCA01.ConsolidationNeeded.csv -notype

get-vm | get-snapshot | Select-Object -Property vm,created,sizeGB,name,description | Export-Csv -Path .\ANCVCA01.ActiveSnaps.csv -notype

Disconnect-VIServer -Server ANCVCA01 -Force -confirm:$false

Connect-VIServer -Server 10.120.51.233

Get-VM | where {$_.ExtensionData.Runtime.consolidationNeeded} | Select Name | export-csv .\HOUSTON.BYIP.ConsolidationNeeded.csv -notype

get-vm | get-snapshot | Select-Object -Property vm,created,sizeGB,name,description | Export-Csv -Path .\HOUSTON.BYIP.ActiveSnaps.csv -notype

Disconnect-VIServer -Server 10.120.51.233 -Force -confirm:$false



Send-MailMessage -from 9johnst@crowley.com -to tjohnson@belltechlogix.com -subject "CRO Weekly Snap Report" -smtpserver jaxmsg12.crowley.com -attachments JAXVC01.ActiveSnaps.csv,JAXVC01.ConsolidationNeeded.csv,SEAA1-VCA01.ConsolidationNeeded.csv,SEAA1-VCA01.ActiveSnaps.csv,ANCVCA01.ConsolidationNeeded.csv,ANCVCA01.ActiveSnaps.csv,HOUSTON.BYIP.ConsolidationNeeded.csv,HOUSTON.BYIP.ActiveSnaps.csv
