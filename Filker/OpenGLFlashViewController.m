//
//  OpenGLFlashViewController.m
//  Filker
//
//  Created by ChanAllan on 3/26/15.
//  Copyright (c) 2015 ChanAllan. All rights reserved.
//

#import "OpenGLFlashViewController.h"
@import GLKit;

@interface OpenGLFlashViewController ()
@property(nonatomic, retain)NSTimer *countDownTimer;
@property(nonatomic, retain)NSTimer *flashTimer;
@property (weak, nonatomic) IBOutlet UILabel *countNumLab;
@property(nonatomic) NSInteger numInt;
@property(nonatomic) NSInteger changePoint;
@property (nonatomic, retain)OpenGLView *openGLV;
@end

@implementation OpenGLFlashViewController
@synthesize countDownTimer = _countDownTimer;
@synthesize flashTimer = _flashTimer;
@synthesize numInt = _numInt;
@synthesize changePoint = _changePoint;
@synthesize codeArray = _codeArray;
@synthesize openGLV = _openGLV;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)initView{
    _numInt = 3;
    _changePoint = 0;
    _openGLV = [OpenGLView new];
    _openGLV.frame = CGRectMake(0, 50, self.view.frame.size.width, self.view.frame.size.height-50);
    _openGLV.hidden = YES;
    _countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1
                                              target:self
                                            selector:@selector(countDown)  userInfo:nil
                                             repeats:YES];
    
    [self.view addSubview:_openGLV];
}

- (void)countDown{
    if (_numInt == 0) {
        [_countDownTimer invalidate];
        _openGLV.hidden = NO;
        _flashTimer = [NSTimer scheduledTimerWithTimeInterval:0.001
                                                           target:self
                                                         selector:@selector(drawBackgroundAction)  userInfo:nil
                                                          repeats:YES];
    }
    
    else{
        self.countNumLab.text = [[NSString alloc] initWithFormat:@"%d",_numInt];
        _numInt --;
    }
}


-(void)drawBackgroundAction
{
    if (_changePoint == [_codeArray count]){
        [_flashTimer invalidate];
        _openGLV.hidden = YES;
    }
    else{
        if ([[_codeArray objectAtIndex:_changePoint] integerValue] == 0)
            _openGLV.bg = 0.0;
        else
            _openGLV.bg = 1.0;
        
        [_openGLV layoutSubviews];
        _changePoint++;
    }
}

- (IBAction)againPress:(id)sender{
    _changePoint = 0;
    _openGLV.hidden = NO;
    _flashTimer = [NSTimer scheduledTimerWithTimeInterval:0.001
                                                   target:self
                                                 selector:@selector(drawBackgroundAction)  userInfo:nil
                                                  repeats:YES];
}

- (IBAction)back:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
