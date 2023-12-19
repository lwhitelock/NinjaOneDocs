function Get-NinjaOneInfoCard($Title, $Data, [string]$Icon, [string]$TitleLink) {
    <#
    $TenantDetailsItems = [PSCustomObject]@{
        'Name' = $Customer.displayName
        'Default Domain' = $Customer.defaultDomainName
        'Tenant ID' = $Customer.customerId
        'Domains' = $customerDomains
        'Admin Users' = ($AdminUsers | ForEach-Object {"$($_.displayname) ($($_.userPrincipalName))"}) -join ', '
        'Creation Date' = $TenantDetails.createdDateTime
    }

    Get-NinjaOneInfoCard -Title "Tenant Details" -Data $TenantDetailsItems
    #>

    [System.Collections.Generic.List[String]]$ItemsHTML = @()

    foreach ($Item in $Data.PSObject.Properties) {
        $ItemsHTML.add('<p ><b >' + $Item.Name + '</b><br />' + $Item.Value + '</p>')
    }

    return Get-NinjaOneCard -Title $Title -Body ($ItemsHTML -join '') -Icon $Icon -TitleLink $TitleLink
       
}