/*
 * @作者: 顾明次
 * @Date: 2025-09-18 14:56:23
 * @Email: gu271901088@gmail.com
 * @描述: 基础API
 */

 class BaseApi {
  String? baseUrl; // 基础URL
  String? apiVersion; // API版本 
  String? apiKey; // API密钥
  String? apiSecret; // API密钥
  String? apiToken; // API令牌
  String? apiRefreshToken; // API刷新令牌
  String? apiAccessToken; // API访问令牌
  String? apiRefreshAccessToken; // API刷新访问令牌
  String? apiAccessTokenExpireTime; // API访问令牌过期时间
  String? apiRefreshAccessTokenExpireTime; // API刷新访问令牌过期时间
  
  static BaseApi? _instance;
  static BaseApi get instance => _instance ??= BaseApi();

  BaseApi({
    this.baseUrl,
    this.apiVersion,
    this.apiKey,
    this.apiSecret,
    this.apiToken,
    this.apiRefreshToken,
    this.apiAccessToken,
    this.apiRefreshAccessToken,
    this.apiAccessTokenExpireTime,
    this.apiRefreshAccessTokenExpireTime,
  });

  factory BaseApi.fromJson(Map<String, dynamic> json) {
    return BaseApi(
      baseUrl: json['baseUrl'],
      apiVersion: json['apiVersion'],
      apiKey: json['apiKey'],
      apiSecret: json['apiSecret'],
      apiToken: json['apiToken'],
      apiRefreshToken: json['apiRefreshToken'],
      apiAccessToken: json['apiAccessToken'],
      apiRefreshAccessToken: json['apiRefreshAccessToken'],
      apiAccessTokenExpireTime: json['apiAccessTokenExpireTime'],
      apiRefreshAccessTokenExpireTime: json['apiRefreshAccessTokenExpireTime'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'baseUrl': baseUrl,
      'apiVersion': apiVersion,
      'apiKey': apiKey,
      'apiSecret': apiSecret,
      'apiToken': apiToken,
      'apiRefreshToken': apiRefreshToken,
      'apiAccessToken': apiAccessToken,
      'apiRefreshAccessToken': apiRefreshAccessToken,
      'apiAccessTokenExpireTime': apiAccessTokenExpireTime,
      'apiRefreshAccessTokenExpireTime': apiRefreshAccessTokenExpireTime,
    };
  }
}