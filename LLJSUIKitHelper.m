//
//  LLJSUIKitHelper.m
//  scifateeredar
//
//  Created by zhaotong on 2023/9/11.
//  Copyright © 2023 com.octInn. All rights reserved.
#import "LLJSUIKitHelper.h"
@implementation LLJSUIKitHelper
-(void)LLJCView:(UIView *)subView cornerRadius:(NSArray *)cornerRadius{
    UIBezierPath *path = [[UIBezierPath alloc] init];
    NSMutableArray *cornerArray  = [NSMutableArray array];
    for (int i = 0; i<cornerRadius.count; i++) {
        if(i == 0){
            [cornerArray addObject:@(UIRectCornerTopLeft)];
        }else if (i == 1){
            [cornerArray addObject:@(UIRectCornerTopRight)];
        }else if (i == 2){
            [cornerArray addObject:@(UIRectCornerBottomRight)];
        }else if (i == 3){
            [cornerArray addObject:@(UIRectCornerBottomLeft)];
        }
    }
    path = [self drawRoundedRect:subView.bounds byRoundingCorners:cornerArray cornerRadius:cornerRadius];
    CAShapeLayer *subLayer = [CAShapeLayer layer];
    subLayer.fillColor = [UIColor whiteColor].CGColor;
    subLayer.path = path.CGPath;
    subLayer.frame = subView.bounds;
    subView.layer.mask = subLayer;
}
-(UIBezierPath *)drawRoundedRect:(CGRect)rect byRoundingCorners:(NSMutableArray *)byRoundingCorners cornerRadius:(NSArray *)cornerRadius{
    UIBezierPath *path = [[UIBezierPath alloc] init];
    CGPoint  startPoint = CGPointMake(rect.origin.x, rect.origin.y);
    //处理第一个角
    if ([byRoundingCorners containsObject:@(UIRectCornerTopLeft)]) {
        NSNumber *position = cornerRadius.firstObject;// ------>cornerRadius
        CGFloat mycg = position.floatValue;
        [path moveToPoint:CGPointMake(startPoint.x + mycg, startPoint.y)];
    }else{
        [path moveToPoint:CGPointMake(startPoint.x , startPoint.y)];
    }
    //处理第二个角
    if ([byRoundingCorners containsObject:@(UIRectCornerTopRight)]) {
        NSNumber *position = [cornerRadius objectAtIndex:1];
        CGFloat mycg = position.floatValue;
        [path addLineToPoint:CGPointMake(startPoint.x + rect.size.width - mycg, startPoint.y)];
        [path addArcWithCenter:CGPointMake(startPoint.x + rect.size.width - mycg, startPoint.y + mycg) radius:mycg startAngle: (M_PI*3/2) endAngle:0 clockwise:YES];
    } else {
        [path addLineToPoint:CGPointMake(startPoint.x + rect.size.width, startPoint.y)];
    }
    //处理第三个角
    if ([byRoundingCorners containsObject:@(UIRectCornerBottomRight)]) {
        NSNumber *position = [cornerRadius objectAtIndex:2];
        CGFloat mycg = position.floatValue;
        [path addLineToPoint:CGPointMake(startPoint.x + rect.size.width, startPoint.y+rect.size.height)];
        [path addArcWithCenter:CGPointMake(startPoint.x+rect.size.width-mycg, startPoint.y+rect.size.height-mycg) radius:mycg startAngle:0 endAngle: (M_PI/2) clockwise:YES];
    } else {
        [path addLineToPoint:CGPointMake(startPoint.x + rect.size.width, startPoint.y + rect.size.height)];
    }
//    //处理第四个角
    if ([byRoundingCorners containsObject:@(UIRectCornerBottomLeft)]) {
        NSNumber *position = [cornerRadius objectAtIndex:3];
        CGFloat mycg = position.floatValue;
        [path addLineToPoint:CGPointMake(startPoint.x + mycg, startPoint.y +rect.size.height)];
        [path addArcWithCenter:CGPointMake(startPoint.x+mycg, startPoint.y + rect.size.height-mycg) radius:mycg startAngle: (M_PI/2) endAngle: (M_PI) clockwise:YES];
    } else {
        [path addLineToPoint:CGPointMake(startPoint.x, startPoint.y+rect.size.height)];
    }
//    //再次处理第一个角
    if ([byRoundingCorners containsObject:@(UIRectCornerTopLeft)]) {
        NSNumber *position = cornerRadius.firstObject;
         CGFloat mycg = position.floatValue;
        [path addLineToPoint:CGPointMake(startPoint.x, startPoint.y + mycg)];
        [path addArcWithCenter:CGPointMake(startPoint.x+mycg, startPoint.y + mycg) radius:mycg startAngle: (M_PI) endAngle:(M_PI*3/2) clockwise:YES];
    } else {
        [path addLineToPoint:CGPointMake(startPoint.x, startPoint.y)];
    }
    return path;
}



@end
