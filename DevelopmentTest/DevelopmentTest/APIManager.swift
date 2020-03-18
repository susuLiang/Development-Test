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
    
    
    func getPosts(page: Int = 30, pageNo: Int = 1, completionHandler: () -> ()) {
        
        let parameters: [String: Any] = ["sort": "pop", "limit": page, "pageNo": pageNo]
        let path = self.enviroment.domain + "social/posts"
        let header: HTTPHeaders = ["x-api-version": "2", "x-access-token": "TOKEN"]
        
        AF.request(path, method: .get, parameters: parameters, headers: header).responseJSON() { response in
            print(response)
        }
    }
    
    
}
