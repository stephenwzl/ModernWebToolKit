//
//  MWViewController.m
//  ModernWebToolKit
//
//  Created by stephenwzl on 08/06/2019.
//  Copyright (c) 2019 stephenwzl. All rights reserved.
//

#import "MWViewController.h"
#import <WebKit/WebKit.h>

@interface MWViewController ()
@property (weak, nonatomic) IBOutlet WKWebView *webview;

@end

@implementation MWViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.webview loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://20000063.stephenw.cc/index.html"]]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
