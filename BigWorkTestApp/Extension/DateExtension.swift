//
//  DateExtension.swift
//  BigWorkTestApp
//
//  Created by kang jiyoun on 2021/08/13.
//

import Foundation

extension Date {
    
    func CompareWithDate() -> String{
        
        return "진행중"
        
        
    }

    func nowTimeDif() -> Bool {

        return self > nowKoreaTime()
    }
    
    func nowKoreaTime() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        var nowTime = Date()
        //시차가안맞아서 9시간더해줌
        nowTime.addTimeInterval(32400)
     
        let date = dateFormatter.date(from: dateFormatter.string(from: nowTime))
    
  
        
        return date!
    }
    
}

