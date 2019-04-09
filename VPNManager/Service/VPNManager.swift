//
//  VPNManager.swift
//  VPNManager
//
//  Created by Kaan Baris BAYRAK on 8.04.2019.
//  Copyright © 2019 Kaan Barış Bayrak. All rights reserved.
//

import Foundation
import NetworkExtension
import CoreData

private let instance = VPNManager()

open class VPNManager {
    
    var delegate : VPNManagerDelegate!
    
    private var manager: NEVPNManager {
        return NEVPNManager.shared()
    }
    
    public var status: NEVPNStatus {
        return manager.connection.status
    }
    
    public lazy var mmdb: MMDB? = {
        return MMDB()
    }()
    
    public class var shared: VPNManager {
        return instance
    }
    
    public func save(_ account: VPNAccount) {
        self.save(account, saveAndConnect: false)
    }
    
    public func saveAndConnect(_ account: VPNAccount) {
        manager.loadFromPreferences { error in
            if(error != nil){
                self.save(account, saveAndConnect: true)
            }else{
                self.connect()
            }
        }
    }
    
    private func save(_ account: VPNAccount , saveAndConnect : Bool) {
        var nevProtocol: NEVPNProtocol
        
        if account.type == .IPSec {
            let p = NEVPNProtocolIPSec()
            p.useExtendedAuthentication = true
            p.localIdentifier = account.groupName ?? "VPNTest"
            p.remoteIdentifier = account.remoteID
            if let secret = account.secretRef {
                p.authenticationMethod = .sharedSecret
                p.sharedSecretReference = secret
            } else {
                p.authenticationMethod = .none
            }
            nevProtocol = p
        } else {
            let p = NEVPNProtocolIKEv2()
            p.useExtendedAuthentication = true
            p.localIdentifier = account.groupName ?? "VPNTest"
            p.remoteIdentifier = account.remoteID
            if let secret = account.secretRef {
                p.authenticationMethod = .none
                p.sharedSecretReference = secret
            } else {
                p.authenticationMethod = .none
            }
            p.deadPeerDetectionRate = NEVPNIKEv2DeadPeerDetectionRate.medium
            nevProtocol = p
        }
        
        nevProtocol.disconnectOnSleep = !account.alwaysOn
        nevProtocol.serverAddress = account.server
        
        if let username = account.account {
            nevProtocol.username = username
        }
        
        if let password = account.passwordRef {
            nevProtocol.passwordReference = password
        }
        
        manager.localizedDescription = account.groupName
        manager.protocolConfiguration = nevProtocol
        manager.isEnabled = true
        
        configOnDemand()
        
        manager.saveToPreferences { error in
            if let err = error {
                self.delegate.VpnManagerConnectionFailed(error: VPNCollectionErrorType.UnkownError, localizedDescription: "Failed to save profile: \(err.localizedDescription)")
            } else {
                if(saveAndConnect){
                    self.delegate.VpnManagerProfileSaved()
                    self.connect()
                }else{
                    self.delegate.VpnManagerProfileSaved()
                }
            }
        }
    }
    
    public func connect() {
        do {
            try self.manager.connection.startVPNTunnel()
            self.delegate.VpnManagerDisconnected()
        } catch NEVPNError.configurationInvalid {
            self.delegate.VpnManagerConnectionFailed(error: VPNCollectionErrorType.ConfigurationInvalid, localizedDescription: "Configuration Invalid")
        } catch NEVPNError.configurationDisabled {
            self.delegate.VpnManagerConnectionFailed(error: VPNCollectionErrorType.ConfigurationDisabled, localizedDescription: "Configuration Disabled")
        } catch let error as NSError {
            NotificationCenter.default.post(
                name: NSNotification.Name.NEVPNStatusDidChange,
                object: nil
            )
            self.delegate.VpnManagerConnectionFailed(error: VPNCollectionErrorType.UnkownError, localizedDescription: error.localizedDescription)
        }
    }
    
    public func configOnDemand() {
        manager.onDemandRules = [NEOnDemandRule]()
        manager.isOnDemandEnabled = false
    }
    
    public func disconnect() {
        manager.connection.stopVPNTunnel()
        self.delegate.VpnManagerDisconnected()
    }
    
    public func removeProfile() {
        // The first removing disable on demand feature of the VPN
        manager.removeFromPreferences { _ in
            // This one actually remove the VPN profile
            self.manager.removeFromPreferences { _ in
                self.delegate.VpnManagerProfileDeleted()
            }
        }
    }
}
