import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'dart:math';

class OssUtil {
  //验证文本域
  static String _policyText =
      '{"expiration": "2069-05-22T03:15:00.000Z","conditions": [["content-length-range", 0, 1048576000]]}';

  //进行utf8编码
  // ignore: non_constant_identifier_names
  static List _policyText_utf8 = utf8.encode(_policyText);
  //进行base64编码
  static String policy= base64.encode(_policyText_utf8);

  //再次进行utf8编码
  // ignore: non_constant_identifier_names
  static List _policy_utf8 = utf8.encode(policy);

  // 工厂模式
  factory OssUtil() => _getInstance();

  static OssUtil get instance => _getInstance();
  static OssUtil _instance;

  OssUtil._internal();

  static OssUtil _getInstance() {
    if (_instance == null) {
      _instance = new OssUtil._internal();
    }
    return _instance;
  }

  /*
  *获取signature签名参数
  */
  String getSignature(String _accessKeySecret){
    //进行utf8 编码
    // ignore: non_constant_identifier_names
    List AccessKeySecretUtf8 = utf8.encode(_accessKeySecret);
    //通过hmac,使用sha1进行加密
    List signaturePre = new Hmac(sha1, AccessKeySecretUtf8).convert(_policy_utf8).bytes;
    //最后一步，将上述所得进行base64 编码
    String signature = base64.encode(signaturePre);
    return signature;
  }

  // ignore: slash_for_doc_comments
  /**
   * 生成上传上传图片的名称 ,获得的格式:photo/20171027175940_oCiobK
   * 可以定义上传的路径uploadPath(Oss中保存文件夹的名称)
   * @param uploadPath 上传的路径 如：/photo
   * @return photo/20171027175940_oCiobK
   */
  String getImageUploadName(String uploadPath,String filePath) {
    String imageMame = "";
    var timestamp = new DateTime.now().millisecondsSinceEpoch;
    imageMame =timestamp.toString()+"_"+getRandom(6);
    if(uploadPath!=null&&uploadPath.isNotEmpty){
      imageMame=uploadPath+"/"+imageMame;
    }
    String imageType=filePath?.substring(filePath?.lastIndexOf("."),filePath?.length);
    return imageMame+imageType;
  }

  String getImageName(String filePath) {
    String imageMame = "";
    var timestamp = new DateTime.now().millisecondsSinceEpoch;
    imageMame =timestamp.toString()+"_"+getRandom(6);
    String imageType=filePath?.substring(filePath?.lastIndexOf("."),filePath?.length);
    return imageMame+imageType;
  }

  /*
  * 生成固定长度的随机字符串
  * */
  String getRandom(int num) {
    String alphabet = 'qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM';
    String left = '';
    for (var i = 0; i < num; i++) {
//    right = right + (min + (Random().nextInt(max - min))).toString();
      left = left + alphabet[Random().nextInt(alphabet.length)];
    }
    return left;
  }

  /*
  * 根据图片本地路径获取图片名称
  * */
  String getImageNameByPath(String filePath) {
    // ignore: null_aware_before_operator
    return filePath?.substring(filePath?.lastIndexOf("/")+1,filePath?.length);
  }
}