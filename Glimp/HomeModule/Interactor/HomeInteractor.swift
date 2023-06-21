//
//  Interactor.swift
//  Glimp
//
//  Created by Surbhi Bagadia on 17/06/23.
//

import Foundation

class HomeInteractor {
    let dispatchGroup = DispatchGroup()
    var output: HomeInteractorOutput?
    private var channels = [Channel]()
    private var programs = [Program]()
}

// MARK: HomeInteractorInput Extension
extension HomeInteractor: HomeInteractorInput {
    func getData() {
        getChannels()
        getPrograms()
        dispatchGroup.notify(queue: .main) { [weak self] in
            guard let self = self else { return }
            
            if channels.isEmpty || programs.isEmpty {
                self.output?.intercatorDidFailToFetchData()
            } else {
                self.output?.interactorDidFetch(channels: channels, programs: programs)
            }
        }
    }
}

private extension HomeInteractor {
    func getChannels() {
        dispatchGroup.enter()
        HomeService.shared.getChannels { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let channels):
                self.channels = channels
            case .failure(let error):
                print("error fetching channels \(error)")
            }
            self.dispatchGroup.leave()
        }
    }
    
    func getPrograms() {
        dispatchGroup.enter()
        HomeService.shared.getPrograms { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let programs):
                self.programs = programs
            case .failure(let error):
                print("error fetching programs \(error)")
            }
            self.dispatchGroup.leave()
        }
    }
}
