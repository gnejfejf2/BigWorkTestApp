
import Alamofire

class HttpNetworkService : HttpService{
    
    static let shared : HttpNetworkService = HttpNetworkService()
     
    /// Alamofire 제공하는 세션 메니저
    var sessionManager : Session = Session.init()
    
    
    func request(_ urlRequest: URLRequestConvertible) -> DataRequest {
        return sessionManager.request(urlRequest).validate(statusCode: 200..<400)
    }
    
}
