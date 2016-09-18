//
//  Album.h
//  BlueLibrary
//
//  Created by Kostyantyn Bilyk on 18.09.16.
//  Copyright © 2016 Eli Ganem. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Album : NSObject

@property (nonatomic, copy, readonly) NSString * title;
@property (nonatomic, copy, readonly) NSString * artist;
@property (nonatomic, copy, readonly) NSString * genre;
@property (nonatomic, copy, readonly) NSString * coverURL;
@property (nonatomic, copy, readonly) NSString * year;

- (id)initWithTitle:(NSString *)title
             artist:(NSString *)artist
           coverURL:(NSString *)coverURL
               year:(NSString *)year;

@end
