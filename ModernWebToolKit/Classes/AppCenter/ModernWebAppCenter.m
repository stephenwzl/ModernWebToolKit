//
//  ModernWebAppCenter.m
//  ModernWebToolKit
//
//  Created by stephenwzl on 2019/8/6.
//

#import "ModernWebAppCenter.h"
#import "ModernWebService.h"

#import <SSZipArchive/SSZipArchive.h>

static NSString *const kModernWebAppInstallPath = @"/modernwebapp/installed";
static NSString *const kModernWebAppDownloadPath = @"/modernwebapp/downloaded";

@interface ModernWebAppCenter()

/**
 appId: ModernWebApp
 */
@property (atomic, strong) NSMutableDictionary<NSString *, ModernWebApp *> *apps;


@property (nonatomic, strong) NSString *appsCachePath;

@end

@implementation ModernWebAppCenter

+ (void)load {
    [ModernWebAppCenter sharedCenter];
}

+ (instancetype)sharedCenter {
    static dispatch_once_t onceToken;
    static ModernWebAppCenter *center;
    dispatch_once(&onceToken, ^{
        center = [ModernWebAppCenter new];
    });
    return center;
}

- (instancetype)init {
    if (self = [super init]) {

        [self read];
        if (!_apps) {
            _apps = [NSMutableDictionary new];
        }
        [NSNotificationCenter.defaultCenter addObserver:self
                                               selector:@selector(read)
                                                   name:UIApplicationDidFinishLaunchingNotification
                                                 object:nil];
        [NSNotificationCenter.defaultCenter addObserver:self
                                               selector:@selector(read)
                                                   name:UIApplicationWillEnterForegroundNotification
                                                 object:nil];
        [NSNotificationCenter.defaultCenter addObserver:self
                                               selector:@selector(sync)
                                                   name:UIApplicationWillResignActiveNotification
                                                 object:nil];
        [NSNotificationCenter.defaultCenter addObserver:self
                                               selector:@selector(sync)
                                                   name:UIApplicationWillTerminateNotification
                                                 object:nil];
        [NSNotificationCenter.defaultCenter addObserver:self
                                               selector:@selector(sync)
                                                   name:UIApplicationDidEnterBackgroundNotification
                                                 object:nil];
    }
    return self;
}

- (ModernWebApp *)getAppWithId:(NSString *)appId {
    return self.apps[appId];
}

- (void)registerApp:(ModernWebApp *)app {
    ModernWebApp *existing = self.apps[app.appId];
    if (existing && existing.version >= app.version) {
        return;
    }
    self.apps[app.appId] = app;
    [app installWithCompletion:^{
        NSLog(@"%@ version: %ld installed", app.appId, app.version);
    }];
}

- (void)sync {
    if (self.apps.count <= 0) {
        return;
    }
    [NSKeyedArchiver archiveRootObject:self.apps toFile:self.appsCachePath];
}

- (void)read {
    if (self.apps && self.apps.count > 0) {
        return;
    }
    if ([NSFileManager.defaultManager fileExistsAtPath:self.appsCachePath]) {
        self.apps = [(NSDictionary *)[NSKeyedUnarchiver unarchiveObjectWithFile:self.appsCachePath] mutableCopy];
    }
}

#pragma mark - getter

- (NSString *)appsCachePath {
    if (!_appsCachePath) {
         NSString *doc = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
        _appsCachePath = [doc stringByAppendingPathComponent:@"/modernwebapp/appcenter.apps"];
    }
    return _appsCachePath;
}

@end

@interface ModernWebApp ()

@property (nonatomic, copy) NSString *installPath;

@end

@implementation ModernWebApp

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.appId forKey:@"appId"];
    [aCoder encodeObject:self.info?:@{} forKey:@"info"];
    [aCoder encodeObject:self.launchParams?:@{} forKey:@"launchParams"];
    [aCoder encodeInteger:self.version forKey:@"version"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.appId = [aDecoder decodeObjectForKey:@"appId"];
        self.info = [aDecoder decodeObjectForKey:@"info"];
        self.launchParams = [aDecoder decodeObjectForKey:@"launchParams"];
        self.version = [aDecoder decodeIntegerForKey:@"version"];
    }
    return self;
}

- (NSString *)installPath {
    if (!_installPath) {
        NSString *doc = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
        _installPath = [doc stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/%@", kModernWebAppInstallPath, self.appId]];
    }
    return _installPath;
}

- (void)installWithCompletion:(void (^)(void))completion {
    NSString *doc = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    [SSZipArchive unzipFileAtPath:self.downloadPath toDestination:[doc stringByAppendingPathComponent:kModernWebAppInstallPath]];
    completion();
}

@end
