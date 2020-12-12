<#
.DESCRIPTION
Run a SQL server query

.PARAMETER query
Query to run
Example: "select top 10 * from [DB].[dbo].[TABLE] where cre_ts > GETDATE()"

.PARAMETER connectionString
Connection string to database
Example: "Data Source = SERVER_NAME\INSTANCE_NAME; Integrated Security = SSPI;"
#>
[CmdletBinding()]
param (
    [Parameter(Mandatory = $true)]
    [string]
    $query,
    [Parameter(Mandatory = $true)]
    [string]
    $connectionString
)

Clear-Host

Try {
    # create new connection to database
    Write-Host "Creating database connection"
    $connection = New-Object System.Data.SqlClient.SQLConnection($connectionString)

    # create sql command
    Write-Host "Executing SQL command"
    $command = New-Object System.Data.SqlClient.SqlCommand($query, $connection)

    # create sql adapter to fill results
    $adapter = New-Object System.Data.SqlClient.SqlDataAdapter($command)

    # create empty data set for results
    $dataSet = New-Object System.Data.DataSet

    # fill the dataset
    Write-Host "Filling dataset"
    $adapter.Fill($dataSet) | Out-Null

    # close the connection
    Write-Host "Closing connection"
    $connection.Close()

    # create variable for temp path to export CSV
    $guid = New-Guid
    $tempPath = "C:\temp\$guid.csv"

    # if no data was returned from query, exit script
    If ($dataset.Tables[0].Rows.Count -eq 0) { 
        Write-Host "No data returned"
        Exit 0
    }

    # export to csv
    Write-Host "Exportint to $tempPath"
    $dataset.Tables[0] | Export-Csv -Path $tempPath -NoTypeInformation
}
Catch {
    $_
    Exit 1
}