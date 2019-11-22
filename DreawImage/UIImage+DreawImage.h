//
//  UIImage+DreawImage.h
//  DreawImage
//
//  Created by apple on 2019/11/19.
//  Copyright © 2019 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (DreawImage)
/**
 *图片生成文字水印
 */
+ (UIImage *)textWatermarkWithImage:(UIImage *)originalImage text:(NSString *)text textPoint:(CGPoint)point attributedString:(NSDictionary *)attributed;
/**
*图片生成图片水印
*/
+ (UIImage *)imageWatermarkWithImage:(UIImage *)originalImage image:(UIImage *)watermarkImage imageRect:(CGRect)rect;
/**
*图片剪取一部分圆形（椭圆）图片
*/
+ (UIImage*)clipCircleImageWithImage:(UIImage *)originalImage clipeRect:(CGRect)rect;
/**
*图片剪取一部分带边框的圆形（椭圆）图片
*/
+ (UIImage*)clipBorderCircleImageWithImage:(UIImage *)originalImage clipeRect:(CGRect)rect borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;
/**
*图片剪取一部分矩形图片
*/
+(UIImage *)cutImageWithImage:(UIImage *)originalImage cornerRadius:(CGFloat)cornerRadius clipRect:(CGRect)rect;
/**
*根据颜色生成一张图片
*/
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
/**
*修改图片尺寸
*/
+ (UIImage *)imageRemake:(UIImage*)originalImage byScalingToSize:(CGSize)targetSize;

/**
*橡皮擦功能（擦除）（可配合手势pan使用）
*/
+ (UIImage *)swipeImageWithView:(UIImageView *)originalImageView currentPoint:(CGPoint)nowPoint size:(CGSize)size;
/**
 获取一个view的截图,注意,只能截取能看的见的部分 （view生成图片/截屏）
 */
+ (UIImage *)makeImageWithView:(UIView *)view withSize:(CGSize)size;

/**
 获取一个view的截图,注意,截取view全部内容部分
 */
+ (UIImage *)makeImageWithFullViewContent:(UIView *)view;

/**
 生成圆形图片
*/
+ (UIImage *)makeCircleImageWithImage:(UIImage *)originalImage andRect:(CGRect)rect;
@end

NS_ASSUME_NONNULL_END
