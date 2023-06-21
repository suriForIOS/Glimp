//
//  HomeInteractorInOut.swift
//  Glimp
//
//  Created by Surbhi Bagadia on 17/06/23.
//

import Foundation

protocol HomeInteractorInput: AnyObject {
    var output: HomeInteractorOutput? { get set }
    func getData()
}

protocol HomeInteractorOutput: AnyObject {
    func interactorDidFetch(channels: [Channel], programs: [Program])
    func intercatorDidFailToFetchData()
}
