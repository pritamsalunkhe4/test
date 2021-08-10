//
//  DashboardPresenter.swift
//  Test
//
//  Created by PritamSing Salunkhe on 09/08/21.
//

import Foundation

protocol DashboardPresenter {
    func initialSetup()
    func numberOfItemsInCollectionView() -> Int
    func numberOfRowsInTableView() -> Int
    func getImageAt(indexPath: IndexPath) -> String
    func getTextAt(indexPath: IndexPath) -> String
    func updateSearchText(searchText: String)
}

class DashboardPresenterImplementation {
    var view: DashboardListView?
    var usecase: DashboardListUseCase?
    var images = [String]()
    var list: [String] = []
    var searchText = ""
    
    init(view: DashboardListView, usecase: DashboardListUseCase) {
        self.view = view
        self.usecase = usecase
    }
    
    private func filterData() -> [String] {
        return list.filter({ $0.contains(searchText) })
    }
}

extension DashboardPresenterImplementation: DashboardPresenter {
    func initialSetup() {
        images = ["image1.png", "image2.png", "image3.png", "image4.png"]
        list = ["Flower", "Plants", "Tree", "Planet", "Animal", "Human", "Building", "Water"]
        view?.initialSetup()
    }
    
    func numberOfItemsInCollectionView() -> Int {
        return images.count
    }
    
    func numberOfRowsInTableView() -> Int {
        if searchText.isEmpty {
            return list.count
        } else {
            return filterData().count
        }
    }
    
    func getImageAt(indexPath: IndexPath) -> String {
        return images[indexPath.row]
    }
    
    func getTextAt(indexPath: IndexPath) -> String {
        if searchText.isEmpty {
            return list[indexPath.row]
        } else {
            return filterData()[indexPath.row]
        }
    }
    
    func updateSearchText(searchText: String) {
        self.searchText = searchText
        view?.reloadTableView()
    }
}
