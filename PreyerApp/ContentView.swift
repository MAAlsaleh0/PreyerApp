//
//  ContentView.swift
//  PreyerApp
//
//  Created by Mohammed Alsaleh on 09/02/1444 AH.
//

import SwiftUI
import CoreLocation

struct ContentView: View {
    @StateObject var vm = ViewModel()
    @StateObject var locationVM = LocationManager()
    var body: some View {
        VStack {
            Text(vm.cityName ?? "")
            if self.locationVM.locationStatus == .denied || self.locationVM.locationStatus == .notDetermined || self.locationVM.locationStatus == .restricted  {
                Text("يجب عليك تفعيل خدمة الموقع لمعرفة مواقيت الصلوات.")
            } else {
        if vm.preyers != nil {
            List(vm.preyers!.data.filter({Date(timeIntervalSince1970: Double($0.date.timestamp)!).getStrDate == Date().getStrDate}),id:\.meta.latitude.binade) { data in
                preyerView(time: data.timings.fajr.getTimeOfPreyerSTR, timeName: .fajr)
                preyerView(time: data.timings.sunrise.getTimeOfPreyerSTR, timeName: .sunrise)
                preyerView(time: data.timings.dhuhr.getTimeOfPreyerSTR, timeName: .dhuhr)
                preyerView(time: data.timings.asr.getTimeOfPreyerSTR, timeName: .asr)
                preyerView(time: data.timings.maghrib.getTimeOfPreyerSTR, timeName: .maghrib)
                preyerView(time: data.timings.isha.getTimeOfPreyerSTR, timeName: .isha)
            }
            }
        }
        }.onAppear {
            guard let coordinate = locationVM.lastLocation?.coordinate else { return }
            self.vm.getData(long:coordinate.longitude.description, lat:coordinate.latitude.description)
            self.vm.getCityName(long:coordinate.longitude.description, lat:coordinate.latitude.description)
        }.onChange(of: self.locationVM.lastLocation) { _ in
            guard let coordinate = locationVM.lastLocation?.coordinate else { return }
            self.vm.getData(long:coordinate.longitude.description, lat:coordinate.latitude.description)
            self.vm.getCityName(long:coordinate.longitude.description, lat:coordinate.latitude.description)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct preyerView : View {
    @State var time : String
    @State var timeName : Timings.CodingKeys
    var body :some View {
        HStack {
            Text(time)
            Spacer()
        if timeName == .fajr {
            Text("الفجر")
        } else if timeName == .sunrise {
            Text("الشروق")
        } else if timeName == .dhuhr {
            Text("الظهر")
        } else if timeName == .asr {
            Text("العصر")
        } else if timeName == .maghrib {
            Text("المغرب")
        } else if timeName == .isha {
            Text("العشاء")
        }
        }
    }
}
