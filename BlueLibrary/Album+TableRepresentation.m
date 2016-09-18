//
//  Album+TableRepresentation.m
//  BlueLibrary
//
//  Created by Kostyantyn Bilyk on 18.09.16.
//  Copyright © 2016 Eli Ganem. All rights reserved.
//

#import "Album+TableRepresentation.h"

@implementation Album (TableRepresentation)

- (NSDictionary *)tr_tableRepresentation {
    return @{@"titles":@[@"Исполнитель", @"Альбом", @"Жанр", @"Год"],
             @"values":@[self.artist, self.title, self.genre, self.year]};
}

@end
