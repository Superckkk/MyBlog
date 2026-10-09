# 重新渲染 Typst 包效果图
#
#   pwsh -File scripts/render-typst-demos.ps1
#
# 把 typst-demos/*.typ 逐个编译成 PNG，输出到 docs/assets/typst/，
# 供 docs/notes/Tools/Typst.md 引用。
#
# 需要 typst CLI 在 PATH 上（0.15+）。首次运行会自动下载示例里 import 的包。

$ErrorActionPreference = 'Stop'

$root = Split-Path -Parent $PSScriptRoot
$srcDir = Join-Path $root 'typst-demos'
$outDir = Join-Path $root 'docs' 'assets' 'typst'

if (-not (Get-Command typst -ErrorAction SilentlyContinue)) {
    throw '找不到 typst 命令。Windows 上可以 winget install Typst.Typst'
}
if (-not (Test-Path $srcDir)) {
    throw "找不到示例目录：$srcDir"
}

New-Item -ItemType Directory -Force -Path $outDir | Out-Null

# 幻灯片页面尺寸大（16:9 有 29.7cm 宽），ppi 得压低，否则图宽得离谱。
$ppiOverride = @{ 'touying' = 130 }
$defaultPpi = 200

$failed = @()

Get-ChildItem $srcDir -Filter *.typ | Sort-Object Name | ForEach-Object {
    $name = $_.BaseName
    $ppi = if ($ppiOverride.ContainsKey($name)) { $ppiOverride[$name] } else { $defaultPpi }
    $target = Join-Path $outDir "$name.png"

    Write-Host ("==> {0,-16} {1} ppi" -f $name, $ppi)
    & typst compile --format png --ppi $ppi $_.FullName $target
    if ($LASTEXITCODE -ne 0) {
        Write-Warning "编译失败：$name"
        $failed += $name
    }
}

Write-Host ''
Write-Host '--- 产物 ---'
Get-ChildItem $outDir -Filter *.png | Sort-Object Name | ForEach-Object {
    Write-Host ("{0,-22} {1,8} bytes" -f $_.Name, $_.Length)
}

if ($failed.Count -gt 0) {
    throw "以下示例编译失败：$($failed -join ', ')"
}
Write-Host ''
Write-Host '全部完成。' -ForegroundColor Green
