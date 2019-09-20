//
//  DataViewModel.swift
//  MVVMSample
//
//  Created by Antonio Corrales on 26/6/18.
//  Copyright © 2018 DesarrolloManzana. All rights reserved.
//

import UIKit

class MainViewModel {
    
    var error: StringDataSource<String>?
    var isLoading: BooleanDataSource<Bool>?
    var dataSource = TableDataSource()
    
    init() {
        self.error = StringDataSource<String>()
        self.isLoading = BooleanDataSource<Bool>()
    }

    func getData(){
        self.isLoading?.data.value = true
        ApiClient.getDataFromServer { (success, data) in
            self.isLoading?.data.value = false
            if success {
                self.dataSource.data.value = data
            } else {
                self.error?.data.value = "Ups, something went wrong."
            }
        }
    }
}
