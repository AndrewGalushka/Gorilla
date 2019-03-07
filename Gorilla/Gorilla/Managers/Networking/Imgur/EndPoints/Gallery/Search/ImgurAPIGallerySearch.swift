//
// Created by Galushka on 2019-03-04.
// Copyright (c) 2019 Galushka.com. All rights reserved.
//

import Moya

extension ImgurAPI.Gallery {

    struct Search: ImgurTarget {        
        let params: Params

        init(_ params: Params) {
            self.params = params
        }

        var path: String {
            let path: String = "gallery/search"
            return path
        }

        var task: Task {
           return Task.requestParameters(parameters: self.queryParams, encoding: URLEncoding.queryString)
        }

        var method: Moya.Method {
            return .get
        }
        
        private var queryParams: [String: Any] {
            var queryParams = [String: Any]()
            
            queryParams["sort"] = self.params.sort?.rawValue
            queryParams["q_all"] = self.params.query
            queryParams["q_size_px"] = self.params.size?.rawValue
            queryParams["q_type"] = self.params.contentType?.rawValue
            
            return queryParams
        }
        
        struct Params {
            let query: String
            let size: SizeType?
            let sort: SortType?
            let contentType: MediaContentType?
            
            init(query: String, sort: SortType? = nil, size: SizeType? = nil, type: MediaContentType? = nil) {
                self.query = query
                self.sort = sort
                self.size = size
                self.contentType = type
            }
            
            enum SizeType: String {
                case small = "small"
                case medium = "med"
                case big = "big"
                case large = "lrg"
                case huge = "huge"
            }
            
            enum SortType: String {
                case time
                case viral
                case top
            }
            
            enum MediaContentType: String {
                case jpg
                case png
                case gif
                case anigif
                case album
            }
        }
    }
}
