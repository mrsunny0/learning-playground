//
//  UIImage+Extension.swift
//  CoreMLDemo
//
//  Created by George Sun on 6/10/20.
//  Copyright © 2020 George Sun. All rights reserved.
//

import Foundation
import UIKit
import VideoToolbox

extension UIImage {
    func resizeImage(targetSize: CGSize) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: targetSize.width, height: targetSize.height)
        UIGraphicsBeginImageContextWithOptions(targetSize, false, 1.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    // need CV pixel buffer conversion...
}
