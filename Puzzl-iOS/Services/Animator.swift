//
//  Animator.swift
//  Puzzl-iOS
//
//  Created by Artem Dudinski on 4/29/20.
//  Copyright © 2020 Denis Butyletskiy. All rights reserved.
//

import UIKit

final class Animator {
    static func makeMoveAnimation(duration: Double = 0.8, delay: Double = 0.1, view: UIView, translationX: CGFloat = 0, translationY: CGFloat = 0, completion:(()->())? = nil) {
        UIView.animate(withDuration: 0.8, delay: delay, animations: {
            view.transform = CGAffineTransform(translationX: translationX, y: translationY)
        }, completion: { finished in
            if finished { completion?() }
        })
    }
}
