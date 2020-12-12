<#
.DESCRIPTION
Log to the console with timestamp, tabs, and color

.PARAMETER message
Message to write to console

.PARAMETER tabs
Number of tabs to prefix the message. Default 0

.PARAMETER color
Color of the message. Default White
#>
function Log() {
    Param(
        [parameter(Mandatory = $true)]
        [string]
        $message,
        [parameter(Mandatory = $false)]
        [int]
        $tabs = 0,
        [parameter(Mandatory = $false)]
        [string]
        $color = "White"
    )

    # get timestamp
    $timeStamp = Get-Date -Format g

    # create base message
    $baseMessage = "$timestamp"
    
    # add appropiate number of tabs
    For ($i = 0; $i -lt $tabs; $i++) {
        $baseMessage += "`t"
    }
    
    # write to console
    Write-Host "$baseMessage$message" -ForegroundColor $color 
}