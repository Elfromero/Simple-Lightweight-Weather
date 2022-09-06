//
//  CityDetailsViewController.swift
//  Simple & Lightweight Weather
//
//  Created by Roman Radchuk on 31.08.2022.
//

import UIKit
import RxSwift
import RxDataSources

class CityDetailsViewController: UIViewController, StoryboardInstantiable {
    @IBOutlet var tableView: UITableView!
    
    var viewModel: CityDetailsViewModel!
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.forecast
            .map() { [weak self] forecastList -> [PeriodForecast] in
                guard let list = forecastList else { self?.showNoData(); return []}
                return list
            }
            .bind(to: tableView.rx.items(cellIdentifier: String(describing: ForecastTableViewCell.self), cellType: ForecastTableViewCell.self)) { row, model, cell in
                cell.configure(with: model)
        }.disposed(by: disposeBag)
        
        viewModel.refreshForecast()
    }
    
    private func showNoData() {
        
    }
    
}
