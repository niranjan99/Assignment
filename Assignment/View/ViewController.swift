//
//  ViewController.swift
//  Assignment
//
//  Created by Niranjan on 18/06/20.
//  Copyright © 2020 Niranjan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  let viewModel = FactsViewModel()
  let contactsTableView = UITableView()
  var refreshControl = UIRefreshControl()
  var activityView = UIActivityIndicatorView()
  
    override func viewDidLoad() {
      super.viewDidLoad()
      view.backgroundColor = .white
      setupView()
   }

  func setupView(){
      initTableView()
      showActivityIndicator()
      viewModel.loadData()
      reloadTableView()
      refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
      contactsTableView.addSubview(refreshControl)
  }
    
 @objc func refreshData(_ sender: AnyObject) {
       viewModel.loadData()
  }
    
 func reloadTableView() {
        viewModel.reloadList = { [weak self] ()  in
            DispatchQueue.main.async {
             self?.hideActivityIndicator()
             self?.refreshControl.endRefreshing()
             self?.contactsTableView.reloadData()
             self?.title = self?.viewModel.feedData?.title
                self?.viewDidLayoutSubviews()
            }
        }
    }

 func initTableView(){
     view.addSubview(contactsTableView)
    contactsTableView.anchor(top: view.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: false)
     contactsTableView.register(DataTableViewCell.self, forCellReuseIdentifier: "DataTableCell")
     contactsTableView.delegate = viewModel
     contactsTableView.dataSource = viewModel
    // contactsTableView.estimatedRowHeight = 150
     contactsTableView.rowHeight = UITableView.automaticDimension
     contactsTableView.translatesAutoresizingMaskIntoConstraints = false
 }
  
 func showActivityIndicator() {
     activityView = UIActivityIndicatorView(style: .large)
     activityView.center = view.center
     activityView.hidesWhenStopped = true
     activityView.startAnimating()
     contactsTableView.addSubview(activityView)
 }
  
 func hideActivityIndicator(){
      activityView.stopAnimating()
 }
}
