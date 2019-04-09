//
//  VPNConnectionProtocol.swift
//  VPNManager
//
//  Created by Kaan Baris BAYRAK on 8.04.2019.
//  Copyright © 2019 Kaan Barış Bayrak. All rights reserved.
//

import Foundation

protocol VPNManagerDelegate {
    func VpnManagerConnectionFailed(error : VPNCollectionErrorType , localizedDescription : String)
    func VpnManagerConnected()
    func VpnManagerDisconnected()
    func VpnManagerProfileSaved()
    func VpnManagerProfileDeleted()
}
