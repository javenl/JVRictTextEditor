//
//  JVRichTextEditorView.m
//  JVRichTextEditor
//
//  Created by liu on 16/11/25.
//  Copyright © 2016年 liu. All rights reserved.
//

#import "JVRichTextEditorView.h"
#import "JVRichTextEditorMenu.h"

#define kScreenWidth CGRectGetWidth([UIApplication sharedApplication].keyWindow.bounds)


typedef NS_ENUM(NSInteger, JVMenuBtnTag) {
    JVMenuBtnTagClear,
    JVMenuBtnTagUndo,
    JVMenuBtnTagRedo,
    JVMenuBtnTagParagraph,
    JVMenuBtnTagH1,
    JVMenuBtnTagH2,
    JVMenuBtnTagH3,
    JVMenuBtnTagH4,
    JVMenuBtnTagH5,
    JVMenuBtnTagLeft,
    JVMenuBtnTagRight,
    JVMenuBtnTagCenter,
    JVMenuBtnTagFull,
    JVMenuBtnTagBold,
    JVMenuBtnTagItalic,
    JVMenuBtnTagHorizontalRule,
    JVMenuBtnTagOrderedList,
    JVMenuBtnTagUnorderedList,
    JVMenuBtnTagTextColor,
    JVMenuBtnTagBackgroundColor,
    JVMenuBtnTagInsertLink,
    JVMenuBtnTagInsertImage,
    JVMenuBtnTagBlockquote,
    JVMenuBtnTagUnderline,
    JVMenuBtnTagStrikeThrough,
    JVMenuBtnTagSuperscript,
    JVMenuBtnTagSubscript
};

@interface JVRichTextEditorView () <UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;

@property (nonatomic, strong) JVRichTextEditorMenu *menu;

@end

@implementation JVRichTextEditorView

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.webView = [[UIWebView alloc] init];
        self.webView.delegate = self;
        [self addSubview:self.webView];
        
        self.menu = [[JVRichTextEditorMenu alloc] init];
        self.menu.textEditor = self;
        self.menu.backgroundColor = [UIColor orangeColor];
        self.menu.frame = CGRectMake(0, CGRectGetMaxY(self.window.bounds)-44, CGRectGetWidth(self.window.bounds), 44);
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"editor" ofType:@"html" inDirectory:@"Res"];
        NSString *rootPath = [[NSBundle mainBundle] bundlePath];
        rootPath = [rootPath stringByAppendingPathComponent:@"Res"];
        NSString *html = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        [self.webView loadHTMLString:html baseURL:[NSURL fileURLWithPath:rootPath]];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.webView.frame = self.bounds;
    
//    CGRect menuFrame = self.menu.frame;
//    menuFrame.size.width = CGRectGetWidth(self.window.bounds);
//    self.menu.frame = menuFrame;
    self.menu.frame = CGRectMake(0, CGRectGetMaxY(self.window.bounds)-44, CGRectGetWidth(self.window.bounds), 44);
}

#pragma mark - Notification

- (void)keyboardWillShow:(NSNotification *)notification {
    CGRect rect2 = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat during = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
//    self.actionView.frame = CGRectMake(0, CGRectGetHeight(self.window.bounds)-44, kScreenWidth, 44);
//    NSLog(@"frame %@", NSStringFromCGRect(self.actionView.frame));
   
//    [UIView setAnimationsEnabled:NO];
//    
//    self.menu.frame = CGRectMake(0, CGRectGetHeight(self.window.bounds)-44, kScreenWidth, 44);
//    [self.window addSubview:self.menu];
//    
//    [UIView setAnimationsEnabled:YES];
    
    [UIView animateWithDuration:during animations:^{
        self.menu.frame = CGRectMake(0, CGRectGetMinY(rect2) - 44, kScreenWidth, 44);
        NSLog(@"frame %@", NSStringFromCGRect(self.menu.frame));
    }];
    
//    if ([self isFirstResponder]) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self showToolBarInView:self.window frame:CGRectMake(0, CGRectGetMinY(rect2) - 44, kScreenWidth, 44) during:during];
//        });
//    }
}

- (void)keyboardWillHide:(NSNotification *)notification {
    CGFloat during = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    [UIView animateWithDuration:during animations:^{
        self.menu.frame = CGRectMake(0, CGRectGetHeight(self.window.bounds), CGRectGetWidth(self.window.bounds), 44);
    } completion:^(BOOL finished) {
        [self.menu removeFromSuperview];
    }];
}

- (void)keyboardDidShow:(NSNotification *)notification {
//    if (self.isFirstResponder) {
//        if ([self.delegate respondsToSelector:@selector(beginEditing)]) {
//            [self.delegate beginEditing];
//        }
//    }
}

