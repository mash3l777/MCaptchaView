//  MCaptchaView.swift
//  MCaptchaView
//
//  Created by Mashal Ibrahim on 04/03/2021.
//

import UIKit

public class MCaptchaView: UIView {
    
    // Verification font code
    private var _captchaFont: UIFont?
    var captchaFont: UIFont? {
        get {
            _captchaFont
        }
        set(captchaFont) {
            _captchaFont = captchaFont
            setNeedsDisplay()
        }
    }
    
    // MARK:-Verification code
    private(set) var captcha: String?
    
    // Verification code update block
    var captchaCompletionBlock: ((_ captcha: String?) -> Void)?
    private var codeList: [AnyHashable]?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Background color
        backgroundColor = fillColor()
        
        // Default font
        captchaFont = UIFont.boldSystemFont(ofSize: 20)
        
        // Verification code character set
        codeList = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
        
        // Update code
        updateCaptcha()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // colour
    func fillColor() -> UIColor? {
        let red: CGFloat = CGFloat(arc4random() % 255) / 255.0
        let green: CGFloat = CGFloat(arc4random() % 255) / 255.0
        let blue: CGFloat = CGFloat(arc4random() % 255) / 255.0
        let color = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        return color
    }

    // Update verification code
    func updateCaptcha() {
        var codeString = ""
        for _ in 0..<4 {
            let index = Int(arc4random()) % ((codeList?.count ?? 0) - 1)
            let code = codeList?[index] as? String
            codeString += code ?? ""
        }
        setNeedsDisplay()
        captcha = "\(codeString)"
        if let captchaCompletionBlock = captchaCompletionBlock {
            captchaCompletionBlock(captcha)
        }
    }

    // MARK:- draw
    public override func draw(_ rect: CGRect) {
        super.draw(rect)

        // Background color
        var color = fillColor()?.withAlphaComponent(0.5)
        backgroundColor = color

        var cSize: CGSize? = nil
        if let captchaFont = captchaFont {
            cSize = "A".size(withAttributes: [
                NSAttributedString.Key.font: captchaFont
            ])
        }
        let width = Int(rect.size.width / CGFloat((captcha?.count ?? 0)) - (cSize?.width ?? 0.0))
        let height = Int(rect.size.height - (cSize?.height ?? 0.0))

        var point: CGPoint
        var pX: CGFloat
        var pY: CGFloat
        
        // Draw verification code
        color = fillColor()
        for i in 0..<(captcha?.count ?? 0) {
            pX = CGFloat(Int(arc4random()) % width) + rect.size.width / CGFloat((captcha?.count ?? 0)) * CGFloat(i)
            pY = CGFloat(Int(arc4random()) % height)
            point = CGPoint(x: pX, y: pY)
            
            let startIndex = captcha!.startIndex
            let index = captcha!.index(startIndex, offsetBy: i)
            let c = Character(extendedGraphemeClusterLiteral: captcha![index])
            let textC = "\(c)"
            if let captchaFont = captchaFont, let color = color {
                textC.draw(at: point, withAttributes: [
                    NSAttributedString.Key.font: captchaFont,
                    NSAttributedString.Key.foregroundColor: color
                ])
            }
        }
        // Draw horizontal lines
        let context = UIGraphicsGetCurrentContext()
        context?.setLineWidth(1.0)
        for _ in 0..<10 {
            color = fillColor()?.withAlphaComponent(0.5)
            if let cg = color?.cgColor {
                context?.setStrokeColor(cg)
            }
            pX = CGFloat(Int(arc4random()) % Int(rect.size.width))
            pY = CGFloat(Int(arc4random()) % Int(rect.size.height))
            context?.move(to: CGPoint(x: pX, y: pY))
            pX = CGFloat(Int(arc4random()) % Int(rect.size.width))
            pY = CGFloat(Int(arc4random()) % Int(rect.size.height))
            context?.addLine(to: CGPoint(x: pX, y: pY))
            context?.strokePath()
        }
    }

    // Click to update verification code
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        updateCaptcha()
    }
}
