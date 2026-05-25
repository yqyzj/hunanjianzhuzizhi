
$files = @(
    1..20 | ForEach-Object { "$_.html" },
    21..33 | ForEach-Object { "$_.html" },
    61..73 | ForEach-Object { "$_.html" },
    81..86 | ForEach-Object { "$_.html" }
)

$brandPrefix = "湘建通_湘筑云_筑管家_"
$brandKeywords = "湘建通,湘筑云,筑管家,资质小帮手,资质参谋,资质通,资质达人"
$brandDesc = "湘建通|湘筑云|筑管家-资质小帮手为您解答："
$brandText = "湘建通|湘筑云|筑管家-资质小帮手"

foreach ($file in $files) {
    if (Test-Path $file) {
        $content = Get-Content $file -Raw -Encoding UTF8
        
        $content = $content -replace '<title>([^<]+)</title>', "<title>$brandPrefix`$1</title>"
        
        $content = $content -replace '<meta name="keywords" content="([^"]+)"', {
            $original = $args[0].Groups[1].Value
            $original = $original -replace '湖南资质服务网,?', ''
            $original = $original -replace ',湖南资质服务网', ''
            $original = $original.Trim(',')
            if ($original) {
                "<meta name=`"keywords`" content=`"$brandKeywords,$original`""
            } else {
                "<meta name=`"keywords`" content=`"$brandKeywords`""
            }
        }
        
        $content = $content -replace '<meta name="description" content="([^"]+)"', "<meta name=`"description`" content=`"$brandDesc`$1`""
        
        $content = $content.Replace('<span>湖南资质服务网</span>', "<span>$brandText</span>")
        $content = $content.Replace('© 2026 湖南资质服务网 版权所有', "© 2026 $brandText 版权所有")
        $content = $content.Replace('专注建筑资质代办，为企业提供专业、高效、合规的一站式服务', "$brandText：专注建筑资质代办，为企业提供专业、高效、合规的一站式服务")
        
        Set-Content -Path $file -Value $content -Encoding UTF8 -NoNewline
        Write-Host "Updated: $file"
    } else {
        Write-Host "File not found: $file"
    }
}

Write-Host "`nBatch update completed!"
