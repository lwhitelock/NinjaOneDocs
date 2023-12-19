function Get-MapColour {
    param (
        $MapList,
        $Count
    )

    $Maximum = ($MapList | measure-object).count - 1
    $Index = [array]::indexof($MapList, "$count")
    $Sixth = $Maximum / 6

    if ($count -eq 0) {
        return "rgb(34,34,34)"
    } elseif ($Index -ge 0 -and $Index -le $Sixth) {
        return "rgb(226, 230, 190)"
    } elseif ($Index -gt $Sixth -and $Index -le $Sixth * 2) {
        return "rgb(237, 223, 133)"
    } elseif ($Index -gt $Sixth * 2 -and $Index -le $Sixth * 3) {
        return "rgb(238, 203, 117)"
    } elseif ($Index -gt $Sixth * 3 -and $Index -le $Sixth * 4) {
        return "rgb(227, 174, 105)"
    } elseif ($Index -gt $Sixth * 4 -and $Index -le $Sixth * 5) {
        return "rgb(205, 137, 92)"
    } elseif ($Index -gt $Sixth * 5 -and $Index -lt $Maximum) {
        return "rgb(172, 89, 77)"
    } else {
        return "rgb(130, 34, 59)"
    }
    
}