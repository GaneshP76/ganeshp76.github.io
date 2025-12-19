# Fetch public-domain astronomical images from Wikimedia Commons into assets/bg
# Run this script in PowerShell: `.etch-bg-images.ps1`

$targetDir = "assets/bg"
if (-not (Test-Path $targetDir)) { New-Item -ItemType Directory -Path $targetDir -Force | Out-Null }

$images = @(
    @{ key='m51'; url='https://upload.wikimedia.org/wikipedia/commons/8/89/M51_HST_2005-04-24.jpg' },
    @{ key='pillars'; url='https://upload.wikimedia.org/wikipedia/commons/5/55/Pillars_of_Creation_2014_HST_WFC3-UVIS_full-res_denoised.jpg' },
    @{ key='crab'; url='https://upload.wikimedia.org/wikipedia/commons/0/0e/Crab_Nebula_%28with_halpha%29.jpg' },
    @{ key='kepler'; url='https://upload.wikimedia.org/wikipedia/commons/1/12/Kepler_supernova_remnant.jpg' },
    @{ key='eht'; url='https://upload.wikimedia.org/wikipedia/commons/4/4e/Black_hole_-_Messier_87_crop_max_res.jpg' }
)

foreach ($img in $images) {
    $file = Join-Path $targetDir ($img.key + '.jpg')
    Write-Host "Downloading $($img.url) -> $file"
    try {
        # First attempt: Invoke-WebRequest with a browser-like User-Agent
        $headers = @{ 'User-Agent' = 'Mozilla/5.0 (Windows NT; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0' }
        Invoke-WebRequest -Uri $img.url -OutFile $file -Headers $headers -UseBasicParsing -ErrorAction Stop
        Write-Host "Saved $file (Invoke-WebRequest)"
    } catch {
        Write-Warning "Invoke-WebRequest failed for $($img.url): $_. Trying BITS transfer..."
        try {
            # Fallback: use Start-BitsTransfer if available (more robust for large binary files)
            if (Get-Command Start-BitsTransfer -ErrorAction SilentlyContinue) {
                Start-BitsTransfer -Source $img.url -Destination $file -ErrorAction Stop
                Write-Host "Saved $file (Start-BitsTransfer)"
            } else {
                Write-Warning "Start-BitsTransfer not available. Skipping $($img.url)"
            }
        } catch {
            Write-Warning "BITS transfer failed for $($img.url): $_"
            try {
                # As a fallback try Wikimedia's thumbnail path (smaller resolution)
                $filename = Split-Path $img.url -Leaf
                $parts = $img.url -split '/wikipedia/commons/'
                if ($parts.Length -ge 2) {
                    $tail = $parts[1]
                    $thumbUrl = 'https://upload.wikimedia.org/wikipedia/commons/thumb/' + $tail + '/1200px-' + $filename
                    Write-Host "Trying thumbnail URL: $thumbUrl"
                    Invoke-WebRequest -Uri $thumbUrl -OutFile $file -Headers $headers -UseBasicParsing -ErrorAction Stop
                    Write-Host "Saved $file (thumbnail)"
                }
            } catch {
                Write-Warning "Thumbnail download failed for $($img.url): $_"
            }
        }
    }
}

Write-Host "Done. If some downloads failed, re-run or check your network/permissions."