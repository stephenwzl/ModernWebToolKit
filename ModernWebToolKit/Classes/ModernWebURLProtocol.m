//
//  ModernWebURLProtocol.m
//  ModernWebToolKit
//
//  Created by stephenwzl on 2019/8/6.
//

#import "ModernWebURLProtocol.h"
#import "ModernWebService.h"
#import "ModernWebAppCenter.h"

static  NSString *const kModernWebURLProtocolHandledKey = @"kModernWebURLProtocolHandledKey";

@interface ModernWebURLProtocol()<NSURLSessionDelegate>

//@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) NSOperationQueue *queue;
//@property (nonatomic, strong) NSURLSessionTask *task;

@end

@implementation ModernWebURLProtocol

+ (BOOL)canInitWithRequest:(NSURLRequest *)request {
    NSURL *url = request.URL;
    if ([NSURLProtocol propertyForKey:kModernWebURLProtocolHandledKey inRequest:request]) {
        return NO;
    }
    if ([url.host hasSuffix:ModernWebService.shared.config.virtualHost]) {
        return YES;
    }
    return NO;
}

+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request {
    NSMutableURLRequest *mutableReqeust = [request mutableCopy];
    // 执行自定义操作，例如添加统一的请求头等
    return mutableReqeust;
}

+ (BOOL)requestIsCacheEquivalent:(NSURLRequest *)a toRequest:(NSURLRequest *)b {
    return [super requestIsCacheEquivalent:a toRequest:b];
}

- (void)startLoading {
    NSMutableURLRequest *mutableRequest = [self request].mutableCopy;
    [NSURLProtocol setProperty:@(YES) forKey:kModernWebURLProtocolHandledKey inRequest:mutableRequest];
    NSString *appId = [mutableRequest.URL.host componentsSeparatedByString:@"."].firstObject;
    if (!appId || appId.length == 0) {
        [self.client URLProtocol:self didFailWithError:[NSError errorWithDomain:NSURLErrorDomain code:404 userInfo:nil]];
        return;
    }
    ModernWebApp *app = [ModernWebAppCenter.sharedCenter getAppWithId:appId];
    if (!app) {
        [self.client URLProtocol:self didFailWithError:[NSError errorWithDomain:NSURLErrorDomain code:404 userInfo:nil]];
        return;
    }
    NSURL *url = mutableRequest.URL;
    NSString *mimeType = nil;
    NSData *data = nil;
    NSString *ext = url.pathExtension;
    if ([@[@"gif", @"png", @"webp"] indexOfObject:ext] != NSNotFound) {
        mimeType = [@"image/" stringByAppendingString:ext];
    } else if ([@[@"jpg", @"jpeg"] indexOfObject:ext] != NSNotFound) {
        mimeType = @"image/jpeg";
    } else if ([@[@"css", @"html", @"xml", @"csv"] indexOfObject:ext] != NSNotFound) {
        mimeType = [@"text/" stringByAppendingString:ext];
    } else if ([@[@"js", @"json", @"pdf"] indexOfObject:ext] != NSNotFound) {
        mimeType = [@"application/" stringByAppendingString:ext];
    }
    // TODO: video & audio not supported yet
    data = [NSData dataWithContentsOfFile:[NSString stringWithFormat:@"%@/%@", app.installPath, url.path]];
    NSURLResponse *response = [[NSURLResponse alloc] initWithURL:url MIMEType:mimeType expectedContentLength:data.length textEncodingName:nil];
    [self.client URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageNotAllowed];
    [self.client URLProtocol:self didLoadData:data];
    [self.client URLProtocolDidFinishLoading:self];
}

- (void)stopLoading {
    
}

#pragma mark - getter
- (NSOperationQueue *)queue {
    if (!_queue) {
        _queue = [[NSOperationQueue alloc] init];
    }
    return _queue;
}

#pragma mark - delegate


@end
