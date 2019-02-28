//
// Created by Galushka on 2019-02-20.
// Copyright (c) 2019 Galushka.com. All rights reserved.
//

import Alamofire
import Foundation

class ImgureSessionManager {
    
    // MARK: - Properties(Private)
    
    private let imgureClientID: String
    private let imgureSecretID: String
    
    private lazy var sessionManager: SessionManager = {
        let sessionManager = SessionManager(configuration: self.sessionConfiguration)

        return sessionManager
    }()

    private var sessionConfiguration: URLSessionConfiguration {
        return URLSessionConfiguration.default
    }
    
    // MARK: - Initializers
    
    init(imgureClientID: String, imgureSecretID: String) {
        self.imgureClientID = imgureClientID
        self.imgureSecretID = imgureSecretID
    }
    
    // MARK: - Methods(Public)
    
    func execute(_ endPoint: ImgurEndPoint) {
        let requestBuilder = self.requestBuilder(for: endPoint)
        
        sessionManager.request(requestBuilder).response { (dataResponse) in
        }
    }
    
//    func execute<ResponseMappingResult>(_ request: NetworkRequestModule<ResponseMappingResult>) -> ResponseMappingResult {
//
//    }
    
//    func execute<MappingResultType>(_ request: ImgureRequestModule<MappingResultType>) throws -> MappingResultType {
//        return try request.responseDataMapper.map(dictionary: [String: Any]())
//    }
    
//    func execute(_ request: NetworkRequestModule) -> NetworkRequestModule.ResponseDataMapperType.OutputType {
//
//    }
    
    // MARK: - Methods(Private)
    
    private func requestBuilder(for endPoint: ImgurEndPoint) -> ImgurRequestBuilder {
        let requestBuilder = ImgurRequestBuilder(endPoint: endPoint)
        
        return requestBuilder
    }
}
