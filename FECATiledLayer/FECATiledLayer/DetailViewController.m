//
//  DetailViewController.m
//  FECATiledLayer
//
//  Created by keso on 2017/8/20.
//  Copyright © 2017年 FlyElephant. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()<CALayerDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) CATiledLayer *tileLayer;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tileLayer = [CATiledLayer layer];
    self.tileLayer.frame = CGRectMake(0, 0, 1920, 1200);
    self.tileLayer.delegate = self;
//    tileLayer.contentsScale = [UIScreen mainScreen].scale;
    [self.scrollView.layer addSublayer:self.tileLayer];
    
    //configure the scroll view
    self.scrollView.contentSize = self.tileLayer.frame.size;
    
    //draw layer
    [self.tileLayer setNeedsDisplay];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.tileLayer removeFromSuperlayer];
    self.tileLayer = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
    //determine tile coordinate
    CGRect bounds = CGContextGetClipBoundingBox(ctx);
    NSInteger x = floor(bounds.origin.x / self.tileLayer.tileSize.width);
    NSInteger y = floor(bounds.origin.y / self.tileLayer.tileSize.height);
    NSLog(@"转动的x:%f---y:%f",bounds.origin.x,bounds.origin.y);
    //load tile image
    NSString *imageName = [NSString stringWithFormat: @"person_%02ld_%02ld", x, y];
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:imageName ofType:@"png"];
    UIImage *tileImage = [UIImage imageWithContentsOfFile:imagePath];
    
    //draw tile
    UIGraphicsPushContext(ctx);
    [tileImage drawInRect:bounds];
    UIGraphicsPopContext();
    
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSaveGState(context);
//    [tileImage drawInRect:bounds];
//    CGContextRestoreGState(context);
}

@end
