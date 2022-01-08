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
            
            self?.selectImageView.image = image
        }.disposed(by: disposeBag) //川の流れを止める
    }


}

