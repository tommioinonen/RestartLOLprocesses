# Define the list of processes to terminate
$processesToKill = @(
    "LeagueClient",
    "LeagueClientUx",
    "LeagueClientUxRender",
    "RiotClientServices",
    "RiotClientCrashHandler",
    "LeagueCrashHandler",
    "League of Legends",
    "LoLPatcherUx"
)

# Close each process if it's running
foreach ($processName in $processesToKill) {
    $processes = Get-Process -Name $processName -ErrorAction SilentlyContinue
    if ($processes) {
        foreach ($process in $processes) {
            try {
                Stop-Process -Id $process.Id -Force
                Write-Output "Stopped process: $processName (ID: $($process.Id))"
            }
            catch {
                Write-Output "Could not stop process: $processName (ID: $($process.Id))"
            }
        }
    }
    else {
        Write-Output "No running process found for: $processName"
    }
}

Write-Output "All League of Legends and Riot Client processes have been terminated."

# Define the path to the Riot Client executable and launch arguments
$riotClientPath = "C:\Riot Games\Riot Client\RiotClientServices.exe"
$launchArgs = "--launch-product=league_of_legends --launch-patchline=live"

# Check if the Riot Client executable exists
if (Test-Path $riotClientPath) {
    # Start the Riot Client with arguments to launch League of Legends
    Start-Process -FilePath $riotClientPath -ArgumentList $launchArgs
    Write-Output "League of Legends is restarting..."
} else {
    Write-Output "Riot Client executable not found at $riotClientPath. Please check the installation path."
}
