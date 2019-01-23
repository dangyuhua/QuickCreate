//
//  QuickTools.h
//  Shopping
//
//  Created by 党玉华 on 2018/7/11.
//  Copyright © 2018年 党玉华. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuickTools : NSObject

#pragma mark UIButton
+(UIButton *)UIButtonWithFrame:(CGRect )frame backgroundColor:(UIColor *)backgroundColor title:(NSString *)title image:(NSString *)image selectImage:(NSString *)selectImage font:(CGFloat)font textColor:(UIColor *)textColor selectTextColor:(UIColor *)selectTextColor edgeInsets:(UIEdgeInsets )edgeInsets tag:(NSInteger)tag target:(id)target action:(SEL)action;
#pragma mark 导航栏返回按钮
+(UIBarButtonItem *)UIBarButtonItemNavBackBarButtonItemWithTarget:(id)target action:(SEL)action;
#pragma mark 导航栏按钮
+(UIBarButtonItem *)UIBarButtonItemBarButtonWithTarget:(id)target action:(SEL)action frame:(CGRect )frame title:(NSString *)title image:(NSString *)image selectImage:(NSString *)selectImage font:(CGFloat)font textColor:(UIColor *)textColor edgeInsets:(UIEdgeInsets)edgeInsets;
#pragma mark 上拉下拉tableview
+(UITableView *)UITableViewMJRefreshWithBackgroundColor:(UIColor *)color frame:(CGRect )frame separatorStyle:(UITableViewCellSeparatorStyle )separatorStyle style:(UITableViewStyle)style contentInset:(UIEdgeInsets )contentInset indicator:(BOOL)indicator isRefresh:(BOOL)isRefresh footerIsNeedDrag:(BOOL)footerIsNeedDrag mjheadBlock:(void (^)(void))mjheadBlock mjfootBlock:(void (^)(void))mjfootBlock;
#pragma mark 通过data获取image,可获取image大小
+(UIImage *)UIImageWithimageURL:(NSString *)imageURL;
#pragma mark UICollectionView
+(UICollectionView *)UICollectionViewMJRefreshWithFrame:(CGRect)frame scrollDirection:(UICollectionViewScrollDirection )scrollDirection itemSize:(CGSize )itemSize minimumLineSpacing:(CGFloat )minimumLineSpacing minimumInteritemSpacing:(CGFloat )minimumInteritemSpacing backgroundColor:(UIColor *)backgroundColor scrollEnabled:(BOOL )scrollEnabled pagingEnabled:(BOOL )pagingEnabled showsScrollIndicator:(BOOL )showsScrollIndicator contentInset:(UIEdgeInsets )contentInset footerLabelLeftInset:(CGFloat)inset isRefresh:(BOOL)isRefresh footerIsNeedDrag:(BOOL)footerIsNeedDrag mjheadBlock:(void (^)(void))mjheadBlock mjfootBlock:(void (^)(void))mjfootBlock;
#pragma mark 解决含有UICollectionView的vc手势返回冲突
+(UICollectionView *)UICollectionViewConflictWithVCBack:(UICollectionView *)collectionview vc:(UIViewController *)vc;
#pragma mark UIScrollView
+ (UIScrollView *)UIScrollViewWithFrame:(CGRect )frame backgroundColor:(UIColor *)bgcolor size:(CGSize )size isPagingEnable:(BOOL )isPage isBounces:(BOOL )isBounces scrollEnabled:(BOOL )scrollEnabled isShowVerticalIndicator:(BOOL )isShowVIndicator isShowsHorizontalScrollIndicator:(BOOL )isShowHIndicator;
#pragma mark 解决含有scrollview的vc手势返回冲突
+(UIScrollView *)UIScrollViewConflictWithVCBack:(UIScrollView *)scrollview vc:(UIViewController *)vc;
#pragma mark
+(UIView *)UIViewWithFrame:(CGRect )frame backgroundColor:(UIColor *)backgroundColor;
#pragma mark
+(UITextView *)UITextViewithFrame:(CGRect )frame backgroundColor:(UIColor *)backgroundColor content:(NSString *)content font:(CGFloat)fontSize textColor:(UIColor *)textColor;
#pragma mark
+(UITextField *)UITextFieldWithFrame:(CGRect )frame cornerRadius:(CGFloat )r font:(CGFloat)font borderStyle:(UITextBorderStyle )borderStyle backgroundColor:(UIColor *)bgcolor placeholder:(NSString *)placeholder attributes:(NSDictionary<NSAttributedStringKey, id> *)attrs returnKeyType:(UIReturnKeyType)returnKeyType leftview:(UIView *)leftview rightView:(UIView *)rightView clearButtonMode:(UITextFieldViewMode )clearButtonMode keyboardType:(UIKeyboardType )keyboardType;
#pragma mark
+(UIImageView *)UIImageViewWithFrame:(CGRect )frame image:(id)image;
#pragma mark
+(UILabel *)UILabelWithFrame:(CGRect )frame backgroundColor:(UIColor *)backgroundColor textColor:(UIColor *)textColor text:(NSString *)text numberOfLines:(NSInteger)numberOfLines textAlignment:(NSTextAlignment )textAlignment font:(CGFloat)fontSize;
#pragma mark UISearchController
+(UISearchController *)UISearchControllerWithSearchResultsController:(UIViewController *)searchResultsController frame:(CGRect )frame;
#pragma mark UIActivityIndicatorView
+(UIActivityIndicatorView *)UIActivityIndicatorViewWithFrame:(CGRect )frame activityIndicatorViewStyle:(UIActivityIndicatorViewStyle) activityIndicatorViewStyle;
#pragma mark
+(NSAttributedString *)NSAttributedStringWithIndex1:(NSInteger )index1 index2:(NSInteger )index2 string:(NSString *)string color:(UIColor *)color font:(CGFloat)font;
#pragma mark 尚未确定
+(UIControl *)TopImageBottomStringWithFrame:(CGRect)frame image:(NSString *)image imageurl:(NSString *)imageurl placeholderImage:(NSString *)placeholderImage name:(NSString *)name font:(CGFloat)font textColor:(UIColor *)textColor tag:(NSInteger)tag target:(id)target action:(SEL)action;
#pragma mark 下载图片
+(UIImageView *)SDWebImageSetImage:(UIImageView *)imageview url:(NSString *)imageURL placeholderImage:(NSString *)placeholderImage;
#pragma mark 下载图片(需要获取frame的)
+(UIImageView *)SDWebImageNeedFrame:(UIImageView *)imageview url:(NSString *)imageURL placeholderImage:(NSString *)placeholderImage;
#pragma mark 截取字符串
+(NSString *)cutoutNSString:(NSString *)str range:(NSInteger )index;
#pragma mark
+(UIControl *)UIControlFrame:(CGRect )frame backgroundColor:(UIColor *)backgroundColor tag:(int)tag target:(id)target action:(SEL)action;
#pragma mark 计算字符串高度
+(CGFloat)calculatedStringHeight:(NSString *)string WithSize:(CGSize)size font:(CGFloat)fontSize;
#pragma mark 计算字符串宽度
+(CGFloat)calculatedStringWidth:(NSString *)string WithSize:(CGSize)size font:(CGFloat)fontSize;
#pragma mark 计算字符串长高度
+(CGSize)calculatedString:(NSString *)string WithSize:(CGSize)size font:(CGFloat)fontSize;
#pragma mark  根据图片url获取图片尺寸
+(CGSize)getImageSizeWithURL:(id)imageURL;
#pragma mark 获得目前时间
+(NSString *)getCurrentDateFormatter:(NSString *)dateFormat;
#pragma mark 获取某个时间与现在时间差
+(NSInteger)getTimeDifferenceWithNowTime:(NSString*)nowTime endTime:(NSString*)endTime;
#pragma mark 数字字符串转成时间字符串
+(NSString *)NumberTimeChangeString:(NSString *)time;
#pragma mark string时间转数字时间戳
+(NSString *)StringDateToNSIntergeTime:(NSString*)time;
#pragma mark 获取目前的VC
+ (UIViewController *)getCurrentVC;
#pragma mark 用途比如推送跳转
+ (UINavigationController *)getCurrentNav;
#pragma mark 设置NSAttributedString颜色
+(NSMutableAttributedString *)NSMutableAttributedStringColorConfigText:(NSString *)text textColor:(UIColor *)textColor range:(NSRange)range;
#pragma mark image转data
+(NSData *)UIImageExchangeNSData:(UIImage *)image;
#pragma mark data转image
+(UIImage *)NSDataExchangeUIImage:(NSData *)data;
#pragma mark 点按
+(UITapGestureRecognizer *)UITapGestureRecognizerWithTarget:(id)target action:(SEL)action;
#pragma mark 长按
+(UILongPressGestureRecognizer *)UILongPressGestureRecognizerWithTarget:(id)target action:(SEL)action;
#pragma mark 轻扫
+(UISwipeGestureRecognizer *)UISwipeGestureRecognizerWithTarget:(id)target action:(SEL)action direction:(UISwipeGestureRecognizerDirection)direction;
#pragma mark 旋转
+(UIRotationGestureRecognizer *)UIRotationGestureRecognizerWithTarget:(id)target action:(SEL)action;
#pragma mark 捏合
+(UIPinchGestureRecognizer *)UIPinchGestureRecognizerWithTarget:(id)target action:(SEL)action;
#pragma mark 拖拽
+(UIPanGestureRecognizer *)UIPanGestureRecognizerWithTarget:(id)target action:(SEL)action;
#pragma mark FPS检测 //流畅度
+(void)FPSLabel;
#pragma mark 返回虚线image的方法
+(UIImage *)drawLineByImageView:(UIImageView *)imageView lineColor:(UIColor *)color;
#pragma mark 字典转JSON字符串
+(NSString *)dictionaryToJsonString:(NSDictionary *)dict;
#pragma mark JSON字符串转化为字典
+ (NSDictionary *)jsonStringToWithDictionary:(NSString *)jsonString;
#pragma mark 替换去除字符
+(NSString *)removeStrWithContent:(NSString *)content removeStr:(NSString *)removeStr replaceStr:(NSString *)replaceStr;
#pragma mark 获取启动图
+(UIImage *)getLaunchImage;
#pragma mark 文字转码(中文)
+(NSString *)NSStringTranscodingWithText:(NSString *)text;
@end
