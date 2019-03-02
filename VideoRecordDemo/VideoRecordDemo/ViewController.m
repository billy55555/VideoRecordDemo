//
//  ViewController.m
//  VideoRecordDemo
//
//  Created by 邻汇吧 on 2019/2/20.
//  Copyright © 2019年 邻汇吧. All rights reserved.
//

#import "ViewController.h"
#import <AVKit/AVKit.h>
#import "PlayerVC.h"
#import <MobileCoreServices/MobileCoreServices.h>

#define KWidth [UIScreen mainScreen].bounds.size.width
#define KHeight [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property(nonatomic,strong)UIButton *btn1;
@property(nonatomic,strong)UIButton *btn2;
@property(nonatomic,strong)UIButton *btn3;
@property(nonatomic,strong)UIButton *btn4;
@property(nonatomic,strong)UIButton *btn5;
@property(nonatomic,strong)UIButton *btn6;
@property(nonatomic,strong)UIButton *btnPlayVC;
@property(nonatomic,strong)UIButton *btnPlayNetVC;
@property(nonatomic,strong)UIScrollView *imageScroll;

@property(nonatomic,strong)NSURL *finalUrl;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _btn1 = [self createButtonWithTag:1 title:@"PhotoLibrary+image\n相册文件夹" x:10 y:100 selector:@selector(choosePhotoLibrary:)];//看相册文件夹
    _btn2 = [self createButtonWithTag:2 title:@"PhotoLibrary+movie\n视频文件夹" x:KWidth/2 y:100 selector:@selector(choosePhotoLibrary:)];//看视频文件夹
    _btn3 = [self createButtonWithTag:3 title:@"Camera+image\n拍照" x:10 y:200 selector:@selector(choosePhotoLibrary:)];//拍照
    _btn4 = [self createButtonWithTag:4 title:@"Camera+movie\n拍视频" x:KWidth/2 y:200 selector:@selector(choosePhotoLibrary:)];//拍视频
    _btn5 = [self createButtonWithTag:5 title:@"SavedPhotosAlbum+image\n照片列表" x:10 y:300 selector:@selector(choosePhotoLibrary:)];//照片列表
    _btn6 = [self createButtonWithTag:6 title:@"SavedPhotosAlbum+movie\n视频列表" x:KWidth/2 y:300 selector:@selector(choosePhotoLibrary:)];//视频列表
    
    _btnPlayVC = [self createButtonWithTag:7 title:@"播放\n拍摄视频" x:0 y:400 selector:@selector(didClickPlayerBtn:)];//播放页
    _btnPlayNetVC = [self createButtonWithTag:8 title:@"播放\n网络视频" x:KWidth/2 y:400 selector:@selector(didClickPlayerNetBtn:)];//播放页
    
    [self.view addSubview:self.btn1];
    [self.view addSubview:self.btn2];
    [self.view addSubview:self.btn3];
    [self.view addSubview:self.btn4];
    [self.view addSubview:self.btn5];
    [self.view addSubview:self.btn6];
    
    [self.view addSubview:self.btnPlayVC];
    [self.view addSubview:self.btnPlayNetVC];
    
    [self.view addSubview:self.imageScroll];
    
    NSLog(@"kUTTypeVideo:%@", kUTTypeVideo);
    NSLog(@"kUTTypeImage:%@", kUTTypeImage);
    NSLog(@"kUTTypeMovie:%@", kUTTypeMovie);
}

- (UIButton *)createButtonWithTag:(NSInteger)tag title:(NSString *)title x:(CGFloat)x y:(CGFloat)y selector:(SEL)selector {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(x, y, 140, 60);
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    btn.titleLabel.numberOfLines = 3;
    [btn setBackgroundColor:[UIColor blueColor]];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    btn.tag = tag;
    
    return btn;
}

- (UIScrollView *)imageScroll {
    if (!_imageScroll) {
        CGFloat height = 120;
        CGFloat left = 15;
        CGFloat bottom = 15;
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(left, KHeight-bottom-height, KWidth-left*2, height)];
        scrollView.backgroundColor = [UIColor darkGrayColor];
        scrollView.pagingEnabled = YES;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.bounces = YES;
        
        _imageScroll = scrollView;
    }
    return _imageScroll;
}

