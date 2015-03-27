//
//  ViewController.h
//  Filker
//
//  Created by ChanAllan on 3/18/15.
//  Copyright (c) 2015 ChanAllan. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#include <OpenGLES/ES2/gl.h>
#include <OpenGLES/ES2/glext.h>
#import <UIKit/UIKit.h>
#import "OpenGLView.h"

@interface ViewController : UIViewController<UIGestureRecognizerDelegate,UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *keyTxt;
@property (weak, nonatomic) IBOutlet UIButton *beginBtn;
@property (weak, nonatomic) IBOutlet UILabel *countNumLab;

@end