- (void)keyboardDidHide:(NSNotification *)notification {
//    if (!self.isFirstResponder) {
//        if ([self.delegate respondsToSelector:@selector(endEditing)]) {
//            [self.delegate endEditing];
//        }
//    }
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView {
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    return YES;
}

#pragma mark - Public Method

- (void)setPlaceholder:(NSString *)placeholder {
    NSString *js = [NSString stringWithFormat:@"jv_editor.setPlaceholder('%@')", placeholder];
    [self.webView stringByEvaluatingJavaScriptFromString:js];
}

- (void)setContentMargin:(UIEdgeInsets)insets {
    NSString *js = [NSString stringWithFormat:@"jv_editor.setMargin('%d', '%d', '%d', '%d')", (int)insets.top, (int)insets.right, (int)insets.bottom, (int)insets.left];
    [self.webView stringByEvaluatingJavaScriptFromString:js];
}

- (void)setContentPadding:(UIEdgeInsets)insets {
    NSString *js = [NSString stringWithFormat:@"jv_editor.setPadding('%d', '%d', '%d', '%d')", (int)insets.top, (int)insets.right, (int)insets.bottom, (int)insets.left];
    [self.webView stringByEvaluatingJavaScriptFromString:js];
}

- (void)clearFormat {
    NSString *js = @"jv_editor.removeFormating()";
    [self.webView stringByEvaluatingJavaScriptFromString:js];
}

- (void)undo {
    NSString *js = @"jv_editor.undo()";
    [self.webView stringByEvaluatingJavaScriptFromString:js];
}

- (void)redo {
    NSString *js = @"jv_editor.redo()";
    [self.webView stringByEvaluatingJavaScriptFromString:js];
}

- (void)setContentParagraph {
    NSString *js = @"jv_editor.setParagraph()";
    [self.webView stringByEvaluatingJavaScriptFromString:js];
}

- (void)setContentHeadeading:(NSString *)heading {
    NSString *js = [NSString stringWithFormat:@"jv_editor.setHeading('%@')", heading];
    [self.webView stringByEvaluatingJavaScriptFromString:js];
}

- (void)setContentHeadeading1 {
    [self setContentHeadeading:@"h1"];
}

- (void)setContentHeadeading2 {
    [self setContentHeadeading:@"h2"];
}

- (void)setContentHeadeading3 {
    [self setContentHeadeading:@"h3"];
}

- (void)setContentHeadeading4 {
    [self setContentHeadeading:@"h4"];
}

- (void)setContentHeadeading5 {
    [self setContentHeadeading:@"h5"];
}

- (void)setContentJustifyLeft {
    NSString *js = @"jv_editor.setJustifyLeft()";
    [self.webView stringByEvaluatingJavaScriptFromString:js];
}

- (void)setContentJustifyRight {
    NSString *js = @"jv_editor.setJustifyRight()";
    [self.webView stringByEvaluatingJavaScriptFromString:js];
}

- (void)setContentJustifyCenter {
    NSString *js = @"jv_editor.setJustifyCenter()";
    [self.webView stringByEvaluatingJavaScriptFromString:js];
}

- (void)setContentJustifyFull {
    NSString *js = @"jv_editor.setJustifyFull()";
    [self.webView stringByEvaluatingJavaScriptFromString:js];
}

- (void)setContentBold {
    NSString *js = @"jv_editor.setBold()";
    [self.webView stringByEvaluatingJavaScriptFromString:js];
}

- (void)setContentItalic {
    NSString *js = @"jv_editor.setItalic()";
    [self.webView stringByEvaluatingJavaScriptFromString:js];
}

- (void)setContentHorizontalRule {
    NSString *js = @"jv_editor.setHorizontalRule()";
    [self.webView stringByEvaluatingJavaScriptFromString:js];
}

- (void)setContentBlockquote {
    NSString *js = @"jv_editor.setBlockquote()";
    [self.webView stringByEvaluatingJavaScriptFromString:js];
}

- (void)setContentUnderline {
    NSString *js = @"jv_editor.setUnderline()";
    [self.webView stringByEvaluatingJavaScriptFromString:js];
}

- (void)setContentStrikeThrough {
    NSString *js = @"jv_editor.setStrikeThrough()";
    [self.webView stringByEvaluatingJavaScriptFromString:js];
}

- (void)setContentSuperscript {
    NSString *js = @"jv_editor.setSuperscript()";
    [self.webView stringByEvaluatingJavaScriptFromString:js];
}

- (void)setContentSubscript {
    NSString *js = @"jv_editor.setSubscript()";
    [self.webView stringByEvaluatingJavaScriptFromString:js];
}

- (void)setContentOrderedList {
    NSString *js = @"jv_editor.setOrderedList()";
    [self.webView stringByEvaluatingJavaScriptFromString:js];
}

- (void)setContentUnorderList {
    NSString *js = @"jv_editor.setUnorderedList()";
    [self.webView stringByEvaluatingJavaScriptFromString:js];
}

- (void)setContentTextColor:(UIColor *)color {
    NSString *js = [NSString stringWithFormat:@"jv_editor.setTextColor('%@')", @"ff0000"];
    [self.webView stringByEvaluatingJavaScriptFromString:js];
}

- (void)setContentBackgroundColor:(UIColor *)backgroundColor {
    NSString *js = [NSString stringWithFormat:@"jv_editor.setBackgroundColor('%@')", @"ff00ff"];
    [self.webView stringByEvaluatingJavaScriptFromString:js];
}

- (void)insertLink:(NSString *)link {
    NSString *js = [NSString stringWithFormat:@"jv_editor.insertLink('%@', '%@')", @"http://www.baidu.com", @"testTitle"];
    [self.webView stringByEvaluatingJavaScriptFromString:js];
}

- (void)insertImage:(UIImage *)image {
    NSString *js = [NSString stringWithFormat:@"jv_editor.insertImage('%@', '%@')", @"http://www.baidu.com", @"testTitle"];
    [self.webView stringByEvaluatingJavaScriptFromString:js];
}


@end
