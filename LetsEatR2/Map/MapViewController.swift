//
//  MapViewController.swift
//  LetsEatR2
//
//  Created by Weerawut Chaiyasomboon on 2/12/2564 BE.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    let manager = MapDataManager()
    var selectedRestaurant: RestaurantItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialize()
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier! {
        case Segue.showDetail.rawValue:
            showRestaurantDetail(segue: segue)
        default:
            print("Segue not added")
        }
    }
    
    func showRestaurantDetail(segue: UIStoryboardSegue){
        if let vc = segue.destination as? RestaurantDetailViewController, let restaurant = selectedRestaurant{
            vc.selectedRestaurant = restaurant
        }
    }
    
}

//MARK: - Private Extension

private extension MapViewController{
    
    func initialize(){
        mapView.delegate = self
        manager.fetch { (annotations) in
            self.addMap(annotations)
        }
    }
    
    func addMap(_ annotations: [RestaurantItem]){
        mapView.setRegion(manager.currentRegion(latDelta: 0.5, longDelta: 0.5), animated: true)
        mapView.addAnnotations(annotations)
    }
}

//MARK: - MKMapViewDelegate

extension MapViewController: MKMapViewDelegate{
    //Create custom MKAnnotationView
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "custompin"
        guard !annotation.isKind(of: MKUserLocation.self) else { return nil }
        
        var annotationView: MKAnnotationView?
        
        if let customAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) {
            annotationView = customAnnotationView
            annotationView?.annotation = annotation
        } else {
            let av = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            av.rightCalloutAccessoryView = UIButton(type:.detailDisclosure)
            annotationView = av
        }
        
        if let annotationView = annotationView {
            annotationView.canShowCallout = true
            annotationView.image = UIImage(named: "custom-annotation")
            
        }
        
        return annotationView

    }
    
    //trigger when callout bubble button tap
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        guard let annotation = mapView.selectedAnnotations.first else { return }
        selectedRestaurant = annotation as? RestaurantItem
        
        self.performSegue(withIdentifier: Segue.showDetail.rawValue, sender: self)
    }

}
