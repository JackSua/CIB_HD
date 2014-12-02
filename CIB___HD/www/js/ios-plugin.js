//定义插件
$(function(){
  //
  var js2native_exception_arr = ["HomeViewPluginshowMask","HomeViewPluginunMask","HomeViewPluginalert"];
  function pageName(){
    var strUrl=location.href;
    var arrUrl=strUrl.split("/");
    var strPage=arrUrl[arrUrl.length-1];
    return strPage;
  }
  function createFrame(url){
      var iframe = document.createElement("iframe");
      iframe.src = url;
      iframe.style.display = 'none';
      document.body.appendChild(iframe);
      iframe.parentNode.removeChild(iframe);
      iframe = null;
  }
  
  
  if(!window.plugins){
    window.plugins = {};
  }
  
  if(!window.js2native){
    window.js2native = {
        exec : function(className,methodName,params){
              var arr = params;
              var arrStr = '';
              if(arr && arr.length > 0){
                  for(var tt in arr){
                      arrStr += '$';
                      arrStr += arr[tt];
                  }
                  arrStr = arrStr.substring(1);
              }
              var url="callfunction://callbackId=" + className + methodName +"Event&className="+className+"&method="+methodName + "&params=" + encodeURIComponent(arrStr);
              url += ("&currentPage=" + pageName());
              url += ("&tt=" + new Date().getTime());
//              var temp = className + methodName;
//              for(var tt in js2native_exception_arr){
//                var et = js2native_exception_arr[tt];
//                if(et == temp){
//                    url = "http://" + url;
//                    $.get(url);
//                    return;
//                }
//              }
              createFrame(url);
//              location.href = url;
          }
    };
  }
  

  
//------------------------------插件方法------------------------//
//1.InfoPlugin
function InfoPlugin() {
  
};
/**
 * 获取上下文路
 */
  InfoPlugin.prototype.getCtx = function() {
    js2native.exec("InfoPlugin", "getCtx",[]);
  };
/**
 * 获取版本号
 */
  InfoPlugin.prototype.getVersion = function() {
    js2native.exec("InfoPlugin", "getVersion",[]);
  };
  
  window.plugins.infoPlugin = new InfoPlugin();
  
  
//2.HomeViewPlugin
function HomeViewPlugin() {
};
/**
 * 是否登录
 */
  HomeViewPlugin.prototype.isLoginSuccess = function(successInfo,jsonString) {
  js2native.exec("HomeViewPlugin", "isLoginSuccess", [successInfo,jsonString]);
  };
/**
 * 显示加载中
 */
  HomeViewPlugin.prototype.showMask = function() {
  js2native.exec("HomeViewPlugin", "showMask", []);
  };
/**
 * 隐藏加载中
 */
  HomeViewPlugin.prototype.unMask = function() {
  js2native.exec("HomeViewPlugin", "unMask", []);
  };
/**
 * 弹出框1
 */
  HomeViewPlugin.prototype.showTip1 = function(title,tipContent,buttonName1,webTag) {
  js2native.exec("HomeViewPlugin", "showTip1", [title,tipContent,buttonName1,webTag]);
  };
/**
 * 弹出框2
 */
  HomeViewPlugin.prototype.showTip2 = function(title,tipContent,buttonName1,buttonName2,webTag) {
  js2native.exec( "HomeViewPlugin", "showTip2", [title,tipContent,buttonName1,buttonName2,webTag]);
  };
  
  HomeViewPlugin.prototype.loadByUrl = function(url,index) {
  js2native.exec( "HomeViewPlugin", "loadByUrl", [url,index]);
  };
  HomeViewPlugin.prototype.executeJsMethod = function(index,methodName) {
  js2native.exec( "HomeViewPlugin", "executeJsMethod", [index,methodName]);
  };
  HomeViewPlugin.prototype.alert = function(message) {
  js2native.exec( "HomeViewPlugin", "alert", [message]);
  };
  HomeViewPlugin.prototype.clickPrograma = function(index,otherUrl) {
  js2native.exec( "HomeViewPlugin", "clickPrograma", [index,otherUrl]);
  };
  
  window.plugins.homeViewPlugin = new HomeViewPlugin();
  
//3.PhotoPlugin
function PhotoPlugin() {
};
/**
 * 显示相机
 */
  PhotoPlugin.prototype.showCapture = function(type,title,photoTip) {
  js2native.exec("PhotoPlugin", "showCapture", [type,title,photoTip]);
  };
/**
 * 保存图片
 */
  PhotoPlugin.prototype.save = function(data) {
  js2native.exec("PhotoPlugin", "save", [data]);
  }
  window.plugins.photoPlugin = new PhotoPlugin();
  
  
//4.SharePlugin
function SharePlugin() {
};
/**
 * 分享插件
 *
 */
  SharePlugin.prototype.share = function(channel,jsonString) {
  js2native.exec("SharePlugin", "share", [channel,jsonString]);
  };
/**
 * 显示分享
 *
 */
  SharePlugin.prototype.show = function(data) {
  js2native.exec("SharePlugin", "show", [data]);
  };
  window.plugins.sharePlugin = new SharePlugin();
  
  //5.PickViewPlugin
  function PickViewPlugin() {
  };
/**
 * 选择器
 *
 */
  PickViewPlugin.prototype.showPickView = function(key,value,currCode) {
  js2native.exec("PickViewPlugin", "showPickView", [key,value,currCode]);
  };
  window.plugins.pickViewPlugin = new PickViewPlugin();

//6.GestureLockerPlugin
 /**
 * 手势解锁插件
 */
  function GestureLockerPlugin() {
  };

  GestureLockerPlugin.prototype.set = function(loginName,userName){
    js2native.exec("GestureLockerPlugin","set",[loginName,userName]);
  }
  GestureLockerPlugin.prototype.setLoginUser = function(userName){
    js2native.exec("GestureLockerPlugin","setLoginUser",[userName]);
  }
  GestureLockerPlugin.prototype.cancel = function(userName){
    js2native.exec("GestureLockerPlugin","cancel",[userName]);
  }
  GestureLockerPlugin.prototype.isUsing = function(){
    js2native.exec("GestureLockerPlugin","isUsing",[]);
  }
  GestureLockerPlugin.prototype.logoutUser = function(){
    js2native.exec("GestureLockerPlugin","logoutUser",[]);
  }
  GestureLockerPlugin.prototype.setLoginToken = function(userName,token){
    js2native.exec("GestureLockerPlugin","setLoginToken",[userName,token]);
  }
  window.plugins.gestureLockerPlugin = new GestureLockerPlugin();

//7.FullScreenPlugin
    /**
   * 全屏事件插件
   */
  function FullScreenPlugin(){
  
  };
  /**
   * 下拉
   */
  FullScreenPlugin.prototype.topScreen = function(){
    js2native.exec("FullScreenPlugin","topScreen",["top"]);
  }
/**
 * 上拉
 */
  FullScreenPlugin.prototype.bottomScreen = function(){
    js2native.exec("FullScreenPlugin","bottomScreen",["bottom"]);
  }
/**
 * 居中
 */
  FullScreenPlugin.prototype.middleScreen = function(){
    js2native.exec("FullScreenPlugin","middleScreen","middle");
  }
  window.plugins.fullScreenPlugin = new FullScreenPlugin();
  
//8.WebViewPlugin
  /**
   * 弹webView
   */
  function WebViewPlugin() {
  };
  /**
  * 弹出窗口
  */
  WebViewPlugin.prototype.openView = function(url,width,height){
    js2native.exec("WebViewPlugin","openView",[url,width,height]);
  }
  WebViewPlugin.prototype.closeView = function(){
    js2native.exec("WebViewPlugin","closeView",[]);
  }
  
  window.plugins.webViewPlugin = new WebViewPlugin();

  //密码控件
  function PasswordPlugin(){
  };
  PasswordPlugin.prototype.showPasswordPT = function(pkid,title,cancel,sure){
    js2native.exec("PasswordPlugin","showPassword",[pkid,title,cancel,sure]);
  }
  PasswordPlugin.prototype.showPaymentPwd = function(title,cancel,sure,pkid,money,message){
    js2native.exec("PasswordPlugin","showPassword",[title,cancel,sure,pkid,money,message]);
  }
  
  window.plugins.passwordPlugin = new PasswordPlugin();
  
  //时间控件
  function DatePlugin(){
  };
  DatePlugin.prototype.getDate = function(tt){
    js2native.exec("DatePlugin","getDate",[tt]);
  }
  window.plugins.datePlugin = new DatePlugin();
  
  //数字控件
  function NumberKeyBoard(){
  };
  NumberKeyBoard.prototype.getNumStr = function(){
  js2native.exec("NumberKeyBoard","getNumber",[]);
  }
  window.plugins.numberKeyBoard = new NumberKeyBoard();
  
  
  })
