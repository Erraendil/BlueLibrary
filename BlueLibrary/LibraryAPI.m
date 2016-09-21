//
//  LibraryAPI.m
//  BlueLibrary
//
//  Created by Kostyantyn Bilyk on 18.09.16.
//  Copyright © 2016 Eli Ganem. All rights reserved.
//

#import "LibraryAPI.h"

#import "PersistencyManager.h"
#import "HTTPClient.h"

@interface LibraryAPI() {
    PersistencyManager * persistencyManager;
    HTTPClient * httpClient;
    BOOL isOnline;
}

@end

@implementation LibraryAPI

- (id)init {
    self = [super init];
    
    if (self) {
        persistencyManager = [[PersistencyManager alloc] init];
        httpClient = [[HTTPClient alloc] init];
        isOnline = NO;
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(downloadImage:)
                                                     name:@"BLDownloadImageNotification"
                                                   object:nil];
    }
    
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

+ (LibraryAPI *)sharedInstance {
    // Declaring static varibale to store class instance
    static LibraryAPI * _sharedInstance = nil;
    
    // Declaring static varibale to provide initialization only once
    static dispatch_once_t oncePredicate;
    
    // Initializing class instance once
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[LibraryAPI alloc] init];
    });
    
    return _sharedInstance;
}

- (NSArray *)albums {
    return [persistencyManager albums];
}

- (void)addAlbum:(Album *)album atIndex:(int)index {
    [persistencyManager addAlbum:album atIndex:index];
    
    if (isOnline) {
        [httpClient postRequest:@"/api/addAlbum" body:[album description]];
    }
}

- (void)deleteAlbumAtIndex:(int)index {
    [persistencyManager deleteAlbumAtIndex:index];
    
    if (isOnline) {
        [httpClient postRequest:@"/api/deleteAlbum" body:[@(index) description]];
    }
}

- (void)downloadImage:(NSNotification *)notification {
    // Getting cuverUrl and imageView from notification.userInfo
    NSString * coverUrl = notification.userInfo[@"coverUrl"];
    UIImageView * imageView = notification.userInfo[@"imageView"];
    
    // Loading image from persistencyManager if it exists
    imageView.image = [persistencyManager getImage:[coverUrl lastPathComponent]];
    
    if (imageView.image == nil) {
        // Download image via httpClient
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            UIImage * image = [httpClient downloadImage:coverUrl];
            
            // When downloading is done showing image on imageView and saving it
            dispatch_async(dispatch_get_main_queue(), ^{
                imageView.image = image;
                [persistencyManager saveImage:image filename:[coverUrl lastPathComponent]];
            });
        });
    }
}

@end
