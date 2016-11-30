//
//  JVRichTextEditorMenu.m
//  JVRichTextEditor
//
//  Created by liu on 16/11/29.
//  Copyright © 2016年 liu. All rights reserved.
//

#import "JVRichTextEditorMenu.h"

@interface JVRichTextEditorMenu ()

@property (nonatomic, strong) NSArray *titles;



@end

@implementation JVRichTextEditorMenu

- (id)init {
    self = [super init];
    if (self) {
        self.showsHorizontalScrollIndicator = NO;
        [self setupActionView];
    }
    return self;
}

- (void)setupActionView {
    self.titles = @[@"RE", @"UN", @"CL", @"P", @"L", @"R", @"C", @"F", @"H1", @"H2", @"H3", @"H4", @"H5", @"B", @"I", @"HR", @"-", @"_", @"O", @"U", @">", @"↑", @"↓", @"TC", @"BC"];
    
    for (int i = 0; i < self.titles.count; i++) {
        UIButton *btn = [[UIButton alloc] init];
        [btn setTitle:self.titles[i] forState:UIControlStateNormal];
        btn.tag = i;
        btn.frame = CGRectMake(44 * i, 0, 44, 44);
        [btn addTarget:self action:@selector(didTapBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
    self.contentSize = CGSizeMake(44*self.titles.count, 44);
}

#pragma mark - Event

- (void)didTapBtn:(UIButton *)sender {
    NSString *title = [sender titleForState:UIControlStateNormal];
    if ([title isEqualToString:@"RE"]) {
        [self.textEditor redo];
    } else if ([title isEqualToString:@"UN"]) {
        [self.textEditor undo];
    } else if ([title isEqualToString:@"CL"]) {
        [self.textEditor clearFormat];
    } else if ([title isEqualToString:@"P"]) {
        [self.textEditor setContentParagraph];
    } else if ([title isEqualToString:@"H1"]) {
        [self.textEditor setContentHeadeading1];
    } else if ([title isEqualToString:@"H2"]) {
        [self.textEditor setContentHeadeading2];
    } else if ([title isEqualToString:@"H3"]) {
        [self.textEditor setContentHeadeading3];
    } else if ([title isEqualToString:@"H4"]) {
        [self.textEditor setContentHeadeading4];
    } else if ([title isEqualToString:@"H5"]) {
        [self.textEditor setContentHeadeading5];
    } else if ([title isEqualToString:@"L"]) {
        [self.textEditor setContentJustifyLeft];
    } else if ([title isEqualToString:@"R"]) {
        [self.textEditor setContentJustifyRight];
    } else if ([title isEqualToString:@"C"]) {
        [self.textEditor setContentJustifyCenter];
    } else if ([title isEqualToString:@"F"]) {
        [self.textEditor setContentJustifyFull];
    } else if ([title isEqualToString:@"B"]) {
        [self.textEditor setContentBold];
    } else if ([title isEqualToString:@"I"]) {
        [self.textEditor setContentItalic];
    } else if ([title isEqualToString:@"HR"]) {
        [self.textEditor setContentHorizontalRule];
    } else if ([title isEqualToString:@"-"]) {
        [self.textEditor setContentStrikeThrough];
    } else if ([title isEqualToString:@"_"]) {
        [self.textEditor setContentUnderline];
    } else if ([title isEqualToString:@"O"]) {
        [self.textEditor setContentOrderedList];
    } else if ([title isEqualToString:@"U"]) {
        [self.textEditor setContentUnorderList];
    } else if ([title isEqualToString:@">"]) {
        [self.textEditor setContentBlockquote];
    } else if ([title isEqualToString:@"↑"]) {
        [self.textEditor setContentSuperscript];
    } else if ([title isEqualToString:@"↓"]) {
        [self.textEditor setContentSubscript];
    } else if ([title isEqualToString:@"TC"]) {
        [self.textEditor setContentTextColor:[UIColor redColor]];
    } else if ([title isEqualToString:@"BC"]) {
        [self.textEditor setContentBackgroundColor:[UIColor orangeColor]];
    }
}

- (CGSize)intrinsicContentSize {
    return CGSizeMake(UIViewNoIntrinsicMetric, 44);
}

@end
