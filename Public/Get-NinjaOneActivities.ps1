function Get-NinjaOneActivities($QueryParams) {
    $ParsedQuery = if ($QueryParams) {
        "$($QueryParams)&"
    } else {
        ''
    }

    $PageSize = 1000

    [System.Collections.Generic.List[PSCustomObject]]$ReturnActivities = (Invoke-NinjaOneRequest -Method GET -Path 'activities' -QueryParams "$($ParsedQuery)pageSize=$PageSize").activities
    $Count = ($Activities.id | measure-object -Minimum).minimum  
    $Found = $False

    do {

        $Result = Invoke-NinjaOneRequest -Method GET -Path 'activities' -QueryParams "$($ParsedQuery)pageSize=$($PageSize)&olderThan=$($Count)"
    
        if (($Result.Activities | Measure-Object).count -gt 0) {
            $ReturnActivities.AddRange([System.Collections.Generic.List[PSCustomObject]]$Result.Activities)
            $Count = ($Result.Activities.id | measure-object -Minimum).Minimum
            $Measurement = $($Result.Activities.id | measure-object -Minimum -Maximum)
            Write-Host "Min: $($Measurement.Minimum) Max: $($Measurement.Maximum)"
        } else {
            $Found = $True
        }
    
    } while ($Found -eq $False)

    return $ReturnActivities

}