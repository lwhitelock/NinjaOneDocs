Function Get-NinjaOneCSSCol($SmallCols, $MedCols, $LargeCols, $XLCols) {
    $SmallCSS = "col-sm-$([Math]::Floor(12 / $SmallCols))"
    $MediumCSS = "col-md-$([Math]::Floor(12 / $MedCols))"
    $LargeCSS = "col-lg-$([Math]::Floor(12 / $LargeCols))"
    $XLCSS = "col-xl-$([Math]::Floor(12 / $XLCols))"

    Return "$SmallCSS $MediumCSS $LargeCSS $XLCSS"
}