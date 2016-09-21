//
//  PersistencyManager.m
//  BlueLibrary
//
//  Created by Kostyantyn Bilyk on 18.09.16.
//  Copyright © 2016 Eli Ganem. All rights reserved.
//

#import "PersistencyManager.h"

@interface PersistencyManager() {
    NSMutableArray * albums;
}

@end

@implementation PersistencyManager

- (id)init {
    self = [super init];
    
    if (self) {
        albums = [NSMutableArray arrayWithArray:
                  @[[[Album alloc] initWithTitle:@"Best of Bowie"
                                          artist:@"David Bowie"
                                        coverURL:@"https://s3.amazonaws.com/CoverProject/album/album_david_bowie_best_of_bowie.png"
                                            year:@"1992"],
                    [[Album alloc] initWithTitle:@"It's My Life"
                                          artist:@"No Doubt"
                                        coverURL:@"https://s3.amazonaws.com/CoverProject/album/album_no_doubt_its_my_life_bathwater.png"
                                            year:@"2003"],
                    [[Album alloc] initWithTitle:@"Noting Like The Sun"
                                          artist:@"Sting"
                                        coverURL:@"https://s3.amazonaws.com/CoverProject/album/album_sting_nothing_like_the_sun.png"
                                            year:@"1999"],
                    [[Album alloc] initWithTitle:@"Staring at the Sun"
                                          artist:@"U2"
                                        coverURL:@"https://s3.amazonaws.com/CoverProject/album/album_u2_staring_at_the_sun.png"
                                            year:@"2000"],
                    [[Album alloc] initWithTitle:@"American Pie"
                                          artist:@"Madonna"
                                        coverURL:@"https://s3.amazonaws.com/CoverProject/album/album_madonna_american_pie.png"
                                            year:@"2000"]]];
    }
    
    return self;
}

- (NSArray *)albums {
    return albums;
}

- (void)addAlbum:(Album *)album atIndex:(NSUInteger)index {
    if (albums.count >= index) {
        [albums insertObject:album atIndex:index];
    } else {
        [albums addObject:album];
    }
}

- (void)deleteAlbumAtIndex:(NSUInteger)index {
    [albums removeObjectAtIndex:index];
}

#pragma mark - Local Image Management

- (void)saveImage:(UIImage *)image filename:(NSString *)filename {
    filename = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@", filename];
    NSData * data = UIImagePNGRepresentation(image);
    [data writeToFile:filename
           atomically:YES];
}

- (UIImage *)getImage:(NSString *)filename {
    filename = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@", filename];
    NSData * data = [NSData dataWithContentsOfFile:filename];
    return [UIImage imageWithData:data];
}

@end
