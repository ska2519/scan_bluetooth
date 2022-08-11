ROOT := $(shell git rev-parse --show-toplevel)
FVM := $(ROOT)/.fvm/flutter_sdk/bin/flutter
FLUTTER := $(shell which flutter)
FLUTTER_BIN_DIR := $(shell dirname $(FLUTTER))
FLUTTER_DIR := $(FLUTTER_BIN_DIR:/bin=)
DART := $(FLUTTER_BIN_DIR)/cache/dart-sdk/bin/dart

SRC_DIRS := lib
SRCS := $(shell find $(SRC_DIRS) -name '*.dart')

.PHONY: format run clean fvmClean buildRunner podClean armPodClean android

format:
	@echo "Formatting source codes"
	$(FLUTTER) format $(SRCS)

run:
	@echo "Running flutter app"
	@${FLUTTER} pub get
	@${FLUTTER} run

clean:
	@echo "╠ Cleaning caches of the app"
	@rm -rf build && rm -rf ios/Pods && rm -rf ios/Podfile.lock && pod cache clean --all && ${FLUTTER} clean && ${FLUTTER} pub get && cd ios && pod repo update && pod install && cd macos && pod repo update && pod install

fvmClean:
	@echo "╠ Cleaning caches of the app"
	@rm -rf build && rm -rf ios/Pods && rm -rf ios/Podfile.lock && rm -rf .pub-cache/hosted/pub.dartlang.org/ && pod cache clean --all && ${FVM} clean && ${FVM} pub get && cd ios && pod repo update && pod install

buildRunner:
	@echo "Run Pub build runner"
	@${FLUTTER} pub run build_runner build --delete-conflicting-outputs

fvmBuildRunner:
	@echo "Run Pub build runner"
	@${FVM} pub run build_runner build --delete-conflicting-outputs

podClean:
	@echo "Cleaning Pods"
	@rm -rf ios/Pods && pod cache clean --all
	@echo "Installing Pods"
	@cd ios && pod repo update && pod install

armPodClean:
	@echo "Cleaning Pods for arm64"
	@rm -rf ios/Pods && pod cache clean --all
	@echo "Installing Pods"
	@cd ios && arch -x86_64 pod repo update && arch -x86_64 pod install

android:
	@echo "Deploy Android"
	@cd android && fastlane deploy_staging --env dev
