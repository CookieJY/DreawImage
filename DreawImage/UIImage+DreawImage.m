//
//  UIImage+DreawImage.m
//  DreawImage
//
//  Created by apple on 2019/11/19.
//  Copyright © 2019 apple. All rights reserved.
//

/**
 drawInRect 是以rect作为图片的绘制区域，图片以填充的方式被绘制在当前区域图片的大小，rect的宽高比与原图的宽高比不同时，会造成变形
 drawAtPoint 是以point作为图片绘制的起点，绘制图片的大小为图片的大小，不会使图片变形
 */

#import "UIImage+DreawImage.h"

@implementation UIImage (DreawImage)
/**
*图片生成文字水印
*/
+ (UIImage *)textWatermarkWithImage:(UIImage *)originalImage text:(NSString *)text textPoint:(CGPoint)point attributedString:(NSDictionary *)attributed {
    UIGraphicsBeginImageContextWithOptions(originalImage.size, NO, 0);
    [originalImage drawInRect:CGRectMake(0, 0, originalImage.size.width, originalImage.size.height)];
    [text drawAtPoint:point withAttributes:attributed];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
/**
*图片生成图片水印
*/
+ (UIImage *)imageWatermarkWithImage:(UIImage *)originalImage image:(UIImage *)watermarkImage imageRect:(CGRect)rect {
    UIGraphicsBeginImageContextWithOptions(originalImage.size, NO, 0);
    [originalImage drawInRect:CGRectMake(0, 0, originalImage.size.width, originalImage.size.height)];
    [watermarkImage drawInRect:rect];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
/**
*图片剪裁成圆形图片
*/
+ (UIImage*)clipCircleImageWithImage:(UIImage *)originalImage clipeRect:(CGRect)rect{
    UIGraphicsBeginImageContextWithOptions(originalImage.size, NO, 0);
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:rect];//内切圆
    [path addClip];
    [originalImage drawAtPoint:CGPointZero];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
/**
*图片剪裁成带边框的圆形图片
*/
+ (UIImage*)clipBorderCircleImageWithImage:(UIImage *)originalImage clipeRect:(CGRect)rect borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor{
    UIGraphicsBeginImageContextWithOptions(originalImage.size, NO, 0);
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:rect];
    [borderColor setFill];
    [path fill];
    
    UIBezierPath *clipPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(rect.origin.x+borderWidth, rect.origin.y+borderWidth, rect.size.width-2*borderWidth, rect.size.height-2*borderWidth)];
    [clipPath addClip];
    [originalImage drawAtPoint:CGPointZero];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
/**
*图片剪裁矩形图片
*/
+(UIImage *)cutImageWithImage:(UIImage *)originalImage cornerRadius:(CGFloat)cornerRadius clipRect:(CGRect)rect{
    UIGraphicsBeginImageContextWithOptions(originalImage.size, NO, 0);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:cornerRadius];
    [path addClip];
    
    [originalImage drawAtPoint:CGPointZero];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


/*
*根据颜色生成一张图片
*/
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size{
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, size.width, size.height)];
    [color setFill];
    [path fill];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
    
}
/**
*修改图片尺寸
*/
+ (UIImage *)imageRemake:(UIImage*)originalImage byScalingToSize:(CGSize)targetSize{
    UIGraphicsBeginImageContextWithOptions(originalImage.size, NO, 0);
    [originalImage drawInRect:CGRectMake(0, 0, targetSize.width, targetSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
/**
*橡皮擦功能（擦除）
*/
+ (UIImage *)swipeImageWithView:(UIImageView *)originalImageView currentPoint:(CGPoint)nowPoint size:(CGSize)size{
   //计算位置
    CGFloat offsetX = nowPoint.x - size.width * 0.5;
    CGFloat offsetY = nowPoint.y - size.height * 0.5;
    CGRect clipRect = CGRectMake(offsetX, offsetY, size.width, size.height);
    
    //开启上下文
    UIGraphicsBeginImageContextWithOptions(originalImageView.bounds.size, NO, 1);
    //获取当前的上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //把图片绘制上去
    [originalImageView.layer renderInContext:ctx];
    //把这一块设置为透明
    CGContextClearRect(ctx, clipRect);
    
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

/**
 获取一个view的截图,注意,只能截取能看的见的部分
 */
+ (UIImage *)makeImageWithView:(UIView *)view withSize:(CGSize)size{
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];//渲染view.layer
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;

}
/**
 获取一个view的截图,注意,截取view全部内容部分

 */
+ (UIImage *)makeImageWithFullViewContent:(UIView *)view{
    if ([view isKindOfClass:[UIScrollView class]]) {
        UIScrollView *scrollView = (UIScrollView *)view;
        CGPoint saveContentOffSet = scrollView.contentOffset;
        CGRect saveFrame = scrollView.frame;
        CGSize oriSize = scrollView.frame.size;
        CGSize contextSize = oriSize;
        if (scrollView.contentSize.width > oriSize.width || scrollView.contentSize.height > oriSize.height) {
            scrollView.contentOffset = CGPointZero;
            scrollView.frame = CGRectMake(0,0, scrollView.contentSize.width, scrollView.contentSize.height);
            contextSize = scrollView.contentSize;
        }
        
        UIGraphicsBeginImageContextWithOptions(contextSize, NO, 0.0);
        [scrollView.layer renderInContext:UIGraphicsGetCurrentContext()];
        scrollView.contentOffset = saveContentOffSet;
        scrollView.frame = saveFrame;
        UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return newImage;
    } else {
        UIImage *newImage = [UIImage makeImageWithView:view withSize:view.bounds.size];
        return newImage;
    }
}
/**
 生成圆形图片
*/
+ (UIImage *)makeCircleImageWithImage:(UIImage *)originalImage andRect:(CGRect)rect{
 
    UIGraphicsBeginImageContextWithOptions(originalImage.size, NO, 0);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, rect.size.width, rect.size.height)];
    [path addClip];
    
    [originalImage drawInRect:CGRectMake(0, 0, rect.size.width,rect.size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
@end
