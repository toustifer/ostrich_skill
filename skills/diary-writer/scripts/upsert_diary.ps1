param(
    [Parameter(Mandatory = $true)]
    [string]$Root,

    [Parameter(Mandatory = $true)]
    [string]$Date,

    [string]$Section = '今日记录',

    [string]$Text = ''
)

$ErrorActionPreference = 'Stop'

$parsedDate = [datetime]::ParseExact($Date, 'yyyy-MM-dd', $null)
$year = $parsedDate.ToString('yyyy')
$month = $parsedDate.ToString('MM')
$dir = Join-Path (Join-Path $Root $year) $month
$filePath = Join-Path $dir ($parsedDate.ToString('yyyy-MM-dd') + '.md')

if (-not (Test-Path $dir)) {
    New-Item -ItemType Directory -Path $dir -Force | Out-Null
}

$weekdayMap = @{
    'Monday' = '周一'
    'Tuesday' = '周二'
    'Wednesday' = '周三'
    'Thursday' = '周四'
    'Friday' = '周五'
    'Saturday' = '周六'
    'Sunday' = '周日'
}

if (-not (Test-Path $filePath)) {
    $skillRoot = Split-Path (Split-Path $MyInvocation.MyCommand.Path -Parent) -Parent
    $templatePath = Join-Path $skillRoot 'assets/diary-template.md'
    $template = Get-Content -Path $templatePath -Raw -Encoding UTF8
    $weekday = $weekdayMap[$parsedDate.DayOfWeek.ToString()]
    $content = $template.Replace('{{DATE}}', $parsedDate.ToString('yyyy-MM-dd')).Replace('{{WEEKDAY}}', $weekday)
    Set-Content -Path $filePath -Value $content -Encoding UTF8
}

if ($Text -and $Text.Trim()) {
    $existing = Get-Content -Path $filePath -Raw -Encoding UTF8
    $header = "## $Section"
    $normalized = $existing -replace "`r`n", "`n"

    if ($normalized -notmatch [regex]::Escape($header)) {
        $normalized = $normalized.TrimEnd() + "`n`n$header`n`n"
    }

    $sectionPattern = '(?ms)^##\s+' + [regex]::Escape($Section) + '\s*$'
    $match = [regex]::Match($normalized, $sectionPattern)

    if ($match.Success) {
        $insertAt = $match.Index + $match.Length
        $before = $normalized.Substring(0, $insertAt)
        $after = $normalized.Substring($insertAt)
        $addition = "`n`n- " + ($Text.Trim() -replace "`r?`n", "`n  ")
        $normalized = $before + $addition + $after
    } else {
        $normalized = $normalized.TrimEnd() + "`n`n$header`n`n- " + ($Text.Trim() -replace "`r?`n", "`n  ") + "`n"
    }

    Set-Content -Path $filePath -Value $normalized -Encoding UTF8
}

Write-Output $filePath
