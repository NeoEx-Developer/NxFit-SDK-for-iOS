# NxFit SDK for iOS

*NxFit SDK for iOS* provides access to the NxFit REST API to retrieve user health data from the NxFit service. The SDK provides *clients*, which contain convenience methods to make HTTP calls to the NxFit API. Models for all the NxFit entities are also provided.

To further assist in adoption of the SDK, *managers* and *repositories* are also provided that use caching to improve performance. The NxFit SDK requires the consuming application to provide a user ID and an access token via the [AuthProviding](NXFitAuth/Sources/AuthProviding.swift) protocol in addition to configuration via the [ConfigurationProviding](NXFitConfig/Sources//ConfigurationProviding.swift) procol.

The NxFit SDK is split into four libraries, *NXFit*, *NXFitManagers*, *NXFitRepositories* and *NXFitSync*. Factories are provided to build each of the services.

## NXFitSync for HealthKit local integration

To sync data from HealthKit on the device, a library has been provided which handles this local integration. See [NXFitSync](NXfitSync/Sources/NXFitSync.swift) and [NXFitSyncFactory](NXFitSync/Sources/NXFitSyncFactory.swift) for additional details.

NXFitSync should be used in conjuction with the [NXFitManagers](NXFitManagers/Sources/NXFitManager.swift) and [IntegrationManaging](NXFitManagers/Sources/IntegrationManaging.swift) service, with the `NXFitSync/connect()` function being passed as the `IntegrationManaging/connect(_:connectLocalIntegrationCallback)` *connectLocalIntegrationCallback* argument.

```swift
let integrations: IntegrationManaging
let sync: NXFitSync
let healthkitIntegration: IntegrationModel
... *user selects healthkit local integration to connect*
try await integrations.connect(healthkitIntegration, connectLocalIntegrationCallback: sync.connect)
```

or for disconnect

```swift
let integrations: IntegrationManaging
let sync: NXFitSync
let healthkitIntegration: IntegrationModel
... *user selects healthkit local integration to connect*
try await integrations.disconnect(healthkitIntegration, disconnectLocalIntegrationCallback: sync.disconnect)
```

Data sync usage requires the *HealthKit* entitlement (background delivery is optional) and two privacy description entries in the *Info.plist* for 'Privacy - Health Update Usage Description' and 'Privacy - Health Share Usage Description'.
