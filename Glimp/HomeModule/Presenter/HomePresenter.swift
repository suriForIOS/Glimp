//
//  HomePresenter.swift
//  Glimp
//
//  Created by Surbhi Bagadia on 17/06/23.
//

import Foundation

class HomePresenter {
    // MARK: Static Constants
    struct Constants {
        static var programTimeSlot = "2020-07-09T01:30:00Z"
        static var startTimeSlot = "09-07-2020 01:30 AM"
        static var endTimeSlot = "10-07-2020 05:00 AM"
        static var timeSlotDateFormat = "dd-MM-yyyy hh:mm a"
        static var timeSlotStringDateFormat = "hh:mm a"
        static var dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        static var commercialProgram = "Commercial"
    }
    
    var interactor: HomeInteractorInput?
    var view: HomeViewInput?
    var dataModel = [SectionDataModel]()
    var timeSlots = [HeaderSlotDataModel]()
}

// MARK: HomeViewOutput Extension
extension HomePresenter: HomeViewOutput {
    func viewDidLoad() {
        prepareTimeSlotDataModel()
        interactor?.getData()
    }
}

// MARK: HomeInteractorOutput Extension
extension HomePresenter: HomeInteractorOutput {
    func interactorDidFetch(channels: [Channel], programs: [Program]) {
        prepareDataModel(channels: channels, programs: programs)
    }
    
    func intercatorDidFailToFetchData() {
        view?.showFailedState()
    }
}

private extension HomePresenter {
    func prepareTimeSlotDataModel() {
        var timeSlots: [HeaderSlotDataModel] = []
        if let date1 = getDate(from: Constants.startTimeSlot, with: Constants.timeSlotDateFormat), let date2 = getDate(from: Constants.endTimeSlot, with: Constants.timeSlotDateFormat) {
            var index = 1
            let string = getString(from: date1, with: Constants.timeSlotStringDateFormat)
            timeSlots.append(HeaderSlotDataModel(date: date1, slot: string))
            while true {
                let date = date1.addingTimeInterval(TimeInterval(index * 30 * 60))
                let string = getString(from: date, with: Constants.timeSlotStringDateFormat)
                
                if date >= date2 {
                    break;
                }
                
                index += 1
                timeSlots.append(HeaderSlotDataModel(date: date, slot: string))
            }
        }
        self.timeSlots = timeSlots
    }
    
    func prepareDataModel(channels: [Channel], programs: [Program]) {
        var sectionData = [SectionDataModel]()
        for channel in channels {
            var rowData = [RowDataModel]()
            var previousStartTime = getDate(from: Constants.programTimeSlot, with: Constants.dateFormat)
            var previousProgramLength: Double = 0
            for program in programs {
                if program.recentAirTime.channelID == channel.id {
                    if let startTime = getDate(from: program.startTime, with: Constants.dateFormat), let previousStartTime = previousStartTime {
                        let expectedStartTime = previousStartTime.addingTimeInterval(TimeInterval(previousProgramLength * 60))
                        let difference = getDifference(from: expectedStartTime, to: startTime)
                        if difference > 0 {
                            let row = RowDataModel(programName: Constants.commercialProgram, startTime: getString(from: expectedStartTime, with: Constants.dateFormat), length: difference / 30)
                            rowData.append(row)
                        }
                    }
                    previousStartTime = getDate(from: program.startTime, with: Constants.dateFormat)
                    previousProgramLength = program.length
                    let row = RowDataModel(programName: program.name, startTime: program.startTime, length: program.length / 30)
                    rowData.append(row)
                }
            }
            let section = SectionDataModel(channelID: channel.id, channelName: channel.callSign, programs: rowData)
            sectionData.append(section)
        }
        self.dataModel = sectionData
        view?.reloadData()
    }
    
    func getString(from date: Date, with format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
    
    func getDate(from string: String, with format: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.date(from: string)
    }
    
    func getDifference(from date1: Date, to date2: Date) -> Double {
        let distanceBetweenDates = date2.timeIntervalSince(date1)
        let minBetweenDates = Double(distanceBetweenDates / 60)
        return minBetweenDates
    }
}
