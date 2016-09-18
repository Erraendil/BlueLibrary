//
//  Album+TableRepresentation.h
//  BlueLibrary
//
//  Created by Kostyantyn Bilyk on 18.09.16.
//  Copyright © 2016 Eli Ganem. All rights reserved.
//

#import "Album.h"

@interface Album (TableRepresentation)

- (NSDictionary *)tr_tableRepresentation;

@end