- (void)didClickPlayerBtn:(UIButton *)btn {
    NSLog(@"去播放器-本地");
    
    NSString *urlString = [self.finalUrl absoluteString];
    if (urlString.length > 0) {
        PlayerVC *playVC = [[PlayerVC alloc] init];
        playVC.url = self.finalUrl;
        [self presentViewController:playVC animated:YES completion:^{
            
        }];
    } else {
        NSLog(@"URL为空");
    }
}

- (void)didClickPlayerNetBtn:(UIButton *)btn {
    NSLog(@"去播放器-网络");
    
    PlayerVC *playVC = [[PlayerVC alloc] init];
    playVC.url = [NSURL URLWithString:@"http://v.cctv.com/flash/mp4video6/TMS/2011/01/05/cf752b1c12ce452b3040cab2f90bc265_h264818000nero_aac32-1.mp4"];//test
    [self presentViewController:playVC animated:YES completion:^{
        
    }];
}

- (void)choosePhotoLibrary:(UIButton *)btn {
    UIImagePickerControllerSourceType sourceType = 0;
    switch (btn.tag) {
        case 1:
            sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            break;
        case 2:
            sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            break;
        case 3:
            sourceType = UIImagePickerControllerSourceTypeCamera;
            break;
        case 4:
            sourceType = UIImagePickerControllerSourceTypeCamera;
            break;
        case 5:
            sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            break;
        case 6:
            sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            break;
        default:
            break;
    }
    if (sourceType == UIImagePickerControllerSourceTypePhotoLibrary) {
        NSLog(@"sourceType = UIImagePickerControllerSourceTypePhotoLibrary");
    } else if (sourceType == UIImagePickerControllerSourceTypeCamera) {
        NSLog(@"sourceType = UIImagePickerControllerSourceTypeCamera");
    } else if (sourceType == UIImagePickerControllerSourceTypeSavedPhotosAlbum) {
        NSLog(@"sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum");
    }
    
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    if ([UIImagePickerController isSourceTypeAvailable:sourceType]) {
        ipc.sourceType = sourceType;//sourcetype有三种分别是camera，photoLibrary和photoAlbum
    }
    NSArray<NSString *> *availableMedia = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];//Camera所支持的Media格式都有哪些,共有两个分别是@"public.image",@"public.movie"
//    NSLog(@"availableMedia:%@", availableMedia);
    
    if (btn.tag == 1 || btn.tag == 3 || btn.tag == 5) {
        if ([availableMedia containsObject:(__bridge NSString *)kUTTypeImage]) {
            NSLog(@"public.image可用");
            ipc.mediaTypes = @[(__bridge NSString *)kUTTypeImage];//设置媒体类型为public.image
            [self presentViewController:ipc animated:YES completion:nil];
            ipc.delegate = self;//设置委托
        } else {
            NSLog(@"public.image不可用");
        }
    } else {
        if ([availableMedia containsObject:(__bridge NSString *)kUTTypeMovie]) {
            NSLog(@"public.movie可用");
            ipc.mediaTypes = @[(__bridge NSString *)kUTTypeMovie];
            [self presentViewController:ipc animated:YES completion:nil];
            
            if (sourceType == UIImagePickerControllerSourceTypeCamera) {
                //录制视频的情况
                [self printImagePickerController:ipc isDefault:YES];
                ipc.allowsEditing = YES;//录制完成后可截取视频部分
                ipc.videoMaximumDuration = 15.0f;//秒
                ipc.videoQuality = UIImagePickerControllerQualityTypeHigh;//画质
                ipc.videoExportPreset = @"视频导出的文字提示";
//                ipc.showsCameraControls = NO;//设为NO就没有录制按钮，以及时间提示，自定义界面时才使用
                [self printImagePickerController:ipc isDefault:NO];
            }
            ipc.delegate = self;//设置委托
        } else {
            NSLog(@"public.movie不可用");
        }
    }
}

