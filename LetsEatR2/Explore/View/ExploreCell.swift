//
//  ExploreCell.swift
//  LetsEatR2
//
//  Created by Weerawut Chaiyasomboon on 30/11/2564 BE.
//

import UIKit

class ExploreCell: UICollectionViewCell {
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgExplore: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imgExplore.layer.cornerRadius = 9
        imgExplore.layer.masksToBounds = true
        
    }
}
