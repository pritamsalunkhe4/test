//
//  ListTableViewCell.swift
//  Test
//
//  Created by PritamSing Salunkhe on 09/08/21.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var title: UILabel!
    
    func configureCell(titleText: String) {
        title.text = titleText
    }
}

