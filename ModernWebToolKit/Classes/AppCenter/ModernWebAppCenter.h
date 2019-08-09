//
//  ModernWebAppCenter.h
//  ModernWebToolKit
//
//  Created by stephenwzl on 2019/8/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class ModernWebApp;

@interface ModernWebAppCenter : NSObject

+ (instancetype)sharedCenter;

- (ModernWebApp * _Nullable)getAppWithId:(NSString *)appId;

- (void)registerApp:(ModernWebApp *)app;

@end

@interface ModernWebApp : NSObject<NSCoding>

/**
 appId, number format, like 20000126
 */
@property (nonatomic, copy) NSString *appId;

/**
 app info, json format
 */
@property (nonatomic, copy) NSDictionary *info;

/**
 installed path, maybe null if not installed
 */
@property (nonatomic, readonly) NSString *installPath;

/**
 package download path, null for not download,
 main bundle path for internal app
 sandbox file path for downloaded app
 */
@property (nonatomic, copy, nullable) NSString *downloadPath;

@property (nonatomic, copy) NSDictionary *launchParams;

/**
 version code
 */
@property (nonatomic, assign) NSInteger version;

/**
 execute install if it's not installed

 @param completion executed when installed
 */
- (void)installWithCompletion:(void(^)(void))completion;

@end

NS_ASSUME_NONNULL_END
