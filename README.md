# Windows Information Gathering
### Overview

This script is designed to gather system information from Windows environments. It must be run from an **Administrator Command Prompt**, and it relies on specific tools for memory collection and malware scanning. Below are detailed instructions and requirements for running the script effectively.

## Standardization
### Key Points

1. **Run the Script from Its Own Directory**: The script uses the current working directory to determine where to save the collected data.
2. **User Input**: 
   - **ORG_SESSION**: e.g., COMPANY_RH.
   - **IP Address**: Use underscores (_) instead of dots (.), e.g., `10_228_97_1`.
   
   Other necessary information is collected automatically.

## Required Tools
### Ensure the Following Tools Are Available:

1. **Loki** – [Latest Release](https://github.com/Neo23x0/Loki/releases/)
   - Loki is used for comprehensive malware scanning, which can take several hours.
2. **WinPMem** – [Latest Release](https://github.com/Velocidex/WinPmem/releases/tag/v4.0.rc1)
   - For memory acquisition.
3. **SysInternals Suite** – [Download Link](https://docs.microsoft.com/en-us/sysinternals/downloads/sysinternals-suite)
   - Includes utilities for in-depth system analysis.
4. **FTK Imager Lite** 
   - An alternative to WinPMem for collecting memory on Windows XP, and it can also acquire `pagefile.sys`.

## Folder Structure
### Directory Tree

At the end of the script execution, the folder structure should look as follows:

![Directory Structure](./img/diretorio_colect.png)

## Recommendations
### Pre-Mission Preparations

1. **Tool Versions**: Always download the latest versions of the required tools. If tool names change, update the script accordingly.
2. **Test Before Deployment**: It's strongly recommended to test the script in a controlled environment before running it in the field to avoid potential issues during the mission.
