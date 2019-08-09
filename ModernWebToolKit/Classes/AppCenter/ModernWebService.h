//
//  ModernWebService.h
//  ModernWebToolKit
//
//  Created by stephenwzl on 2019/8/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class ModernWebConfig;


@interface ModernWebService : NSObject

@property (nonatomic, readonly) ModernWebConfig *config;

+ (instancetype)shared;

- (void)initializeWithConfig:(ModernWebConfig *_Nullable)config;

@end

/**
 通过 config初始化 service
 */
@interface ModernWebConfig : NSObject

/**
 虚拟域名，默认 stephenw.cc
 */
@property (nonatomic, copy) NSString *virtualHost;

/**
 沙盒存储目录，默认 /modernweb
 */
@property (nonatomic, copy) NSString *sandboxCachePath;

@end

NS_ASSUME_NONNULL_END
