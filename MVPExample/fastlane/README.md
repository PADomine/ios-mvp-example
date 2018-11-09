fastlane documentation
================
# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```
xcode-select --install
```

Install _fastlane_ using
```
[sudo] gem install fastlane -NV
```
or alternatively using `brew cask install fastlane`

# Available Actions
## iOS
### ios unit_tests
```
fastlane ios unit_tests
```
Runs all unit tests
### ios fetch_all_certificates
```
fastlane ios fetch_all_certificates
```
Fetches development and distribution certificates and provisioning profiles
### ios fetch_development_certificates
```
fastlane ios fetch_development_certificates
```
Fetches development certificate and provisioning profile
### ios fetch_distribution_certificates
```
fastlane ios fetch_distribution_certificates
```
Fetches distribution certificate and provisioning profile
### ios beta
```
fastlane ios beta
```
Push a new build to TestFlight
### ios version
```
fastlane ios version
```
Increment build number
### ios devices
```
fastlane ios devices
```
Register new devices

----

This README.md is auto-generated and will be re-generated every time [fastlane](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
