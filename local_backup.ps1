# Senior Engineer Local Backup Script
# This script creates a timestamped backup of critical project files

$Timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
$BackupRoot = "backup"
$BackupPath = "$BackupRoot/backup_$Timestamp"

# Create backup directories
if (-not (Test-Path $BackupRoot)) {
    New-Item -ItemType Directory -Path $BackupRoot
}
New-Item -ItemType Directory -Path $BackupPath
New-Item -ItemType Directory -Path "$BackupPath/lib"
New-Item -ItemType Directory -Path "$BackupPath/assets_data"

Write-Host "Starting backup to $BackupPath..." -ForegroundColor Cyan

# Define critical files/folders
$CriticalFiles = @(
    "pubspec.yaml",
    "pubspec.lock",
    "README.md",
    "analysis_options.yaml"
)

# Copy critical root files
foreach ($file in $CriticalFiles) {
    if (Test-Path $file) {
        Copy-Item $file "$BackupPath/$file"
        Write-Host "Backed up: $file" -ForegroundColor Gray
    }
}

# Copy lib folder (Recursively)
if (Test-Path "lib") {
    Copy-Item "lib" "$BackupPath" -Recurse
    Write-Host "Backed up: lib folder" -ForegroundColor Gray
}

# Copy assets/data folder
if (Test-Path "assets/data") {
    Copy-Item "assets/data" "$BackupPath/assets_data" -Recurse
    Write-Host "Backed up: assets/data folder" -ForegroundColor Gray
}

# Create a simple log
$LogContent = "Backup created at: $(Get-Date -Format "yyyy-MM-dd HH:mm:ss")`r`nBackup Location: $BackupPath"
$LogContent | Out-File "$BackupPath/backup_log.txt"

Write-Host "Backup completed successfully!" -ForegroundColor Green
