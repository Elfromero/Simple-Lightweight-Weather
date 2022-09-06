//
//  HomeViewController.swift
//  Simple & Lightweight Weather
//
//  Created by Roman Radchuk on 29.08.2022.
//

import UIKit
import RxSwift
import RxDataSources

class HomeViewController: UIViewController, StoryboardInstantiable {
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!
    
    var viewModel: HomeViewModel!
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.rx.text.asObservable()
            .subscribe(viewModel.searchingText)
            .disposed(by: disposeBag)
        
        viewModel.cities.bind(to: tableView.rx.items(cellIdentifier: String(describing: CityTableViewCell.self), cellType: CityTableViewCell.self)) { row, model, cell in
                cell.configure(with: model)
        }.disposed(by: disposeBag)
        
        tableView.rx.modelSelected(CityModel.self)
            .subscribe { [weak self] model in
                self?.openDetails(with: model)
            }.disposed(by: disposeBag)
        
        viewModel.refreshData()
        
        addUnitsButton()
    }
    
    private func openDetails(with model: CityModel) {
        let cdDataProvider: CityDetailsDataProvider = DefaultCityDetailsDataProvider(apiClient: OpenWeatherAPINetworkClient(), cityModel: model)
        let cdViewModel : CityDetailsViewModel = DefaultCityDetailsViewModel(provider: cdDataProvider)
        let cdVC = CityDetailsViewController.instantiateViewController() as CityDetailsViewController
        cdVC.viewModel = cdViewModel
        cdVC.title = model.name
        self.navigationController?.pushViewController(cdVC, animated: true)
    }
    
    private func addUnitsButton() {
        let selectedUnits = UserManager.shared.getSelectedMeasurementUnitsType()
        let button = UIBarButtonItem(title: selectedUnits.temperatureUnitsString(),
                                     style: .done,
                                     target: self,
                                     action: #selector(switchMeasurementUnits))
        self.navigationItem.setRightBarButton(button, animated: false)
    }
    
    @objc private func switchMeasurementUnits(selector: UIBarButtonItem) {
        let newSelectedUnits = UserManager.shared.getSelectedMeasurementUnitsType().switchUnits()
        UserManager.shared.setSelectedMeasurementUnitsType(newSelectedUnits)
        selector.title = newSelectedUnits.temperatureUnitsString()
        self.viewModel.refreshData()
    }
}
