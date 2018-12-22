# IDDialog IOS 弹框组件


# 要求

- iOS 8.0+
- swift 3.0+

# 主要功能：

- 类似ios系统弹框，支持标题+内容+按钮
- 展示图片的弹框
- 可输入文本的弹框。文本框支持设置最大长度、支持自定义正则表达式、自动换行等。
- 支持横竖屏


# 更新日志

-版本号 1.0.0：项目初始化
-版本号 1.0.4：新增自定义view

# 使用方式

pod 'IDDialog'

# IDDialog的使用
目前提供4种类型的弹框

### 1.普通弹框，调用id_show方法

```
IDDialog.id_show(title: "温馨提示", msg: "确定要取消？", leftActionTitle: "确定", rightActionTitle: "取消", leftHandler: {
}) {
}
```

### 2.带有图片显示的弹框，调用id_showImg方法

```
IDDialog.id_showImg(success: IDDialogUtilImageType.success, msg: "提交成功", leftActionTitle: "知道了", rightActionTitle: nil, leftHandler: nil, rightHandler: nil)

```

### 3.带有输入文本框的弹框，调用id_showInput方法

```
IDDialog.id_showInput(msg: "请输入取消原因", leftActionTitle: "取消", rightActionTitle: "确定", leftHandler: { (text) in
   print(text)
}) { (text) in
   print(text)
}

```
### 4.自定义内容的弹框，调用id_showCustom方法
```
IDDialog.id_showCustom(msg: "标题", leftActionTitle: nil, rightActionTitle: "确定", customView: self.myView, leftHandler: { (customView) in

}) { (customView) in

}

```
# 详细使用介绍
### 1.普通弹框，可扩展属性介绍

- 在默认情况下，文本居中显示，默认有动画。

- 提供如下可扩展属性，可设置文本的对齐方式，主题色，自定义动画，具体参考示例代码。

```
/// 内容的对齐方式
public var textAlignment = NSTextAlignment.center
/// 设置主题色，2个按钮时只设置右边的主题色，1个按钮时显示主题色
public var mainColor = UIColor.black
/// 是否支持动画
public var supportAnimate = true
/// 自定义动画
public var animate = CABasicAnimation()
```
- 针对上面属性的使用，下面列举几种常见的案例来详细说明

##### 1) 场景1：全局设置IDDialog的相关属性

再Appdelegate中：

```
IDDialogManager.share.mainColor = UIColor.red
```


##### 2）场景1：全局设置IDDialog的主题色为红色，但是在某个页面需要设置IDDialog的主题色为蓝色。

首先再Appdelegate中：

```
IDDialogManager.share.mainColor = UIColor.red
```

在需要设置蓝色的地方,记得重置主题色

```
IDDialogManager.share.mainColor = UIColor.blue
IDDialog.id_show(title: "温馨提示", msg: "确定要取消？", leftActionTitle: "确定", rightActionTitle: "取消", leftHandler: {
   print("点击了左边")
   IDDialogManager.share.mainColor = UIColor.red
}) {
   print("点击了右边")
   IDDialogManager.share.mainColor = UIColor.red
}
```

##### 3）自定义弹框动画

```
let shakeAnimation = CABasicAnimation.init(keyPath: "position")
shakeAnimation.duration = 0.2
shakeAnimation.fromValue = NSValue.init(cgPoint: CGPoint.init(x: KScreenWidth*0.5, y: 0))
shakeAnimation.toValue = NSValue.init(cgPoint: CGPoint.init(x: KScreenWidth*0.5, y: KScreenHeight*0.5))
shakeAnimation.autoreverses = false
IDDialogManager.share.animate = shakeAnimation
IDDialog.id_show(title: "温馨提示", msg: "自定义动画", leftActionTitle: "取消", rightActionTitle: "确定", leftHandler: {
}) {

```

### 2.带有图片的弹框，可扩展属性介绍

带有图片的弹框的可扩展属性拥有上面普通弹框的所有属性，额外还支持更换图片

```
IDDialogManager.share.successImage = UIImage.init(named: "success")
IDDialog.id_showImg(success: IDDialogUtilImageType.success, msg: "提交成功", leftActionTitle: "知道了", rightActionTitle: nil, leftHandler: nil, rightHandler: nil)
```

### 3.带有输入文本框的弹框，支持普通弹框的所有属性外，还支持以下功能


    /// 最多允许输入多少个字符
    public var maxLength: Int?
    /// 只允许输入数字和小数点
    public var onlyNumberAndPoint: Bool?
    /// 设置小数点位数
    var pointLength: Int?
    /// 只允许输入数字
    public var onlyNumber: Bool?
    /// 禁止输入表情符号emoji
    public var allowEmoji: Bool?
    /// 正则表达式
    var predicateString: String?




# 使用注意
1.由于IDDialogManager 是一个单例对象，当设置相应的属性后，那整个项目的Dialog就会保持这个属性值。如果项目Dialog较为统一，那么只要在appdelegate中设置一次即可，如果只是想偶尔改变一次Dialog的属性值，那么再改变之后，记得重新赋值一下相关的属性。

2.如果是文本框类型的dialog，如果设置了文本框最多输入10个汉子，那么不用重置改属性，因为内部在点击确定按钮时已经重置了该限制
```
@objc func clickLeftbtn() {
IDDialogManager.share.id_resetInputProps()
if self.leftHandler != nil {
self.leftHandler!(self.dealText())
}
}
```

# 截图

![](http://github.app.hd123.cn:10080/ideal/IDDialog-iOS/raw/fe383673319ba666c2b226b4da79ca139060346a/screenshot/%E5%B1%8F%E5%B9%95%E5%BF%AB%E7%85%A7%202018-08-31%20%E4%B8%8B%E5%8D%882.57.47.png)

![](http://github.app.hd123.cn:10080/ideal/IDDialog-iOS/raw/fe383673319ba666c2b226b4da79ca139060346a/screenshot/%E5%B1%8F%E5%B9%95%E5%BF%AB%E7%85%A7%202018-08-31%20%E4%B8%8B%E5%8D%882.58.03.png)

![](http://github.app.hd123.cn:10080/ideal/IDDialog-iOS/raw/fe383673319ba666c2b226b4da79ca139060346a/screenshot/%E5%B1%8F%E5%B9%95%E5%BF%AB%E7%85%A7%202018-08-31%20%E4%B8%8B%E5%8D%882.58.27.png)
