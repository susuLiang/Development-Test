//
//  APIManager.swift
//  DevelopmentTest
//
//  Created by Hsu Ming Ku on 2020/3/18.
//  Copyright © 2020 Shu Wei Liang. All rights reserved.
//

import Foundation
import Alamofire

class APIManager {
    
    static let shared = APIManager()
    
    var enviroment: Enviroment = .dev
    
    enum Enviroment {
        case dev
        case release
        
        var domain: String {
            switch self {
            case .dev:
                return "https://interview-api.kollectin.com/"
            case .release:
                return "https://interview-api.kollectin.com/api/"
            }
        }
    }
    
    
    func getPosts(pageNo: Int = 1, completionHandler: @escaping (Result<PostModel, AFError>) -> ()) {
        
        let parameters: [String: String] = ["limit": "10", "pageNo": "\(pageNo)"]
        let path = self.enviroment.domain + "api/social/posts"
        
        AF.request(path, method: .get, parameters: parameters, encoder: URLEncodedFormParameterEncoder.default).validate().responseJSON() { response in
            switch response.result {
            case .success(let result):
                guard let result = result as? [String: Any] else { return }
                let postModel = PostModel(from: result)
                completionHandler(.success(postModel))
                
            case .failure(let error):
                completionHandler(.failure(error))
            }
            
        }
    }
    
    
}
