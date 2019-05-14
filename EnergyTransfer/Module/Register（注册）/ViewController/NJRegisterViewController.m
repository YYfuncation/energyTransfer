//
//  NJRegisterViewController.m
//  EnergyTransfer
//
//  Created by Liandi on 2018/10/19.
//  Copyright © 2018年 Liandi. All rights reserved.
//

#import "NJRegisterViewController.h"
#import "TZImagePickerController.h"

@interface NJRegisterViewController ()<TZImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *codeBnt;
@property (weak, nonatomic) IBOutlet UITextField *describeFieldText;
@property (weak, nonatomic) IBOutlet UITextField *addressFieldText;
@property (weak, nonatomic) IBOutlet UITextField *ageFieldText;
@property (weak, nonatomic) IBOutlet UITextField *idCardFieldText;
@property (weak, nonatomic) IBOutlet UITextField *driversNameFieldText;
@property (weak, nonatomic) IBOutlet UITextField *passWordFieldText;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberFieldText;
@property (weak, nonatomic) IBOutlet UITextField *loadFieldTect;
@property (weak, nonatomic) IBOutlet UITextField *plateNumberFieldText;
@property (weak, nonatomic) IBOutlet UISegmentedControl *genderControl;
@property (weak, nonatomic) IBOutlet UIButton *operationCertificateBnt;
@property (weak, nonatomic) IBOutlet UIButton *vehicleLicenseBnt;
@property (weak, nonatomic) IBOutlet UIButton *driverLicenseBnt;
@property (weak, nonatomic) IBOutlet UIButton *registerBnt;
@property (weak, nonatomic) IBOutlet UIButton *backBnt;

@end

@implementation NJRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"注册";
    self.codeBnt.layer.cornerRadius = 3;
    self.registerBnt.layer.cornerRadius = 10;
    self.backBnt.layer.cornerRadius = 10;
    self.genderControl.selectedSegmentIndex = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)getCode:(id)sender {
    __block int timeout = 59; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout <= 0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [self.codeBnt setTitle:@"获取验证码" forState:UIControlStateNormal];
                self.codeBnt.backgroundColor = [UIColor orangeColor];
                self.codeBnt.userInteractionEnabled = YES;
            });
        }else{
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1];
                [self.codeBnt setTitle:[NSString stringWithFormat:@"%@秒后重发",strTime] forState:UIControlStateNormal];
                self.codeBnt.backgroundColor = [UIColor grayColor];
                [UIView commitAnimations];
                self.codeBnt.userInteractionEnabled = NO;
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}
- (IBAction)selectDriver:(id)sender {
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
    
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        [self.driverLicenseBnt setImage:photos.lastObject forState:UIControlStateNormal];
    }];
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}
- (IBAction)selectLicense:(id)sender {
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
    
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        [self.vehicleLicenseBnt setImage:photos.lastObject forState:UIControlStateNormal];
    }];
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}
- (IBAction)selectCertificate:(id)sender {
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
    
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        [self.operationCertificateBnt setImage:photos.lastObject forState:UIControlStateNormal];
    }];
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

- (IBAction)selectGenders:(UISegmentedControl *)sender {
    NSInteger index = sender.selectedSegmentIndex;
    if (index == 0) {
        NSLog(@"男");
    }else{
        NSLog(@"女");
    }
}

- (IBAction)backTo:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)registerTo:(id)sender {
    
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
