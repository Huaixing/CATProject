//
//  CATDetailViewController.m
//  CATProject
//
//  Created by Shihuaixing on 2020/9/5.
//  Copyright © 2020 Shihuaixing. All rights reserved.
//

#import "CATDetailViewController.h"
#import <CATTextKit.h>
#import "UIView+CATSize.h"
#import "CATCommonMacro.h"

@interface CATDetailViewController ()

/// textv iew
@property (nonatomic, strong) CATTextView *textView;
/// <#comment#>
@property (nonatomic, strong) CATKeyboardBar *keyboardBar;

@end

@implementation CATDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _textView = [[CATTextView alloc] initWithFrame:CGRectMake(0, 100, self.view.width, 300)];
    _textView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_textView];
    
    CGFloat barHeight = 64;
    _keyboardBar = [[CATKeyboardBar alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.frame) - barHeight, CGRectGetWidth(self.view.frame), barHeight)];
    _keyboardBar.backgroundColor = [UIColor redColor];
//    _keyboardBar.delegate = self;
    [self.view addSubview:_keyboardBar];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
