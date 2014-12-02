/**
 * Contains:
 * PwdIntensity,
 * JqGrid,
 * Form Validation,
 * DatePicker
 */
;(function($){
	
/**
*密码强弱国际化
**/
$.checkIntensity = {
	regional: {
		lower:'低',
		midder:'中',
		high:'高'
	} 	
};
/**
 * jqGrid Chinese Translation for v3.6
 * waiting 2010.01.18
 * http://waiting.javaeye.com/
 * Dual licensed under the MIT and GPL licenses:
 * http://www.opensource.org/licenses/mit-license.php
 * http://www.gnu.org/licenses/gpl.html
 * 
 * update 2010.05.04
 *		add double u3000 SPACE for search:odata to fix SEARCH box display err when narrow width from only use of eq/ne/cn/in/lt/gt operator under IE6/7
**/


$.jgrid = {
	defaults : {
		recordtext: "{0} - {1}\u3000共 {2} 条",	// 共字前是全角空格
		emptyrecords: "无数据显示",
		loadtext: "读取中...",
		pgtext : " {0} 共 {1} 页",
		first:"首页",
		prev:"上一页",
		next:"下一页",
		last:"末页"
	},
	search : {
		caption: "搜索...",
		Find: "查找",
		Reset: "重置",
		odata : ['等于\u3000\u3000', '不等\u3000\u3000', '小于\u3000\u3000', '小于等于','大于\u3000\u3000','大于等于', 
			'开始于','不开始于','属于\u3000\u3000','不属于','结束于','不结束于','包含\u3000\u3000','不包含'],
		groupOps: [	{ op: "AND", text: "所有" },	{ op: "OR",  text: "任一" }	],
		matchText: " 匹配",
		rulesText: " 规则"
	},
	edit : {
		addCaption: "添加记录",
		editCaption: "编辑记录",
		bSubmit: "提交",
		bCancel: "取消",
		bClose: "关闭",
		saveData: "数据已改变，是否保存？",
		bYes : "是",
		bNo : "否",
		bExit : "取消",
		msg: {
			required:"此字段必需",
			number:"请输入有效数字",
			minValue:"输值必须大于等于 ",
			maxValue:"输值必须小于等于 ",
			email: "这不是有效的e-mail地址",
			integer: "请输入有效整数",
			date: "请输入有效时间",
			url: "无效网址。前缀必须为 ('http://' 或 'https://')",
			nodefined : " 未定义！",
			novalue : " 需要返回值！",
			customarray : "自定义函数需要返回数组！",
			customfcheck : "Custom function should be present in case of custom checking!"
			
		}
	},
	view : {
		caption: "查看记录",
		bClose: "关闭"
	},
	del : {
		caption: "删除",
		msg: "删除所选记录？",
		bSubmit: "删除",
		bCancel: "取消"
	},
	nav : {
		edittext: "",
		edittitle: "编辑所选记录",
		addtext:"",
		addtitle: "添加新记录",
		deltext: "",
		deltitle: "删除所选记录",
		searchtext: "",
		searchtitle: "查找",
		refreshtext: "",
		refreshtitle: "刷新表格",
		alertcap: "注意",
		alerttext: "请选择记录",
		viewtext: "",
		viewtitle: "查看所选记录"
	},
	col : {
		caption: "选择列",
		bSubmit: "确定",
		bCancel: "取消"
	},
	errors : {
		errcap : "错误",
		nourl : "没有设置url",
		norecords: "没有要处理的记录",
		model : "colNames 和 colModel 长度不等！"
	},
	formatter : {
		integer : {thousandsSeparator: " ", defaultValue: '0'},
		number : {decimalSeparator:".", thousandsSeparator: " ", decimalPlaces: 2, defaultValue: '0.00'},
		currency : {decimalSeparator:".", thousandsSeparator: " ", decimalPlaces: 2, prefix: "", suffix:"", defaultValue: '0.00'},
		date : {
			dayNames:   [
				"Sun", "Mon", "Tue", "Wed", "Thr", "Fri", "Sat",
		         "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"
			],
			monthNames: [
				"Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec",
				"January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"
			],
			AmPm : ["am","pm","AM","PM"],
			S: function (j) {return j < 11 || j > 13 ? ['st', 'nd', 'rd', 'th'][Math.min((j - 1) % 10, 3)] : 'th'},
			srcformat: 'Y-m-d',
			newformat: 'm-d-Y',
			masks : {
				ISO8601Long:"Y-m-d H:i:s",
				ISO8601Short:"Y-m-d",
				ShortDate: "Y/j/n",
				LongDate: "l, F d, Y",
				FullDateTime: "l, F d, Y g:i:s A",
				MonthDay: "F d",
				ShortTime: "g:i A",
				LongTime: "g:i:s A",
				SortableDateTime: "Y-m-d\\TH:i:s",
				UniversalSortableDateTime: "Y-m-d H:i:sO",
				YearMonth: "F, Y"
			},
			reformatAfterEdit : false
		},
		baseLinkUrl: '',
		showAction: '',
		target: '',
		checkbox : {disabled:true},
		idName : 'id'
	}
};
})(jQuery);


