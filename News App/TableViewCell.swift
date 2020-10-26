//
//  TableViewCell.swift
//  News App
//
//  Created by Юрий Могорита on 26.10.2020.
//  Copyright © 2020 Yuri Mogorita. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    //MARK: - Outlets
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var articleTitleLabel: UILabel!
    @IBOutlet weak var articleDescriptionLabel: UILabel!
    
}
