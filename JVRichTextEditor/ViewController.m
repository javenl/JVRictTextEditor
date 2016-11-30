//
//  ViewController.m
//  JVRichTextEditor
//
//  Created by liu on 16/11/25.
//  Copyright © 2016年 liu. All rights reserved.
//

#import "ViewController.h"
#import "JVRichTextEditorView.h"

@interface ViewController ()

@property (nonatomic, strong) JVRichTextEditorView *editorView;

//@property (nonatomic, strong) UIButton *button;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.editorView = [[JVRichTextEditorView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.editorView];
    
    [self.editorView setContentPadding:UIEdgeInsetsMake(40, 0, 0, 0)];
    
//    self.button = [UIButton buttonWithType:UIButtonTypeSystem];
//    [self.button setTitle:@"test" forState:UIControlStateNormal];
//    [self.button addTarget:self action:@selector(didTapTest) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:self.button];
}

- (void)didTapTest {

}

@end
