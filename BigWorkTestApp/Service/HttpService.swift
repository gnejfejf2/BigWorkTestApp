//
//  HttpService.swift
//  ClimbMateStoryBoard
//
//  Created by kang jiyoun on 2021/07/14.
//

import Foundation
import Alamofire

///Http통신을 도와주는 기본적인 프로토콜
protocol HttpService {
    var sessionManager : Session { get }
    func request(_ urlRequest : URLRequestConvertible) -> DataRequest
}
