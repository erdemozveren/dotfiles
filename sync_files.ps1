# Thanks to chat-gpt for not taking my job (unemployed) and help me to write this script

# Define the source array and destination path
$documentsPath = [Environment]::GetFolderPath('MyDocuments')
$sourceItems = @(
    "~/.wezterm.lua",
    "~/.config/starship.toml" # dont add comma in here Join-Path freaks out
    Join-Path $documentsPath "PowerShell/Microsoft.PowerShell_profile.ps1"
    Join-Path $env:LOCALAPPDATA "nvim"
)

$destinationPath = "."

# Ensure the destination directory exists
if (!(Test-Path -Path $destinationPath)) {
    New-Item -ItemType Directory -Path $destinationPath
}

# Loop through each item in the source array
foreach ($item in $sourceItems) {
    if (Test-Path -Path $item) {
        $itemName = Split-Path -Path $item -Leaf
        $destinationItem = Join-Path -Path $destinationPath -ChildPath $itemName

        # Copy files and directories recursively
        Copy-Item -Path $item -Destination $destinationItem -Recurse -Force
        Write-Host "Copied: $item to $destinationItem"
    } else {
        Write-Warning "Item not found: $item"
    }
}

Write-Host "Press Enter to exit..."
Read-Host
