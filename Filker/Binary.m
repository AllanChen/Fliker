//
//  Binary.m
//  Filker
//
//  Created by ChanAllan on 3/18/15.
//  Copyright (c) 2015 ChanAllan. All rights reserved.
//

#import "Binary.h"
typedef NS_ENUM(NSInteger , ACRequestMethod) {
    ACRequestMethodGet = 0,
    ACRequestMethodPost,
    ACRequestMethodHead,
    ACRequestMethodPut,
    ACRequestMethodDelete,
};

@implementation Binary

-(NSString *)binaryReturn:(NSString *)inputSting
{
    return inputSting;
}



@end
