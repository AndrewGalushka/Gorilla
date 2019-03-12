//
//  ImgurRequestManager.swift
//  Gorilla
//
//  Created by Galushka on 3/5/19.
//  Copyright © 2019 Galushka.com. All rights reserved.
//

import Moya

class ImgurRequestManager {
    private let provider: MoyaProvider<AnyImgurTarget>
    private let authorizationPlugin: ImgurAuthenticationPlugin
    private let clientID: String
    
    init(clientID: String) {
        self.clientID = clientID
        self.authorizationPlugin = ImgurAuthenticationPlugin()
        self.provider = MoyaProvider<AnyImgurTarget>.init(plugins: [authorizationPlugin])
        
        authorizationPlugin.delegate = self
    }
    
    func execute<D: JSONDataDecodable>(_ imgurAPI: ImgurAPI, mapper: D, competion: @escaping (_ result: SpecificResult<D.OutputModel, MoyaError>) -> Void) {
        
        self.execute(imgurAPI) { (result) in
            
            switch result {
            case .success(let response):
                
                switch self.map(response, mapper: mapper) {
                case .success(let mappedModel):
                    competion(SpecificResult<D.OutputModel, MoyaError>.success(mappedModel))
                case .failure(let error):
                    competion(SpecificResult<D.OutputModel, MoyaError>.failure(error))
                }
            case .failure(let error):
                competion(.failure(error))
            }
            
            
        }
    }
    
    func execute(_ imgurAPI: ImgurAPI, competion: @escaping Moya.Completion) {
        _ = self.execute(imgurAPI, completionClosure: { (result) in competion(result) })
    }
    
    private func execute(_ imgurAPI: ImgurAPI, progressClosure: Moya.ProgressBlock? = nil, completionClosure: @escaping Moya.Completion) -> Cancellable {
        return provider.request(AnyImgurTarget(imgurAPI.asImgurTarget), callbackQueue: DispatchQueue.main, progress: progressClosure, completion: completionClosure)
    }
    
    private func map<D: JSONDataDecodable>(_ moyaResponse: Moya.Response, mapper: D) -> SpecificResult<D.OutputModel, MoyaError> {

        do {
            let mappedModel = try mapper.decodeJSONData(moyaResponse.data)
            return .success(mappedModel)
        } catch (let error) {
            let moyaError = MoyaError.objectMapping(error, moyaResponse)
            return .failure(moyaError)
        }
    }
}

extension ImgurRequestManager: ImgurAuthenticationPluginDelegate {
    func imgurAuthenticationPlugin(_ imgurAuthPlugin: ImgurAuthenticationPlugin, tokenFor accessType: ImgurAccessType) -> String? {
        switch accessType {
        case .none: return nil
        case .clientID: return self.clientID
        case .token: return nil
        }
    }
}

