#!/bin/bash

# Move to project folder.
cd ../../shop-angular-cloudfront

# Install the app’s npm dependencies.
npm install

# Set environment.
ENV_CONFIGURATION="production"

# Check if the file client-app.zip exists before building.
# If so, remove it and proceed with the build.
if [[ -f ./dist/client-app.zip ]]
then
  rm ./dist/client-app.zip
fi

# Build the app.
npm run build -- --configuration=${ENV_CONFIGURATION}

# Move to dist folder, where build files are generated.
cd ./dist

# If zip is not installed, install zip.
if ! [[ -f $(which zip) ]]
then
  sudo apt-get install zip
fi

# Compress all built content/files in one client-app.zip file in the dist folder.
zip -r ./client-app.zip ./

