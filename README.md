# zjSwiftRadio
基于swift实现单选按钮，代码简洁，能实现多个选项的自动高度
```swift
let zjr = ZJRadio.init(frame: CGRectMake(0, 64, 320, 20), arr: ["男性", "女性", "第三人", "亚洲", "非洲", "欧洲", "澳洲"], isAutoHeight: true) { (cur) -> (Void) in
    NSLog("当前点击：%d", cur)
}
self.view.addSubview(zjr)

let zjr1 = ZJRadio.init(frame: CGRectMake(0, 200, 320, 20), arr: ["男性", "女性", "第三人", "亚洲", "非洲", "欧洲", "澳洲"], isAutoHeight: false) { (cur) -> (Void) in
    NSLog("当前点击1：%d", cur)
}
self.view.addSubview(zjr1)
```
![](https://github.com/zxc3731/zjSwiftRadio/blob/master/tem22.gif) 
