//
//  StringExtension.swift
//  BigWorkTestApp
//
//  Created by kang jiyoun on 2021/08/18.
//

import Foundation

extension String {
    
    func stringToDate() -> Date?{
        

        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.timeZone = TimeZone(abbreviation: "KST")
        let date : Date? = dateFormatter.date(from: self)
        
        return date
    }
    
}
