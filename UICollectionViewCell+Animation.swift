import UIKit

class AnimatedCollectionViewCell: UICollectionViewCell {
    
    private let duration = 0.15
    private let fadeColor = UIColor.black
    private let fadeAlpha: CGFloat = 0.2
    private let scaleFactor: CGFloat = 0.97
    private let fade = true
    private let scale = true
    
    private var overlayView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        overlayView = UIView(frame: self.frame)
        overlayView?.backgroundColor = fadeColor
        overlayView?.layer.cornerRadius = 3
        overlayView?.alpha = 0
        
        addSubview(overlayView)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        overlayView?.alpha = 0
    }
    
    func mockHighlight() {
        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true) { _ in
            self.isHighlighted = true
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false, block: { _ in
                self.isHighlighted = false
            })
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                if fade {
                    UIView.animate(withDuration: duration, animations: {
                        self.overlayView.alpha = self.fadeAlpha
                    }, completion: { _ in
                        _ = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { _ in
                            UIView.animate(withDuration: self.duration, animations: {
                                self.overlayView.alpha = 0
                            })
                        })
                    })
                }
                
                if scale {
                    UIView.animate(withDuration: duration, animations: {
                        self.transform = self.isHighlighted ? self.transform.scaledBy(x: self.scaleFactor, y: self.scaleFactor) : .identity
                    }, completion: { _ in
                        _ = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { _ in
                            UIView.animate(withDuration: self.duration, animations: {
                                self.transform = .identity
                            })
                        })
                    })
                }
            }

        }
    }
    
//    override var isSelected: Bool {
//        didSet {
//            if fade {
//                overlayView.alpha = isSelected ? 0.2 : 0
//            }
//
//            if scale {
//                UIView.animate(withDuration: duration, animations: {
//                    self.transform = self.isSelected ? self.transform.scaledBy(x: 0.95, y: 0.95) : .identity
//                }, completion: { _ in
//                    self.transform = .identity
//                })
//            }
//        }
//    }
}
