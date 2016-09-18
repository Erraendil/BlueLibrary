//
//  Album.m
//  BlueLibrary
//
//  Created by Kostyantyn Bilyk on 18.09.16.
//  Copyright © 2016 Eli Ganem. All rights reserved.
//

#import "Album.h"

@implementation Album

- (id)initWithTitle:(NSString *)title artist:(NSString *)artist coverURL:(NSString *)coverURL year:(NSString *)year {
    self = [super init];
    
    if (self) {
        _title = title;
        _artist = artist;
        _coverURL = coverURL;
        _year = year;
        _genre = @"Pop";
    }
    
    return self;
}

@end
