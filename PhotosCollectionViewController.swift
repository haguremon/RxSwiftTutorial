//
//  PhotosCollectionViewController.swift
//  RxSwiftTutorial
//
//  Created by IwasakIYuta on 2022/01/08.
//

import UIKit
import Photos
import RxSwift


private let reuseIdentifier = "Cell"

class PhotosCollectionViewController: UICollectionViewController {
    //UIImageを取得
    private let selectPhotoSubject = PublishSubject<UIImage>()
    
    //購読できるようにする　selectPhoto.subscribe { image in  }
    var selectPhoto: Observable<UIImage> {
        selectPhotoSubject.asObservable()
    }
    
    private var images = [PHAsset]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        self.collectionView!.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        populatePhotos()
    }
    
    private func populatePhotos() {
        
        PHPhotoLibrary.requestAuthorization { [weak self] status in
            
            if status == .authorized {
                //許可してる時にアルバムにアクセスできる
                //カメラの情報を全て取得する
                let asset = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: nil)
                asset.enumerateObjects { (obejct, count, stope) in
                    self?.images.append(obejct)
                }
                self?.images.reverse()//最新の写真からに変更
                DispatchQueue.main.async {
                    //メインスレッドで切り替える必要があるため
                    self?.collectionView.reloadData()
                }
            }
        }
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return images.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? PhotoCollectionViewCell else {
            
            fatalError("PhotoCollectionViewCell is not found")
        }
        
        let asset = images[indexPath.row]
        let manager = PHImageManager.default()
        // PHAssetをイメージに変更
        manager.requestImage(for: asset, targetSize: CGSize.init(width: 150, height: 150), contentMode: .aspectFill, options: nil) { image, _ in
            
            DispatchQueue.main.async {
                cell.photoImageView.image  = image
            }
            
            
        }
    
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let selctedAsset = images[indexPath.row]
        let manager = PHImageManager.default()
        // PHAssetをイメージに変更
        manager.requestImage(for: selctedAsset, targetSize: CGSize.init(width: 300, height: 300), contentMode: .aspectFill, options: nil) { [weak self] image, info in
            
            guard let info = info else { return }
            
            let isDegradedImage = info["PHImageResultIsDegradedKey"] as! Bool
        
            if !isDegradedImage {
                if let image = image {
                    //本当はデリゲートとかを使って伝えてる
                    self?.selectPhotoSubject.onNext(image)//selectPhotoSubjectに入る
                    self?.dismiss(animated: true)
                    
                }
            }
            
            
        }
    }


    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
