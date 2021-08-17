
//서버 URL관리

import Foundation

class ServerManager {
    
    static let shared : ServerManager = ServerManager()
    
    ///해당값이 false 가되면 모든 통신이 실서버에서 이루어진다
    private let testServer : Bool = true
    
    private let testServerURL : String = "https://app-dev.bigwalk.co.kr:10000/api/"
    //private let testServerURL : String = "13.209.4.105"
    
    private let realServerURL : String = "https://app-dev.bigwalk.co.kr:10000/api/"
    
}

extension ServerManager {
    
    public func returnServerURL() -> String{
        if(self.testServer){
            return self.testServerURL
        }else{
            return self.realServerURL
        }
    }
    
}
