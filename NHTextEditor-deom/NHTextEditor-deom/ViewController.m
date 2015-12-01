//
//  ViewController.m
//  NHTextEditor-deom
//
//  Created by Wilson Yuan on 15/11/30.
//  Copyright © 2015年 Wilson-Yuan. All rights reserved.
//

#import "ViewController.h"

#import "NHTextEditorController.h"

#import "NHTextEditor.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)editorButton:(id)sender {
    NHTextEditorController *editorController = [[NHTextEditorController alloc] init];
    [self.navigationController pushViewController:editorController animated:YES];
}
- (IBAction)tableEditor:(id)sender {
    NHTextEditor *editor = [[NHTextEditor alloc] init];
    [self.navigationController pushViewController:editor animated:YES];
    
}

@end
