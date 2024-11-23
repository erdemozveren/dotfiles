# Thanks to chat-gpt for not taking my job (unemployed) and help me to write this script

# Define the source array and destination path
$documentsPath = [Environment]::GetFolderPath('MyDocuments')
$sourceItems = @(
  "~/.wezterm.lua",
  "~/.config/starship.toml" # dont add comma in here Join-Path freaks out
  Join-Path $documentsPath "PowerShell/Microsoft.PowerShell_profile.ps1"
  Join-Path $env:LOCALAPPDATA "nvim"
)

$choice = Read-Host "Choose an option (1: Copy from machine to here, 2: Copy from here to machine folders)"

$currentDir = "."
if ($choice -eq "1")
{

  # Ensure the destination directory exists
  if (!(Test-Path -Path $currentDir))
  {
    Write-Warning "Can't read current directory"
    exit 1
  }

  # Loop through each item in the source array
  foreach ($item in $sourceItems)
  {
    if (Test-Path -Path $item)
    {
      #$resolvedItemPath = $item -replace "^~", $env:USERPROFILE
      $itemName = Split-Path -Path $item -Leaf
      $destinationItem = Join-Path -Path $currentDir -ChildPath $itemName

      # Copy files and directories recursively
      Copy-Item -Path $item -Destination $destinationItem -Recurse -Force
      Write-Host "Copied: $item to $destinationItem"
    } else
    {
      Write-Warning "Item not found: $item"
    }
  }
} elseif ($choice -eq "2")
{
  foreach ($item in $sourceItems)
  {
    # Resolve any potential tilde (~) paths
    #$resolvedItemPath = $item  -replace "^~", $env:USERPROFILE
    $itemName = Split-Path -Path $item -Leaf
    $sourceItem = Join-Path -Path $currentDir -ChildPath $itemName

    if (Test-Path -Path $sourceItem)
    {
      # Ensure the target directory exists
      $targetDir = Split-Path -Path $item -Parent
      if (!(Test-Path -Path $targetDir))
      {
        New-Item -ItemType Directory -Path $targetDir -Force
      }

      # Copy files and directories recursively
      Copy-Item -Path $sourceItem -Destination $item -Recurse -Force
      Write-Host "Copied: $sourceItem to $item"
    } else
    {
      Write-Warning "Source item not found in destination: $sourceItem"
    }
  }
} else
{
  Write-Warning "Invalid choice. Please run the script again and choose 1 or 2."
}

Write-Host "Press Enter to exit..."
Read-Host
