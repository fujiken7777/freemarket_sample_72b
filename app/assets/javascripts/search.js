$(window).on("load", function() {
	var _radio = [];
	$('input.radio-btn').on('click', function() {
		var _this = $(this);
		var _name = _this.attr('name');
		var _val  = _this.val();
		
		if (_radio[_name] === '' || _radio[_name] === null || _radio[_name] === undefined) {
			_radio[_name] = _val;
		} else {
			if (_radio[_name] == _val) {
				_this.prop('checked', false);
				_radio[_name] = '';
			} else {
				_radio[_name] = _val;
			}
		}
	});
});

