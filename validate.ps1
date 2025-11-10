# validate.ps1
# Script for å validere Terraform-kode med TFLint og Checkov

Write-Host "`n=== Trinn 1: Terraform format check ===" -ForegroundColor Cyan
terraform fmt -check
if ($LASTEXITCODE -ne 0) { Write-Host "Feil: formattering!" -ForegroundColor Red; exit 1 }

Write-Host "`n=== Trinn 2: Terraform validate ===" -ForegroundColor Cyan
terraform validate
if ($LASTEXITCODE -ne 0) { Write-Host "Feil: validering!" -ForegroundColor Red; exit 1 }

Write-Host "`n=== Trinn 3: TFLint ===" -ForegroundColor Cyan
tflint --init
tflint
if ($LASTEXITCODE -ne 0) { Write-Host "Feil: TFLint!" -ForegroundColor Red; exit 1 }

Write-Host "`n=== Trinn 4: Checkov ===" -ForegroundColor Cyan
checkov -d . --framework terraform
if ($LASTEXITCODE -ne 0) { Write-Host "Feil: Checkov!" -ForegroundColor Red; exit 1 }

Write-Host "`n✅ Alle kontroller bestått!`n" -ForegroundColor Green
