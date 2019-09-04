//
//  OwnPopoverBackgroundView.swift
//  PopoverPresent
//
//  Created by App005 SYNERGY on 2019/9/3.
//  Copyright © 2019 App005 SYNERGY. All rights reserved.
//

import UIKit
let HArrowHeight:CGFloat = 10.0

let HArrowBase:CGFloat = 10

let HArrowInsets:CGFloat = 10
class OwnPopoverBackgroundView: UIPopoverBackgroundView {

    var _arrowDirection:UIPopoverArrowDirection!
    
    var _arrowOffset:CGFloat = 0
    
    override var arrowDirection: UIPopoverArrowDirection {
        set {
            _arrowDirection = newValue
        }
       
        get {
            return UIPopoverArrowDirection.any
        }
    }
    
    override var arrowOffset: CGFloat {
        set {
            _arrowOffset = newValue
        }
        get {
            return _arrowOffset
        }
    }
    
    //用于绘制箭头，如果不绘制，将没有箭头
    var arrowImageView:UIImageView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        arrowImageView = UIImageView(frame: .zero)
        addSubview(arrowImageView!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let arrowSize = CGSize(width: OwnPopoverBackgroundView.arrowBase(), height: OwnPopoverBackgroundView.arrowHeight())
        self.arrowImageView?.image = drawArrowImage(size: arrowSize)
        
        var x:CGFloat = 0
        var y:CGFloat = 0
        
        let selfWidth = self.bounds.size.width
        let selfHeight = self.bounds.size.height
        let arrowWidth = arrowSize.width
        let arrowHeight = arrowSize.height
        
        switch _arrowDirection {
        case UIPopoverArrowDirection.up:
            x = (selfWidth - arrowWidth) / 2.0 + _arrowOffset
            y = 0
        case UIPopoverArrowDirection.left:
            x = 0
            y = (selfHeight - arrowHeight) / 2.0 + _arrowOffset
        case UIPopoverArrowDirection.down:
            x = (selfWidth - arrowWidth) / 2.0 + _arrowOffset
            y = selfHeight - arrowHeight
        case UIPopoverArrowDirection.right:
            x = selfWidth - arrowWidth
            y = (selfHeight - arrowHeight) / 2.0 + _arrowOffset
        default:
            x = 0
            y = 0
        }
        
        arrowImageView?.frame = CGRect(x: x, y: y, width: arrowSize.width, height: arrowSize.height)
        
        
    }
    
    // 绘制图片
    func drawArrowImage(size:CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        let ctx = UIGraphicsGetCurrentContext()!
        UIColor.clear.setFill()
        ctx.fill(CGRect(x: 30, y: 260, width: 100, height: 60))
        var point1:CGPoint = .zero
        var point2:CGPoint = .zero
        var point3:CGPoint = .zero
        
        //根据箭头位置确认箭头的3个绘制点
        //箭头的UIPopoverArrowDirectionAny类型会被判断成上左下右中的其中一种
        switch _arrowDirection {
            case UIPopoverArrowDirection.up:
                point1 = CGPoint(x: size.width/2.0, y: 0)
                point2 = CGPoint(x: size.width, y: size.height)
                point3 = CGPoint(x: 0, y: size.height)
            case UIPopoverArrowDirection.left:
                point1 = CGPoint(x: 0, y: size.height/2.0)
                point2 = CGPoint(x: size.width, y: size.height)
                point3 = CGPoint(x: size.width, y: 0)
            case UIPopoverArrowDirection.down:
                point1 = CGPoint(x: 0, y: 0)
                point2 = CGPoint(x: size.width/2.0, y: size.height)
                point3 = CGPoint(x: size.width, y: 0)
            case UIPopoverArrowDirection.right:
                point1 = CGPoint(x: 0, y: 0)
                point2 = CGPoint(x: size.width, y: size.height/2.0)
                point3 = CGPoint(x: 0, y: size.height)
            default:
                break
        }
        
        let arrowPath = CGMutablePath()
        arrowPath.move(to: point1)
        arrowPath.addLine(to: point2)
        arrowPath.addLine(to: point3)
        arrowPath.closeSubpath();

        ctx.addPath(arrowPath)
        let fillColor = self.backgroundColor ?? UIColor.yellow
        ctx.setFillColor(fillColor.cgColor)
        ctx.drawPath(using: CGPathDrawingMode.fill)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
        
    }
    // 箭头底部宽度
    override static func arrowBase() -> CGFloat {
        return HArrowBase
    }
    // 内容视图的偏移
    override static func contentViewInsets() -> UIEdgeInsets {
        return UIEdgeInsets(top: HArrowInsets, left: HArrowInsets, bottom: HArrowInsets, right: HArrowInsets)
    }
    //箭头高度
    override static func arrowHeight() -> CGFloat {
        return HArrowHeight
    }
    //是否使用默认的内置阴影和圆角
    static func wantsDefaultContentAppearance() -> Bool {
        return true
    }
}
