//
//  ViewModel.swift
//  PreyerApp
//
//  Created by Mohammed Alsaleh on 09/02/1444 AH.
//

import Combine
import CoreLocation
import Foundation
import SwiftUI

class ViewModel : ObservableObject {
    @Published var preyers : PreyerModel?
    @Published var cityName : String?
    
    func getCityName(long:String,lat:String) {
        let location = CLLocation(latitude: Double(lat)!, longitude: Double(long)!)
        CLGeocoder().reverseGeocodeLocation(location,preferredLocale: .init(identifier: "ar")) { placemark, err in
            if err != nil {
                print(err!.localizedDescription)
            } else {
                guard let place = placemark?.first else { return }
                self.cityName = place.administrativeArea! + ", " + place.locality!
            }
        }
    }
    
    func getData(long:String,lat:String) {
        guard let url = URL(string: "http://api.aladhan.com/v1/calendar?latitude=\(lat)&longitude=\(long)&method=4") else { return }
        URLSession.shared.dataTask(with: url) { (data, res, err) in
            if err != nil {
                print(err!.localizedDescription)
            } else {
                let jsonData = try? JSONDecoder().decode(PreyerModel.self, from: data!)
                if jsonData != nil {
                    DispatchQueue.main.async {
                        self.preyers = jsonData
                        print(self.preyers!.data.map({$0.date.gregorian.date.getDate.getStrDate}))
                    }
                }
            }
        }.resume()
    }
}
