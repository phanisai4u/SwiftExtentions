//
//  URLExtension.swift
//  ReusableComponents_Ashok
//
//  Created by Ashok on 30/01/17.
//  Copyright © 2017 Ashok. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

extension URL {
    
    func videoThumbnail(completion: @escaping (_ thumbnailImage: UIImage?) -> Void) {
        DispatchQueue.global(qos: .background).async {
            print("This is run on the background queue")
            
            let asset: AVAsset = AVAsset(url: self)
            let assetImgGenerate : AVAssetImageGenerator = AVAssetImageGenerator(asset: asset)
            assetImgGenerate.appliesPreferredTrackTransform = true
            let time: CMTime = CMTimeMake(1, 2)
            let img: CGImage
            
            do {
                try img = assetImgGenerate.copyCGImage(at: time, actualTime: nil)
                let frameImg: UIImage = UIImage(cgImage: img)
                DispatchQueue.main.async {
                    print("This is run on the main queue, after the previous code in outer block")
                    completion(frameImg)
                }
            } catch {
                DispatchQueue.main.async {
                    print("This is run on the main queue, after the previous code in outer block")
                    completion(nil)
                }
            }
        }
    }
    
}
