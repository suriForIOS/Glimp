//
//  HomeViewInOut.swift
//  Glimp
//
//  Created by Surbhi Bagadia on 17/06/23.
//

import Foundation


protocol HomeViewInput: AnyObject {
    func reloadData()
    func showFailedState()
}

protocol HomeViewOutput: AnyObject {
    var interactor: HomeInteractorInput? { get set }
    var view: HomeViewInput? { get set }
    var dataModel: [SectionDataModel] { get set }
    var timeSlots: [HeaderSlotDataModel] { get set }
    func viewDidLoad()
}
