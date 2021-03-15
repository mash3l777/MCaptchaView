# MCaptchaView

[![Swift Package Manager](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg?style=flat)](https://github.com/apple/swift-package-manager) ![GitHub Workflow Status](https://img.shields.io/github/workflow/status/mash3l777/MCaptchaView/Swift) [![CodeFactor](https://img.shields.io/codefactor/grade/github/mash3l777/MCaptchaView/main)](https://www.codefactor.io/repository/github/mash3l777/sacview)

![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/mash3l777/MCaptchaView) 
![Lines of code](https://img.shields.io/tokei/lines/github/mash3l777/MCaptchaView)

**Offline Captcha for iOS & iPad.**

## Example：
```swift
myCaptcha = MCaptchaView(frame: viewCaptcha.frame)
myCaptcha.captchaFont = UIFont.boldSystemFont(ofSize: 30)
myCaptcha.captchaCompletionBlock = { captcha in
    print("captcha is：\(captcha ?? "")")
}
viewCaptcha.clearsContextBeforeDrawing = true
viewCaptcha.addSubview(myCaptcha)
```

## Provide a case-insensitive comparison method：
```swift
let isMatch = txtCode.text!.caseInsensitiveCompare(myCaptcha.captcha) == .orderedSame
if isMatch {
    print("The verification code is entered correctly!!");
} else {
    print("incorrect verification code!!");
}
```
