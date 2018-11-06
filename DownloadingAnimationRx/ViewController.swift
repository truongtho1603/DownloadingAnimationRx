//
//  ViewController.swift
//  DownloadingAnimationRx
//
//  Created by Thomas Do on 06/11/2018.
//  Copyright © 2018 Tho Do. All rights reserved.
//

import UIKit
import RxSwift

class ViewController: UIViewController {
    @IBOutlet weak var targetView: UIView!
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        let maximum: CGFloat = 100.0
        let downloadObservable: Observable<CGFloat> = Observable<CGFloat>.of(10.0, 15.0, 20.0, 35.0, 50.0, 75.0, 85.0)

        downloadObservable.observeOn(MainScheduler.instance)
            .subscribe(onNext: { downloaded in
                self.animateWithDownloading(percentage: downloaded / maximum)
            })
            .disposed(by: disposeBag)
    }

    func animateWithDownloading(percentage: CGFloat = 1.0) {
        targetView.layer.cornerRadius = 50.0

        let targetViewPath = UIBezierPath(roundedRect: targetView.bounds.insetBy(dx: -20.0, dy: -20.0), cornerRadius: 50)
        let pathLayer = CAShapeLayer()
        pathLayer.strokeEnd = 0.0
        pathLayer.strokeColor = UIColor.blue.cgColor
        pathLayer.fillColor = UIColor.clear.cgColor
        pathLayer.lineWidth = 11.0
        pathLayer.lineJoin = CAShapeLayerLineJoin.bevel
        pathLayer.lineCap = CAShapeLayerLineCap.square
        pathLayer.path = targetViewPath.cgPath


        let animation = CABasicAnimation()
        animation.keyPath = "strokeEnd"
        animation.duration = 3.0
        animation.toValue = percentage
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.isRemovedOnCompletion = false

        pathLayer.add(animation, forKey: "kDownloadAnimation")

        targetView.layer.addSublayer(pathLayer)
    }
}