- (void)printImagePickerController:(UIImagePickerController *)ipc isDefault:(BOOL)isDefault {
    if (isDefault) {
        NSLog(@"相机拍摄的默认设置------");
    } else {
       NSLog(@"相机拍摄的自定义设置------");
    }
    NSLog(@"ipc.allowsEditing:%ld", (long)ipc.allowsEditing);
    NSLog(@"ipc.imageExportPreset:%ld", (long)ipc.imageExportPreset);
    NSLog(@"ipc.videoMaximumDuration:%ld", (long)ipc.videoMaximumDuration);
    NSLog(@"ipc.videoQuality:%ld", (long)ipc.videoQuality);
    NSLog(@"ipc.videoExportPreset:%@", ipc.videoExportPreset);
    NSLog(@"ipc.showsCameraControls:%ld", (long)ipc.showsCameraControls);
    NSLog(@"ipc.cameraCaptureMode:%ld", (long)ipc.cameraCaptureMode);
    NSLog(@"ipc.cameraDevice:%ld", (long)ipc.cameraDevice);
    NSLog(@"ipc.cameraFlashMode:%ld", (long)ipc.cameraFlashMode);
}

////选择本地视频
//- (void)chooseCamera {
//    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
//    ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;//sourcetype有三种分别是camera，photoLibrary和photoAlbum
//    NSArray<NSString *> *availableMedia = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];//Camera所支持的Media格式都有哪些,共有两个分别是@"public.image",@"public.movie"
//    if (availableMedia.count > 1) {
//        ipc.mediaTypes = [NSArray arrayWithObject:availableMedia[1]];//设置媒体类型为public.movie
//
//        [self presentViewController:ipc animated:YES completion:nil];
//        ipc.delegate = self;//设置委托
//    } else {
//        NSLog(@"相机不可用");
//    }
//}

////录制视频
//- (void)startvideo{
//    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
//    ipc.sourceType = UIImagePickerControllerSourceTypeCamera;//sourcetype有三种分别是camera，photoLibrary和photoAlbum
//    NSArray *availableMedia = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];//Camera所支持的Media格式都有哪些,共有两个分别是@"public.image",@"public.movie"
//    ipc.mediaTypes = [NSArray arrayWithObject:availableMedia[1]];//设置媒体类型为public.movie
//
//    [self presentViewController:ipc animated:YES completion:nil];
//    ipc.videoMaximumDuration = 30.0f;//30秒
//    ipc.delegate = self;//设置委托
//}

//此方法可以获取文件的大小，返回的是单位是KB。
- (CGFloat)getFileSize:(NSString *)path{
    NSLog(@"%@",path);
    NSFileManager *fileManager = [NSFileManager defaultManager];
    float filesize = -1.0;
    
    if ([fileManager fileExistsAtPath:path]) {
        NSDictionary *fileDic = [fileManager attributesOfItemAtPath:path error:nil];//获取文件的属性
        unsigned long long size = [[fileDic objectForKey:NSFileSize] longLongValue];
        filesize = 1.0*size/1024;
    }else{
        NSLog(@"找不到文件");
    }
    return filesize;
}

//视频时长（单位：秒 向上取整）
- (CGFloat) getVideoLength:(NSURL *)URL{
    AVURLAsset *avUrl = [AVURLAsset assetWithURL:URL];
    CMTime time = [avUrl duration];
    int second = ceil((CGFloat)time.value/time.timescale);
    return second;
}

//此方法可以获取视频文件的时长。
//完成视频录制，并压缩后显示大小、时长
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    NSURL *sourceURL = [info objectForKey:UIImagePickerControllerMediaURL];
    NSLog(@"%@",[NSString stringWithFormat:@"%f s", [self getVideoLength:sourceURL]]);
    NSLog(@"%@", [NSString stringWithFormat:@"%.2f kb", [self getFileSize:[sourceURL path]]]);
    NSURL *newVideoUrl ; //一般.mp4
    
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];//用时间给文件全名，以免重复，在测试的时候其实可以判断文件是否存在若存在，则删除，重新生成文件即可
    [formater setDateFormat:@"yyyy-MM-dd-HH:mm:ss"];
    
    newVideoUrl = [NSURL fileURLWithPath:[NSHomeDirectory() stringByAppendingFormat:@"/Documents/output-%@.mp4", [formater stringFromDate:[NSDate date]]]] ;//这个是保存在app自己的沙盒路径里，后面可以选择是否在上传后删除掉。我建议删除掉，免得占空间。
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"newVideoUrl:%@",newVideoUrl);
    
    [self convertVideoQuailtyWithInputURL:sourceURL outputURL:newVideoUrl completeHandler:nil];
}

