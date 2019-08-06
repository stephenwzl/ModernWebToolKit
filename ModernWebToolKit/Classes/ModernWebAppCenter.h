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

@property (nonatomic, copy) NSString *appId;

@property (nonatomic, copy) NSDictionary *info;

@property (nonatomic, readonly) NSString *installPath;

@property (nonatomic, copy) NSDictionary *launchParams;

@end

NS_ASSUME_NONNULL_END
