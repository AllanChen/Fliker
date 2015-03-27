//
//  OpenGLFlashViewController.h
//  Filker
//
//  Created by ChanAllan on 3/26/15.
//  Copyright (c) 2015 ChanAllan. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#include <OpenGLES/ES2/glext.h>
#include <OpenGLES/ES2/gl.h>
#import <UIKit/UIKit.h>
#import "OpenGLView.h"

@interface OpenGLFlashViewController : UIViewController
@property(nonatomic ,strong)NSMutableArray *codeArray;
@end
