//
//  ViewController.m
//  Fusionworks News
//
//  Created by lofyer on 16/3/6.
//  Copyright © 2016年 lofyer. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSURL *url = [NSURL URLWithString:@"https://forex.fusionworks.cn"];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];

    //侧滑返回
    UIScreenEdgePanGestureRecognizer *bezelSwipeGestureRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(swipeBack:)];
    bezelSwipeGestureRecognizer.edges = UIRectEdgeLeft;
    bezelSwipeGestureRecognizer.delegate = self;
    [self.view addGestureRecognizer:bezelSwipeGestureRecognizer];
    UIView *invisibleScrollPreventer = [UIView new];
    invisibleScrollPreventer.frame = CGRectMake(0, 0, 10, self.view.frame.size.height);
    [self.view addSubview:invisibleScrollPreventer];

}

-(void)swipeBack:(UIScreenEdgePanGestureRecognizer *)recognizer
{
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        if (_webView.canGoBack) {
            [_webView goBack];
        }
    }
}

//webView自适应屏幕大小
- (void)viewDidLayoutSubviews {
    self.webView.frame = CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
