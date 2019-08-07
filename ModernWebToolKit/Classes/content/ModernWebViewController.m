//
//  ModernWebViewController.m
//  ModernWebToolKit
//
//  Created by stephenwzl on 2019/8/7.
//

#import "ModernWebViewController.h"
#import <WebKit/WebKit.h>

@interface ModernWebViewController ()

@property (nonatomic, strong) WKWebView *webview;

@end

@implementation ModernWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (WKWebView *)webview {
    if (!_webview) {
        WKWebViewConfiguration *configuration = nil;
        _webview = [[WKWebView alloc] initWithFrame:UIScreen.mainScreen.bounds configuration:configuration];
    }
    return _webview;
}

@end
