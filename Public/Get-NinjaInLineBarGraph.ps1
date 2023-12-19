function Get-NinjaInLineBarGraph ($Data, [string]$Title, [string]$Icon, [string]$TitleLink, [switch]$KeyInLine, [switch]$NoCount, [switch]$NoSort) {
    <# 
    Example: 
    $Data = @(
        @{
            Label = 'Licensed'
            Amount = 3
            Colour = '#55ACBF'
        },
        @{
            Label = 'Unlicensed'
            Amount = 1
            Colour = '#3633B7'
        },
        @{
            Label = 'Guests'
            Amount = 10
            Colour = '#8063BF'
        }
    )
    Get-NinjaInLineBarGraph -Title "Users" -Data $Data -KeyInLine

    #>

    if (!$NoSort) {
        $Data = $Data | Sort-Object Amount -Descending
    }

    $Total = ($Data.Amount | measure-object -sum).sum
    [System.Collections.Generic.List[String]]$OutputHTML = @()

    if ($Title) {
        $OutputHTML.add((Get-NinjaOneTitle -Icon $Icon -Title ($Title + $(if (!$NoCount) { " ($Total)" })) -TitleLink $TitleLink))
    }

    $OutputHTML.add('<div class="pb-3 pt-3 linechart">')

    foreach ($Item in $Data) {
        $OutputHTML.add(@"
        <div style="width: $(($Item.Amount / $Total) * 100)%; background-color: $($Item.Colour);"></div>
"@)

    }

    $OutputHTML.add('</div>')

    if ($KeyInline) {
        $OutputHTML.add('<ul class="unstyled p-3" style="display: flex; justify-content: space-between;">')
    } else {
        $OutputHTML.add('<ul class="unstyled p-3" >')
    }

    foreach ($Item in $Data) {
        $OutputHTML.add(@"
        <li><span class="chart-key" style="background-color: $($Item.Colour);"></span><span > $($Item.Label) ($($Item.Amount))</span></li>
"@)

    }

    $OutputHTML.add('</ul>')

    return $OutputHTML -join ''


}