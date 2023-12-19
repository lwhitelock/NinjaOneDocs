function Get-NinjaOneWidgetCard($Title, $Data, [string]$Icon, [string]$TitleLink, [int]$SmallCols, [int]$MedCols, [int]$LargeCols, [int]$XLCols, [Switch]$NoCard) {
    <#
    $Data = @(
        @{
            Value = 20
            Description = 'Users'
            Colour = '#CCCCCC'
            Link = 'https://example.com/users'
        },
        @{
            Value = 42
            Description = 'Devices'
            Colour = '#CCCCCC'
            Link = 'https://example.com/devices'
        }
    )
    
    $HTML = Get-NinjaOneWidgetCard -Title 'Summary Details' -Data $Data -Icon 'fas fa-building' -TitleLink 'http://example.com' -Columns 3

    #>

    $CSSCols = Get-NinjaOneCSSCol -SmallCols $SmallCols -MedCols $MedCols -LargeCols $LargeCols -XLCols $XLCols


    [System.Collections.Generic.List[String]]$OutputHTML = @()
    
    $OutputHTML.add('<div class="row d-flex m-1 justify-content-center align-items-center">')


    foreach ($Item in $Data) {

        $HTML = @"
    <div class="$CSSCols">
    <div class="stat-card">
    <div class="stat-value"><a href="$($Item.Link)" target="_blank"><span style="color: $($Item.Colour);">$($Item.Value)</span></a></div>
    <div class="stat-desc"><a href="$($Item.Link)" target="_blank"><span style="font-size: 18px;"><span style="white-space:nowrap;">$($Item.Description)</span></span></a></div>
        </div>
    </div>
"@

        $OutputHTML.add($HTML)

    }

    $OutputHTML.add('</div>')

    if ($NoCard) {
        return $OutputHTML -join ''
    } else {
        Return Get-NinjaOneCard -Title $Title -Body ($OutputHTML -join '') -Icon $Icon -TitleLink $TitleLink
    }

}