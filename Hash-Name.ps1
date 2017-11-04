[CmdletBinding()]
param(
    [string]$name = "Greg Dryke"
)

function Main()
{
    $nameNoSpaces = $name -replace '\s',''
    $name
    $enc = [system.Text.Encoding]::UTF8
    $bytes = $enc.GetBytes($nameNoSpaces)
    Write-Verbose ""

    $start = [int]$bytes[0]
    $fixedHex = 16777215
    for ($i = 1; $i -lt $bytes.Length ; $i++)
    {
        Write-Verbose ("Current number.`n`t Int: {0}, bin: {1}" -f $start, [Convert]::ToString($start, 2))
        
        #Works pretty well!
        #   $start = (($start -shl ($bytes[$i] % 8) -bor $bytes[$i]) -band $fixedHex)
        #$start = $start -bor $bytes[$i] -shl ($bytes[$i] % 8) -shr ($bytes[$i] % 3)
        $start = $start -shl ($bytes[$i] % 8) -shr ($bytes[$i] % 5) -bor $bytes[$i]

        # k is weird and resets?? $start = ((($start -bor $bytes[$i]) -shl $bytes[$i] % 16)  -band $fixedHex)
        #$start = ((($start -bor $bytes[$i]) -shl $bytes[$i] % 32)  -band $fixedHex)
        # only uses last 5 characters? $start = (($start -shl ($bytes[$i] % 16) -bor $bytes[$i]) -band $fixedHex)
        
        Write-Verbose ("Letter: {0} Byte: {1} bin: {2}" -f $nameNoSpaces[$i], $bytes[$i], [Convert]::ToString($bytes[$i], 2))

        Write-Verbose ("AFter number.`n`t Int: {0}, bin: {1}" -f $start, [Convert]::ToString($start, 2))
    }
    $start = $start -band $fixedHex
    Write-Host ("{0:X6}" -f $start)
}

function Shift-LeftAndOr()
{

}

Main
