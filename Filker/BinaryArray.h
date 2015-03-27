//
//  BinaryArray.h
//  Filker
//
//  Created by ChanAllan on 3/18/15.
//  Copyright (c) 2015 ChanAllan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BinaryArray : NSObject
{
    NSMutableArray *_truckBoxes;
    NSMutableArray *_farmerlist;
    NSString *_farmerCardNumber;
    NSString *_fName;
}

+ (BinaryArray *)sharedInstance;

@property(strong, nonatomic, readwrite) NSMutableArray *binary;

-(NSMutableArray *)returnArray;
@end
