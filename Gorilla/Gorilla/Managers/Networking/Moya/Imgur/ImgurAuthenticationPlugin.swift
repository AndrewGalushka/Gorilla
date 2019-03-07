//
//  ImgurAuthenticationPlugin.swift
//  Gorilla
//
//  Created by Galushka on 3/6/19.
//  Copyright © 2019 Galushka.com. All rights reserved.
//

import Moya

enum ImgurAccessType {
    case none
    case token
    case clientID
    
    var prefix: String? {
        switch self {
        case .none: return nil
        case .token: return "Bearer"
        case .clientID: return "Client-ID"
        }
    }
}

protocol ImgurAccessTokenAuthorizable {
    var imgurAuthorizationType: ImgurAccessType { get }
}

class ImgurAuthenticationPlugin: PluginType {
    
    // MARK: - Properties
    
    weak var delegate: ImgurAuthenticationPluginDelegate?
    
    // MARK: - Methods(PluginType)
    
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        
        guard
            let accessType = (target as? ImgurAccessTokenAuthorizable)?.imgurAuthorizationType,
            let delegate = self.delegate
        else {
            return request
        }
    
        var request = request
        
        if let prefix = accessType.prefix, let token = delegate.imgurAuthenticationPlugin(self, tokenFor: accessType) {
            let value = "\(prefix) \(token)"
            request.addValue(value, forHTTPHeaderField: "Authorization")
        }
        return request
    }
}

protocol ImgurAuthenticationPluginDelegate: AnyObject {
    func imgurAuthenticationPlugin(_ imgurAuthPlugin: ImgurAuthenticationPlugin, tokenFor accessType: ImgurAccessType) -> String?
}

extension ImgurAuthenticationPluginDelegate where Self: ClientIDProvidable & TokenProvidable {
    
    func imgurAuthenticationPlugin(_ imgurAuthPlugin: ImgurAuthenticationPlugin, tokenFor accessType: ImgurAccessType) -> String? {
        
        switch accessType {
        case .none: return nil
        case .clientID: return self.clientID
        case .token: return self.token
        }
    }
}
