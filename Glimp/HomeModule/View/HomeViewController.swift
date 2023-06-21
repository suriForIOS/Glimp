//
//  HomeViewController.swift
//  Glimp
//
//  Created by Surbhi Bagadia on 17/06/23.
//

import UIKit

var timeCollectionViewCellReusableIdentifier: String {
    return "TimeCollectionViewCell"
}

var programCollectionViewCellReusableIdentifier: String {
    return "ProgramCollectionViewCell"
}

class HomeViewController: UIViewController {
    // MARK: Static Constants
    struct Constants {
        static var collectionViewXOffset: CGFloat = 0
        static var collectionViewYOffset: CGFloat = 150
        static var collectionViewHeight: CGFloat = 0
        static var collectionViewWidth: CGFloat = 0
        static var collectionViewHorizontalPadding: CGFloat = 16
        static var navigationBarTitle = "Home"
        static var sectionTitle = "Today"
        static var collectionViewCellDefaultWidth: CGFloat = 300
    }

    var output: HomeViewOutput?
  
    lazy var programCaraousel: UICollectionView = {
        let layout = CustomCollectionViewLayout()
        layout.delegate = self
        let collectionView = UICollectionView(frame: CGRect(x: Constants.collectionViewXOffset, y: Constants.collectionViewYOffset, width: Constants.collectionViewWidth, height: Constants.collectionViewHeight), collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        output?.viewDidLoad()
    }
}

private extension HomeViewController {
    
    func setupUI() {
        overrideUserInterfaceStyle = .light
        self.view.addSubview(programCaraousel)
        
        NSLayoutConstraint.activate([
            programCaraousel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: Constants.collectionViewHorizontalPadding),
            programCaraousel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -Constants.collectionViewHorizontalPadding),
            programCaraousel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: Constants.collectionViewYOffset),
            programCaraousel.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
        self.navigationItem.title = Constants.navigationBarTitle
        initialiseProgramCarousel()
    }
    
    func initialiseProgramCarousel() {
        programCaraousel.register(TimeCollectionViewCell.self, forCellWithReuseIdentifier: timeCollectionViewCellReusableIdentifier)
        programCaraousel.register(ProgramCollectionViewCell.self, forCellWithReuseIdentifier: programCollectionViewCellReusableIdentifier)
        programCaraousel.delegate = self
        programCaraousel.dataSource = self
    }
}

// MARK: CollectionViewProtocols Extension
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        guard let dataModelCount = output?.dataModel.count else { return 1 }
        
        return dataModelCount + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            guard let timeslots = output?.timeSlots else { return 1 }
            
            return timeslots.count + 1
        default:
            guard let data = output?.dataModel, !data.isEmpty else { return 1 }
            
            return data[section - 1].programs.count + 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: timeCollectionViewCellReusableIdentifier,
                                                                for: indexPath) as? TimeCollectionViewCell,
                  let timeSlots = output?.timeSlots,
                  !timeSlots.isEmpty else { return UICollectionViewCell() }
            
            switch indexPath.row {
            case 0:
                cell.setup(model: TimeCollectionViewCellModel(date: Constants.sectionTitle))
            default:
                cell.setup(model: TimeCollectionViewCellModel(date: timeSlots[indexPath.row - 1].slot))
            }
            return cell
        default:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: programCollectionViewCellReusableIdentifier,
                                                                for: indexPath) as? ProgramCollectionViewCell,
                  let data = output?.dataModel,
                  !data.isEmpty else { return UICollectionViewCell() }
            
            switch indexPath.row {
            case 0:
                cell.setup(model: ProgramCollectionViewCellModel(title: data[indexPath.section - 1].channelName))
            default:
                cell.setup(model: ProgramCollectionViewCellModel(title: data[indexPath.section - 1].programs[indexPath.row - 1].programName))
            }
            return cell
        }
    }
}

// MARK: HomeViewInput Extension
extension HomeViewController: HomeViewInput {
    func reloadData() {
        programCaraousel.reloadData()
    }
    
    func showFailedState() {}
}

// MARK: CustomCollectionViewLayoutPrototcol Extension
extension HomeViewController: CustomCollectionViewLayoutPrototcol {
    func collectionView(_ collectionView: UICollectionView, widthForProgramAtIndexPath indexPath: IndexPath) -> CGFloat {
        guard let data = output?.dataModel, !data.isEmpty, indexPath.row > 0, indexPath.section > 0, indexPath.row <= data[indexPath.section - 1].programs.count else { return Constants.collectionViewCellDefaultWidth }
        
        return CGFloat(data[indexPath.section - 1].programs[indexPath.row - 1].length * Constants.collectionViewCellDefaultWidth)
    }
}
