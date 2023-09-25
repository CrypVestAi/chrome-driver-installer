# Chromedriver Installer Script

## Background

This project was initiated due to the changes in the ChromeDriver release process starting with version M115 of Chrome. The ChromeDriver release process has been integrated with that of Chrome, and the latest Chrome + ChromeDriver releases per release channel are available at the [Chrome for Testing (CfT) availability dashboard](https://googlechromelabs.github.io/chrome-for-testing/). 

Given these changes, it's crucial to have a reliable mechanism to match the installed version of Chrome with the corresponding ChromeDriver binary. This project serves to automate the process of downloading and installing the appropriate version of ChromeDriver based on the installed version of Chrome.

For detailed information regarding version selection, you can refer to the [official ChromeDriver version selection guide](https://chromedriver.chromium.org/downloads/version-selection).

## Requirements

- Bash Shell
- Google Chrome Installed
- `wget`
- `unzip`
- `jq` (Command-line JSON processor)

## Installation

### 1. Clone this Repository

```sh
git clone https://github.com/CrypVestAi/chrome-driver-installer.git
cd chrome-driver-installer
```

### 2. Run the Script

Make the script executable and run it:

```sh
chmod +x install_chromedriver.sh
./install_chromedriver.sh
```

This will install the appropriate Chromedriver in `/usr/local/bin`.

## How it Works

1. The script first determines the platform and architecture it’s running on.
2. It then gets the currently installed Chrome version.
3. Using the Chrome version, it fetches the corresponding Chromedriver version.
4. Downloads the appropriate Chromedriver based on the determined platform and Chrome version.
5. Unzips and moves the Chromedriver to `/usr/local/bin`.
6. Cleans up by removing the downloaded zip file and temporary directories.

## Supported Platforms

- macOS (x64 & arm64)
- Linux (x64)
- Windows (x64 & x32)

## Contributions

Contributions, issues, and feature requests are welcome! Feel free to check [issues page](https://github.com/CrypVestAi/chrome-driver-installer/issues).

## License

[MIT](LICENSE)

## Author

**Nifemi Alpine**

- [Github](https://github.com/mrkeyiano)
- [X (fka Twitter)](https://x.com/usecodenaija)
- [LinkedIn](https://www.linkedin.com/in/iamkeyiano/)

## Show your support

Give a ⭐️ if this project helped you!
