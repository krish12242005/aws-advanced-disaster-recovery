$ErrorActionPreference = "Stop"

Write-Host "========================================="
Write-Host " Disaster Recovery Local Validation"
Write-Host "========================================="

Write-Host ""
Write-Host "[1/3] Checking Terraform installation..."

terraform version

if ($LASTEXITCODE -ne 0) {
    throw "Terraform is not installed or not available in PATH."
}

Write-Host ""
Write-Host "[2/3] Running Python DR tests..."

python tests\test_disaster_recovery.py

if ($LASTEXITCODE -ne 0) {
    throw "Disaster recovery tests failed."
}

Write-Host ""
Write-Host "[3/3] Checking project structure..."

$requiredPaths = @(
    "terraform\main.tf",
    "terraform\variables.tf",
    "terraform\outputs.tf",
    "config\dr-config.json",
    "tests\test_disaster_recovery.py",
    "README.md"
)

foreach ($path in $requiredPaths) {
    if (-not (Test-Path $path)) {
        throw "Missing required file: $path"
    }

    Write-Host "PASS: $path"
}

Write-Host ""
Write-Host "========================================="
Write-Host " Local validation completed successfully"
Write-Host "========================================="
