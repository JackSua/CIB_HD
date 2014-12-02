/*
 * the yypt-mobile ui plugins
 * Author: wizard
 * Dual licensed under the YYPT licenses.
 * Date: 2014-02-14 09:37
 * Revision: 1.0.0
 */
;(function($){

	/*
	 * Switch Plugins
	 */
	$.fn.initSwitch = function() {
		return this.each(function(i,obj){
			var id = (this.name||this.id)+'__uiSwitch'+i||'__uiSwitch'+i;
			id = id.chartReplace();
			if(obj.style.display != 'none' && $(this).parents()[0].id.indexOf('__uiSwitch')<0){
				var $input = $(this);
				var widgetStyle = $input.attr("style");
				if(undefined==widgetStyle){
					widgetStyle="";
				}
				var $switch = $('<div id="'+id+'" class="ui-switch" style='+widgetStyle+'></div>');
				var $switch_button = $('<div class="ui-switch-button"></div>');
				$switch.append($switch_button);
				$input.before($switch).appendTo($switch);
				if($input.attr("checked")) {
					$switch.addClass("open");
				}
				$switch.bind("click",function(){
					if(!$input.prop("disabled")){
						eval($input.attr("onclick"));
						if($input.attr("checked")=='true'||$input.attr("checked")=='checked') {
							$input.removeAttr("checked");
							$switch.removeClass("open");
						}else{
							$input.attr("checked","true");
							$switch.addClass("open");
						}
					}
				});
				$input.hide();
			}
		});
	}

	/*
	 * Tick Plugins
	 */
	$.fn.initTick = function() {
		return this.each(function(i,obj){
			var id = (this.name||this.id)+'__uiTick'+i||'__uiTick'+i;
			id = id.chartReplace();
			if(obj.style.display != 'none' && $(this).parents()[0].id.indexOf('__uiTick')<0){
				var $input = $(this);
				var widgetStyle = $input.attr("style");
				if(undefined==widgetStyle){
					widgetStyle="";
				}
				var contentValue = $(this).val();
				var $tick = $('<div id="'+id+'" class="ui-tick" style='+widgetStyle+'></div>');
				var $tick_content = $('<div class="content">'+$(this).attr("alt")+'</div>');
				var $tick_button = $('<div class="ui-tick-button"><img src="../../resources/images/tick.png"/></div>');
				$tick.append($tick_content);
				$tick.append($tick_button);
				$input.before($tick).appendTo($tick);
				if(!$input.attr("checked")) {
					$tick.addClass("close");
				}
				$tick.bind("click",function(){
					if(!$input.prop("disabled")){
						if(!$input.attr("checked")) {
							$input.attr("checked","true");
							$tick.removeClass("close");
						}else{
							$input.removeAttr("checked");
							$tick.addClass("close");
						}
						eval($input.attr("onclick"));
					}
				});
				$input.hide();
			}
		});
	}

	/*
	 * TickRadio Plugins
	 */
	$.fn.initTickRadio = function() {
		return this.each(function(i,obj){
			var id = (this.id)+'__uiTickRadio';
			id = id.chartReplace();
			if(obj.style.display != 'none' && $(this).parents()[0].id.indexOf('__uiTickRadio')<0){
				var $input = $(this);
				var widgetStyle = $input.attr("style");
				if(undefined==widgetStyle){
					widgetStyle="";
				}
				var contentName = this.name;
				var $tick = $('<div id="'+id+'" class="ui-tick" style='+widgetStyle+'></div>');
				var $tick_content = $('<div class="content">'+$(this).attr("alt")+'</div>');
				var $tick_button = $('<div class="ui-tick-button"><img src="../../resources/images/tick.png"/></div>');
				$tick.append($tick_content);
				$tick.append($tick_button);
				$input.before($tick).appendTo($tick);
				if(!$input.attr("checked")) {
					$tick.addClass("close");
				}
				$tick.bind("click",function(){
					if(!$input.prop("disabled")){
						if(!$input.attr("checked")) {
							/*所有的input置为没有选中*/
							$("input[type='radio']").each(function(ids,objects){
										var tem_name = objects.name;
										if(tem_name == contentName){
											var obids = objects.id;
											$(objects).removeAttr("checked")
											$("div#"+obids+'__uiTickRadio').addClass("close");
										}
									}
							)
							$input.attr("checked","true");
							$tick.removeClass("close");
						}else{
							$input.removeAttr("checked");
							$tick.addClass("close");
						}
						eval($input.attr("onclick"));
					}
				});
				$input.hide();
			}
		});
	}

	/*
	 * Visible Password
	 */

	$.fn.visiblePwd = function(){
		return this.each(function(i,obj){
			var id = (this.name||this.id)+'__uiVisiblePwd'+i||'__uiVisiblePwd'+i;
			id = id.chartReplace();
			var $inp = $(this);
			if ($inp.next(".visibleIcon").size()==0){
				var $icon = $('<a id="'+id+'" href="javascript:void(0)" class="visibleIcon" style="position: absolute;"></a>');
				if ($inp.parents(".inp-group").size()>0){
					$inp.after($icon);
					$inp.parent("p").css("position","relative");
					$icon.css("right",10);
//					$icon.css("top",$inp.parent("p").height()/2-7);
					$icon.css("top",1);
					$icon.click(function(){
						if ($inp.attr("type")=="password"){
							$icon.addClass("visible");
							$inp.attr("type","text");
						}else if ($inp.attr("type")=="text"){
							$icon.removeClass("visible");
							$inp.attr("type","password");
						}
					})
				}
			}
		});
	}

	/**
	 *  delete text
	 */
	$.fn.deleteText = function(){
		return this.each(function(i,obj){
			var id = (this.name||this.id)+'_uiDeleteText'+i||'_uiDeleteText'+i;
			id = id.replace();
			var $inp = $(this);
			if ($inp.next(".deleteIcon").size()==0){
				var $icon = $('<a id="'+id+'" href="javascript:void(0)" class="deleteIcon" style="position: absolute;display:none;"></a>');
				if ($inp.parents(".inp-group").size()>0){
					$inp.after($icon);
					$inp.parent("p").css("position","relative");
					$icon.css("right",10);
					$icon.css("top",1);
					$icon.click(function(){
						$inp.val("");
						$("#"+id).hide();
					})
				}
			}
			if($(obj).val() != ""){
				$("#"+id).show();
			}
			$(obj).bind('input propertychange', function() {
				if($(obj).val() != ""){
					$("#"+id).show();
				} else{
					$("#"+id).hide();
				}
			})
		})
	}
	/*
	 * Checkbox
	 */
	$.fn.checkbox = function() {
		return this.each(function(i,obj){
			var id = (this.name||this.id)+'__Checkbox'+i||'__Checkbox'+i;
			id = id.chartReplace();
			if(obj.style.display != 'none' && $(this).parents()[0].id.indexOf('__Checkbox')<0){
				var $inp = $(this);
				var checkboxStyle = $inp.attr("style");
				if(undefined==checkboxStyle){
					checkboxStyle="";
				}
				var chk_bg = $('<div id="'+id+'" class="chk-bg" style="'+checkboxStyle+'"></div>');
				$inp.before(chk_bg).appendTo(chk_bg);
				var $widget = $("#"+id);
				$widget.bind("click",function(){
					if(!$inp.prop("disabled")){
						if($inp.attr("type")=="checkbox"){
							if($inp.attr("checked")) {
								$inp.removeAttr("checked");
								$widget.removeClass("chk-bg-checked");
							}else{
								$widget.addClass("chk-bg-checked");
								$inp.attr("checked",'true');
							}
						}else if($inp.attr("type")=="radio"){
							$("[name="+$inp.attr("name")+"]").removeAttr("checked");
							$("[name="+$inp.attr("name")+"]").parents(".chk-bg").removeClass("chk-bg-checked");
							$widget.addClass("chk-bg-checked");
							$inp.attr("checked",'true');
						}
						eval($inp.attr("onclick"));
					}
				});
				if($inp.attr("checked")) {
					$widget.addClass("chk-bg-checked");
				}else{
					$widget.removeClass("chk-bg-checked");
				}
				$inp.hide();
			}
		});
	};

	/*
	 * 转账控件
	 */
	$.nswitchacct = $.nswitchacct || {};
	$.extend($.nswitchacct,{
		b2a:function(src,animate)
		{
			if(animate)
			{
				$("#"+src.p.id+" .first").animate({translateY: '139px'}, 200, 'ease');
				$("#"+src.p.id+" .sec").animate({translateY: '-139px'}, 200, 'ease');
			}else
			{
				$("#"+src.p.id+" .first").css({'-webkit-transform': 'translateY(139px)'});
				$("#"+src.p.id+" .sec").css({'-webkit-transform': 'translateY(-139px)'});
			}

			$("#"+src.p.id+" .sec .type-text").html("转出账户");
			$("#"+src.p.id+" .first .type-text").html("转入账户");
			$("#"+src.p.id+" .sec .balance-text").html("可转");
			$("#"+src.p.id+" .first .balance-text").html("余额");
		},
		a2b:function(src,animate)
		{
			if(animate)
			{
				$("#"+src.p.id+" .first").animate({ translateY: '0px'}, 200, 'ease');
				$("#"+src.p.id+" .sec").animate({ translateY: '0px'}, 200, 'ease');
			}else
			{
				$("#"+src.p.id+" .first").css({'-webkit-transform': 'translateY(0px)'});
				$("#"+src.p.id+" .sec").css({'-webkit-transform': 'translateY(-0px)'});
			}
			$("#"+src.p.id+" .first .type-text").html("转出账户");
			$("#"+src.p.id+" .sec .type-text").html("转入账户");
			$("#"+src.p.id+" .first .balance-text").html("可转");
			$("#"+src.p.id+" .sec .balance-text").html("余额");
		}
	} );
	$.fn.nswitchacct = function(pin) {

		return this.each(function() {

			if(this.nswitchacct){
				$("#"+this.p.id).unbind("click");
				$("#"+this.p.id).remove();
			}
			var p = $.extend(true,{
				a2b :"a2b",
				b2a :"b2a",
				abalance:"",
				bbalance:"",
				onchange:null,
				onclick:null,
				a:"",
				b:"",
				atext:"银行账户",
				btext:"理财账户",
				id:"",
				disabled:false
			}, pin || {});
			this.nswitchacct=true;
			var $this=$(this);
			p.id="nsa_"+$this.attr("id");
			this.p=p;
			var that=this;
			if(p.tmpl==null)
			{
				p.tmpl='';
				p.tmpl+='<div id="{{id}}" class="acctSwitch">';
				p.tmpl+='<div class="prod-block first">';
				p.tmpl+='<p><span class="type-text">转出帐户</span><span class="right">{{a}}</span></p>';
				p.tmpl+='<p><span>'+p.atext+'：</span><span class="right"><span class="balance-text">可转</span><span class="highlight">'+ $("#"+p.abalance).val()+'</span>元</span></p>';
				p.tmpl+='</div>';
				p.tmpl+='<div class="btn"><canvas class="icon"></canvas></div>';
				p.tmpl+='<div class="prod-block sec">';
				p.tmpl+='<p><span class="type-text">转入帐户</span><span class="right">{{b}}</span></p>';
				p.tmpl+='<p><span>'+p.btext+'：</span><span class="right"><span class="balance-text">余额</span><span class="highlight">'+ $("#"+p.bbalance).val()+'</span>元</span></p>';
				p.tmpl+='</div>';
				p.tmpl+='</div>';
//				p.tmpl+='<div id="{{id}}" class="acctSwitch notap">';
//				p.tmpl+='<div class="btn"><canvas class="icon"></canvas></div>';
//				p.tmpl+='<div class="texta">转出账户：</div>';
//				p.tmpl+='<div class="textb">转入账户：</div>';
//				p.tmpl+='<div class="acct first" >'+p.atext+'{{a}}</div>';
//				p.tmpl+='<div class="acct sec" >'+p.btext+'{{b}}</div>';
//				p.tmpl+='</div>';
			}


			var toggleSwitch=function(src)
			{
				$src=$(src);
				if($src.val()!=p.b2a)
				{
					$.nswitchacct.b2a(src,true);
					$src.val(p.b2a);
				}
				else
				{
					$.nswitchacct.a2b(src,true);
					$src.val(p.a2b);
				}
				$src.trigger('change', src);
			}

			var output=Mustache.render(p.tmpl, p);
			var sw=$(output);

			$this.after(sw);
			if(p.b2a==$this.val())
			{
				$.nswitchacct.b2a(that,false);
			}
			sw.on("click",".btn",function()
			{
				if(p.disabled == false){
					$.proxy(toggleSwitch,sw)(that);
					$this.trigger('click', that);
					if($.isFunction(p.onclick))p.onclick.call(that);
				}
			});
			$this.on("change",function()
			{
				if($this.val()!=that.p.b2a)
				{
					$.nswitchacct.a2b(that,true);
				}
				else
				{
					$.nswitchacct.b2a(that,true);
				}
				if($.isFunction(p.onchange))p.onchange.call(that);
			});

		});
	}
	String.prototype.chartReplace=function(){
		return this.replace(/\[|\]|\./g, "_");
	}
})(Zepto);

