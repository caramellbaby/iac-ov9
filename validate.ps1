Write-Host "Running terraform fmt..."
terraform fmt -check
if ($LASTEXITCODE -ne 0) { exit 1 }

Write-Host "Running terraform validate..."
terraform validate
if ($LASTEXITCODE -ne 0) { exit 1 }

Write-Host "Running TFLint..."
tflint --init
tflint
if ($LASTEXITCODE -ne 0) { exit 1 }

Write-Host "Running Checkov..."
checkov -d . --framework terraform
if ($LASTEXITCODE -ne 0) { exit 1 }

Write-Host "All validations passed!"

