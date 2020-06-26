//
//  FactsViewModel.swift
//  Assignment
//
//  Created by Niranjan on 18/06/20.
//  Copyright © 2020 Niranjan. All rights reserved.
//

import Foundation
import UIKit
class FactsViewModel:NSObject{
    
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

extension FactsViewModel: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat    {
                  return UITableView.automaticDimension
        }
}
extension FactsViewModel: UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return feedData?.rows?.count ?? 0

        }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->    UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DataTableCell", for:    indexPath) as! DataTableViewCell
            cell.setData = feedData?.rows?[indexPath.row]
            return cell
        }
}
