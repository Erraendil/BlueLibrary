//
//  AlbumView.m
//  BlueLibrary
//
//  Created by Kostyantyn Bilyk on 18.09.16.
//  Copyright © 2016 Eli Ganem. All rights reserved.
//

#import "AlbumView.h"

@implementation AlbumView {
    UIImageView * coverImage;
    UIActivityIndicatorView * indicator;
}

- (id)initWithFrame:(CGRect)frame albumCover:(NSString *)albumCover {
    self = [super initWithFrame:frame];
    
    if (self) {
        // Setting black background
        self.backgroundColor = [UIColor blackColor];
        
        // Creating image with small indent - 5 px from edge
        coverImage = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, frame.size.width - 10, frame.size.height -10)];
        [self addSubview:coverImage];
        
        // Adding activity indicator
        indicator = [[UIActivityIndicatorView alloc] init];
        indicator.center = self.center;
        indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
        [indicator startAnimating];
        [self addSubview:indicator];
        
        // Subscribe for notification
        [[NSNotificationCenter defaultCenter] postNotificationName:@"BLDownloadImageNotification"
                                                            object:self
                                                          userInfo:@{@"coverUrl"    : albumCover,
                                                                     @"imageView"   : coverImage}];
    }
    
    return self;
}

@end
