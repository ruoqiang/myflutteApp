import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:myflutterapp/base_widgit/appbar.dart';
import 'package:myflutterapp/base_widgit/showToast.dart';
import 'package:myflutterapp/base_widgit/webview.dart';
import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:myflutterapp/common/http.dart';

import 'package:myflutterapp/pages/search.dart';
import 'package:myflutterapp/pages/user_base_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../base_widgit/popup/popup.dart';
import '../base_widgit/popup/popup_content.dart';
class ProcessPage extends StatefulWidget {
  @override
  _ProcessPageState createState() => _ProcessPageState();
}

class _ProcessPageState extends State<ProcessPage> {
  String homePageContent = '正在获取数据';
  List<Map> navigatorList = [];
  List<Map> slideList = [];
  bool _newCheckboxValue = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Colors.blue,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Stack(
                children: <Widget>[
                  Container(
                    color: Colors.black,
                    child: Column(
                      children: <Widget>[
                        Image.asset('images/index_apply_banner.png'),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 20,
                    top: 0,
                    child: GestureDetector(
                      child: Image.asset(
                        'images/index_apply_btn.png',
                        width: 50,
                      ),
                      onTap: () {
                        showPopup(context, _popupBody(), '办卡须知');
                      },
                    ),
                  ),
                  Positioned(
                    right: 80,
                    top: 410,
                    child: GestureDetector(
                        onTap: () {
                          showPopup(context, _popupUseDiscountBody(), '各省市优惠');
                        },
                      child: Text('查看各省市优惠>',style: TextStyle(color: Colors.white,decoration: TextDecoration.underline),
                    )),
                  )
                ],
              ),
            ),
          )
          ),
          bottomNavigationBar: BottomAppBar(
            child: Container(
              height: 100,
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: <Widget>[
                        Checkbox(
                        value: _newCheckboxValue,
                        activeColor: Color(0xff2D4ED1),
                        onChanged: (newValue) {
                          setState(() {
                            _newCheckboxValue = newValue;
                          });
                        },
                      ),
                      Text('我已阅读并同意《 '),
                      GestureDetector(
                        onTap: (){
                          showPopup(context, _popupUseAgreementBody(), 'ETC用卡协议');
                        },
                        child: Text('ETC用卡协议',style: TextStyle(color: Color(0xff2D4ED1)),),
                      ),

                      Text('》'),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(left: 15,right: 15),
                          height: 40,
                          child: RaisedButton(
                            color:Color(0xffecb81c) ,
                            onPressed: (){
                              if(_newCheckboxValue ==false) {
                                showToast('请勾选同意协议');
                                return;
                              }
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return UserBaseInfoPage();
                                }),
                              );
                            },
                            textColor: Color(0xffffffff),
                            child: Text("立即开通ETC",style: TextStyle(fontSize: 16),),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
    );
  }


//弹框相关--start
  showPopup(BuildContext context, Widget widget, String title,
      {BuildContext popupContext}) {
    Navigator.push(
      context,
      PopupLayout(
        top: 0,
        left: 0,
        right: 0,
        bottom: 0,
        child: PopupContent(
          content: Scaffold(
            appBar: AppBar(
              // Here we take the value from the MyHomePage object that was created by
              // the App.build method, and use it to set our appbar title.
              title: Text(title,style: TextStyle(color: Colors.white),),
              backgroundColor:  Color(0xff2D4ED1),
                iconTheme: IconThemeData(color: Colors.white),
                centerTitle:true,
            ),
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
//                  MyAppBar(title:title,isHasBackBtn:true,icon:Icons.close,),
                  widget
                ],
              ) ,
            ),
          ),
        ),
      ),
    );
  }
