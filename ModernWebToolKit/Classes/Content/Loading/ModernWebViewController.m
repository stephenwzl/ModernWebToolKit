//
//  ModernWebViewController.m
//  ModernWebToolKit
//
//  Created by stephenwzl on 2019/8/7.
//

#import "ModernWebViewController.h"
#import "ModernWebAPI.h"
#import <WebKit/WebKit.h>

@interface ModernWebViewController ()

@property (nonatomic, strong) WKWebView *webview;
@property (nonatomic, strong) ModernWebAPIContext *context;

@end

@implementation ModernWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (WKWebView *)webview {
    if (!_webview) {
        _webview = [[WKWebView alloc] initWithFrame:UIScreen.mainScreen.bounds
                                      configuration:self.context.configuration];
    }
    return _webview;
}

- (ModernWebAPIContext *)context {
    if (!_context) {
        _context = [ModernWebAPIContext new];
        _context.contentController = self;
    }
    return _context;
}

@end
