//
//  HXImageUtil.swift
//  RecordTechnology
//
//  Created by ArthurWang on 2017/11/28.
//  Copyright © 2017年 Monkey King. All rights reserved.
//

import Foundation

class HXImageUtil {
    @objc class func scaleImage(srcImg:UIImage, targetSize:CGSize) -> UIImage? {
        let sourceImage = srcImg;
        var newImage:UIImage? = nil;
        let imageSize = sourceImage.size;
        let width:CGFloat = imageSize.width;
        let height:CGFloat = imageSize.height;
        let targetWidth:CGFloat = targetSize.width;
        let targetHeight:CGFloat = targetSize.height;
        var scaleFactor:CGFloat = 0.0;
        var scaledWidth:CGFloat = targetWidth;
        var scaledHeight:CGFloat = targetHeight;
        var thumbnailPoint = CGPoint.init(x: 0.0, y: 0.0);

        if __CGSizeEqualToSize(imageSize, targetSize) {
            let widthFactor = targetWidth / width;
            let heightFactor = targetHeight / height;

            if widthFactor > heightFactor {
                scaleFactor = widthFactor;
            } else {
                scaleFactor = heightFactor;
            }

            scaledWidth = width * scaleFactor;
            scaledHeight = height * scaleFactor;

            if widthFactor > heightFactor {
                thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
            } else if widthFactor < heightFactor {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
        }

        objc_sync_enter(self);

        UIGraphicsBeginImageContext(targetSize);
        var thumbnailRect = CGRect();
        thumbnailRect.origin = thumbnailPoint;
        thumbnailRect.size.width = scaledWidth;
        thumbnailRect.size.height = scaledHeight;

        sourceImage.draw(in: thumbnailRect);

        newImage = UIGraphicsGetImageFromCurrentImageContext();

        if nil == newImage {
            print("could not scale image");
        }

        UIGraphicsEndImageContext();

        objc_sync_exit(self);


        return newImage;
    }

    @objc class func scaleImage(srcImg: UIImage, toMaxPixels maxLength:CGFloat) -> UIImage? {
        let sourceImage = srcImg;
        let imageSize = sourceImage.size;
        var width:CGFloat = imageSize.width;
        var height:CGFloat = imageSize.height;
        var ratio:CGFloat = 0.0;

        if height > width {
            if height > maxLength {
                ratio = maxLength / height;
                height = maxLength;
                width = width * ratio;
            } else {
                return srcImg;
            }
        } else {
            if width > maxLength {
                ratio = maxLength / width;
                width = maxLength;
                height = height * ratio;
            } else {
                return srcImg;
            }
        }

        return self.scaleImage(srcImg: srcImg, targetSize: CGSize.init(width: width, height: height));
    }




}
