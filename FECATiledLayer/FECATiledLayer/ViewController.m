//
//  ViewController.m
//  FECATiledLayer
//
//  Created by keso on 2017/8/20.
//  Copyright © 2017年 FlyElephant. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)cutImageAction:(UIButton *)sender {
    
    NSString *filePath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    NSLog(@"存储路径：%@",filePath);
    UIImage *image = [UIImage imageNamed:@"person.jpg"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    CGFloat WH = 256;
    CGSize size = image.size;
    
    //ceil 向上取整
    NSInteger rows = ceil(size.height / WH);
    NSInteger cols = ceil(size.width / WH);
    
    for (NSInteger y = 0; y < rows; ++y) {
        for (NSInteger x = 0; x < cols; ++x) {
            UIImage *subImage = [self captureView:imageView frame:CGRectMake(x*WH, y*WH, WH, WH)];
            NSString *path = [NSString stringWithFormat:@"%@/person_%02ld_%02ld.png",filePath,x,y];
            [UIImagePNGRepresentation(subImage) writeToFile:path atomically:YES];
        }
    }
    NSLog(@"图片切图完成");
}

/** 切图 */
- (UIImage*)captureView:(UIView *)theView frame:(CGRect)fra{
    //开启图形上下文 将heView的所有内容渲染到图形上下文中
    UIGraphicsBeginImageContext(theView.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [theView.layer renderInContext:context];
    //获取图片
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    CGImageRef ref = CGImageCreateWithImageInRect(img.CGImage, fra);
    UIImage *image = [UIImage imageWithCGImage:ref];
    CGImageRelease(ref);
    return image;
}


@end
