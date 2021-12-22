//
//  PhotosViewController.swift
//  LetsEatR2
//
//  Created by Weerawut Chaiyasomboon on 16/12/2564 BE.
//

import UIKit

class PhotosViewController: UIViewController {

    @IBOutlet var collectionView: UICollectionView!
    var selectedRestaurantID: Int?
    var photos: [RestaurantPhotoItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkPhotos()
    }

}

private extension PhotosViewController{
    
    func initialize(){
        setupCollectionView()
    }
    
    func setupCollectionView() {
        let flow = UICollectionViewFlowLayout()
        flow.sectionInset = UIEdgeInsets(top: 7, left: 7, bottom: 7, right: 7)
        flow.minimumInteritemSpacing = 0
        flow.minimumLineSpacing = 7
        flow.scrollDirection = .horizontal
        collectionView.collectionViewLayout = flow
    }
    
    func checkPhotos() {
        let viewController = self.parent as? RestaurantDetailViewController
        if let id = viewController?.selectedRestaurant?.restaurantID {
            photos = CoreDataManager.shared.fetchPhotos(by: id)
            if photos.count > 0 {
                collectionView.backgroundView = nil
            } else {
                let view = NoDataView(frame: CGRect(x: 0, y: 0, width: collectionView.frame.width, height: collectionView.frame.height))
                view.set(title: "Photos")
                view.set(desc: "There are currently no photos")
                collectionView.backgroundView = view
            }
        }
        collectionView.reloadData()
    }
}

extension PhotosViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! PhotoCell
        let photoItem = photos[indexPath.item]
        if let photo = photoItem.photo{
            cell.set(image: photo)
        }
        return cell
    }
}

extension PhotosViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if photos.count == 1 {
            let width = collectionView.frame.size.width - 14
            return CGSize(width: width, height: 200)
        } else {
            let width = collectionView.frame.size.width - 21
            return CGSize(width: width, height: 200)
        }
    }
}
