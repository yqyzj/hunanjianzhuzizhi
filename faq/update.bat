@echo off
setlocal enabledelayedexpansion

set "brandPrefix=湘建通_湘筑云_筑管家_"
set "brandKeywords=湘建通,湘筑云,筑管家,资质小帮手,资质参谋,资质通,资质达人"
set "brandDesc=湘建通|湘筑云|筑管家-资质小帮手为您解答："
set "brandText=湘建通|湘筑云|筑管家-资质小帮手"

for %%f in (1.html 2.html 3.html 4.html 5.html 6.html 7.html 8.html 9.html 10.html 11.html 12.html 13.html 14.html 15.html 16.html 17.html 18.html 19.html 20.html 21.html 22.html 23.html 24.html 25.html 26.html 27.html 28.html 29.html 30.html 31.html 32.html 33.html 61.html 62.html 63.html 64.html 65.html 66.html 67.html 68.html 69.html 70.html 71.html 72.html 73.html 81.html 82.html 83.html 84.html 85.html 86.html) do (
    if exist "%%f" (
        echo Processing %%f...
        
        powershell -Command "(Get-Content '%%f' -Raw -Encoding UTF8) -replace '<title>([^<]+)</title>', '<title>!brandPrefix!$1</title>' | Set-Content '%%f' -Encoding UTF8 -NoNewline"
        
        powershell -Command "(Get-Content '%%f' -Raw -Encoding UTF8) -replace '<meta name=\"keywords\" content=\"([^\"]+)\"', '<meta name=\"keywords\" content=\"!brandKeywords!,$1\"' | Set-Content '%%f' -Encoding UTF8 -NoNewline"
        
        powershell -Command "(Get-Content '%%f' -Raw -Encoding UTF8) -replace '<meta name=\"description\" content=\"([^\"]+)\"', '<meta name=\"description\" content=\"!brandDesc!$1\"' | Set-Content '%%f' -Encoding UTF8 -NoNewline"
        
        powershell -Command "(Get-Content '%%f' -Raw -Encoding UTF8).Replace('<span>湖南资质服务网</span>', '<span>!brandText!</span>') | Set-Content '%%f' -Encoding UTF8 -NoNewline"
        
        powershell -Command "(Get-Content '%%f' -Raw -Encoding UTF8).Replace('© 2026 湖南资质服务网 版权所有', '© 2026 !brandText! 版权所有') | Set-Content '%%f' -Encoding UTF8 -NoNewline"
        
        powershell -Command "(Get-Content '%%f' -Raw -Encoding UTF8).Replace('专注建筑资质代办，为企业提供专业、高效、合规的一站式服务', '!brandText!：专注建筑资质代办，为企业提供专业、高效、合规的一站式服务') | Set-Content '%%f' -Encoding UTF8 -NoNewline"
        
        echo Updated: %%f
    )
)

echo Done!
pause
