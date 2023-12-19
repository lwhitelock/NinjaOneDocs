function Get-NinjaOneLinks ($Data, $Title, [string]$Icon, [string]$TitleLink, [int]$SmallCols, [int]$MedCols, [int]$LargeCols, [int]$XLCols) {
    <#
$ManagementLinksData = @(
        @{
            Name = 'M365 Admin Portal'
            Link = "https://portal.office.com/Partner/BeginClientSession.aspx?CTID=$($customer.CustomerId)&CSDEST=o365admincenter"
            Icon = 'fas fa-cogs'
        },
        @{
            Name = 'Exchange Admin Portal'
            Link = "https://outlook.office365.com/ecp/?rfr=Admin_o365&exsvurl=1&delegatedOrg=$($Customer.DefaultDomainName)"
            Icon = 'fas fa-mail-bulk'
        },
        @{
            Name = 'Entra Admin'
            Link = "https://aad.portal.azure.com/$($Customer.DefaultDomainName)"
            Icon = 'fas fa-users-cog'
        })

        Get-NinjaOneLinks -Title 'M365 Admin Links' -Data $ManagementLinksData
#>

    [System.Collections.Generic.List[String]]$OutputHTML = @()

    $OutputHTML.add('<div class="card flex-grow-1">')

    if ($Title) {
        $OutputHTML.add('<div class="card-title-box"><div class="card-title">' + $(if ($Icon) { '<i class="' + $Icon + '"></i>&nbsp;&nbsp;' }) + $Title + '</div>')

        if ($TitleLink) {
            $OutputHTML.add('<div class="card-link-box"><a href="' + $TitleLink + '" target="_blank" class="card-link"><i class="fas fa-arrow-up-right-from-square"></i></a></div>')
        }

        $OutputHTML.add('</div>')
    }

    $OutputHTML.add('<div class="card-body">')
    $OutputHTML.add('<ul class="row unstyled">')

    $CSSCols = Get-NinjaOneCSSCol -SmallCols $SmallCols -MedCols $MedCols -LargeCols $LargeCols -XLCols $XLCols

   
    foreach ($Item in $Data) {


        $OutputHTML.add(@"
        <li class="$CSSCols"><a href="$($Item.Link)" target="_blank">$(if ($Item.Icon){"<span><i class=`"$($Item.Icon)`"></i>&nbsp;&nbsp;</span>"})<span style="text-align: center;">$($Item.Name)</span></a></li>
"@)

    }

    $OutputHTML.add('</ul></div></div>')

    return $OutputHTML -join ''

}