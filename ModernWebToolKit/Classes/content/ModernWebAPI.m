//
//  ModernWebAPI.m
//  ModernWebToolKit
//
//  Created by stephenwzl on 2019/8/7.
//

#import "ModernWebAPI.h"

@implementation ModernWebAPI

+ (instancetype)sharedAPI {
    static dispatch_once_t onceToken;
    static ModernWebAPI *webapi;
    dispatch_once(&onceToken, ^{
        webapi = [ModernWebAPI new];
    });
    return webapi;
}

+ (void)invokeAPI:(NSString *)interface
         function:(NSString *)functionName
           params:(NSDictionary *)params
      withContext:(ModernWebAPIContext *)context
       completion:(void (^)(void))completion {
    // TODO: implement
    
}

@end

@interface ModernWebAPIContext()

@property (nonatomic, strong) WKWebViewConfiguration *configuration;

@end

@implementation ModernWebAPIContext

- (WKWebViewConfiguration *)configuration {
    if (!_configuration) {
        WKWebViewConfiguration *configuration = [WKWebViewConfiguration new];
        configuration.userContentController = [WKUserContentController new];
        // TODO: script source
        [configuration.userContentController addUserScript:[[WKUserScript alloc] initWithSource:@""
                                                                                  injectionTime:WKUserScriptInjectionTimeAtDocumentStart
                                                                               forMainFrameOnly:YES]];
        _configuration = configuration;
    }
    return _configuration;
}

@end
