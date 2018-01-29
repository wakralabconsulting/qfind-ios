//
//  CategoryCollectionViewCell.swift
//  QFind
//
//  Created by Exalture on 15/01/18.
//  Copyright © 2018 QFind. All rights reserved.
//

import Alamofire
import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var categoryViewTrailing: NSLayoutConstraint!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var thumbnailView: UIImageView!
    @IBOutlet weak var titleCenterConstraint: NSLayoutConstraint!
    
    func setCategoryCellValues(categoryValues : Category)
    {
        
        self.titleLabel.text = categoryValues.categories_name
       
    }
    
}
