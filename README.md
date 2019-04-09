VPNManager ![cocoapods](https://img.shields.io/cocoapods/v/VPNManager.svg)[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage) ![Swift 5.0](https://img.shields.io/badge/Swift-5.0-orange.svg)
===========

### How to get started
- install via [CocoaPods](http://cocoapods.org)
- Don't you have any VPN Server ? , you can look here : https://www.digitalocean.com/community/tutorials/how-to-set-up-an-ikev2-vpn-server-with-strongswan-on-ubuntu-18-04-2

### CocoaPods
```ruby
platform :ios, '11.0'

# You need to set target when you use CocoaPods 1.0.0 or later.
target 'SampleTarget' do
  use_frameworks!
  pod 'VPNManager'
end
```

### Methods

``` swift
//Import Framework
import VPNManager

//Create your VPN Manager variable
let vpn = VPNManager.shared
vpn.delegate = self 

//Create your VPN Account and configurations
let vpnAccount = VPNAccount(id: "UNIQUE ID", type: VPNProtocolType.IKEv2, title: "TITLE SEEN IN SETTINGS", server: "IP HERE", account: "bd2147240ab2471d", groupName: "Group Name Of Your VPN", remoteId: "Remote IP Address(Same most of the time)", alwaysOn: true)

//Set your account password and secret
vpnAccount.passwordRef = "YourVPNPassword".data(using: .utf8)
//If you are using IPSec you can use this in order to set secret
vpnAccount.secretRef = "YourVPNSecret".data(using: .utf8)
//Note : If you want to secure you secrets and passwords for your VPN you can use some Keychain wrapper 

//Save and connect your 
vpn.saveAndConnect(account : vpnAccount)

//Only Save account then connect
vpn.save(account : vpnAccount)
vpn.connect()

//Disconnect
vpn.disconnect()

//Remove saved Account
vpn.removeProfile()

//Config On Demand (Connect only on request is made)
vpn.configOnDemand()

```


### Delegate Methods

VPNManagerDelegate Methods:
```swift
public func VpnManagerConnectionFailed(error : VPNCollectionErrorType , localizedDescription : String)
```
This called when connection failed with error type and description
```swift
public func VpnManagerConnected()
```
This method called when connection established successfully
```swift
public func VpnManagerDisconnected()
```
This method called when disconnect action made successfully
```swift
public func VpnManagerProfileSaved()
```
This method called when you save your VPN account
```swift
public func VpnManagerProfileDeleted()
```
This method called when you delete your VPN account



# Requirements
- Swift 5
- iOS 11.0 or above.

# License
[MIT](http://thi.mit-license.org/)
