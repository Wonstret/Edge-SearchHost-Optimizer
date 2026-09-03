<div align="center">

# Security Policy

[Português (Brasil)](./SECURITY-pt-br.md)

</div>

---

## Supported Versions

Only the latest version available on the main branch is actively maintained and supported with security patches and bug fixes.

| Version | Supported |
| ------- | --------- |
| Main branch | Yes |
| Older commits | No |

---

## Reporting a Vulnerability

Security and system integrity are taken seriously in this project. If you discover a security vulnerability, unintended system impact, or potential flaw in the script execution, please report it responsibly.

### How to Report

1. Open a new issue in the GitHub repository tagged as a Security issue, or contact the maintainer directly via GitHub profile.
2. Provide a detailed description of the issue.
3. Include clear steps to reproduce the behavior, along with:
   - Your Windows OS build version (e.g., Windows 11 23H2 / Windows 10 22H2).
   - Any relevant logs or error codes generated during execution.
   - The expected versus actual system behavior.

### Response Time

Reports will be reviewed as soon as possible. Critical system issues or breaking bugs will be prioritized for remediation.

---

## System Impact & Transparency

Edge Killer interacts directly with Windows system components and configuration registries. For full transparency, below is an exhaustive list of system modifications performed by this tool:

### 1. Registry Keys
The tool modifies the following standard Windows configuration entries:
- `HKLM:\SOFTWARE\Microsoft\EdgeUpdate`
  - Sets `DoNotUpdateToEdgeWithChromium = 1` (Official Microsoft policy to prevent automatic browser reinstallation via Windows Update).
- `HKCU:\Software\Policies\Microsoft\Windows\Explorer`
  - Sets `DisableSearchBoxSuggestions = 1` (Disables Bing web search suggestions in Windows Search).
- `HKCU:\Software\Microsoft\Windows\CurrentVersion\Search`
  - Sets `SearchboxTaskbarMode = 0` (Hides taskbar search icon, leaving only the Start button).
  - Sets `BingSearchEnabled = 0` and `CortanaConsent = 0` (Disables web queries from SearchHost).

### 2. Services and Scheduled Tasks
- Disables Windows services: `edgeupdate` and `edgeupdatem`.
- Disables scheduled tasks: `MicrosoftEdgeUpdateTaskMachineCore` and `MicrosoftEdgeUpdateTaskMachineUA`.

### 3. File System & Packages
- Invokes the official Microsoft Edge setup binary with silent uninstall parameters (`setup.exe --uninstall --system-level --force-uninstall`).
- Removes residual desktop and Start Menu shortcut links (`.lnk`).
- Filters out protected Windows system packages before attempting AppX package cleanup to prevent system instability.

---

## Network & Data Privacy

- **Zero Telemetry:** This script does not collect, log, or transmit any user data, telemetry, hardware identifiers, or personal information.
- **No External Binaries:** The script does not download third-party executable binaries (`.exe`, `.dll`, or drivers). It utilizes built-in Windows PowerShell commands, standard Windows APIs, and the native Microsoft Edge uninstaller already present on your machine.

---

## Best Practices

When running scripts via remote execution commands (`irm | iex`), it is recommended to:
1. Inspect the source code directly in the GitHub repository before execution.
2. Ensure you are executing commands from official repository links.
3. Run PowerShell with Administrator privileges only when intentional system modification is desired.

---

## Disclaimer

This software is provided "as is", without warranty of any kind, express or implied. While all modifications use native Windows methods and include a rollback function, the user assumes all responsibility for running system-level customization scripts on their device.
