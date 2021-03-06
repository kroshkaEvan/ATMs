//
//  ListViewController.swift
//  Task4
//
//  Created by Эван Крошкин on 27.02.22.
//

import UIKit
import SnapKit

class ListViewController: UIViewController {
    private var townNames = [String]()
    private var modelForWork = [String: [ATM]]()
    
    var model: [ATM]?
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: Constants.Dimensions.cellsSpacing / 2,
                                           left: Constants.Dimensions.cellsSpacing,
                                           bottom: Constants.Dimensions.cellsSpacing / 2,
                                           right: Constants.Dimensions.cellsSpacing)
        let numberOfItemsInSection = 2
        let cellWidth = (view.bounds.width
                         - layout.sectionInset.left
                         - layout.sectionInset.right
                         - Constants.Dimensions.cellsSpacing
                         * (CGFloat(numberOfItemsInSection) + 1)) / CGFloat(numberOfItemsInSection)
        let cellHeight = cellWidth
        layout.minimumLineSpacing = Constants.Dimensions.cellsSpacing
        layout.minimumInteritemSpacing = Constants.Dimensions.cellsSpacing
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        layout.headerReferenceSize = CGSize(width: self.view.width,
                                            height: Constants.Dimensions.sectionHeight)
        let collectionView = UICollectionView(frame: self.view.frame,
                                              collectionViewLayout: layout)
        collectionView.register(ListCollectionViewCell.self,
                                forCellWithReuseIdentifier: ListCollectionViewCell.reuseIdentifier)
        collectionView.register(SectionReusableView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: SectionReusableView.identifier)
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.keyboardDismissMode = .onDrag
        return collectionView
    }()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = Constants.Strings.searchBarPlaceholder
        searchBar.showsCancelButton = false
        searchBar.backgroundColor = .lightGray
        searchBar.sizeToFit()
        searchBar.isTranslucent = true
        return searchBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
    }
    
    private func setupVC() {
        view.addSubview(collectionView)
        view.addSubview(searchBar)
        collectionView.delegate = self
        collectionView.dataSource = self
        searchBar.delegate = self
        collectionView.snp.makeConstraints { make in
            make.leading.top.equalTo(searchBar.bottom)
            make.leading.bottom.equalToSuperview()
            make.leading.leading.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
        prepareModelForCollectionView()
    }
    
    func prepareModelForCollectionView() {
        modelForWork.removeAll()
        townNames.removeAll()
        
        model?.forEach({ atm in
            if !townNames.contains(atm.address.townName), !atm.address.townName.isEmpty {
                townNames.append(atm.address.townName)
            } else if !townNames.contains(atm.address.townName), atm.address.townName.isEmpty {
                townNames.append(atm.address.streetName)
            }
            modelForWork.append(element: atm, toValueOfKey: atm.address.townName)
            modelForWork.append(element: atm, toValueOfKey: atm.address.streetName)
        })
        townNames = townNames.sorted { $0 < $1 }
        modelForWork.forEach({ key, value in
            modelForWork.updateValue(value.sorted { $0.atmID < $1.atmID }, forKey: key)
        })
    }
}

extension ListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let key = townNames[section]
        return modelForWork[key]?.count ?? 0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return townNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListCollectionViewCell.reuseIdentifier, for: indexPath)
        if let cell = cell as? ListCollectionViewCell {
            let key = townNames[indexPath.section]
            cell.setup(viewModel: modelForWork[key]?[indexPath.row])
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let section = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                      withReuseIdentifier: SectionReusableView.identifier,
                                                                      for: indexPath)
        if  let sectionHeader = section as? SectionReusableView {
            sectionHeader.sectionLabel.text = townNames[indexPath.section]
            return sectionHeader
        }
        return UICollectionReusableView()
    }
    
}

extension ListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let mainController = self.parent as? MainViewController else { return }
        let key = townNames[indexPath.section]
        mainController.forceMapCallout(for: modelForWork[key]?[indexPath.row].address.addressLine ?? "")
    }
}

extension ListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let searchedTownIndex = townNames.firstIndex(where: { $0.lowercased().starts(with: searchText.lowercased())}) else { return }
        self.collectionView.scrollToItem(at: IndexPath(item: 0, section: searchedTownIndex),
                                         at: .centeredVertically,
                                         animated: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}
