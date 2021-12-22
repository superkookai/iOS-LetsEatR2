//
//  RestaurantDetailViewController.swift
//  LetsEatR2
//
//  Created by Weerawut Chaiyasomboon on 2/12/2564 BE.
//

import UIKit
import MapKit

class RestaurantDetailViewController: UITableViewController {

    var selectedRestaurant: RestaurantItem?
    
    // Nav Bar
    @IBOutlet weak var btnHeart:UIBarButtonItem!
    // Cell One
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblCuisine: UILabel!
    @IBOutlet weak var lblHeaderAddress: UILabel!
    // Cell Two
    @IBOutlet weak var lblTableDetails: UILabel!
    // Cell Three
    @IBOutlet weak var lblOverallRating: UILabel!
    @IBOutlet weak var ratingsView: RatingsView!
    // Cell Eight
    @IBOutlet weak var lblAddress: UILabel!
    // Cell Nine
    @IBOutlet weak var imgMap: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialize()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier{
            switch Segue(rawValue: identifier) {
            case .showReview:
                showReview(segue: segue)
            case .showPhotoFilter:
                showPhotoFiler(segue: segue)
            default:
                print("Segue not found.")
            }
        }
    }

}

private extension RestaurantDetailViewController{
    
    func initialize(){
        setupLabels()
        createMap()
        createRating()
    }
    
    func setupLabels(){
        
        guard let restaurant = selectedRestaurant else { return }
        
        if let name = restaurant.name {
            lblName.text = name
            title = name
        }
        if let cuisine = restaurant.subtitle {
            lblCuisine.text = cuisine
        }
        if let address = restaurant.address {
            lblAddress.text = address
            lblHeaderAddress.text = address
        }
        lblTableDetails.text = "Table for 7, tonight at 10:00 PM"
        
    }
    
    func createMap() {
        guard let annotation = selectedRestaurant, let long = annotation.long, let lat = annotation.lat else { return }
        let location = CLLocationCoordinate2D(latitude: lat, longitude: long)
        
        takeSnapShot(with: location)
    }

    func takeSnapShot(with location: CLLocationCoordinate2D) {
        let mapSnapShotOptions = MKMapSnapshotter.Options()
        var loc = location
        let polyline = MKPolyline(coordinates: &loc, count: 1)
        let region = MKCoordinateRegion(polyline.boundingMapRect)
        mapSnapShotOptions.region = region
        mapSnapShotOptions.scale = UIScreen.main.scale
        mapSnapShotOptions.size = CGSize(width: 340, height: 208)
        mapSnapShotOptions.showsBuildings = true
        mapSnapShotOptions.pointOfInterestFilter = .includingAll
        let snapShotter = MKMapSnapshotter(options: mapSnapShotOptions)
        snapShotter.start() {
            snapshot, error in
            guard let snapshot = snapshot else { return }
            UIGraphicsBeginImageContextWithOptions(mapSnapShotOptions.size, true, 0)
            snapshot.image.draw(at: .zero)
            let identifier = "custompin"
            let annotation = MKPointAnnotation()
            annotation.coordinate = location
            let pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            pinView.image = UIImage(named: "custom-annotation")!
            let pinImage = pinView.image
            var point = snapshot.point(for: location)
            let rect = self.imgMap.bounds
            if rect.contains(point) {
                let pinCenterOffset = pinView.centerOffset
                point.x -= pinView.bounds.size.width/2
                point.y -= pinView.bounds.size.height/2
                point.x += pinCenterOffset.x
                point.y += pinCenterOffset.y
                pinImage?.draw(at: point)
            }
            if let image = UIGraphicsGetImageFromCurrentImageContext() {
                UIGraphicsEndImageContext()
                DispatchQueue.main.async {
                    self.imgMap.image = image
                }
            }
        }
    }
    
    func createRating(){
        ratingsView.isEnabled = false
        if let id = selectedRestaurant?.restaurantID{
            let value = CoreDataManager.shared.fetchRestaurantRating(by: id)
            ratingsView.rating = Double(value)
            if value.isNaN{
                lblOverallRating.text = "0.0"
            }else{
                let roundedValue = ((value*10).rounded()/10)
                lblOverallRating.text = "\(roundedValue)"
            }
        }
        
    }
    
    //MARK: - Navigation
    
    @IBAction func unwindReviewCancel(segue: UIStoryboardSegue){
        
    }
    
    func showReview(segue: UIStoryboardSegue) {
        guard let navController = segue.destination as? UINavigationController, let viewController = navController.topViewController as? ReviewFormViewController else {
            return
        }
        viewController.selectedRestaurantID = selectedRestaurant?.restaurantID
    }
    
    func showPhotoFiler(segue: UIStoryboardSegue){
        guard let navController = segue.destination as? UINavigationController, let viewController = navController.topViewController as? PhotoFilterViewController else {
            return
        }
        viewController.selectedRestaurantID = selectedRestaurant?.restaurantID
    }
    
}
