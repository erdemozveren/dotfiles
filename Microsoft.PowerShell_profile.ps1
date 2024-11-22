# This is need for cwd is not correct on restored sesion in wezterm
# see https://wezfurlong.org/wezterm/shell-integration.html#osc-7-on-windows-with-powershell-with-starship
$prompt = ""
function Invoke-Starship-PreCommand {
    $current_location = $executionContext.SessionState.Path.CurrentLocation
    if ($current_location.Provider.Name -eq "FileSystem") {
        $ansi_escape = [char]27
        $provider_path = $current_location.ProviderPath -replace "\\", "/"
        $prompt = "$ansi_escape]7;file://${env:COMPUTERNAME}/${provider_path}$ansi_escape\"
    }
    $host.ui.Write($prompt)
}
Invoke-Expression (&starship init powershell)
#oh-my-posh init pwsh --config 'C:\Users\PC\AppData\Local\Programs\oh-my-posh\themes\pure.omp.json' | Invoke-Expression
#Set-PSReadLineOption -Colors @{ InlinePrediction = 'DarkCyan' }