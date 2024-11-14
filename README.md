
# League of Legends Restart Script

  

This PowerShell script is designed to terminate all processes associated with League of Legends and the Riot Client. If League of Legends freezes on the loading screen, running this script will close all related processes and automatically restart the game using the Riot Client with the appropriate launch options.

  

## Prerequisites

  

-  **PowerShell**: Make sure PowerShell is installed on your system.

-  **Execution Policy**: You may need to change the PowerShell execution policy to allow running scripts. To do this, open PowerShell as Administrator and run:

```powershell
Set-ExecutionPolicy RemoteSigned
```
  

# Setup and Usage

  

## Save the Script:

Copy the script contents below and paste them into a new text file.

Save the file as Restart-League.ps1 on your Desktop.

  

Run the Script:

  

Simply double-click the Restart-League.ps1 file on your desktop.

  

The script will execute, closing all related processes and restarting League of Legends.

**Note**: You may see a prompt confirming that you want to run the script; select "Yes" or "Run" to continue.


```powershell

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

  ```

# Script Details

**Processes Terminated** : The script targets all known processes related to League of Legends and the Riot Client, including:

LeagueClient

LeagueClientUx

LeagueClientUxRender

RiotClientServices

RiotClientCrashHandler

LeagueCrashHandler

League of Legends

LoLPatcherUx


**Riot Client Launch Path**: The script assumes that the Riot Client executable is located at:
```
C:\Riot Games\Riot Client\RiotClientServices.exe
```

If your installation is in a different location, update this path in the script file.

  

**Launch Options**: The script uses the following launch options to start League of Legends directly:
```
--launch-product=league_of_legends --launch-patchline=live
```
# Troubleshooting

**Execution Policy Error**: If you receive an error about the execution policy, ensure you’ve set it to RemoteSigned as described in the prerequisites.

  

**Riot Client Path Error**: If the script cannot find the Riot Client executable, verify the path in the script matches your installation location.

  

# License

This script is provided "as is" without warranty of any kind. Use at your own risk