//办卡须知内容
  Widget _popupBody() {
    return Container(
      margin: EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            myText('1.货车司机可办理，本产品为记账卡，一车一卡，卡与车辆绑定，使用方式为“先通行，后付费”（已办理其他省份ETC卡的用户须先注销后才可继续办理）；'),
            myText('2.办理本产品，您需要准备以下材料：申请人身份证正反面照片、驾驶证正反面照片、行驶证主页正反面照片（如非本人办理，则需提供车主的姓名、身份证号码和手机号码）；'),
            myText('3.一人可办理多张卡，但同一时间仅能办理一张卡；'),
            myText('4.提交申请资料后进入人工审核环节，若审核通过，则会在3-5个工作日内将ETC卡寄送到您填写的收货地址；若审核未通过，需要您重新提交申请资料。'),
          ],
        ),
      ),
    );
  }

  Widget _popupUseDiscountBody(){
    return Container(
      margin: EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            myText('1.货车司机可办理，本产品为记账卡，一车一卡，卡与车辆绑定，使用方式为“先通行，后付费”（已办理其他省份ETC卡的用户须先注销后才可继续办理）；'),
             Image.asset('images/index_apply_img_discount.png')
          ],
        ),
      ),
    );
  }
  //用卡协议
  Widget _popupUseAgreementBody(){
    return Container(
      margin: EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            myTitleText('一、特别提示 '),
            myText2('欢迎您使用上海易路通达车联网信息科技有限公司（以下简称“易路通达”）推出的黔通记账卡产品。当您在相关页面上点击确认键之前，例如，您点击“申请办卡”或类似文字的按钮，或者实际使用易路通达提供的服务（以下简称“服务”）之前，请您事先仔细阅读本合同内容，您点击确认或实际使用服务即代表您清楚理解并同意接受本合同的全部内容。如您不同意本合同的内容，或无法准确理解本合同任何条款的含义，请不要进行确认及后续操作。如果您对本合同有疑问的，请通过易路通达的客服渠道进行询问并获得对应的解答。您同意，易路通达有权对本合同内容进行变更，并以在官方网站或移动客户端公告的方式予以公布，无需另行单独通知您。该等变更自公告载明的生效时间开始生效，并成为本合同的一部分。'),
            myText2('您同意并确认本服务合同以数据电文形式签署且本服务合同具有相对独立性，不因您的服务申请未被易路通达审核通过或记账卡未办理成功而失效，您同意易路通达及其合作方有权在前述情况下继续保留本服务合同内容、签署记录和您为申请开通本服务提供的相关信息和操作记录等，以便作为以后发生诉争时的有效证明材料。'),
            myTitleText('您需特别关注和充分理解本服务合同的各项约定，尤其是粗体字突出描述的相关内容。'),
            myTitleText('第一条 黔通个人记账卡服务合同'),
            myText2('上海易路通达车联网信息科技有限公司（以下简称“易路通达”）系贵州高速集团有限公司的合作单位，从事黔通卡代理发行、推广、运营等业务，为黔通卡用户提供高速公路通行费优化整体解决方案及服务。本合同由您和易路通达签订。'),
            myTitleText('第二条 定义'),
            myText2('(一)黔通记账卡：简称“记账卡”，系指用于贵州省及其联网的其他省份的高速公路非现金支付的专用缴费卡，并作为高速公路通行卡，用于人工收费车道（MTC 车道），特点是先消费、后缴费，一卡一车，卡与车辆绑定，可挂失、可注销。'),
            myText2('(二)黔通记账卡产品：系指易路通达为您提供的高速公路通行费优化整体解决方案和服务的产品，包括：通行费优化方案咨询、制定、实施及通行费账单查询、数据整理等一揽子服务。您向易路通达申办记账卡时，易路通达会对您进行交易评估，对符合黔通记账卡业务准入条件的，给予办卡确认，并完成办卡服务，您获得黔通记账卡后即可上路通行使用。您在收到通行费、服务费和管理费账单后，在付款日前向易路通达支付应付的通行费、服务费和管理费。'),
            myText2('(三)应收账款：系指易路通达基于向您提供高速公路通行费记账卡服务后，您需向易路通达支付的通行费、服务费和管理费等金钱债权。'),
            myText2('(四)账单日：系指易路通达向您出具的通行费及相应服务费账单的日期，具体日期以实际申请的产品性质为准。'),
            myText2('(五)还款日：系指您根据本合同及您申请的产品确定的支付记账卡通行费、服务费和管理费等款项的期限，具体日期以您申请的产品性质为准；'),
            myText2('(六)禁卡：若您未按约定时间还款, 易路通达有权立即暂停您所涉及车辆的黔通记账卡的业务及使用（操作方式包括但不限于易路通达单方面禁卡、销卡等），对于情节严重的，易路通达有权对您所涉及的车辆进行全国联网高速系统的禁卡操作，停止其全国联网高速的使用。'),
            myText2('(七)服务费：易路通达按照服务内容向您收取相应的服务费，具体金额根据产品性质确定。服务内容包括：通行费优化方案咨询、制定、实施及通行费账单查询、数据整理等与记账卡相关的一揽子服务。'),
            myText2('(八)管理费：易路通达以车辆为单位按照一定标准向您收取管理费，具体金额根据产品性质确定。'),
            myTitleText('第三条 所选记账卡产品'),
            myText2('根据您的申请，易路通达审核后确定最终的产品类型、通行费金额的消费上限、管理费金额、服务费率、还款日等，相关信息详见易路通达官方APP或者微信公众号。'),
            myTitleText('第四条 服务模式'),
            myText2('(一)根据您的实际情况，易路通达帮助您优化通行费方案。'),
            myText2('(二)您确定产品方案后，向易路通达提出办理记账卡的申请，并按照易路通达的要求提供相应的资料。'),
            myText2('(三)易路通达对您提供的资料进行审查，或通过其他合法的手段对您进行调查，最终确定是否给予您办理记账卡。'),
            myText2('(四)您可以在易路通达官方APP或者微信公众号查询通行费、服务费、管理费等数据账单。'),
            myText2('(五)您需要在还款日（以易路通达官方APP或者微信公众号为准）前将应付的通行费、服务费和管理费等款项支付给易路通达。若您未按约定时间向甲方支付相关费用，还需支付相应违约金。'),
            myTitleText('第五条 通行费、服务费和管理费等的支付'),
            myText2('(一)您应按本合同约定在还款日前全额支付通行费、服务费和管理费等款项。如您对易路通达提供的记账卡通行费账单有异议，应在收到账单后三日内向易路通达提出异议，并提供多扣费的有效证据，易路通达在收到并确认证据有效后，应于3个工作日内完成账单修订，并将最后确认的账单通知您，并在下期的账单内进行调整。由于全国高速公路刷卡消费为脱机交易，消费数据上传存在滞后，可能会导致当期记账卡消费不能及时出现在对应账单中，而会延后出现在以后的账单中，您应接受滞后的通行数据。您不能对符合国家收费标准和计重标准的通行数据提出异议。若您在收到账单后三日内未提出异议并且未提供多扣费的有效证据，则视为您对账单无异议。如果您对易路通达最后确认的账单仍有异议的，按照国家联网高速及贵州省高速的相关规定确定有效的通行费。'),
            myText2('(二)您应于还款日前将相应通行费、服务费和管理费等款项以银行转账方式直接支付给易路通达，或以易路通达与您约定的其他方式支付。'),
            myText2('(三)您必须通过自有的实名银行账户进行支付，使申办人与付款人一致，若您使用第三人支付导致易路通达无法核实该款项的，易路通达有权认为您未履行付款义务，因此产生违约金的相关责任及损失由您承担。onloadedmetadata=""'),
            myText2('(四)若您因自身原因发生错误支付，导致易路通达未按时足额收到相关款项，您应承担相应违约金。'),
            myTitleText('第六条 易路通达的权利和义务'),
            myText2('(一)除监管机关要求或法律、法规及部门规章等相关规定另有规定或有其他合理理由外，易路通达应对您提交的资料予以保密。'),
            myText2('(二)易路通达根据您的申请，有权对您进行资信调查及信用评估，对符合申请条件的您办理记账卡。'),
            myText2('(三)您可在易路通达官方APP或者微信公众号上查阅您的通行费及您所选择产品对应的服务费电子账单。'),
            myText2('(四)易路通达对您使用的记账卡所产生的通行费、服务费和管理费等款项进行管理和催收，您应给予配合。'),
            myText2('(五)若您未按约定时间支付通行费、服务费和管理费等款项的，每逾期一日，易路通达有权自逾期之日起按您应付款项总金额的千分之一计收违约金。'),
            myText2('(六)您发生未按约定时间付款时，易路通达有权通过法律手段对其进行催收，并上报中国人民银行个人/企业信用信息基础数据库，纳入征信黑名单，同时在易路通达公司网站和其他媒体公告您的欠款行为，因此发生的费用（包括但不限于催收费、诉讼费、律师费等）均由您承担。'),
            myText2('(七)若您未按时支付任何款项的，易路通达均有权采取禁卡措施。'),
            myText2('(八)易路通达有权自主决定是否调整或取消您通行费金额的消费上限。'),
            myTitleText('您的权利和义务'),
            myText2('(一)您同意按照易路通达要求提供办理记账卡业务所需资料，并保证所提供资料的真实性、准确性、完整性。'),
            myText2('(二)您应授权且同意易路通达利用第三方征信工具对您的个人信息和包括信贷信息在内的信用信息进行查询。只要您实际使用了黔通记账卡，就表明您认可并接受本合同及其附件的所有条款，受本合同及其附件所有条款的约束。'),
            myText2('(三)您有权在本合同约定的范围内正常使用黔通记账卡。'),
            myText2('(四)您应根据本合同的约定，及时向易路通达支付相关通行费、服务费及管理费等。否则，每逾期一日，您应按应付款项总金额的千分之一向易路通达支付违约金。'),
            myText2('(五)如您发生重大事件（如重大疾病、债务纠纷等）可能引起支付困难时，应立即告知易路通达，以便易路通达尽早采取补救措施。'),
            myText2('(六)如果您未能在还款日前全额支付到期通行费、服务费和管理费等，您同意易路通达暂停您已办理黔通记账卡的使用，采取包括但不限于单方面禁卡、销卡等措施进行。'),
            myTitleText('第八条 信息保护与使用'),
            myText2('(一)易路通达尊重和保护您的个人信息，并将采取一切适当的技术和组织上的措施防止您的个人信息被任何未经您合法有效授权的第三方获取或使用。'),
            myTitleText('易路通达原则上不向任何第三方透露您的个人信息，除非：'),
            myTitleText('a)您授权易路通达透露您的信息；'),
            myTitleText('b)相应的法律或司法程序要求易路通达提供您的个人信息；'),
            myTitleText('c)相关政府主管部门的要求；'),
            myTitleText('d)维护易路通达合法权益的需要；'),
            myTitleText('e)维护您合法权益的需要；'),
            myTitleText('f)维护社会公共利益的需要；'),
            myTitleText('（二）由于通过网络、手机提供和传输信息存在特定的泄密风险，您已经充分知悉并考虑到该等风险，愿意承担该等风险并申请开通本服务，通过在线方式向易路通达提供您的个人信息并授权易路通达按照本合同约定进行使用（包含对外提供），如果因网络手机传输通讯故障、计算机病毒感染、黑客攻击窃取资料等易路通达及其合作的信息共享方无法控制的不可抗力因素或其他不可归责于其的原因导致您个人隐私泄露等后果的，由您自行负责。若您提供的，与本合同履行相关的各项信息发生变更时，您还应主动告知易路通达并及时进行更新，否则由此导致相关服务不可用、使用瑕疵等，应由您自行承担。'),
            myTitleText('第九条 通行费金额消费上限的调整'),
            myText2('在本合同有效期内，您可以根据业务需求，向易路通达申请调整通行费金额的消费上限。您应按照调整后的产品性质要求执行。如您减少车辆或调低通行费金额的消费上限，则已收取的管理费不予退还；如您增加车辆或调高通行费金额的消费上限，则您应补足管理费。'),
            myTitleText('第十条 管理费的收取及续费'),
            myText2('(一)您应按照申请产品的性质要求按时缴纳管理费。'),
            myText2('(二)管理费如果采取每年缴纳一次的方式，您应在每年12月31日前根据易路通达发出的缴费通知书及时缴纳下一年的管理费，如您未按时续缴，易路通达有权采取禁卡管理措施。管理费如果分期支付，则分期的管理费均与同期通行费和服务费一起支付。'),
            myTitleText('第十一条 记账卡的使用、挂失和注销'),
            myText2('(一)您应按照记账卡的使用说明以及其他相关规定正确使用记账卡，否则易路通达有权暂停、终止您记账卡的使用。您已缴纳的管理费等不予退回。'),
            myText2('(二)记账卡使用有效期最长为三年，期满后需要办理延期，否则自动失效。'),
            myText2('(三)您在使用记账卡时，必须在高速公路收费站入口车道进行写卡（人工收费车道刷卡），方可在出口用该卡交费。'),
            myText2('(四)您有义务保证您申办的记账卡只能用于该记账卡所绑定车辆，不得用于其他非绑定车辆或其他消费。如您将记账卡用于其他车辆或其他消费造成易路通达损失的，应对易路通达损失承担赔偿责任，并向易路通达支付相当于消费金额的100%作为违约金。'),
            myText2('(五)您根据自身经营需要更换办卡车辆的，应向易路通达提交书面变更申请，易路通达收到申请后对申请进行审查并作出决定。'),
            myText2('(六)记账卡无法正常使用的，您可按易路通达的规定办理换卡。非人为因素造成卡不能正常使用需换卡的，您无需另行支付新卡工本费；因不规范使用、人为因素等原因造成卡损坏不能正常使用需换卡的，您应向易路通达支付新卡工本费（工本费30元）。'),
            myText2('(七)您遗失记账卡的，可向易路通达书面申请挂失；挂失自受理之时起48小时后生效。挂失的记账卡在挂失生效前发生的费用，由您承担。'),
            myText2('(八)如您要终止记账卡的使用，注销记账卡的，记账卡终止使用生效前所发生的通行费、服务费等相关费用由您负责支付。如您申请注销的记账卡缴纳了管理费，您已缴纳的管理费不予退还。'),
            myText2('(九)您将记账卡业务车辆转让给第三人或遗失车辆而由其他人使用记账卡产生通行费、服务费和管理费等，应由您负责支付。'),
            myTitleText('第十二条 违约事件及其后果'),
            myText2('(一)如有下列任一情形，视为您根本性违约事件：'),
            myText2('a)您提供的证件、资料虚假不属实，或您的签名不真实；'),
            myText2('b)您发生未按约定时间付款；'),
            myText2('c)您有伪造、篡改记账卡或有其他任何逃避应付消费金额的行为；'),
            myText2('d)您违反或未履行本合同第七条中约定的义务时；'),
            myText2('e)您有其他负债等情况，易路通达认为该情况可能影响您履行本合同义务时。'),
            myText2('(二)发生本合同第十二条第一款中约定的任一的违约事件时，易路通达有权采取如下一项或几项措施：'),
            myText2('a)您有上述情形之一的，易路通达有权采取禁卡管理措施，单方解除本合同并有权以法律途径追偿所有损失；'),
            myText2('b)本合同解除后，易路通达有权向您追讨您未支付费用，您应承担相应的违约责任及由此发生的费用（包括但不仅限于催收费、诉讼费、律师费等）；'),
            myText2('c)您提供的证件、资料虚假不属实，或您的盖章或签名不真实，情节严重并导致易路通达发生重大损失，易路通达有权根据具体情况提请有关机关追诉您的刑事责任；'),
            myText2('d)您发生未按约定时间付款时，每逾期一日应按照未支付金额的千分之一计收取违约金； '),
            myText2('(三)因您未按时、足额缴纳通行费、服务费和管理费等款项的，易路通达有权向易路通达所在地人民法院提起诉讼，因诉讼产生的律师费、差旅费等实现债权的费用由您承担。'),
            myText2('(四)您使用记账卡进行消费，或享受易路通达提供的记账卡服务时不可避免会受到网络覆盖、网络故障及系统优化、升级等影响，有可能造成服务中断，易路通达不承担赔偿责任。'),
            myText2('(五)合同双方应严格遵守本合同的约定，如有一方拒不履行本合同约定义务的，另外一方有权要求违约方承担违约责任。任何一方的违约行为对相对方造成的一切损失，由违约方承担。'),
            myTitleText('第十三条 法律适用、管辖及争议解决'),
            myText2('凡因本合同发生的任何争议，合同双方应通过友好协商解决；友好协商不成的，合同任意一方有权将争议提交至易路通达所在地有管辖权的法院进行诉讼解决。由此发生的费用（包括但不限于诉讼费、律师费、差旅费、公证认证费、翻译费等）均由败诉方承担。'),
          ],
        ),
      ),
    );
  }
Widget myText(text){
    return Text(text,style: TextStyle(fontSize: 18 ,));
}
  Widget myText2(text){
    return Container(
      padding: EdgeInsets.only(bottom: 5,top: 5),
      child: Text(text,style: TextStyle(fontSize: 15 ),),
    );
  }
  Widget myTitleText(text){
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(bottom: 10),
      child: Text(text,style: TextStyle(fontSize: 18),),
    );
  }
//弹框相关--end


//Main/MainQuest

  void checkToken() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var token = _prefs.getString('token');
    var params = {'token': token};

    await post('Main/MainQuest', formData: params).then((val) {
      print('dddddd：>>>>>>>>>>>>>-----------------------------------$val');
      // showToast('登录成功');
      // _prefs.setString('token',val['result']['Token']);
      // _prefs.setString('mobile',phoneController.text);
      if (val['issuccess'] == false) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return UserBaseInfoPage();
          }),
        );
      } else if (val['issuccess'] == true) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return SearchPage();
          }),
        );
      }
    });
  }
}
