connect-viserver kimvc55 -user kzlsrvc-veeam
Get-VM | Where-Object {$_.Extensiondata.Runtime.ConsolidationNeeded}