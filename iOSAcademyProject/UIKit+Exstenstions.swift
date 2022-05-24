//
//  UIKit+Exstenstions.swift
//  iOSAcademyProject
//
//  Created by Luka Vujnovac on 24.05.2022..
//

import Foundation
import UIKit

extension UIImageView{
    func makeBlurImage(targetImageView:UIImageView?)
    {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = targetImageView!.bounds

        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        targetImageView?.addSubview(blurEffectView)
    }
}
