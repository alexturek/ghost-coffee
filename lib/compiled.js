(function() {
  var all_words, alphabet, combine, fragments, is_even, is_odd, win_total;

  alphabet = 'abcdefghijklmnopqrstuvwxyz'.split('');

  all_words = 'butts fart farts fabulous fast fasts fatty'.split(' ');

  combine = function(a, b) {
    return [a[0] + b[0], a[1] + b[1]];
  };

  win_total = function(x) {
    return [x, 1];
  };

  is_even = function(word) {
    return 1 - word.length % 2;
  };

  is_odd = function(word) {
    return 1 + word.length % 2;
  };

  fragments = function(word) {
    var frag, frags, i, j, stop, win, _i, _j, _ref, _ref1;
    frags = {};
    stop = word.length;
    win = is_even;
    if (is_even(word)) {
      win = is_odd;
    }
    for (i = _i = 0, _ref = stop - 1; 0 <= _ref ? _i <= _ref : _i >= _ref; i = 0 <= _ref ? ++_i : --_i) {
      for (j = _j = 1, _ref1 = stop - i; 1 <= _ref1 ? _j <= _ref1 : _j >= _ref1; j = 1 <= _ref1 ? ++_j : --_j) {
        frag = word.substr(i, j);
        frags[frag] = win_total(win(frag));
      }
    }
    delete frags[word];
    return frags;
  };

  console.log(fragments('hello'));

}).call(this);
