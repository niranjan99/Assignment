//
//  FactsViewModel.swift
//  Assignment
//
//  Created by Niranjan on 18/06/20.
//  Copyright © 2020 Niranjan. All rights reserved.
//

import Foundation

class FactsViewModel{
    
    let service = RequestService()
    var reloadList = {() -> () in }
    public var feedData : FeedsModel? {
        ///Reload data when data set
        didSet{
            reloadList()
        }
    }
    func loadData(){
       service.loadData { jsonArray in
                 switch jsonArray {
                 case .success(let response):
                    self.feedData = response
               case .failure:
                     print("FAILED")
               }
            }
    }
    
    
}


