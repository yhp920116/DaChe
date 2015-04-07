//
//  ZuoxinDelegateProtocol.m
//  ZuoxinApp
//
//  Created by tongxia on 9/4/13.
//  Copyright (c) 2013 Zuoxin.com. All rights reserved.
//

#import "ZuoxinDelegateProtocol.h"
#import <QuartzCore/QuartzCore.h>
#import "TabBarController.h"

@interface ZuoxinDelegateProtocol ()

@end

@implementation ZuoxinDelegateProtocol

@synthesize protocolView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

/*
- (void)viewWillAppear:(BOOL)animated
{
    TabBarController *tabBarController = (TabBarController *) self.tabBarController;
    [tabBarController tabBarHidden:YES];
}
*/

-(void)LoadTextView
{
    UIView *protocolText = [[UIView alloc]initWithFrame:CGRectMake(10, 55, 300, self.view.frame.size.height-55-8)];
    protocolText.backgroundColor = [UIColor whiteColor];
    //protocolText.layer.cornerRadius = 5.0;
    [self setLayerCornerRadiusAndshadowInView:protocolText];
    [self.view addSubview:protocolText];
    
    UILabel *dPlabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 8, 202, 18.0f)];
    dPlabel.text = @"委托代驾服务协议";
    dPlabel.font = [UIFont systemFontOfSize:13.0f];
    dPlabel.textColor = [UIColor colorWithRed:90/255.0 green:156/255.0 blue:0/255.0 alpha:1];
    dPlabel.backgroundColor = [UIColor clearColor];
    [protocolText addSubview:dPlabel];
    
    
    self.protocolView = [[UITextView alloc]initWithFrame:CGRectMake(6, 30, 294, self.view.frame.size.height-55-30-14)];
    self.protocolView.textColor = [UIColor blackColor];
    self.protocolView.font = [UIFont fontWithName:@"Helvetica" size:12.0];
    self.protocolView.delegate = self;
    self.protocolView.backgroundColor = [UIColor whiteColor];
    [self setLayerCornerRadiusAndshadowInView:protocolText];
    //self.protocolView.text = @"1.委托代驾服务协议.\n2.委托代驾服务协议委托代驾服务协议委托代驾服务协议委托代驾服务协议委托代驾服务协议委托代驾服务协议委托代驾服务协议委托代驾服务协议如果你程序是有导航条的，可以在导航条上面加多一个Done的按钮，用来退出键盘，当然要先实现。\n3.委托代驾服务协议委托代驾服务协议委托代驾服务协议委托代驾服务协议委托代驾服务协议委托代驾服务协议委托代驾服务协议委托代驾服务协议用来退出键盘，当然要先实现，委托代驾服务协议委托代驾服务协议委托代驾服务协议。委托代驾服务协议委托代驾服务协议用来退出键盘，当然要先实现1000个，委托代驾服务协议委托代驾服务协议委托代驾服务协议委托代驾服务协议委托代驾服务协议委托代驾服务协议委托代驾服务协议委托代驾服务协议.";
    
    self.protocolView.text = @"“小易代驾”使用协议\n\n  特别提示：“小易代驾”是由北京卓信汽车租赁有限公司提供的客户端软件和相关的网络服务。用户在安装“小易代驾”前应仔细阅读本服务协议，只要用户安装“小易代驾”，即表明用户已经完整准确地了解了本协议所有约定，并同意接受本协议的全部条款。\n\n一．关于知识产权保护\n“小易代驾”受国际版权公约、中华人民共和国著作权法、专利法、及其他知识产权方面的法律法规的保护，其所有知识产权归北京卓信汽车租赁有限公司所有和享有，用户需承认北京卓信汽车租赁有限公司拥有对“小易代驾”的所有权利，包括但不限于所有知识产权。“知识产权”包括在专利法、版权法、商标法、反不正当竞争法中等法律规定的任何和所有权利、任何和所有其它所有权以及其中的任何和所有应用、更新、扩展和恢复。用户不得修改、改编、翻译“小易代驾”，或者创作“小易代驾”的派生作品，不得通过反向工程、反编译、反汇编或其他类似行为获得“小易代驾”源代码，否则由此的一切法律后果由用户负责，北京卓信汽车租赁有限公司将依法追究违约方的法律责任。用户不得恶意修改、复制、传播与“小易代驾”相关的材料。如果用户复制和修改传播这些材料因此而造成对其他人的损害，或者造成对北京卓信汽车租赁有限公司形象损害，要承担相应的法律责任。用户不得删除、掩盖或更改北京卓信汽车租赁有限公司的版权声明、商标或其它权利声明。\n\n二．义务和责任限制\n  北京卓信汽车租赁有限公司免费授权用户非商业性使用“小易代驾”软件，并为用户提供升级更新和提供有关网络服务。这意味着用户可以自主选择安装或卸载并免费使用或停止使用“小易代驾”，及免费使用北京卓信汽车租赁有限公司提供的有关网络服务。用户可以非商业性地复制和散发“小易代驾”。但是如果要进行商业性的销售、复制、散发或其他商业活动，例如软件预装和捆绑，必须事先获得北京卓信汽车租赁有限公司的书面授权和许可。另外，用户在使用“小易代驾”时，不得损害、妨碍、影响、禁用“小易代驾”的网络服务，也不得影响任何其它方享用“小易代驾”的网络服务，不得有违反法律、危害网络安全或损害第三方合法权益之行为，否则由此产生的后果均由用户自己承担，北京卓信汽车租赁有限公司对用户不承担任何责任。\n  用户理解并同意自主选择免费下载和使用“小易代驾”，风险自负，包括但不限于用户使用“小易代驾”过程中的行为，以及因使用“小易代驾”而产生的一切后果。如因下载或使用“小易代驾”而对计算机系统造成的损坏或数据的丢失，用户须自行承担全部责任。在法律允许的最大限度内，北京卓信汽车租赁有限公司明确表示不做出任何明示、暗示和强制的担保，包括但不限于适销性、针对特定用途的适用性以及不侵犯所有权的担保。北京卓信汽车租赁有限公司不做出任何与“小易代驾”的安全性、可靠性、及时性和性能有关的担保。北京卓信汽车租赁有限公司有权在任何时候，暂时或永久地变更、中断或终止“小易代驾”或其中任何一部分的服务。北京卓信汽车租赁有限公司对本服务的变更、中断或终止，对用户和任何第三人均不承担任何责任。\n  用户可以向北京卓信汽车租赁有限公司提出咨询和获得“小易代驾”相关的合理技术支持，北京卓信汽车租赁有限公司的此项义务不应超过北京卓信汽车租赁有限公司的合理承受限度。如果用户对“小易代驾”有任何意见和如何改进的建议，请使用“用户反馈”功能发表您的意见和建议。\n  特别提示：“小易代驾”作为信息提供方为代驾司机登记和公示身份信息，并为代驾委托方和代驾司机提供服务供需信息的匹配，对双方在代驾过程中已产生或可能产生纠纷或损害不承担任何责任。如代驾委托方各代驾司机对此有不同意见，可以拒绝安装本软件。但只要用户安装“小易代驾”，即表明用户已经完整准确地了解了本协议所有约定，并同意接受本协议的全部条款。\n  代驾司机必须在“小易代驾”登记和公示真实有效的身份证和驾照信息；代驾委托方有权审核代驾司机的驾驶证和合法有效的身份证明。代驾委托方提供代驾司机代驾的车辆，应保证车况良好，且必须具备合法的行驶手续，包括“交强险”、“车辆损失”和“第三者责任险”。如果上述手续不全，代驾委托方应如实提前告知代驾司机，代驾司机有权拒绝本次代驾服务。\n  服务开始前，代驾委托方应配合代驾司机了解车辆状况、操作特点，在不影响安全驾驶的前提下，有权在代驾过程中提示代驾司机的不当操作。\n  以安全到达为前提，在代驾过程开始前和行进中，代驾司机有权要求代驾委托方指示正确合理的路径，代驾委托方对代驾司机的指路要求，应作出正确的回应与配合。\n  代驾司机必须严格遵守道路交通相关法律法规，代驾委托方有权监督代驾 司机的驾驶过程，如果代驾司机出现明显违反交通法律法规的行为，代驾委托方有权中止本次服务。服务过程中出现客观未能避免的交通事故，造成代驾委托方车辆财产损失和人身伤害，以及本合同无法顺利执行，如果属于肇事方全责，代驾委托方、代驾司机双方均免责；\n  如果由交通执法机构判定代驾司机驾驶车辆有责任，代驾司机应承担超出保险赔付范围部分的代驾委托方损失，同时退还本次服务费用；如果由交通执法机构判定代驾司机代驾车辆为全责，代驾司机应承担超出保险赔付范围部分和代驾委托方的直接损失，同时退还本次服务费用。无论以上何种情况，北京卓信汽车租赁有限公司及“小易代驾”作为信息提供方对代驾委托方，代驾司机以及交通事故第三方的损失不承担任何责任。服务未开始，或执行过程中，未经代驾委托方许可，代驾司机不得单独进入驾驶室或在驾驶室滞留。同时，代驾司机有权拒绝非本合同内容约定的、或与约定服务无关的任何形式的委托。作为信息提供方，北京卓信汽车租赁有限公司及“小易代驾”在任何情况下，对代驾委托方和代驾司机对对方可能造成的人身和财产损害不承担任何责任。\n  因等候或依据代驾委托方其他服务要求，致使原定服务价格的基本参照条件发生变化，代驾司机有权提出服务价格变更，跨越或进入下一级的时段，服务费用将按实际里程范围计收。\n\n三．无担保声明及隐私政策\n  “小易代驾”（包括其升级版）经过北京卓信汽车租赁有限公司详细的测试，但北京卓信汽车租赁有限公司不能保证其与所有的软硬件、系统完全兼容。如果出现不兼容的情况，用户可将情况报告北京卓信汽车租赁有限公司，以获得技术支持。如果无法解决问题，用户可以选择卸载“小易代驾”。由于“小易代驾”可以通过网络途径下载、传播，对于从非北京卓信汽车租赁有限公司指定官方站点下载的“小易代驾”以及从非北京卓信汽车租赁有限公司发行的介质上获得的“小易代驾”，公司无法保证该软件是否感染计算机病毒、是否隐藏有伪装的特洛伊木马程序等黑客软件，也不承担对由此使用所遭受的一切直接或间接损害的赔偿等法律责任。\n\n四．关于本协议\n  北京卓信汽车租赁有限公司保留随时修改本服务协议的权利并无须逐一通知用户，最新版本之服务协议将公布于“小易代驾”网站，一经公布即视为已经通知所有用户。用户对北京卓信汽车租赁有限公司修改后的协议如果有异议，可选择卸载“小易代驾”，由此给用户造成的任何损失北京卓信汽车租赁有限公司均不承担责任。用户继续使用“小易代驾”即表明用户完全同意北京卓信汽车租赁有限公司对服务协议的修改。在法律许可的范围内，本服务协议条款的最终解释权在北京卓信汽车租赁有限公司。\n\n五.本协议适用中华人民共和国法律。\n  如双方就本协议内容或其执行发生任何争议，双方应尽量友好协商解决；协商不成时，任何一方均可向北京卓信汽车租赁有限公司所在地人民法院提起诉讼。\n\n                        经理：";
    
    self.protocolView.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    self.protocolView.editable = NO;
    self.protocolView.scrollEnabled = YES;
    self.protocolView.layer.cornerRadius = 5.0;
    self.protocolView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    self.protocolView.textAlignment = NSTextAlignmentLeft;
    [protocolText addSubview:self.protocolView];
}

- (void)loadCustomBar
{
    self.view.backgroundColor = [UIColor colorWithRed:0.82 green:0.82 blue:0.82 alpha:1];
    self.navTitleLabel.text = @"委托代驾服务协议";
}

-(void)backBtnClick
{
    [self setTabBarHidden:NO];
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self loadCustomBar];
    [self LoadTextView];
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [self setTabBarHidden:YES];
    [super viewDidDisappear:animated];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
