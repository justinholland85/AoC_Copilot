$hookInput = [Console]::In.ReadToEnd() | ConvertFrom-Json

if ($hookInput.stop_hook_active -or $hookInput.stopHookActive) {
    '{"decision":"allow"}'
    exit 0
}

$repositoryRoot = (Resolve-Path (Join-Path $PSScriptRoot '..\..')).Path
$hookInstalledAt = (Get-Item (Join-Path $PSScriptRoot 'aoc-solution-summary.json')).LastWriteTimeUtc
$gitStatus = & git -C $repositoryRoot status --porcelain=v1 --untracked-files=all
if ($LASTEXITCODE -ne 0) {
    [Console]::Error.WriteLine('AoC summary hook could not read git status.')
    '{"decision":"allow"}'
    exit 0
}

$solutionsNeedingSummary = @()
foreach ($statusLine in $gitStatus) {
    if ($statusLine.Length -lt 4) {
        continue
    }

    $relativePath = $statusLine.Substring(3).Trim()
    if ($relativePath -notmatch '^(\d{4})/AoC_\1_(\d{2})/AoC_\1_\2_(?:Copilot\.(?:R|py)|R_to_Python\.py)$') {
        continue
    }

    $year = $Matches[1]
    $day = $Matches[2]
    $sourcePath = Join-Path $repositoryRoot ($relativePath -replace '/', '\')
    if (-not (Test-Path -LiteralPath $sourcePath -PathType Leaf)) {
        continue
    }

    $summaryPath = Join-Path (Split-Path -Parent $sourcePath) "AoC_${year}_${day}_Summary.md"
    $sourceFile = Get-Item -LiteralPath $sourcePath
    # Ignore pre-existing dirty solution files when the hook is first installed.
    if ($sourceFile.LastWriteTimeUtc -le $hookInstalledAt) {
        continue
    }

    if (
        -not (Test-Path -LiteralPath $summaryPath -PathType Leaf) -or
        (Get-Item -LiteralPath $summaryPath).LastWriteTimeUtc -lt $sourceFile.LastWriteTimeUtc
    ) {
        $solutionsNeedingSummary += $relativePath
    }
}

if ($solutionsNeedingSummary.Count -eq 0) {
    '{"decision":"allow"}'
    exit 0
}

$solutionList = $solutionsNeedingSummary -join "`n"
$reason = @"
An Advent of Code solution script was changed:
$solutionList

Before finishing, create or update the corresponding AoC_<year>_<day>_Summary.md in that puzzle's directory. Summarize only the changed solution script(s), explaining the key algorithmic idea, major steps, and notable performance considerations. Do not summarize unrelated files. Keep the summary newer than the solution script. Do not modify the solution just to satisfy this request.
"@
$output = @{
    decision = 'block'
    reason = $reason.Trim()
} | ConvertTo-Json -Compress
$output
