<#
.DESCRIPTION
Hosts a PowerShell Web server
#>
 
function Write-LogToFile {
    param(
        [parameter(Mandatory = $true)]
        [object] $logMessage
    )
    $logMessage | Out-File $logFilePath -Append
}

Clear-Host

# create http Server
$http = [System.Net.HttpListener]::new() 

# hostname and port to listen on
$http.Prefixes.Add("https://SERVERNAME.DOMAIN.com:8443/")

# start the http Server 
$http.Start()

# log ready message to terminal 
if ($http.IsListening) {
    Write-Host " HTTP Server Ready!  " -f 'black' -b 'gre'
    Write-Host "Listening on $($http.Prefixes)" -f 'y'
} 

while ($http.IsListening) {
    $context = $http.GetContext()

    $logFilePath = "C:\temp\powershell_web_server\$(get-date -f yyy-MM-dd_hh-mm-ss).log"
    
    if ($context.Request.HttpMethod -eq 'DELETE') {
        $http.Close()
    }

    if ($context.Request.HttpMethod -eq 'POST') {
        # decode the form post
        $formContent = [System.IO.StreamReader]::new($context.Request.InputStream).ReadToEnd()

        Write-Host "$($context.Request.UserHostAddress)  =>  $($context.Request.Url)" -ForegroundColor Magenta

        Write-LogToFile $formContent

        # process stuff

        # respond to the request
        $buffer = [System.Text.Encoding]::UTF8.GetBytes("Done")
        $context.Response.ContentLength64 = $buffer.Length
        $context.Response.OutputStream.Write($buffer, 0, $buffer.Length)
        $context.Response.OutputStream.Close()

        Write-Host "Request complete" -ForegroundColor Green
    }
} 
