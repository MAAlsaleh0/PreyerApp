//
//  Extensions.swift
//  PreyerApp
//
//  Created by Mohammed Alsaleh on 09/02/1444 AH.
//

import Foundation

extension String {
    var getDate : Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Format.ddMmYyyy.rawValue
          return dateFormatter.date(from:self)!
    }
    var getTimeOfPreyerSTR : String {
        let text = self.dropLast(6)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let date = dateFormatter.date(from: String(text))
        return date!.getArabicTime
    }
}

extension Date {
   var getStrDate : String {
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = Format.ddMmYyyy.rawValue
     return dateFormatter.string(from: self)
    }
    var getArabicTime : String {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        formatter.locale = Locale(identifier: "ar_SA")
        return formatter.string(from: self)
    }
}
