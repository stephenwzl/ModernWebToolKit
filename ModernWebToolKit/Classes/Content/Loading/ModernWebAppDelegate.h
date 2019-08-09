//
//  ModernWebAppDelegate.h
//  ModernWebToolKit
//
//  Created by stephenwzl on 2019/8/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ModernWebApp;

@protocol ModernWebAppDelegate <NSObject>

@required

- (__kindof UIViewController *)rootControllerForApp:(ModernWebApp *)app;

/**
 tells the loader whether this web app should launch

 @param app web app instance
 @param params launch params
 @return BOOL value whether should launch
 */
- (BOOL)app:(ModernWebApp *)app shouldLaunchWithParams:(NSDictionary * _Nullable)params;

/**
 the loader tells the delegate, this web app has already finished launching

 @param app web app instance
 @param params passed launch options
 */
- (void)app:(ModernWebApp *)app didFinishLaunchingWithParams:(NSDictionary * _Nullable)params;

@optional

- (void)appWillHide:(ModernWebApp *)app;
- (void)appWillShow:(ModernWebApp *)app;
- (void)appWillResume:(ModernWebApp *)app;
- (void)appWillTerminate:(ModernWebApp *)app;

- (BOOL)app:(ModernWebApp *)app canLaunchMultipleInstance:(NSDictionary * _Nullable)params;

@end


typedef NSString * ModernWebAppId;
extern ModernWebAppId const ModernProxyWebAppId;
// default delegate only accepts web app with id: ModernProxyWebAppKey
@interface ModernWebAppProxyDelegate : NSObject<ModernWebAppDelegate>

+ (instancetype)shared;

@end

NS_ASSUME_NONNULL_END
