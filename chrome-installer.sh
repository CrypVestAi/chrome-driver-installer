#!/bin/bash

echo "Determining the platform..."

# Determine Operating System and Architecture
OS=$(uname)
ARCH=$(uname -m)

if [ "$OS" == "Darwin" ]; then
    if [ "$ARCH" == "arm64" ]; then
        PLATFORM="mac-arm64"
    else
        PLATFORM="mac-x64"
    fi
elif [ "$OS" == "Linux" ]; then
    if [ "$ARCH" == "x86_64" ]; then
        PLATFORM="linux64"
    else
        PLATFORM="linux32"
    fi
elif [ "$OS" == "Windows_NT" ] || [ "$OS" == "CYGWIN_NT-10.0" ]; then
    if [ "$ARCH" == "x86_64" ]; then
        PLATFORM="win64"
    else
        PLATFORM="win32"
    fi
else
    echo "Unsupported operating system and architecture: $OS, $ARCH"
    exit 1
fi

echo "Platform: $PLATFORM"

# Get the OS type
OSTYPE=$(uname)

# Get current Chrome version based on OS type
if [ "$OSTYPE" == "Darwin" ]; then
  CHROME_VERSION=$(/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --version 2>/dev/null | awk '{ print $3 }' | cut -d '.' -f 1-3)
elif [ "$OSTYPE" == "Linux" ]; then
  CHROME_VERSION=$(google-chrome --version 2>/dev/null | awk '{ print $3 }' | cut -d '.' -f 1-3)
else
  CHROME_VERSION=$(google-chrome --version 2>/dev/null | awk '{ print $3 }' | cut -d '.' -f 1-3)
fi

# If Chrome version is not found, print error message and exit
if [ -z "$CHROME_VERSION" ]; then
  echo "Error: Google Chrome is not installed or the version cannot be found."
  exit 1
fi

echo "Current Chrome Version: $CHROME_VERSION"

echo "Fetching JSON versions..."
# Get the latest build for the version
JSON_VERSIONS=$(curl -s https://googlechromelabs.github.io/chrome-for-testing/known-good-versions.json)

echo "Getting the latest build..."
LATEST_BUILD=$(echo $JSON_VERSIONS | jq -r --arg ver "$CHROME_VERSION" '.versions[] | select(.version | startswith($ver)) | .version' | sort -V | tail -1)
echo "Latest Build: $LATEST_BUILD"

echo "Formulating the download link..."
# Get the download URL for the specified platform
DOWNLOAD_URL="https://edgedl.me.gvt1.com/edgedl/chrome/chrome-for-testing/$LATEST_BUILD/$PLATFORM/chromedriver-$PLATFORM.zip"

echo "Download URL: $DOWNLOAD_URL"

echo "Downloading and installing..."
# Download and install
wget -q $DOWNLOAD_URL -O chromedriver.zip
unzip -o chromedriver.zip
cp chromedriver-$PLATFORM/chromedriver /usr/local/bin/
cp chromedriver-$PLATFORM/chromedriver ./
rm -r chromedriver-$PLATFORM chromedriver.zip  # Removing both .zip and unzipped directory

echo "Chromedriver installed successfully."
