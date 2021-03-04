# MCaptchaView

Example：

```swift
myCaptcha = MCaptchaView(frame: viewCaptcha.frame)
myCaptcha.captchaFont = UIFont.boldSystemFont(ofSize: 30)
myCaptcha.captchaCompletionBlock = { captcha in
    print("captcha is：\(captcha ?? "")")
}
viewCaptcha.clearsContextBeforeDrawing = true
viewCaptcha.addSubview(myCaptcha)
```

Provide a case-insensitive comparison method：

```swift
let isMatch = txtCode.text!.caseInsensitiveCompare(myCaptcha.captcha) == .orderedSame
if isMatch {
    print("The verification code is entered correctly!!");
} else {
    print("incorrect verification code!!");
}
```
