//
//  PhotoCell.swift
//  LetsEatR2
//
//  Created by Weerawut Chaiyasomboon on 16/12/2564 BE.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    @IBOutlet var imgReview: UIImageView!
}

extension PhotoCell {
    func set(image:UIImage) {
        imgReview.image = image
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        imgReview.layer.cornerRadius = 9
        imgReview.layer.masksToBounds = true
    }
}
