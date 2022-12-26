//
//  CarDataWorker.swift
//  Cars
//
//  Created by Linkon Sid on 18/12/22.
//

import Foundation

protocol CarDataWorkerProtocol{
    func processViewDataFrom(articles:[CarData])->[CarViewData]
    func processViewDataFrom(cars:[Car])->[CarViewData]
}
// This class format model data to presentable data for view purpose
final class CarDataWorker:CarDataWorkerProtocol{
    func processViewDataFrom(articles:[CarData])->[CarViewData]{
        articles.map{[weak self] item -> CarViewData in // convert to domain object for presentation
            var resultDate = ""
            var resultTime = ""
            if let calendar = self?.processDateFrom(item.dateTime.toDate()){
                resultDate = calendar.date
                resultTime = calendar.time
            }
            return CarViewData(id:item.id, title: item.title, image: item.image, description: item.ingress, date: resultDate, time: resultTime)
        }
    }
    func processViewDataFrom(cars:[Car])->[CarViewData]{
        cars.map{[weak self] item -> CarViewData in // convert to domain object for presentation
            var resultDate = ""
            var resultTime = ""
            if let calendar = self?.processDateFrom(item.date){
                resultDate = calendar.date
                resultTime = calendar.time
            }
            return CarViewData(id:item.id, title: item.title, image: item.image, description: item.ingress, date: resultDate, time: resultTime)
        }
    }
    private func processDateFrom(_ dateObj:Date?)->(date:String,time:String){
        var presentableTime = ""
        var presentableDate = ""
        if let date = dateObj{
            let time = date.getTime()
            presentableDate = "\(date.getDateOfMonth()) \(date.getMonthName()) \(date.getYearByComparingToCurrent())"
            presentableTime = "\(time.hour):\(time.minute)"
        }
        return (presentableDate,presentableTime)
    }
}
