//
//  DashboardViewController.swift
//  Test
//
//  Created by PritamSing Salunkhe on 09/08/21.
//

import UIKit

protocol DashboardListView {
    func initialSetup()
    func reloadTableView()
}

class DashboardViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var presenter: DashboardPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let service = DashboardServiceImplementation()
        let usecase = DashboardListUseCaseImplementation(service: service)
        presenter = DashboardPresenterImplementation(view: self, usecase: usecase)
        presenter?.initialSetup()
    }
    
    private func registerCells() {
        self.collectionView.register(UINib.init(nibName: CellConstant.ImageCell, bundle: nil), forCellWithReuseIdentifier: CellConstant.ImageCell)
        self.listTableView.register(UINib.init(nibName: CellConstant.TableCell, bundle: nil), forCellReuseIdentifier: CellConstant.TableCell)

    }
}

extension DashboardViewController: DashboardListView {
    func initialSetup() {
        registerCells()
    }
    
    func reloadTableView() {
        listTableView.reloadData()
    }
}

extension DashboardViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.numberOfItemsInCollectionView() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let imageCell = collectionView.dequeueReusableCell(withReuseIdentifier: CellConstant.ImageCell, for: indexPath) as? ImageCollectionViewCell, let imageName = presenter?.getImageAt(indexPath: indexPath) {
            imageCell.configureCell(imageName: imageName)
            return imageCell
        } else {
            let defaultCell = ImageCollectionViewCell.init(frame: CGRect.zero)
            return defaultCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize = UIScreen.main.bounds
        return CGSize(width: screenSize.width, height: screenSize.height)
    }
}

extension DashboardViewController: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfRowsInTableView() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let tableCell = tableView.dequeueReusableCell(withIdentifier:
                                                            CellConstant.TableCell) as? ListTableViewCell, let title = presenter?.getTextAt(indexPath: indexPath) {
            
            tableCell.configureCell(titleText: title)
            tableCell.selectionStyle = .none
            return tableCell
        } else {
            let defaultCell = ListTableViewCell.init(style: .default, reuseIdentifier: nil)
            return defaultCell
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter?.updateSearchText(searchText: searchText)
    }
}
