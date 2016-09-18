//
//  LibraryAPI.h
//  BlueLibrary
//
//  Created by Kostyantyn Bilyk on 18.09.16.
//  Copyright © 2016 Eli Ganem. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Album.h"

@interface LibraryAPI : NSObject

+ (LibraryAPI *)sharedInstance;

- (NSArray *)albums;
- (void)addAlbum:(Album *)album atIndex:(int)index;
- (void)deleteAlbumAtIndex:(int)index;

@end
