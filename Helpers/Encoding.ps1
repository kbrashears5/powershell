function Convert-ByteArrayToHex {
    param(
        [parameter(Mandatory = $true)]
        [Byte[]] $bytes
    )
    $hex = [System.Text.StringBuilder]::new($bytes.Length * 2)

    ForEach ($byte in $bytes) {
        $hex.AppendFormat("{0:x2}", $byte) | Out-Null
    }

    Write-LogToFile $hex.ToString()
    $hex.ToString()
}

function Convert-HexToByteArray {
    param(
        [parameter(Mandatory = $true)]
        [String] $hex
    )
    $bytes = [byte[]]::new($hex.Length / 2)

    For ($i = 0; $i -lt $hex.Length; $i += 2) {
        $bytes[$i / 2] = [convert]::ToByte($hex.Substring($i, 2), 16)
    }

    Write-LogToFile $bytes
    $bytes
}