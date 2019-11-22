//
//  ViewController.m
//  DreawImage
//
//  Created by apple on 2019/11/19.
//  Copyright © 2019 apple. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+DreawImage.h"
#import <Photos/Photos.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.tag = 1000;
    // 原始图片
    UIImage *image = [UIImage imageNamed:@"123"];
    imageView.image = image;
    [self.view addSubview:imageView];
    
    //生成文字水印
    NSDictionary *attributedDic = @{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:[UIColor whiteColor]};
    UIImage *newImage = [UIImage textWatermarkWithImage:image text:@"文字水印cookie" textPoint:CGPointMake(self.view.bounds.size.width - 150, self.view.bounds.size.height - 100) attributedString:attributedDic];
    imageView.image = newImage;
    
    //生成图片水印
    UIImage *newImage1 = [UIImage imageWatermarkWithImage:image image:[UIImage imageNamed:@"housekeep"] imageRect:CGRectMake(self.view.bounds.size.width - 150, self.view.bounds.size.height - 100, 60, 60)];
    imageView.image = newImage1;
    
//    //图片剪裁成圆形图片
//    UIImage *newImage2 = [UIImage clipCircleImageWithImage:image clipeRect:CGRectMake(50, 200, 300, 500)];
//    imageView.image = newImage2;
//
//    //图片剪裁成带边框圆形图片
//    UIImage *newImage3 = [UIImage clipBorderCircleImageWithImage:image clipeRect:CGRectMake(50, 200, 300, 500) borderWidth:5.0f borderColor:[UIColor redColor]];
//    imageView.image = newImage3;
//
//    //图片剪裁矩形图片
//    UIImage *newImage4 = [UIImage cutImageWithImage:image cornerRadius:5 clipRect:CGRectMake(50, 200, 300, 500)];
//    imageView.image = newImage4;
//
//    //根据颜色生成图片
//    UIImage *newImage5 = [UIImage imageWithColor:[UIColor redColor] size:CGSizeMake(300, 300)];
//    imageView.image = newImage5;
//
//    //修改图片尺寸
//    UIImage *newImage6 = [UIImage imageRemake:image byScalingToSize:CGSizeMake(200,300)];
//    imageView.image = newImage6;
//
    
    //橡皮擦 擦除
//    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(wipePan:)];
//    imageView.userInteractionEnabled = YES;
//    [imageView addGestureRecognizer:pan];
//
//    //截图并保存到相册
//    UIView *oneView = [[UIView alloc]init];
//    oneView.backgroundColor = [UIColor yellowColor];
//    oneView.frame = CGRectMake(0, 400, 100, 100);
//    [self.view addSubview:oneView];
//
//    UIImage *newImage8 = [UIImage makeImageWithView:oneView withSize:CGSizeMake(10, 10)];
//    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
//        [PHAssetChangeRequest creationRequestForAssetFromImage:newImage8];
//    } completionHandler:^(BOOL success, NSError * _Nullable error) {
//
//    }];
//
//    UIScrollView *scrlloview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 500, 300, 100)];
//    [self.view addSubview:scrlloview];
//    scrlloview.backgroundColor=[UIColor redColor];
//    scrlloview.contentSize = CGSizeMake(300, 800);
//
//    UIImage *newImage9 = [UIImage makeImageWithFullViewContent:scrlloview];
//    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
//        [PHAssetChangeRequest creationRequestForAssetFromImage:newImage9];
//    } completionHandler:^(BOOL success, NSError * _Nullable error) {
//
//    }];
    
    UIImage *newImage10 = [UIImage makeCircleImageWithImage:image andRect:CGRectMake(100, 100, 200, 200)];
    imageView.image = newImage10;
}


-(void)wipePan:(UIPanGestureRecognizer *)pan {
    UIImageView *imageView = (UIImageView *)[self.view viewWithTag:1000];
    
    imageView.image =[UIImage swipeImageWithView:imageView currentPoint:[pan locationInView:imageView] size:CGSizeMake(20, 20)];
    
}

@end
