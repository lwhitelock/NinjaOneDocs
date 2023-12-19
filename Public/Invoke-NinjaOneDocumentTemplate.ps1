function Invoke-NinjaOneDocumentTemplate {
    [CmdletBinding()]
    param (
        $Template,
        $Token,
        $ID
    )

    if (!$ID) {
        $DocumentTemplates = Invoke-NinjaOneRequest -Path "document-templates" -Method GET
        $DocumentTemplate = $DocumentTemplates | Where-Object { $_.name -eq $Template.name }
    } else {
        $DocumentTemplate = Invoke-NinjaOneRequest -Path "document-templates/$($ID)" -Method GET
    }
    
    $PatchTemplate = $False

    $MatchedCount = ($DocumentTemplate | Measure-Object).count
    if ($MatchedCount -eq 1) {
        # Matched a single document template
        # Check fields are correct
        foreach ($Field in $Template.Fields) {
            $MatchedField = $DocumentTemplate.Fields | Where-Object { $_.fieldName -eq $Field.fieldName -and $_.fieldType -eq $Field.fieldType }
            if (($MatchedField | Measure-Object).count -ne 1) {
                $MatchedField = $DocumentTemplate.Fields | Where-Object { $_.fieldName -eq $Field.fieldName }
                $MatchCount = ($MatchedField | Measure-Object).count
                if ($MatchCount -eq 1 ) {
                    Throw "$($Field.fieldName) exists with the wrong type. Please manually edit the template $($Template.name) to set it to a $($Field.fieldType) field."
                } elseif ($MatchCount -eq 0) {
                    $PatchTemplate = $True
                } else {
                    Throw "Mutliple Fields exists for $($Field.fieldName) in $($Template.name)"
                }
            }
        }

        if ($PatchTemplate -eq $True) {
            Write-Host "Updating Template"
            $NinjaDocumentTemplate = Invoke-NinjaOneRequest -Path "document-templates/$($DocumentTemplate.id)" -Method PUT -InputObject ($Template | Select-Object * -ExcludeProperty allowMultiple)
        }

        $NinjaDocumentTemplate = $DocumentTemplate


    } elseif ($MatchedCount -eq 0) {
        # Create a new Document Template
        Write-Host "Creating Template"
        $NinjaDocumentTemplate = Invoke-NinjaOneRequest -Path "document-templates" -Method POST -InputObject $Template
    } else {
        # Matched multiple templates. Should be impossible but lets check anyway :D
        Throw "Multiiple Documents Matched the Provided Criteria"
    }

    return $NinjaDocumentTemplate

}