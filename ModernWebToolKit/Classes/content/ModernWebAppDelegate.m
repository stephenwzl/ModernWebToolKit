//
//  ModernWebAppDelegate.m
//  ModernWebToolKit
//
//  Created by stephenwzl on 2019/8/9.
//

#import "ModernWebAppDelegate.h"
#import "ModernWebViewController.h"
#import "ModernWebAppCenter.h"

ModernWebAppId const ModernProxyWebAppId = @"20000001";

@interface ModernWebAppProxyDelegate ()

@property (nonatomic, strong) ModernWebViewController *viewController;

@end

@implementation ModernWebAppProxyDelegate

+ (instancetype)shared {
    static dispatch_once_t onceToken;
    static ModernWebAppProxyDelegate *delegate;
    dispatch_once(&onceToken, ^{
        delegate = ModernWebAppProxyDelegate.new;
    });
    return delegate;
}

- (ModernWebViewController *)viewController {
    if (!_viewController) {
        _viewController = [ModernWebViewController new];
    }
    return _viewController;
}

#pragma mark - delegate

- (UIViewController *)rootControllerForApp:(ModernWebApp *)app {
    return self.viewController;
}

- (BOOL)app:(ModernWebApp *)app shouldLaunchWithParams:(NSDictionary *)params {
    if ([app.appId isEqualToString:ModernProxyWebAppId]) {
        return YES;
    }
    return NO;
}

- (void)app:(nonnull ModernWebApp *)app didFinishLaunchingWithParams:(NSDictionary * _Nullable)params {
    // TODO
}


@end
