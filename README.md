# Daily-Chocolatey-Update
## Schedule the Script Manually

Be sure to use your path in the arguments below:

1. Open Task Scheduler by hitting Windows Start key, and typing Task Scheduler until it appears. Click to open.
1. In Actions Pane, click 'Create Basic Task'.
1. In Name, type "_Daily Choco Upgrade", click 'Next'.
1. Selected 'On Login', click 'Next'.
1. 'Start a program' is selected, so click 'Next'.
1. In Program/script:, type ```PowerShell.exe```.
1. In Add arguments (optional), type ```-File "<PATH>\daily_choco.ps1"```
1. Click 'Next'.
1. Click 'Finish'.
