//
//  ModernWebAPI.h
//  ModernWebToolKit
//
//  Created by stephenwzl on 2019/8/7.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN
@class ModernWebAPIContext;
@interface ModernWebAPI : NSObject
/**
 default is ModerWebBridge
 */
@property (nonatomic, copy) NSString *bridgeName;

//+ (instancetype)sharedAPI;

+ (void)invokeAPI:(NSString *)interface
         function:(NSString *)functionName
           params:(NSDictionary * _Nullable)params
      withContext:(ModernWebAPIContext *)context
       completion:(nullable void(^)(void))completion;

@end

@interface ModernWebAPIContext : NSObject

@property (nonatomic, readonly) WKWebViewConfiguration *configuration;
@property (nonatomic, weak) UIViewController *contentController;

@end

NS_ASSUME_NONNULL_END