function newDate(str) {
	str = str.split(' ')[0];
	str = str.split('-');
	var date = new Date();
	date.setUTCFullYear(str[0],str[1]-1,str[2]);
	date.setUTCHours(0,0,0,0);
	return date;
}
Date.prototype.format = function(format){
	var o = {
		"M+" : this.getMonth()+1, //month
		"d+" : this.getDate(), //day
		"h+" : this.getHours(), //hour
		"m+" : this.getMinutes(), //minute
		"s+" : this.getSeconds(), //second
		"q+" : Math.floor((this.getMonth()+3)/3), //quarter
		"S" : this.getMilliseconds() //millisecond
	}

	if(/(y+)/.test(format)) {
		format = format.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length));
	}

	for(var k in o) {
		if(new RegExp("("+ k +")").test(format)) {
			format = format.replace(RegExp.$1, RegExp.$1.length==1 ? o[k] : ("00"+ o[k]).substr((""+ o[k]).length));
		}
	}
	return format;
}

Date.prototype.diff = function(date){
	return (this.getTime() - date.getTime())/(24 * 60 * 60 * 1000);
}

//给开关模拟效果配合initSwitch，checkbox方法
//给switch加上默认选中效果
$.fn.switchOpen=function(){
	return this.each(function(i,dom){
		if(!$(dom).hasClass('switch')) return;
		var currentChecked=$(dom).attr('checked');
		if(!currentChecked){
			$(dom).attr('checked',true);
			$(dom).parent('div').addClass('open');
		}else{
			return;
		}
	});
}
//给switch加上默认未选中效果
$.fn.switchClose=function(){
	return this.each(function(i,dom){
		if(!$(dom).hasClass('switch')) return;					  
		var currentChecked=$(dom).attr('checked');
		if(!currentChecked){
			return;
		}else{
			$(dom).removeAttr('checked');
			$(dom).parent('div').removeClass('open');
		}
	});
}
//给checkbox加上默认选中效果
$.fn.uiChecked=function(){
	return this.each(function(i,dom){
		if(!$(dom).hasClass('checkbox')) return;					  
		var currentChecked=$(dom).attr('checked');
		if(!currentChecked){
			$(dom).attr('checked',true);
			$(dom).parent('div').addClass('chk-bg-checked');
		}else{
			return;
		}
	});
}
//给checkbox加上默未认选中效果
$.fn.uiUnhecked=function(){
	return this.each(function(i,dom){
		if(!$(dom).hasClass('checkbox')) return;					  
		var currentChecked=$(dom).attr('checked');
		if(!currentChecked){
			return;
		}else{
			$(dom).removeAttr('checked');
			$(dom).parent('div').removeClass('chk-bg-checked');
		}
	});
}


$(function(){
	initWidget();

})

function initWidget(){
	//开关
	$(".switch").initSwitch();
	//打勾
	$(".tick").initTick();
	$(".tickradio").initTickRadio();
	//可视密码框
	$(".visiblePwd").visiblePwd();
	//复选框
	$(".checkbox").checkbox();
	//删除input框的内容
	$(".deleteText").deleteText();
}