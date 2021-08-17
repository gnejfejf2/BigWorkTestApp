
import Foundation
import Alamofire

//기본적인 통신에서 채택할 프로토콜이다
// baseUrlString -> 기본적인 URL
// path -> "/index.php"와 같은 실제 통신을 진행할 파일명
// method -> post get delete 와 같은 매스방법을 컨트롤하는공간
// parameters ->  통신에 필요한 파라미터를 담아 놓을공간
// request 서버에 요청

//Moya를 사용하는 방법도있지만 따로 과제에없어 그냥 퓨어하게처리했습니다.
protocol HttpRouter {
    ///기본
    var baseUrlString : String { get }
    var path : String { get }
    var method : HTTPMethod { get }
    var headers : HTTPHeaders? { get }
    var parameters : Parameters? { get }
    
    func request(usingHttpService service : HttpService , _ parameters : Data?) throws -> DataRequest
    
}



extension HttpRouter {
    
    var baseUrlString : String {
        ServerManager.shared.returnServerURL()
    }
    
    var parameters : Parameters? { return nil }
    
    
    //기본해더
    var headers : HTTPHeaders? { return ["X-AUTH-TOKEN" : "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIxODUiLCJyb2xlcyI6WyJST0xFX1VTRVIiXSwiaWF0IjoxNjExNTYzMzgxLCJleHAiOjE3MDYxNzEzODF9._4DPRRFx09yIBVLqwbTGVSuP6vy5fM4UP3vJXszfP4w"] }
    
    func asUrlRequest(_ parameters : Data?) throws -> URLRequest {
        
        var url = try baseUrlString.asURL()
        url.appendPathComponent(path)
       
        if(self.method == .get && parameters != nil){
            if let jsons = try JSONSerialization.jsonObject(with: parameters!, options: []) as? [String: Any] {
                for json in jsons{
                    
                    url = url.appending(json.key , value: "\(json.value)")
                }
            }
        }
       
        var request = try URLRequest(url: url, method: method, headers: headers)
        if(self.method != .get){
            request.httpBody = parameters
        }
        
        
        return request
    }
    
    func request(usingHttpService service : HttpService , _ parameters : Data? = nil) throws -> DataRequest{
        return try service.request(asUrlRequest(parameters))
    }
}



//새로운 통신이 추가될때마다 여기에 값을 추가할예정
//API 값에 따른 행동처리
enum Router : Int{
    case getCampaigns = 100
}
//http통신을 하는 기타 기본적인 값셋팅
// airports.json 라는 페이지에 통신하고
// 방식은 get방식
extension Router : HttpRouter{
   var path: String {
        switch self {
        case .getCampaigns:
            return "campaigns/category/0/story"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getCampaigns :
            return .get
        }
    }
    
  
    
    
}


//HttpService에 라우터를 넣어 통신을 진행한다
extension URL {

    func appending(_ queryItem: String, value: String?) -> URL {

        guard var urlComponents = URLComponents(string: absoluteString) else { return absoluteURL }

        var queryItems: [URLQueryItem] = urlComponents.queryItems ??  []

        let queryItem = URLQueryItem(name: queryItem, value: value)

        queryItems.append(queryItem)

        urlComponents.queryItems = queryItems

        return urlComponents.url!
    }
}
