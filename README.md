# DX180 Performance Enhancement Module

This Magisk module optimizes the iBasso DX180 by adjusting schedtune boost values, CPU min frequencies, and GPU governor settings.

## Installation
1. Download the module ZIP file.
2. Open Magisk Manager.
3. Install the ZIP file from storage.
4. Reboot your device.

## Features
- Adjusts schedtune boost values. (like Intel's Turbo-boost clock, Ryzen PBO)
- Sets CPU min frequency to 300000MHz (little cores) and 300000MHz (big cores).
- Sets CPU max frequency to 1804800MHz (little cores) and 2016000MHz (big cores).
- Changes GPU governor to `simple_ondemand`.

## Description
The default firmware of the iBasso DX180 has fixed minimum frequencies for cores and GPU locked at the minimum clock. This module resolves these issues.

## Usage
Automatically adjusts settings 3 seconds after boot and re-checks every 5 seconds for 1 minute.

## License
MIT License
