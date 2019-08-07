//
//  ModernWebViewController.h
//  ModernWebToolKit
//
//  Created by stephenwzl on 2019/8/7.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ModernWebViewController : UIViewController

@property (nonatomic, readonly) WKWebView *webview;

@end

NS_ASSUME_NONNULL_END