;(function($){
    $.fn.validationEngineLanguage = function(){
    };
    $.validationEngineLanguage = {
        newLang: function(){
            //Some regular expressions were append "|^$", to avoid different error messages popup in the same time. FuYM
            $.validationEngineLanguage.allRules = {
                "required": { // Add your regex rules here, you can take telephone as an example
                    "regex": "none",
                    "alertText": "不能为空",
                    "alertTextCheckboxMultiple": "请选择一个项目",
                    "alertTextCheckboxe": "您必需勾选此栏位",
                    "alertTextDateRange": "日期范不能为空"
                },
                "dateRange": {
                    "regex": "none",
                    "alertText": "无效的 ",
                    "alertText2": " 日期范围"
                },
                "dateTimeRange": {
                    "regex": "none",
                    "alertText": "无效的 ",
                    "alertText2": " 时间范围"
                },
                "minSize": {
                    "regex": "none",
                    "alertText": "最少 ",
                    "alertText2": " 个字符"
                },
                "maxSize": {
                    "regex": "none",
                    "alertText": "最多 ",
                    "alertText2": " 个字符"
                },
				"groupRequired": {
                    "regex": "none",
                    "alertText": "您必需选填其中一个栏位"
                },
                "min": {
                    "regex": "none",
                    "alertText": "最小值为 "
                },
                "max": {
                    "regex": "none",
                    "alertText": "最大值为 "
                },
                "past": {
                    "regex": "none",
                    "alertText": "日期必需早于 "
                },
                "future": {
                    "regex": "none",
                    "alertText": "日期必需晚于 "
                },	
                "maxCheckbox": {
                    "regex": "none",
                    "alertText": "最多选取 ",
                    "alertText2": " 个项目"
                },
                "minCheckbox": {
                    "regex": "none",
                    "alertText": "请选取 ",
                    "alertText2": " 个项目"
                },
                "equals": {
                    "regex": "none",
                    "alertText": "栏位內容不相符"
                },
                "phone": {
                    // credit: jquery.h5validate.js / orefalo
                    "regex": /^\d{3,4}-\d{7,8}(-\d{1,})?$/,       /** /^([\+][0-9]{1,3}[ \.\-])?([\(]{1}[0-9]{2,6}[\)])?([0-9 \.\-\/]{3,20})((x|ext|extension)[ ]?[0-9]{1,4})?$|^$/,**/
                    "alertText": "无效的电话号码,格式应为:区号-固话号码-分机号"
                },
                "email": {
                    // Shamelessly lifted from Scott Gonzalez via the Bassistance Validation plugin http://projects.scottsplayground.com/email_address_validation/
                    //"regex": /^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?$|^$/i,
					"regex":/^(\w)+(\.\w+)*@(\w)+((\.\w{2,3}){1,3})$|^$/,
                    "alertText": "email 地址不合法"
                },
                "integer": {
                    "regex": /^\d+$/,
                    "alertText": "只能输入整数"
                },
                "number": {
                    // Number, including positive, negative, and floating decimal. credit: orefalo
                    "regex": /^[\-\+]?(([0-9]+)([\.,]([0-9]+))?|([\.,]([0-9]+))?)$/,
                    "alertText": "无效的數字"
                },
                "date": {
                    "regex": /^\d{4}[\/\-](0?[1-9]|1[012])[\/\-](0?[1-9]|[12][0-9]|3[01])$|^$/,
                    "alertText": "无效的日期，格式必需为 YYYY-MM-DD"
                },
                "ipv4": {
                    "regex": /^((([01]?[0-9]{1,2})|(2[0-4][0-9])|(25[0-5]))[.]){3}(([0-1]?[0-9]{1,2})|(2[0-4][0-9])|(25[0-5]))$/,
                    "alertText": "无效的 IP 位址"
                },
                "url": {
                    "regex": /^(https?|ftp):\/\/(((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:)*@)?(((\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5]))|((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?)(:\d*)?)(\/((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)+(\/(([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)*)*)?)?(\?((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)|[\uE000-\uF8FF]|\/|\?)*)?(\#((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)|\/|\?)*)?$/i,
                    "alertText": "非法的 URL"
                },
                "onlyNumberSp": {
                    "regex": /^[0-9\ ]+$|^$/,
                    "alertText": "只能填數字"
                },
                "onlyLetterSp": {
                    "regex": /^[a-zA-Z\ \']+$|^$/,
                    "alertText": "只接受英文字母大小寫"
                },
                "onlyLetterNumber": {
                    "regex": /^[0-9a-zA-Z]+$|^$/,
                    "alertText": "不接受特殊字元"
                },
				"identity":{
					"regex":/^\d{15}$|^\d{17}([0-9]|X|x)$/,
					"alertText":"无效的身份证号码"
				},
				"mobile":{
					"regex":/1[0-9]{10}/,
					"alertText":"无效的手机号码"
				},
				"name":{
					"regex":/^[()（）a-zA-Z\u4e00-\u9fa5\u00b7]+$/,
					"alertText":"姓名是字母、汉字的组合"
				},
				"account":{
					"regex":/^[a-zA-Z][a-zA-Z0-9]{5,11}$/,
					"alertText":"第一位必须为字母，数字或字母组合，长度6-12位"
				},
                // --- CUSTOM RULES -- Those are specific to the demos, they can be removed or changed to your likings
                "ajaxUserCall": {
                    "url": "ajaxValidateFieldUser",
                    // you may want to pass extra data on the ajax call
                    "extraData": "name=eric",
                    "alertText": "此名称已经被其他人使用",
                    "alertTextLoad": "正在确认名称是否有其他人使用，请稍等。"
                },
				"ajaxUserCallPhp": {
                    "url": "phpajax/ajaxValidateFieldUser.php",
                    // you may want to pass extra data on the ajax call
                    "extraData": "name=eric",
                    // if you provide an "alertTextOk", it will show as a green prompt when the field validates
                    "alertTextOk": "此账号名称可以使用",
                    "alertText": "此账号名称已经被其他人使用",
                    "alertTextLoad": "正在确认账号名称是否有其他人使用，请稍等。"
                },
                "ajaxLoginNameCall": {
                    // remote json service location
                    "url": "regist!loginNameValidate.do",
                    // error
                    "alertText": "此用户名已被使用",
                    // if you provide an "alertTextOk", it will show as a green prompt when the field validates
                    "alertTextOk": "此用户名可以使用",
                    // speaks by itself
                    "alertTextLoad": "正在确认此用户名是否可以使用，请稍等。"
                },
				 "ajaxNameCallPhp": {
	                    // remote json service location
	                    "url": "phpajax/ajaxValidateFieldName.php",
	                    // error
	                    "alertText": "此名称已经被其他人使用",
	                    // speaks by itself
	                    "alertTextLoad": "正在确认名称是否有其他人使用，请稍等。"
	                },
                "validate2fields": {
                    "alertText": "请输入 HELLO"
                },
	            //tls warning:homegrown not fielded 
                "dateFormat":{
                    "regex": /^\d{4}[\/\-](0?[1-9]|1[012])[\/\-](0?[1-9]|[12][0-9]|3[01])$|^(?:(?:(?:0?[13578]|1[02])(\/|-)31)|(?:(?:0?[1,3-9]|1[0-2])(\/|-)(?:29|30)))(\/|-)(?:[1-9]\d\d\d|\d[1-9]\d\d|\d\d[1-9]\d|\d\d\d[1-9])$|^(?:(?:0?[1-9]|1[0-2])(\/|-)(?:0?[1-9]|1\d|2[0-8]))(\/|-)(?:[1-9]\d\d\d|\d[1-9]\d\d|\d\d[1-9]\d|\d\d\d[1-9])$|^(0?2(\/|-)29)(\/|-)(?:(?:0[48]00|[13579][26]00|[2468][048]00)|(?:\d\d)?(?:0[48]|[2468][048]|[13579][26]))$/,
                    "alertText": "无效的日期格式"
                },
                //tls warning:homegrown not fielded 
				"dateTimeFormat": {
	                "regex": /^\d{4}[\/\-](0?[1-9]|1[012])[\/\-](0?[1-9]|[12][0-9]|3[01])\s+(1[012]|0?[1-9]){1}:(0?[1-5]|[0-6][0-9]){1}:(0?[0-6]|[0-6][0-9]){1}\s+(am|pm|AM|PM){1}$|^(?:(?:(?:0?[13578]|1[02])(\/|-)31)|(?:(?:0?[1,3-9]|1[0-2])(\/|-)(?:29|30)))(\/|-)(?:[1-9]\d\d\d|\d[1-9]\d\d|\d\d[1-9]\d|\d\d\d[1-9])$|^((1[012]|0?[1-9]){1}\/(0?[1-9]|[12][0-9]|3[01]){1}\/\d{2,4}\s+(1[012]|0?[1-9]){1}:(0?[1-5]|[0-6][0-9]){1}:(0?[0-6]|[0-6][0-9]){1}\s+(am|pm|AM|PM){1})$/,
                    "alertText": "无效的日期或时间格式",
                    "alertText2": "可接受的格式: ",
                    "alertText3": "mm/dd/yyyy hh:mm:ss AM|PM 或 ", 
                    "alertText4": "yyyy-mm-dd hh:mm:ss AM|PM"
	            },
                //Rules below here were defined by ourself, FuYM
                "lengthRange":{
                    "regex":"none",
                    "alertText":"长度为 ",
                    "alertText2":" 到 ",
                    "alertText3": " 个字符"
                },
                "codeLength":{
                    "regex":"none",
                    "alertText":"长度必需",
                    "alertText2": " 个字符"
                },
                "cardNo":{
                    "regex":/^[0-9]+$/,
                    "alertText":"账号只能输入数字"
                },
                "onlyNumber":{
                    "regex":/(^[0-9]+$)|^$/,
                    "alertText":"只能输入数字"
                },
                "onlyLetter":{
                    "regex":/(^[a-zA-Z]+$)|^$/,
                    "alertText":"只能输入字母"
                },
                "numOrletter":{
                    "regex":/(^[a-zA-Z0-9]+$)|^$/,
                    "alertText":"只能输入数字或字母"
                },
                "numAndLetter":{
                      "regex":/(^(([a-zA-Z]+[0-9]+)|([0-9]+[a-zA-Z]+))[a-zA-Z0-9]*$)|^$/,
                      "alertText":"必须为数字和字母的组合"
                },
                "number2":{
                        "regex":/(^(([1-9]+[0-9]*(\.\d{1,2})?)|0|(0\.\d{1,2}))$)|^$/,
                        "alertText":"只能输入数字，可带两位小数"
                },
                "keyboard":{
                    "regex":"none",
                    "alertText":"不能为空",
                    "alertText2":"长度应为",
                    "alertText3": " 个字符"
                },
                "cardMonth":{
                    "regex":"none",
                    "alertText1":"不能为空",
                    "alertText2":"只能是2位数字",
                    "alertText3":"月份输入不合法"
                },
                "numOrLetterOrUnderline":{
                    "regex":/(^[a-zA-Z0-9\_]+$)|^$/,
                    "alertText":"只能输入数字或字母或下划线"
                },
			    "numOrLetterOrUnderlineOrcn":{
                     "regex": /^[a-zA-Z0-9_\u4e00-\u9fa5]{0,13}$/,
                     "alertText": "请输入数字字母中文或者下划线"
			    },
                //Same as "equals", used in last version
                "confirm":{
                   "regex":"none",
                   "alertText":"两次输入不一致"
                },
                "moneyCompare":{
                    "regex":"none",
                   "alertText":"输入值不能低于最低值"
                },
				"moneyBetween":{
					"regex":"none",
                   "alertText":"输入值超出了范围"
				},
				"mobilePhone": {
					"regex":/1[0-9]{10}/,
					 "alertText": "手机号码格式不正确"
				},
				"idCard":{
					"regex":/(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/,
					   "alertText": "请检查您的身份证号码是否正确"
				},
				"numOrLetterOrcn":{
					 "regex": /^[a-zA-Z0-9\u4e00-\u9fa5]+$/,
					   "alertText":  "请输入数字字母或中文"
				},
				"letterOrcn":{
					 "regex": /^[a-zA-Z\u4e00-\u9fa5]+$/,
					   "alertText":  "请输入字母或中文"
				},
				"yyptFinPwd":{
					"regex":/(^[0-9]{6}$)/,
					"alertText":"只能输入6位数字"
				},
				"yyptLoginPwd":{
					"regex":/(^[a-zA-Z0-9]{6,12}$)/,
					"alertText":"只能输入6到12位数字货字母"
				}
            };
            
        }
    };
    $.validationEngineLanguage.newLang();
})(jQuery);
