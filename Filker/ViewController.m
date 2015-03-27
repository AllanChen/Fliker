//
//  ViewController.m
//  Filker
//
//  Created by ChanAllan on 3/18/15.
//  Copyright (c) 2015 ChanAllan. All rights reserved.
//
#import <AVFoundation/AVFoundation.h>
#import "ViewController.h"
#import "OpenGLFlashViewController.h"
@import GLKit;

@interface ViewController ()
@property (nonatomic)NSInteger changePoint;
@property (nonatomic)NSInteger numInt;
@property (nonatomic, strong)NSTimer *flashTimer;
@property (nonatomic, strong)NSTimer *countDownTimer;
@property (nonatomic, retain)EAGLContext *context;
@property (nonatomic, retain)GLKBaseEffect *effect;
@property (nonatomic, retain)OpenGLView *openGLV;
@property (nonatomic, retain)NSString *binaryString;
@property (nonatomic, retain)NSMutableArray *binaryArray;
@property (nonatomic, copy)NSString *jsReturnDataString;
@property (nonatomic, retain)UIWebView *jsCodeWebView;
@end

@implementation ViewController
@synthesize flashTimer = _flashTimer;
@synthesize countDownTimer = _countDownTimer;
@synthesize changePoint = _changePoint;
@synthesize numInt = _numInt;
@synthesize binaryString = _binaryString;
@synthesize binaryArray = _binaryArray;
@synthesize jsReturnDataString = _jsReturnDataString;
@synthesize jsCodeWebView = _jsCodeWebView;

- (void)viewDidLoad {
    [self initView];
    [super viewDidLoad];
}

-(void)initView{
    _changePoint = 0;
    _numInt = 3;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"pVar" ofType:@"html"];
    NSURL *instructionsURL = [NSURL fileURLWithPath:path];
    _jsCodeWebView = [UIWebView new];
    [_jsCodeWebView setDelegate:self];
    NSString* htmlString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    [_jsCodeWebView loadHTMLString:htmlString baseURL:instructionsURL];
    [self.view addSubview:_jsCodeWebView];
}

- (IBAction)flashPress:(id)sender{
    _countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1
                                                      target:self
                                                    selector:@selector(countDown)
                                                    userInfo:nil
                                                     repeats:YES];
    }

//闪灯倒数
-(void)countDown{
    if (_numInt == 0) {
        _numInt=3;
        _changePoint = 0;
        self.countNumLab.text = [[NSString alloc] initWithFormat:@"%d",_numInt];
        [_countDownTimer invalidate];
        [self pushDataIntoArray];
        _flashTimer = [NSTimer scheduledTimerWithTimeInterval:0.001
                                                       target:self
                                                     selector:@selector(flashAction)
                                                     userInfo:nil
                                                      repeats:YES];
    }
    
    else{
        self.countNumLab.text = [[NSString alloc] initWithFormat:@"%d",_numInt];
        _numInt --;
    }

}

//开始闪屏
- (void)flashAction{
    AVCaptureDevice *flashLight = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if ([flashLight isTorchAvailable] && [flashLight isTorchModeSupported:AVCaptureTorchModeOn])
    {
        [flashLight lockForConfiguration:nil];
        
        if (_changePoint == [_binaryArray count]){
            [_flashTimer invalidate];
            [flashLight setTorchMode:AVCaptureTorchModeOff];
        }
        else{
            if ([[_binaryArray objectAtIndex:_changePoint] integerValue] == 0)
                [flashLight setTorchMode:AVCaptureTorchModeOff];
            else
                [flashLight setTorchMode:AVCaptureTorchModeOn];
            
            _changePoint++;
        }
        /*
        if (flashLight.torchMode == AVCaptureTorchModeOff)
            [flashLight setTorchMode:AVCaptureTorchModeOn];
        else
            [flashLight setTorchMode:AVCaptureTorchModeOff];
         */
    }
}

//OpenGL VC
- (IBAction)openGLVCPress:(id)sender{
    [self pushDataIntoArray];
    OpenGLFlashViewController *openGLVC = [[OpenGLFlashViewController alloc] initWithNibName:@"OpenGLFlashViewController" bundle:nil];
    openGLVC.codeArray = _binaryArray;
    [self presentViewController:openGLVC animated:YES completion:nil];
}

//数据JS返回数据
- (void)pushDataIntoArray{
    NSString * jsCallBack = [NSString stringWithFormat:@"myFunction('%@')",self.keyTxt.text];
    _jsReturnDataString = [_jsCodeWebView stringByEvaluatingJavaScriptFromString:jsCallBack];

    _binaryArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < [_jsReturnDataString length]; i++) {
        [_binaryArray addObject:[NSString stringWithFormat:@"%C", [_jsReturnDataString characterAtIndex:i]]];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
