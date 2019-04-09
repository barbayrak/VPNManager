//
//  VPNAccount.swift
//  VPNManager
//
//  Created by Kaan Baris BAYRAK on 8.04.2019.
//  Copyright © 2019 Kaan Barış Bayrak. All rights reserved.
//

import Foundation

public struct VPNAccount {
    public var ID: String = ""
    public var type: VPNProtocolType = .IPSec
    public var title: String = ""
    public var server: String = ""
    public var account: String?
    public var groupName: String?
    public var remoteID: String?
    public var alwaysOn = true
    public var passwordRef: Data?
    public var secretRef: Data?
    
    public init() { }
    
    public init(id : String , type : VPNProtocolType,title : String,server : String , account : String , groupName : String , remoteId : String , alwaysOn : Bool){
        self.ID = id
        self.type = type
        self.title = title
        self.server = server
        self.account = account
        self.groupName = groupName
        self.remoteID = remoteId
        self.alwaysOn = alwaysOn
    }
}
