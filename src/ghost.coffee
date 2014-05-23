
alphabet = 'abcdefghijklmnopqrstuvwxyz'.split ''
all_words = 'butts fart farts fabulous fast fasts fatty'.split ' '

combine = (a, b) ->
    [a[0] + b[0], a[1] + b[1]]

win_total = (x) ->
    [x, 1]

is_even = (word) -> 1 - word.length % 2

is_odd = (word) -> 1 + word.length % 2

fragments = (word) ->
    frags = {}
    stop = word.length

    win = is_even
    if is_even word
        win = is_odd

    for i in [0..stop - 1]
        for j in [1..stop - i]
            frag = word.substr i, j
            frags[frag] = win_total(win(frag))
    delete frags[word]
    frags

console.log fragments 'hello'