- (void)convertVideoQuailtyWithInputURL:(NSURL*)inputURL outputURL:(NSURL*)outputURL completeHandler:(void (^)(AVAssetExportSession*))handler{
    
    AVURLAsset *avAsset = [AVURLAsset URLAssetWithURL:inputURL options:nil];
    AVAssetExportSession *exportSession = [[AVAssetExportSession alloc] initWithAsset:avAsset presetName:AVAssetExportPresetMediumQuality];//转码后的清晰度
    
    //  NSLog(resultPath);
    exportSession.outputURL = outputURL;
    exportSession.outputFileType = AVFileTypeMPEG4;
    exportSession.shouldOptimizeForNetworkUse= YES;
    [exportSession exportAsynchronouslyWithCompletionHandler:^(void){
        switch (exportSession.status) {
            case AVAssetExportSessionStatusCancelled:
                NSLog(@"---AVAssetExportSessionStatusCancelled");
                break;
            case AVAssetExportSessionStatusUnknown:
                NSLog(@"---AVAssetExportSessionStatusUnknown");
                break;
            case AVAssetExportSessionStatusWaiting:
                NSLog(@"---AVAssetExportSessionStatusWaiting");
                break;
            case AVAssetExportSessionStatusExporting:
                NSLog(@"---AVAssetExportSessionStatusExporting");
                break;
            case AVAssetExportSessionStatusCompleted:
                NSLog(@"---AVAssetExportSessionStatusCompleted");
                NSLog(@"%@",[NSString stringWithFormat:@"%f s", [self getVideoLength:outputURL]]);
                NSLog(@"%@", [NSString stringWithFormat:@"%.2f kb", [self getFileSize:[outputURL path]]]);
                //UISaveVideoAtPathToSavedPhotosAlbum([outputURL path], self, nil, NULL);//这个是保存到手机相册
                [self alertUploadVideo:outputURL];
                break;
            case AVAssetExportSessionStatusFailed:
                NSLog(@"---AVAssetExportSessionStatusFailed");
                break;
        }
    }];
}

-(void)alertUploadVideo:(NSURL*)URL{
    CGFloat size = [self getFileSize:[URL path]];
    NSString *message;
    NSString *sizeString;
    CGFloat sizemb= size/1024;
    if(size<=1024){
        sizeString = [NSString stringWithFormat:@"%.2fKB",size];
    }else{
        sizeString = [NSString stringWithFormat:@"%.2fMB",sizemb];
    }
    if(sizemb<2){
        [self uploadVideo:URL];
        
    }else if(sizemb<=5){
        message = [NSString stringWithFormat:@"视频%@，大于2MB会有点慢，确定上传吗？", sizeString];
        UIAlertController * alertController = [UIAlertController alertControllerWithTitle: nil message: message preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshwebpages" object:nil userInfo:nil];
            [[NSFileManager defaultManager] removeItemAtPath:[URL path] error:nil];//取消之后就删除，以免占用手机硬盘空间（沙盒）
        }]];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self uploadVideo:URL];
            
        }]];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
    }else if(sizemb>5){
        message = [NSString stringWithFormat:@"视频%@，超过5MB，不能上传，抱歉。", sizeString];
        UIAlertController * alertController = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshwebpages" object:nil userInfo:nil];
            [[NSFileManager defaultManager] removeItemAtPath:[URL path] error:nil];//取消之后就删除，以免占用手机硬盘空间
            
        }]];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

