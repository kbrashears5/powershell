<#
.DESCRIPTION
Gets all the COM objects on the local machine and outputs them to a file
#>
Get-ChildItem HKLM:\Software\Classes -ea 0 | Where-Object { $_.PSChildName -match '^\w+\.\w+$' -and (Get-ItemProperty "$($_.PSPath)\CLSID" -ea 0) } | Format-Table PSChildName | Out-File 'C:\temp\COMObjects.txt'