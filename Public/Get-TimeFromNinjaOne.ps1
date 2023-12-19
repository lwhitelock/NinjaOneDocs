function Get-TimeFromNinjaOne {
    [CmdletBinding()]
    param (
        [Parameter(Position = 0, Mandatory = $false)]
        [int64]$Date,
        [Switch]$Seconds
    )

    $unixEpoch = Get-Date -Year 1970 -Month 1 -Day 1 -Hour 0 -Minute 0 -Second 0 -Millisecond 0

    if ($Seconds) {
        $ReturnDate = $unixEpoch.AddSeconds($Date)
    } else {
        $ReturnDate = $unixEpoch.AddMilliseconds($Date)
    }
    
    Return $ReturnDate

}