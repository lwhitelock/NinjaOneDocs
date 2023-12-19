function Get-HeatMap {
    param(
        $InputData,
        $XValues,
        $YValues
    )

    $BaseMap = [ordered]@{}
    foreach ($y in $YValues) {
        foreach ($x in $XValues) {
            $BaseMap.add("$($y)$($x)", 0)
        }
    }

    foreach ($DataToParse in $InputData) {
        $BaseMap["$($DataToParse)"] += 1
    }

    $MapValues = $BaseMap.values | Where-Object { $_ -ne 0 } | Group-Object
    $MapList = $MapValues.Name

    $HeaderRow = foreach ($x in $XValues) {
        "<th width=`"$(85/($XValues.count+1))%`" style=`"text-align:center`">$($x)</th>"
    }
    
    $HTMLRows = foreach ($y in $YValues) {
        $RowHTML = foreach ($x in $XValues) {
            '<td style="text-align:center; padding: 0; margin:0; border-collapse: collapse;"><svg height="25" width="100%" style="display:block;"><rect width="100%" height="100%" fill="' + $(Get-MapColour -MapList $MapList -Count $($BaseMap."$($y)$($x)")) + '" /></svg></td>'
        }       
        '<tr style="padding: 0; margin:0; border-spacing: 0px; border-collapse: collapse;"><td height=25px style="text-align:center; padding: 0; margin:0; border-collapse: collapse; line-height: 0px;">' + "$y</td>$RowHTML</tr>"
    }

    $Html = @"
    <table role="presentation" cellspacing="0" cellpadding="0" border="0" style="padding: 0; margin:0; border-spacing: 0px; border-collapse: collapse;"><thead>
        <tr>
            <td width=15%></td>$HeaderRow
        </tr>
    </thead>
    $HTMLRows
    </table>
"@

    return $html
}