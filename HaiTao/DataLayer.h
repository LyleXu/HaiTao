//
//  DataLayer.h
//  HaiTao
//
//  Created by gtcc on 11/22/14.
//  Copyright (c) 2014 home. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataLayer : NSObject
+(NSMutableString *)FetchDataFromWebByGet:(NSString* )url;
@end
