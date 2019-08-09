//
//  ModernWebService.m
//  ModernWebToolKit
//
//  Created by stephenwzl on 2019/8/6.
//

#import "ModernWebService.h"
#import "ModernWebURLProtocol.h"

#import <WebKit/WebKit.h>

@interface ModernWebService()

@property (nonatomic, strong) ModernWebConfig *config;

@end

@implementation ModernWebService

+ (instancetype)shared {
    static dispatch_once_t onceToken;
    static ModernWebService *service;
    dispatch_once(&onceToken, ^{
        service = [ModernWebService new];
    });
    return service;
}

- (void)initializeWithConfig:(ModernWebConfig *)config {
    // can not be initialized again
    if (_config) {
        return;
    }
    // if no config, use default config
    _config = config ?: [ModernWebConfig new];
    [self doTheWebViewLoadHook];
    [NSURLProtocol registerClass:ModernWebURLProtocol.class];
}

- (void)doTheWebViewLoadHook {
    NSArray *symbol = @[@"ontroller", @"ontextC", @"rowsingC", @"KB", @"W"];
    NSString *clsName = [[[symbol reverseObjectEnumerator] allObjects] componentsJoinedByString:@""];
    Class cls = NSClassFromString(clsName);
    SEL sel = NSSelectorFromString(@"registerSchemeForCustomProtocol:");
    if (cls && sel && [cls respondsToSelector:sel]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [cls performSelector:sel withObject:@"http"];
        [cls performSelector:sel withObject:@"https"];
#pragma clang diagnostic pop
    } else {
        NSAssert(NO, @"initialize webview hook failed");
    }
}


@end

@implementation ModernWebConfig

- (instancetype)init {
    if (self = [super init]) {
        _virtualHost = @"stephenw.cc";
        _sandboxCachePath = @"/modernweb";
    }
    return self;
}

@end
