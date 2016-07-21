//
//  UIImageExtension.swift
//  APIAndGoogleMaps
//
//  Created by Mylo Ho on 7/21/16.
//  Copyright © 2016 Ho Van Su. All rights reserved.
//

extension UIImage{
    var roundedImage: UIImage {
        let rect = CGRect(origin:CGPoint(x: 0, y: 0), size: self.size)
        UIGraphicsBeginImageContextWithOptions(self.size, false, 1)
        UIBezierPath(
            roundedRect: rect,
            cornerRadius: self.size.height
            ).addClip()
        self.drawInRect(rect)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}