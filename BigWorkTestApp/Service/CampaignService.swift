import RxSwift
import RxCocoa
import Alamofire


protocol CampaignAPI{
    //Single은 Obvservable의 한 형태이며,
    //한 가지의 값 또는 에러를 발행합니다. 그렇기에 Single을 구독시 success, error 두 개의 이벤트에 처리를 합니다
    func fetchCampaign(pagingCount : Int , pagingSize : Int) -> Single<[CampaignModelElement]>
  //  func fetchCampaign() -> Single<[CampaignModelElement]>
    
}

//통신을하는 객체
class CampaignService {
    private lazy var httpService = HttpNetworkService.shared
    //AirportService 는 싱글톤 객체이다.
    static let shared : CampaignService = CampaignService()
}

//Airport관련된
extension CampaignService : CampaignAPI{
    
    func fetchCampaign(pagingCount : Int , pagingSize : Int) -> Single<CampaignModelElements> {
    //func fetchCampaign() -> Single<CampaignModelElements> {
        return Single.create { [httpService] (single) -> Disposable in
            do{
                let parameters: [String : Int] = ["page": pagingCount , "size": pagingSize]
                let encodedDictionary = try JSONEncoder().encode(parameters)
                   
              
                try Router.init(rawValue: 100)?.request(usingHttpService: httpService , encodedDictionary)
                    .responseJSON { (result) in
                        do {

                            let Campaigns = try CampaignService.parseModelElements(result: result)
                          
                            single(.success(Campaigns))
                        }catch{
                           
                            single(.failure(error))
                        }

                    }
            }catch{
               
                single(.failure(error))
            }
            
            return Disposables.create()
        }
    }
}

extension CampaignService {
    //통신값을 파싱해주는 함수
    static func parseModelElements(result : AFDataResponse<Any>) throws -> CampaignModelElements{

        guard let data = result.data ,
        let CampaignModelResponse = try? JSONDecoder().decode(CampaignModelElements.self, from: data)
        else {
            throw CustomError.error(message: "Invalid Airports JSON")
        }
        
        return CampaignModelResponse
        
    }
    
}
