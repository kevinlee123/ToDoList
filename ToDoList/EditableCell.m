//
//  EditableCell.m
//  ToDoList
//
//  Created by Kevin Lee on 10/13/13.
//  Copyright (c) 2013 Kevin Lee. All rights reserved.
//

#import "EditableCell.h"

@interface EditableCell ()

@end

@implementation EditableCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib {
    self.txtCellString.delegate = self;
    self.txtCellString.enabled = NO;
    
    self.editingAccessoryView =[[UIView alloc] init];
    self.editingAccessoryView.backgroundColor = [UIColor clearColor];
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    
    if (editing == YES) {
        self.txtCellString.enabled = YES;
    } else {
        self.txtCellString.enabled = NO;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(BOOL)textFieldShouldBeginEditing:(UITextField*)textfield {
    [self.cellDelegate scrollToCell:self];
    
    return YES;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    [textField resignFirstResponder];
    
    [self.cellDelegate updateText:self.txtCellString.text forCell:self];
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.txtCellString) {
        [textField resignFirstResponder];
    }
    return NO;
}

@end