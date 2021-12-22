//
//  ReviewFormViewController.swift
//  LetsEatR2
//
//  Created by Weerawut Chaiyasomboon on 13/12/2564 BE.
//

import UIKit

class ReviewFormViewController: UITableViewController {
    
    @IBOutlet weak var ratingsView: RatingsView!
    @IBOutlet weak var tfTitle: UITextField!
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tvReview: UITextView!
    
    var selectedRestaurantID: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        print(selectedRestaurantID as Any)
    }

}

private extension ReviewFormViewController{
    
    @IBAction func onSaveTapped(_ sender: Any) {
        var item = ReviewItem()
        item.name = tfName.text
        item.title = tfTitle.text
        item.customerReview = tvReview.text
        item.restaurantID = selectedRestaurantID
        item.rating = Double(ratingsView.rating)
        
        CoreDataManager.shared.addReview(item)
        
        dismiss(animated: true, completion: nil)
    }
}
