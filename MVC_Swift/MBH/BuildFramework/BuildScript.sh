#!/bin/sh
# iOS universal library build script supporting swift modules, including dSYM and simulator slices

# prevention from running xcodebuild in a recusive way
if [ "true" == ${ALREADYINVOKED:-false} ]; then
echo "RECURSION: Detected, stopping"
else
export ALREADYINVOKED="true"

# path defines including output directory for universal framework
DERIVED_DATA_PATH=build
BUILD_PRODUCTS_PATH=`pwd`/${DERIVED_DATA_PATH}/Build/Products/${CONFIGURATION}
UNIVERSAL_BUILD_PATH="${BUILD_PRODUCTS_PATH}-universal/iOS"
OUTPUT_DIR=`pwd`"/universal-framework"

mkdir -p "${UNIVERSAL_BUILD_PATH}"
mkdir -p "${OUTPUT_DIR}"

echo "Build Configuration = ${CONFIGURATION}"
echo "Derived Data path = ${DERIVED_DATA_PATH}"
echo "Build Produdcts path = ${BUILD_PRODUCTS_PATH}"
echo "Universal Framework path = ${UNIVERSAL_BUILD_PATH}"

# build both device and simulator versions for iOS
xcodebuild -project "${PROJECT_NAME}.xcodeproj" -scheme "${PROJECT_NAME}" \
-sdk iphonesimulator -configuration ${CONFIGURATION} \
-destination "platform=iOS Simulator,name=iPhone 8" \
ONLY_ACTIVE_ARCH=NO \
clean build -derivedDataPath "${DERIVED_DATA_PATH}"

xcodebuild -project "${PROJECT_NAME}.xcodeproj" -scheme "${PROJECT_NAME}" \
-sdk iphoneos \
-configuration ${CONFIGURATION} \
ONLY_ACTIVE_ARCH=NO \
clean build -derivedDataPath "${DERIVED_DATA_PATH}"

# copy the framework structure from iphoneos build to the universal folder
cp -R "${BUILD_PRODUCTS_PATH}-iphoneos/${PROJECT_NAME}.framework" "${UNIVERSAL_BUILD_PATH}"
cp -R "${BUILD_PRODUCTS_PATH}-iphoneos/${PROJECT_NAME}.framework.dSYM" "${UNIVERSAL_BUILD_PATH}"

# copy existing Swift modules from iphonesimulator build to the universal framework directory
SIMULATOR_SWIFT_MODULES_DIR="${BUILD_PRODUCTS_PATH}-iphonesimulator/${PROJECT_NAME}.framework/Modules/${PROJECT_NAME}.swiftmodule/"
if [ -d "${SIMULATOR_SWIFT_MODULES_DIR}" ]; then
cp -R "${SIMULATOR_SWIFT_MODULES_DIR}" "${UNIVERSAL_BUILD_PATH}/${PROJECT_NAME}.framework/Modules/${PROJECT_NAME}.swiftmodule"
fi

# create universal binary file using lipo and place the combined executable in the universal framework directory
lipo -create -output "${UNIVERSAL_BUILD_PATH}/${PROJECT_NAME}.framework/${PROJECT_NAME}" \
"${BUILD_PRODUCTS_PATH}-iphonesimulator/${PROJECT_NAME}.framework/${PROJECT_NAME}" \
"${BUILD_PRODUCTS_PATH}-iphoneos/${PROJECT_NAME}.framework/${PROJECT_NAME}"

# move the framework folder to the project's directory
cp -R "${UNIVERSAL_BUILD_PATH}/." "${OUTPUT_DIR}"

# optional: create a zip file
cd "${OUTPUT_DIR}"
zip -r "${PROJECT_NAME}.framework.zip" "."

# optional: show the project's directory in Finder
open "${PROJECT_DIR}/universal-framework"
fi
