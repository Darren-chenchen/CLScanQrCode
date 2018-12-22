
import UIKit

// 屏幕宽度
var KScreenHeight = UIScreen.main.bounds.height
// 屏幕高度
var KScreenWidth = UIScreen.main.bounds.width

var dialogWidth: CGFloat = 300

var RGBAColor: (CGFloat, CGFloat, CGFloat, CGFloat) -> UIColor = {red, green, blue, alpha in
    return UIColor(red: red / 255, green: green / 255, blue: blue / 255, alpha: alpha);
}
