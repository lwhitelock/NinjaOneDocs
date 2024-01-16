function Get-NinjaBarGraph ($Data, [string]$Title, [string]$Icon, [string]$TitleLink, [switch]$KeyInLine, [switch]$NoSort, [switch]$NoKey, [switch]$NoLabels) {
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
    Get-NinjaBarGraph -Title "Users" -Data $Data -KeyInLine

    #>

    if (!$NoSort) {
        $Data = $Data | Sort-Object Amount -Descending
    }

    $maxAmount = ($Data | Measure-Object -Property Amount -Maximum).Maximum

    [System.Collections.Generic.List[String]]$OutputHTML = @()

    if ($Title) {
        $OutputHTML.add((Get-NinjaOneTitle -Icon $Icon -Title ($Title) -TitleLink $TitleLink))
    }

    $OutputHTML.add('<div class="pb-3 pt-3" style="font-size:14px;">')

    foreach ($Item in $Data) {
        if ($MaxAmount -gt 0) {
            $widthPercent = ($item.Amount / $maxAmount) * 100
        } else {
            $widthPercent = 0
        }
        $OutputHTML.add(@"
        <div class="row align-items-center my-2">
        $(if (!$NoLabels){'<div class="col-md-2 text-right" style="white-space: nowrap;">' + "$($item.Label) - $($item.Amount)</div>"})
                <div class="col-md-10">
                    <div style="width: $widthPercent%; height: 20px; background-color: $($item.Colour);"></div>
                </div>
            </div>
"@)

    }

    $OutputHTML.add('</div>')

    if (!$NoKey) {
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
    }

    return $OutputHTML -join ''


}