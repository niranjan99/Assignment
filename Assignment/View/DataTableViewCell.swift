//
//  DataTableViewCell.swift
//  Assignment
//
//  Created by Niranjan on 18/06/20.
//  Copyright © 2020 Niranjan. All rights reserved.
//

import UIKit
class DataTableViewCell: UITableViewCell {
 var myViewHeightConstraint: NSLayoutConstraint!
    var setData:ListModel? {
           didSet {
               guard let contactItem = setData else {return}
               if let name = contactItem.title {
                   profileImageView.image = UIImage(named: name)
                   nameLabel.text = name
               }
                if let imageURL = contactItem.imageHref {
                    profileImageView.downloadImageFromURL(imageURL)
                }
                else{
                     profileImageView.image = UIImage(named: "placeholder")
                 }
               if let desc = contactItem.description {
                   detailedLabel.text = desc
               }
        }
       }
    
   private let containerView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true // this will make sure its children do not go out of the boundary
        return view
    }()
    
   private let profileImageView:UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.translatesAutoresizingMaskIntoConstraints = false // enable autolayout
        img.layer.cornerRadius = 5
        img.clipsToBounds = true
        return img
    }()
    
   private let nameLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
   private let detailedLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor =  .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
   override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    addSubview(profileImageView)
    addSubview(nameLabel)
    addSubview(detailedLabel)

    
    profileImageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 7, paddingLeft: 5, paddingBottom: 0, paddingRight: 0, width: 50, height: 50, enableInsets: false)
    
    nameLabel.anchor(top: topAnchor, left: profileImageView.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 5, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: frame.size.width , height: 0, enableInsets: false)
    
    detailedLabel.anchor(top: nameLabel.bottomAnchor, left: profileImageView.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 10, paddingRight: 0, width: frame.size.width , height: 0, enableInsets: false)

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
         
    }

}


