//
//  ViewController.swift
//  GravityBubbles
//
//  Created by Finbar Allan on 13/09/2023.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var gameView: UIView!
    private var gravity = UIGravityBehavior()
    private var collider = UICollisionBehavior()
    private var animator: UIDynamicAnimator?
    
    struct Constants {
        static let bubbleSize = CGSize(width: 28, height: 28)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        animator = UIDynamicAnimator(referenceView: gameView)
        animator?.addBehavior(gravity)
        collider.translatesReferenceBoundsIntoBoundary = true
        animator?.addBehavior(collider)
    }

    @IBAction func tap(_ sender: UITapGestureRecognizer) {
        let count = Int.random(in: 10...20)
        for _ in 1...count {
            dropBubble()
        }
    }
    
    private func dropBubble() {
        var frame = CGRect()
        frame.origin = CGPoint.zero
        frame.size = Constants.bubbleSize
        let x = gameView.bounds.width * CGFloat.random(in: 0..<1)
        frame.origin.x = x
        let y = gameView.bounds.height * CGFloat.random(in:0.0..<0.2)
        frame.origin.y = y
        let bubbleView = EllipseView(frame: frame)
        gameView.addSubview(bubbleView)
        collider.addItem(bubbleView)
        gravity.addItem(bubbleView)
    }
    
}

class EllipseView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .randomColor
        layer.cornerRadius = frame.size.width / 2.0
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 0.5
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var collisionBoundsType: UIDynamicItemCollisionBoundsType {
        return .ellipse
    }
}

extension UIColor {
    static var randomColor: UIColor {
        let randomHue = CGFloat.random(in: 0..<1)
        return UIColor(hue: randomHue, saturation: 1.0, brightness: 1.0, alpha: 0.5)
    }
}
