function Get-NinjaOneTime {
    [CmdletBinding()]
    param (
        [Parameter(Position = 0, Mandatory = $false)]
        [DateTime]$Date = (Get-Date), # Use current date by default
        [Switch]$Seconds
    )

    $unixEpoch = Get-Date -Year 1970 -Month 1 -Day 1 -Hour 0 -Minute 0 -Second 0 -Millisecond 0
    $timeSpan = $Date.ToUniversalTime() - $unixEpoch

    if ($Seconds) {
        return [int64]([math]::Round($timeSpan.TotalSeconds))
    } else {
        return [int64]([math]::Round($timeSpan.TotalMilliSeconds))
    }
}