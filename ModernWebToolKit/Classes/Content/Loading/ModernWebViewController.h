//
//  ModernWebViewController.h
//  ModernWebToolKit
//
//  Created by stephenwzl on 2019/8/7.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@class ModernWebAPIContext;

NS_ASSUME_NONNULL_BEGIN

@interface ModernWebViewController : UIViewController

@property (nonatomic, readonly) WKWebView *webview;

@property (nonatomic, readonly) ModernWebAPIContext *context;

@end

NS_ASSUME_NONNULL_END
