//
//  ViewController.swift
//  RxSwiftTutorial
//
//  Created by IwasakIYuta on 2022/01/07.
//

import UIKit
import RxSwift

class ViewController: UIViewController {
    
    let disposeBag = DisposeBag()

    @IBOutlet weak var selectImageView: UIImageView!
    
    @IBOutlet weak var applyFilterButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
       
    }
    //UIStoryboardSegueを使って遷移をするのでこれで取得してる
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let naV = segue.destination as? UINavigationController,
              let photosCVC = naV.viewControllers.first as? PhotosCollectionViewController else {
            fatalError("PhotosCollectionViewController is not found")
        }
        //此処でselectImageViewにimageを伝えてる
        photosCVC.selectPhoto.subscribe { [weak self] image in
            DispatchQueue.main.async {
                //UIを切り替えるのでメインスレッドで
                self?.updateUI(for: image)
            
            }
        }.disposed(by: disposeBag) //川の流れを止める
    }
   
    private func updateUI(for image: UIImage){
        selectImageView.image = image
    
        applyFilterButton.isHidden = false
    }
    
    @IBAction func applyFilterPressed() {
        
        guard let sourceImage = selectImageView.image else { return }
        
        FiltersService().applyFilter(to: sourceImage) { [ weak self ] filteredImage in
            
            DispatchQueue.main.async {
                self?.selectImageView.image = filteredImage
            }
            
        }
        
    }


}

