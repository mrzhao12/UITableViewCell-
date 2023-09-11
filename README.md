# UITableViewCell-
cell部分圆角
UITableViewCell部分圆角
UITableViewCell多分组下部分圆角
作者：ttdiOS
链接：https://juejin.cn/spost/7277362508813500457
来源：稀土掘金
著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。




实现效果如图：

![IMG_0BB02543B1D3-1](https://github.com/mrzhao12/UITableViewCell-/assets/17422639/ec3bd8f7-9e4b-4269-a68d-129224367499)

swift和oc版本都有
直接上demo：


.h文件：
#import 
NS_ASSUME_NONNULL_BEGIN
@interface LLJSUIKitHelper : NSObject
-(void)LLJCView:(UIView*)viewcornerRadius:(NSArray*)cornerRadius;
@end
NS_ASSUME_NONNULL_END
.m文件
#import "LLJSUIKitHelper.h"
@implementation LLJSUIKitHelper
-(void)LLJCView:(UIView*)subViewcornerRadius:(NSArray*)cornerRadius{
    UIBezierPath *path = [[UIBezierPath alloc] init];
    NSMutableArray*cornerArray  = [NSMutableArray array];
    for(inti =0; i
        if(i ==0){
            [cornerArrayaddObject:@(UIRectCornerTopLeft)];
        }else if(i ==1){
            [cornerArrayaddObject:@(UIRectCornerTopRight)];
        }else if(i ==2){
            [cornerArrayaddObject:@(UIRectCornerBottomRight)];
        }else if(i ==3){
            [cornerArrayaddObject:@(UIRectCornerBottomLeft)];
        }
    }
    path = [selfdrawRoundedRect:subView.boundsbyRoundingCorners:cornerArraycornerRadius:cornerRadius];
    CAShapeLayer *subLayer = [CAShapeLayer layer];
    subLayer.fillColor = [UIColor whiteColor].CGColor;
    subLayer.path= path.CGPath;
    subLayer.frame= subView.bounds;
    subView.layer.mask= subLayer;
}
-(UIBezierPath*)drawRoundedRect:(CGRect)rectbyRoundingCorners:(NSMutableArray*)byRoundingCornerscornerRadius:(NSArray*)cornerRadius{
    UIBezierPath *path = [[UIBezierPath alloc] init];
    CGPoint  startPoint =CGPointMake(rect.origin.x, rect.origin.y);
    //处理第一个角
    if ([byRoundingCorners containsObject:@(UIRectCornerTopLeft)]) {
        NSNumber*position = cornerRadius.firstObject;// ------>cornerRadius
        CGFloatmycg = position.floatValue;
        [pathmoveToPoint:CGPointMake(startPoint.x+ mycg, startPoint.y)];
    }else{
        [pathmoveToPoint:CGPointMake(startPoint.x, startPoint.y)];
    }
    //处理第二个角
    if ([byRoundingCorners containsObject:@(UIRectCornerTopRight)]) {
        NSNumber*position = [cornerRadiusobjectAtIndex:1];
        CGFloatmycg = position.floatValue;
        [pathaddLineToPoint:CGPointMake(startPoint.x+ rect.size.width- mycg, startPoint.y)];
        [pathaddArcWithCenter:CGPointMake(startPoint.x+ rect.size.width- mycg, startPoint.y+ mycg)radius:mycgstartAngle: (M_PI*3/2)endAngle:0clockwise:YES];
    }else{
        [pathaddLineToPoint:CGPointMake(startPoint.x+ rect.size.width, startPoint.y)];
    }
    //处理第三个角
    if ([byRoundingCorners containsObject:@(UIRectCornerBottomRight)]) {
        NSNumber*position = [cornerRadiusobjectAtIndex:2];
        CGFloatmycg = position.floatValue;
        [pathaddLineToPoint:CGPointMake(startPoint.x+ rect.size.width, startPoint.y+rect.size.height)];
        [pathaddArcWithCenter:CGPointMake(startPoint.x+rect.size.width-mycg, startPoint.y+rect.size.height-mycg)radius:mycgstartAngle:0endAngle: (M_PI/2)clockwise:YES];
    }else{
        [pathaddLineToPoint:CGPointMake(startPoint.x+ rect.size.width, startPoint.y+ rect.size.height)];
    }
//    //处理第四个角
    if ([byRoundingCorners containsObject:@(UIRectCornerBottomLeft)]) {
        NSNumber*position = [cornerRadiusobjectAtIndex:3];
        CGFloatmycg = position.floatValue;
        [pathaddLineToPoint:CGPointMake(startPoint.x+ mycg, startPoint.y+rect.size.height)];
        [pathaddArcWithCenter:CGPointMake(startPoint.x+mycg, startPoint.y+ rect.size.height-mycg)radius:mycgstartAngle: (M_PI/2)endAngle: (M_PI)clockwise:YES];
    }else{
        [pathaddLineToPoint:CGPointMake(startPoint.x, startPoint.y+rect.size.height)];
    }
//    //再次处理第一个角
    if ([byRoundingCorners containsObject:@(UIRectCornerTopLeft)]) {
        NSNumber*position = cornerRadius.firstObject;
         CGFloatmycg = position.floatValue;
        [pathaddLineToPoint:CGPointMake(startPoint.x, startPoint.y+ mycg)];
        [pathaddArcWithCenter:CGPointMake(startPoint.x+mycg, startPoint.y+ mycg)radius:mycgstartAngle: (M_PI)endAngle:(M_PI*3/2)clockwise:YES];
    }else{
        [pathaddLineToPoint:CGPointMake(startPoint.x, startPoint.y)];
    }
    returnpath;
}
@end
调用：直接在对应的TableView所在vc里写如下即可：

- (void)tableView:(UITableView)tableViewwillDisplayCell:(UITableViewCell)cellforRowAtIndexPath:(NSIndexPath*)indexPath{
**
    //组切圆角
    //方法一 判断第一个cell, 切出左上和又上圆角, 最后一个cell, 切出左下和右下圆角
    //方法二 使用带圆角的图片模拟
    LLJSUIKitHelper*kitHelper =  [[LLJSUIKitHelper alloc] init];
    if(indexPath.section==sectionSystem){
        [kitHelperLLJCView:cellcornerRadius:@[@(20),@(20),@(20),@(20)]];
  }  else if(indexPath.section==sectionCommunity){
      [kitHelperLLJCView:cellcornerRadius:@[@(20),@(20),@(12),@(12)]];
  }
  else if(indexPath.section==sectionWangyi){
      [kitHelperLLJCView:cellcornerRadius:@[@(20),@(10),@(40),@(20)]];
  }else if(indexPath.section==sectionChat){
      if(self.recentSessions.count>0) {
          if(self.recentSessions.count==1) {
              [kitHelperLLJCView:cellcornerRadius:@[@(10),@(10),@(10),@(10)]];
          }else{
              if( indexPath.row==0) {
                  [kitHelperLLJCView:cellcornerRadius:@[@(10),@(10),@(0),@(0)]];
              }else if(indexPath.row==self.recentSessions.count-1) {
//                  LLJSUIKitHelper.LLJCView(subView: cell, cornerRadius: [0,0,12,12])
                  [kitHelperLLJCView:cellcornerRadius:@[@(0),@(0),@(10),@(10)]];
              }
          }
      }
  }
  else if(indexPath.section==sectionGray){
      [kitHelperLLJCView:cellcornerRadius:@[@(20),@(10),@(40),@(20)]];
  }
}

swift代码如下：
importUIKit
public class LLJSUIKitHelper {
    //UIView
    class func LLJView(backGroundColor: UIColor?, frame: CGRect?) -> UIView {
        letview =UIView()
        if(backGroundColor !=nil) {
            view.backgroundColor= backGroundColor
        }
        if(frame !=nil) {
            view.frame= frame!
        }
        returnview
    }
    //UIView 切统一圆角
    class func LLJCView(subView: UIView, cornerRadius: CGFloat) {
        // 圆角
        LLJCView(subView: subView,cornerRadius: [cornerRadius,cornerRadius,cornerRadius,cornerRadius])
    }
    //UIView 切指定不同圆角 cornerRadius = [8,10,12,14] 一次对应topLeft，topRight，bottomRight，bottomLeft的圆角半径
    class func LLJCView(subView: UIView, cornerRadius: [CGFloat]) {
        // 圆角
        varpath:UIBezierPath?
        varcornerArray = UIRectCorner
        foriinstride(from:0,to: cornerRadius.count,by:1) {
            ifi ==0{
                cornerArray.append(UIRectCorner.topLeft)
            }else ifi ==1{
                cornerArray.append(UIRectCorner.topRight)
            }else ifi ==2{
                cornerArray.append(UIRectCorner.bottomRight)
            }else ifi ==3{
                cornerArray.append(UIRectCorner.bottomLeft)
            }
        }
        path =LLJBezierPath.drawRoundedRect(rect: subView.bounds,byRoundingCorners: cornerArray,cornerRadius: cornerRadius)
        letsubLayer =CAShapeLayer()
        subLayer.path= path!.cgPath
        subLayer.frame= subView.bounds
        subView.layer.mask= subLayer;
    }
    //按钮
    class func LLJButton(title: String?, titleColor: UIColor?, backGroundColor: UIColor?, titleFont: UIFont?, frame: CGRect?) -> UIButton {
        let button = UIButton(type: UIButton.ButtonType.custom)
        if(title !=nil) {
            button.setTitle(title,for:UIControl.State.normal)
        }
        if(titleColor !=nil) {
            button.setTitleColor(titleColor,for:UIControl.State.normal)
        }
        if(backGroundColor !=nil) {
            button.backgroundColor= backGroundColor
        }
        if(titleFont !=nil) {
            button.titleLabel?.font= titleFont
        }
        if(frame !=nil) {
            button.frame= frame!
        }
        returnbutton;
    }
    //Label
    class func LLJLabel(title: String?, titleColor: UIColor?, backGroundColor: UIColor?, titleFont: UIFont?, frame: CGRect?, numberOfLines: Int) -> UILabel {
        letlabel =UILabel()
        if(title !=nil) {
            label.text= title
        }
        if(titleColor !=nil) {
            label.textColor= titleColor
        }
        if(backGroundColor !=nil) {
            label.backgroundColor= backGroundColor
        }
        if(titleFont !=nil) {
            label.font= titleFont
        }
        if(frame !=nil) {
            label.frame= frame!
        }
        label.numberOfLines= numberOfLines
        returnlabel;
    }
}

importUIKit
class LLJBezierPath {
    /*
     * 画圆 椭圆
     * rect.w = rect.h 时画圆； rect.w != rect.h 画椭圆
     */
    class func drawCyle(rect: CGRect) -> UIBezierPath {
        letpath =UIBezierPath.init(ovalIn: rect)
        returnpath
    }
    /*
     * 画圆 圆弧
     * arcCenter: 圆心
     * radius: 半径
     * startAngle: 开始角度
     * endAngle: 结束角度
     * clockwise: 顺时针 yes 逆时针 no
     */
    class func drawCyle(arcCenter: CGPoint, radius: CGFloat, startAngle: CGFloat, endAngle: CGFloat, clockwise: Bool) -> UIBezierPath {
        letpath =UIBezierPath.init(arcCenter: arcCenter,radius: radius,startAngle: startAngle,endAngle: endAngle,clockwise: clockwise)
        returnpath
    }
    /*
     * 画矩形 统一圆角
     * rect: 矩形rect
     */
    class func drawRoundedRect(rect: CGRect, cornerRadius: CGFloat?) -> UIBezierPath {
        letpath =UIBezierPath.init(roundedRect: rect,cornerRadius: cornerRadius ??0.0)
        returnpath
    }
    /*
     * 画矩形 单一圆角
     * rect: 矩形rect
     */
    class func drawRoundedRect(rect: CGRect, byRoundingCorners: UIRectCorner, cornerRadius: CGFloat) -> UIBezierPath {
        letpath =UIBezierPath.init(roundedRect: rect,byRoundingCorners: byRoundingCorners,cornerRadii:CGSize(width: cornerRadius,height: cornerRadius))
        returnpath
    }
    /*
     * 画矩形 可变圆角
     * byRoundingCorners: 需要切的圆角
     * cornerRadius: 圆角半径
     * 注意：byRoundingCorners要和cornerRadius一一对应。
     * 如：[UIRectCorner.topLeft,UIRectCorner.topRight,UIRectCorner.bottomLeft,UIRectCorner.bottomRight] 对应 [10,5,5,10]
     */
    class func drawRoundedRect(rect: CGRect, byRoundingCorners: [UIRectCorner], cornerRadius: [CGFloat]) -> UIBezierPath {
        letpath =UIBezierPath()
        letstartPoint =CGPoint(x: rect.origin.x,y: rect.origin.y)
        //处理第一个角
        ifbyRoundingCorners.contains(UIRectCorner.topLeft) {
            letposition = byRoundingCorners.firstIndex(of:UIRectCorner.topLeft)
            path.move(to:CGPoint(x: startPoint.x+ cornerRadius[position!],y: startPoint.y))
        }else{
            path.move(to:CGPoint(x: startPoint.x,y: startPoint.y))
        }
        //处理第二个角
        ifbyRoundingCorners.contains(UIRectCorner.topRight) {
            letposition = byRoundingCorners.firstIndex(of:UIRectCorner.topRight)
            path.addLine(to:CGPoint(x: startPoint.x+ rect.width- cornerRadius[position!],y: startPoint.y))
            path.addArc(withCenter:CGPoint(x: startPoint.x+ rect.width- cornerRadius[position!],y: startPoint.y+ cornerRadius[position!]),radius: cornerRadius[position!],startAngle:CGFloat.pi*3/2,endAngle:0,clockwise:true)
        }else{
            path.addLine(to:CGPoint(x: startPoint.x+ rect.width,y: startPoint.y))
        }
        //处理第三个角
        ifbyRoundingCorners.contains(UIRectCorner.bottomRight) {
            letposition = byRoundingCorners.firstIndex(of:UIRectCorner.bottomRight)
            path.addLine(to:CGPoint(x: startPoint.x+ rect.width,y: startPoint.y+ rect.height- cornerRadius[position!]))
            path.addArc(withCenter:CGPoint(x: startPoint.x+ rect.width- cornerRadius[position!],y: startPoint.y+ rect.height- cornerRadius[position!]),radius: cornerRadius[position!],startAngle:0,endAngle:CGFloat.pi/2,clockwise:true)
        }else{
            path.addLine(to:CGPoint(x: startPoint.x+ rect.width,y: startPoint.y+ rect.height))
        }
        //处理第四个角
        ifbyRoundingCorners.contains(UIRectCorner.bottomLeft) {
            letposition = byRoundingCorners.firstIndex(of:UIRectCorner.bottomLeft)
            path.addLine(to:CGPoint(x: startPoint.x+ cornerRadius[position!],y: startPoint.y+ rect.height))
            path.addArc(withCenter:CGPoint(x: startPoint.x+ cornerRadius[position!],y: startPoint.y+ rect.height- cornerRadius[position!]),radius: cornerRadius[position!],startAngle:CGFloat.pi/2,endAngle:CGFloat.pi,clockwise:true)
        }else{
            path.addLine(to:CGPoint(x: startPoint.x,y: startPoint.y+ rect.height))
        }
        //再次处理第一个角
        ifbyRoundingCorners.contains(UIRectCorner.topLeft) {
            letposition = byRoundingCorners.firstIndex(of:UIRectCorner.topLeft)
            path.addLine(to:CGPoint(x: startPoint.x,y: startPoint.y+ cornerRadius[position!]))
            path.addArc(withCenter:CGPoint(x: startPoint.x+ cornerRadius[position!],y: startPoint.y+ cornerRadius[position!]),radius: cornerRadius[position!],startAngle:CGFloat.pi,endAngle:CGFloat.pi*3/2,clockwise:true)
        }else{
            path.addLine(to:CGPoint(x: startPoint.x,y: startPoint.y))
        }
        returnpath
    }
    /*
     * 画多边行 或折线
     * pointArray：多边形顶点数组，第一个点默认起点
     * closePath：true表示关闭，即多边形；false表示不关闭，即折线图
     */
    class func drawPolygon(pointArray: Array, closePath: Bool) -> UIBezierPath {
        letpath =UIBezierPath()
        foriinstride(from:0,to: pointArray.count,by:1) {
            letpoint = pointArray[i]
            ifi ==0{
                path.move(to: point)
            }else{
                path.addLine(to: point)
            }
        }
        ifclosePath {
            path.close()
        }
        returnpath
    }
    /*
     * 画曲线 单曲线
     * startPoint: 起点
     * endPoint: 终点
     * controlPoint: 控制点
     */
    class func drawoQuadCurve(startPoint: CGPoint, endPoint: CGPoint, controlPoint: CGPoint) -> UIBezierPath {
        letpath =UIBezierPath()
        path.move(to: startPoint)
        path.addQuadCurve(to: endPoint,controlPoint: controlPoint)
        returnpath
    }
    /*
     * 画曲线 双曲线
     * startPoint: 起点
     * endPoint: 终点
     * controlPoint1: 控制点1
     * controlPoint2: 控制点2
     */
    class func drawCurve(startPoint: CGPoint, endPoint: CGPoint, controlPoint1: CGPoint, controlPoint2: CGPoint) -> UIBezierPath {
        letpath =UIBezierPath()
        path.move(to: startPoint)
        path.addCurve(to: endPoint,controlPoint1: controlPoint1,controlPoint2: controlPoint2)
        returnpath
    }
}

调用：
extension LLJWChatMainViewController: UITableViewDelegate {
    functableView(_tableView:UITableView,willDisplaycell:UITableViewCell,forRowAtindexPath:IndexPath) {
        //组切圆角
        //方法一 判断第一个cell, 切出左上和又上圆角, 最后一个cell, 切出左下和右下圆角
        //方法二 使用带圆角的图片模拟
        letsubArray =self.dataArray[indexPath.section]
        //切圆角
        ifsubArray.count==1{
            LLJSUIKitHelper.LLJCView(subView: cell,cornerRadius: [12,12,12,12])
        }else{
            ifindexPath.row==0{
                LLJSUIKitHelper.LLJCView(subView: cell,cornerRadius: [12,12,0,0])
            }else if(indexPath.row== subArray.count-1) {
                LLJSUIKitHelper.LLJCView(subView: cell,cornerRadius: [0,0,12,12])
            }
        }
    }
}



