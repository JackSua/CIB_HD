/*!
 * jquery plugin
 */
;(function(){

    // [[Class]] -> type pairs
    var class2type = {};

    // Populate the class2type map
    Zepto.each("Boolean Number String Function Array Date RegExp Object".split(" "), function(i, name) {
            class2type[ "[object " + name + "]" ] = name.toLowerCase();
    });
    Zepto.wtype=function( obj ) {
            return obj == null ?
                    String( obj ) :
                    class2type[ toString.call(obj) ] || "object";
    }
    Zepto.merge=function( first, second ) {
            var i = first.length,
                    j = 0;

            if ( typeof second.length === "number" ) {
                    for ( var l = second.length; j < l; j++ ) {
                            first[ i++ ] = second[ j ];
                    }
            } else {
                    while ( second[j] !== undefined ) {
                            first[ i++ ] = second[ j++ ];
                    }
            }

            first.length = i;
            return first;
    }
    // A crude way of determining if an object is a window
    Zepto.isWindow= function( obj ) {
            return obj && typeof obj === "object" && "setInterval" in obj;
    }
    Zepto.makeArray=function( array, results ) {
        var ret = results || [];

        if ( array != null ) {
                // The window, strings (and functions) also have 'length'
                // The extra typeof function check is to prevent crashes
                // in Safari 2 (See: #3039)
                // Tweaked logic slightly to handle Blackberry 4.7 RegExp issues #6930
                var type = Zepto.wtype( array );

                if ( array.length == null || type === "string" || type === "function" || type === "regexp" || Zepto.isWindow( array ) ) {
                        push.call( ret, array );
                } else {
                        Zepto.merge( ret, array );
                }
        }

        return ret;
    }
    function getWindow( elem ) {
            return Zepto.isWindow( elem ) ?
                    elem :
                    elem.nodeType === 9 ?
                            elem.defaultView || elem.parentWindow :
                            false;
    }
    // Create scrollLeft and scrollTop methods
    Zepto.each( ["Left", "Top"], function( i, name ) {
	var method = "scroll" + name;

	Zepto.fn[ method ] = function( val ) {
		var elem, win;

		if ( val === undefined ) {
			elem = this[ 0 ];

			if ( !elem ) {
				return null;
			}

			win = getWindow( elem );

			// Return the scroll offset
			return win ? ("pageXOffset" in win) ? win[ i ? "pageYOffset" : "pageXOffset" ] :
				    win.document.documentElement[ method ] ||
					win.document.body[ method ] :
				elem[ method ];
		}

		// Set the scroll offset
		return this.each(function() {
			win = getWindow( this );

                            if ( win ) {
                                    win.scrollTo(
                                            !i ? val : Zepto( win ).scrollLeft(),
                                             i ? val : Zepto( win ).scrollTop()
                                    );

                            } else {
                                    this[ method ] = val;
                            }
                    });
            };
    });


})()