//
//  ImageCollectionViewCell.swift
//  Test
//
//  Created by PritamSing Salunkhe on 09/08/21.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    
    func configureCell(imageName: String) {
        imageView.image = UIImage(named: imageName)
    }
}
