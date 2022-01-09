//
//  FilterService.swift
//  RxSwiftTutorial
//
//  Created by IwasakIYuta on 2022/01/09.
//

import UIKit
import CoreImage// filterできるモジュール
import RxSwift

class FiltersService {
    
    private var context: CIContext
    
    init() {
        self.context = CIContext()
    }
    
    func applyFilter(to inputImage: UIImage) -> Observable<UIImage> {
        // createを使って観察者を作成する
        return Observable<UIImage>.create { observer in
            
            self.applyFilter(to: inputImage) { filteredImage in
               
                observer.onNext(filteredImage)
                
            }
            return Disposables.create()
        }
        
        
    }
    
    
    private func applyFilter(to inputImage: UIImage, completion: @escaping ((UIImage) -> ())) {
        
        guard let filter = CIFilter(name: "CICMYKHalftone") else { return }
        
        filter.setValue(5.0, forKey: kCIInputWidthKey)//フィルターの強度や種類
        
        if let sourceImage = CIImage(image: inputImage) {
            
            filter.setValue(sourceImage, forKey: kCIInputImageKey)
            
            // filterされたCGImage？を作成
            guard let cgimg = self.context.createCGImage(filter.outputImage!, from: filter.outputImage!.extent) else { return }
            
            
            let processedImage = UIImage(cgImage: cgimg, scale: inputImage.scale, orientation: inputImage.imageOrientation)
            //クロージャーで伝える
            completion(processedImage)
            
        }
        
    }
    
}

