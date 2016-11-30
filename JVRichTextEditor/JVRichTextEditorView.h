//
//  JVRichTextEditorView.h
//  JVRichTextEditor
//
//  Created by liu on 16/11/25.
//  Copyright © 2016年 liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JVRichTextEditorView : UIView

- (void)setPlaceholder:(NSString *)placeholder;

- (void)setContentMargin:(UIEdgeInsets)insets;

- (void)setContentPadding:(UIEdgeInsets)insets;

- (void)clearFormat;

- (void)undo;

- (void)redo;

- (void)setContentParagraph;

- (void)setContentHeadeading1;

- (void)setContentHeadeading2;

- (void)setContentHeadeading3;

- (void)setContentHeadeading4;

- (void)setContentHeadeading5;

- (void)setContentHeadeading:(NSString *)heading;

- (void)setContentJustifyLeft;

- (void)setContentJustifyRight;

- (void)setContentJustifyCenter;

- (void)setContentJustifyFull;

- (void)setContentBold;

- (void)setContentItalic;

- (void)setContentHorizontalRule;

- (void)setContentBlockquote;

- (void)setContentUnderline;

- (void)setContentStrikeThrough;

- (void)setContentSuperscript;

- (void)setContentSubscript;

- (void)setContentOrderedList;

- (void)setContentUnorderList;

- (void)setContentTextColor:(UIColor *)color;

- (void)setContentBackgroundColor:(UIColor *)backgroundColor;

- (void)insertLink:(NSString *)link;

- (void)insertImage:(UIImage *)image;

@end
