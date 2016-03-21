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

    //左边侧滑返回
    UIScreenEdgePanGestureRecognizer *backSwipeGestureRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(swipeBack:)];
    backSwipeGestureRecognizer.edges = UIRectEdgeLeft;
    //backSwipeGestureRecognizer.delegate = self.webView;
    [self.view addGestureRecognizer:backSwipeGestureRecognizer];
    UIView *invisibleScrollPreventerLeft = [UIView new];
    invisibleScrollPreventerLeft.frame = CGRectMake(0, 0, 20, self.view.frame.size.height);
    [self.view addSubview:invisibleScrollPreventerLeft];
    
    //右边侧滑前进
    UIScreenEdgePanGestureRecognizer *forwardSwipeGestureRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(swipeForward:)];
    forwardSwipeGestureRecognizer.edges = UIRectEdgeRight;
    //forwardSwipeGestureRecognizer.delegate = self.webView;
    [self.view addGestureRecognizer:forwardSwipeGestureRecognizer];
    UIView *invisibleScrollPreventerRight = [UIView new];
    invisibleScrollPreventerRight.frame = CGRectMake(self.view.frame.size.width, 0, self.view.frame.size.width-20, self.view.frame.size.height);
    [self.view addSubview:invisibleScrollPreventerRight];
}

-(void)swipeBack:(UIScreenEdgePanGestureRecognizer *)recognizerBack
{
    if (recognizerBack.state == UIGestureRecognizerStateBegan)
    {
        
        UIGraphicsBeginImageContext ( self.webView.frame.size );
        [self.webView.layer renderInContext:UIGraphicsGetCurrentContext() ];
        
        UIImage *grab = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        if ( _imgvcChild1 ) [ _imgvcChild1 removeFromSuperview ];
        _imgvcChild1 = [[ UIImageView alloc ] initWithImage:grab ];
        _imgvcChild1.frame = self.webView.frame;
        _imgvcChild1.userInteractionEnabled = YES;
        if ([self.webView canGoBack])
        {
            
            [self.webView goBack];
            
        }
        
        [ self.view addSubview:_imgvcChild1 ];
        
    }
    
    if (recognizerBack.state == UIGestureRecognizerStateChanged)
    {
        _imgvcChild1.frame = CGRectMake([ recognizerBack locationInView:_imgvcChild1.superview ].x, _imgvcChild1.frame.origin.y, _imgvcChild1.frame.size.width, _imgvcChild1.frame.size.height);
        
    }
    

    if (recognizerBack.state == UIGestureRecognizerStateEnded)
    {
    
        [_imgvcChild1 removeFromSuperview];
    }
        
}
-(void)swipeForward:(UIScreenEdgePanGestureRecognizer *)recognizerForward
{
    if (recognizerForward.state == UIGestureRecognizerStateEnded) {
        if (_webView.canGoForward) {
            [_webView goForward];
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