-(void)uploadVideo:(NSURL*)URL{
#if 0
    //[MyTools showTipsWithNoDisappear:nil message:@"正在上传..."];
    NSData *data = [NSData dataWithContentsOfURL:URL];
    MKNetworkEngine *engine = [[MKNetworkEngine alloc] initWithHostName:@"www.ylhuakai.com" customHeaderFields:nil];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    NSString *updateURL = @"/alflower/Data/sendupdate";
    [dic setValue:[NSString stringWithFormat:@"%@",User_id] forKey:@"openid"];
    [dic setValue:[NSString stringWithFormat:@"%@",[self.web objectForKey:@"web_id"]] forKey:@"web_id"];
    [dic setValue:[NSString stringWithFormat:@"%i",insertnumber] forKey:@"number"];
    [dic setValue:[NSString stringWithFormat:@"%i",insertType] forKey:@"type"];
    
    MKNetworkOperation *op = [engine operationWithPath:updateURL params:dic httpMethod:@"POST"];
    [op addData:data forKey:@"video" mimeType:@"video/mpeg" fileName:@"aa.mp4"];
    [op addCompletionHandler:^(MKNetworkOperation *operation) {
        NSLog(@"[operation responseData]-->>%@", [operation responseString]);
        NSData *data = [operation responseData];
        NSDictionary *resweiboDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSString *status = [[resweiboDict objectForKey:@"status"] stringValue];
        NSLog(@"addfriendlist status is %@", status);
        NSString *info = [resweiboDict objectForKey:@"info"];
        NSLog(@"addfriendlist info is %@", info);
        // [MyTools showTipsWithView:nil message:info];
        // [SVProgressHUD showErrorWithStatus:info];
        if ([status isEqualToString:@"1"]){
            [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshwebpages" object:nil userInfo:nil];
            [[NSFileManager defaultManager] removeItemAtPath:[URL path] error:nil];//上传之后就删除，以免占用手机硬盘空间;
        }else{
            //[SVProgressHUD showErrorWithStatus:dic[@"info"]];
        }
        // [[NSNotificationCenter defaultCenter] postNotificationName:@"StoryData" object:nil userInfo:nil];
    }errorHandler:^(MKNetworkOperation *errorOp, NSError* err) {
        NSLog(@"MKNetwork request error : %@", [err localizedDescription]);
    }];
    [engine enqueueOperation:op];
#else
    dispatch_async(dispatch_get_main_queue(), ^{
        [self drawImagesFromVideoUrl:URL];
    });
    self.finalUrl = URL;
//    [[NSFileManager defaultManager] removeItemAtPath:[URL path] error:nil];//上传之后就删除，以免占用手机硬盘空间;
#endif
}

- (void)drawImagesFromVideoUrl:(NSURL *)videoURL {
    NSMutableArray *images = [[NSMutableArray alloc] init];
    CGFloat totalWidth = 0;
    CGFloat height = self.imageScroll.frame.size.height;
    CGFloat spacing = 10;
    CGFloat length = [self getVideoLength:videoURL];
    for (int i = 0; i < (int)length; i++) {
        UIImage *image = [self getImageFromVideoUrl:videoURL timePoint:i];
        [images addObject:image];
        
        CGFloat width = height*(image.size.width/image.size.height);
        CGFloat left = (i==0)?totalWidth:totalWidth+spacing;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(left, 0, width, height)];
        imageView.image = image;
        NSLog(@"[%ld] imageView:%@", (long)i, imageView);
        [self.imageScroll addSubview:imageView];
        totalWidth = CGRectGetMaxX(imageView.frame);
    }
    
    self.imageScroll.contentSize = CGSizeMake(totalWidth, height);
}

//能够取出视频中每一帧的缩略图或者预览图
- (UIImage *)getImageFromVideoUrl:(NSURL *)videoURL timePoint:(CGFloat)timePoint{
    // result
    UIImage *image = nil;
    
    // AVAssetImageGenerator
    AVAsset *asset = [AVAsset assetWithURL:videoURL];
    AVAssetImageGenerator *imageGenerator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    imageGenerator.appliesPreferredTrackTransform = YES;

#if 0
    // calculate the midpoint time of video
//    Float64 duration = CMTimeGetSeconds([asset duration]);
    // 取某个帧的时间，参数一表示哪个时间（秒），参数二表示每秒多少帧
    // 通常来说，600是一个常用的公共参数，苹果有说明:
    // 24 frames per second (fps) for film, 30 fps for NTSC (used for TV in North America and
    // Japan), and 25 fps for PAL (used for TV in Europe).
    // Using a timescale of 600, you can exactly represent any number of frames in these systems
//    CMTime midpoint = CMTimeMakeWithSeconds(duration / 2.0, 600);
#else
    CMTime midpoint = CMTimeMakeWithSeconds((double)timePoint, 600);
#endif
    
    // get the image from
    NSError *error = nil;
    CMTime actualTime;
    // Returns a CFRetained CGImageRef for an asset at or near the specified time.
    // So we should mannully release it
    CGImageRef centerFrameImage = [imageGenerator copyCGImageAtTime:midpoint
                                                         actualTime:&actualTime
                                                              error:&error];
    
    if (centerFrameImage != NULL) {
        image = [[UIImage alloc] initWithCGImage:centerFrameImage];
        // Release the CFRetained image
        CGImageRelease(centerFrameImage);
    }
    
    return image;
}
@end
