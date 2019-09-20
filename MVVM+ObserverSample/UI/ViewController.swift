//
//  ViewController.swift
//  MVVM+ObserverSample
//
//  Created by Antonio Corrales on 03/09/2019.
//  Copyright © 2019 DesarrolloManzana. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var dataViewModel = MainViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        initViewModel()
        self.tableView.dataSource = self.dataViewModel.dataSource
    }
    
    func initViewModel(){
        dataViewModel.dataSource.data.addAndNotify(observer: self) { [weak self] _ in
            DispatchQueue.main.async { self?.tableView.reloadData() }
        }
        
        dataViewModel.error?.data.addObserver(self) { [weak self] error in
            DispatchQueue.main.async { self?.showAlert(error ?? "") }
        }
        
        dataViewModel.isLoading?.data.addObserver(self) { [weak self] value in
            self?.loading(show: value)
        }
        dataViewModel.getData()
    }
    
    func loading(show: Bool?){
        switch show {
            case true:   DispatchQueue.main.async { self.activityIndicator.startAnimating() }
            case false:  DispatchQueue.main.async { self.activityIndicator.stopAnimating() }
            default:     break
        }
    }
}
