from __future__ import print_function

from collections import defaultdict
import string

all_words = 'fart farts fartin'.split()

'''
fasts:
    fast -> WORD
    asts -> 1, 1
    sts -> 0, 1
    ast -> 0, 1
    as -> 1, 1
    st -> 1, 1
    ts -> 1, 1
    a -> 0, 1
    s -> 0, 2
    t -> 0, 1
fast:
    fas -> 1, 1
    ast -> 1, 1
    fa -> 0, 1
    as -> 0, 1
    st -> 0, 1
    f -> 1, 1
    a -> 1, 1
    s -> 1, 1
    t -> 1, 1
fart:
    far -> 1, 1
    fa -> 0, 1
    f -> 1, 1
    a -> 1, 1
    r -> 1, 1
    t -> 1, 1
    ar -> 0, 1
    rt -> 0, 1
    art -> 1, 1
farts:
    fart -> WORD
    arts -> 1, 1
    art -> 0, 1
    rts -> 0, 1
    ar -> 1, 1
    rt -> 1, 1
    ts -> 1, 1
    a -> 0, 1
    r -> 0, 1
    t -> 0, 1
    s -> 0, 1
'''

def combine(a, b):
    return a[0]+b[0], a[1]+b[1]

def win_total():
    return 0, 0

def fragments(word):
    """Generate all fragments of this word"""
    word_length = len(word)
    for start in range(word_length):
        for end in range(start + 1, word_length + 1):
            yield word[start:end]

is_even = lambda x: 1 - (len(x) % 2)
is_odd = lambda x: len(x) % 2

def add_to_vocabulary(word, win_buckets):
    win = is_even
    # e.g. if a word is length 4, if you can form 3 letters you'll win
    if is_even(word):
        win = is_odd

    for frag in fragments(word):
        if frag in all_words:
            continue
        win_buckets[frag] = combine(win_buckets[frag], (win(frag), 1))

wins = defaultdict(win_total)

def build_vocabulary():
    for word in all_words:
        add_to_vocabulary(word, wins)

def best(win, options, move, best_score, best_options, best_move):
    '''Compare a potential better move to the best we've found.

    Return (best score, best options, best move)'''
    score = float(win) / options
    if score > best_score:
        best_score = score
        best_options = options
        best_move = move
    elif score == best_score and options > best_options:
        best_score = score
        best_options = options
        best_move = move
    return best_score, best_options, best_move


def decide_best(word):
    best_score, best_options, best_move = -1, -1, None
    for letter in string.letters[:26].lower():

        move = letter + word
        if move in wins:
            win, options = wins[move]
            score = float(win) / options
            best_score, best_options, best_move = best(win, options, move, best_score, best_options, best_move)
        elif move in all_words:
            best_score, best_options, best_move = best(0, 1, move, best_score, best_options, best_move)

        move = word + letter
        if move in wins:
            win, options = wins[move]
            score = float(win) / options
            best_score, best_options, best_move = best(win, options, move, best_score, best_options, best_move)
        elif move in all_words:
            best_score, best_options, best_move = best(0, 1, move, best_score, best_options, best_move)

    return best_move

def play_game():
    keep_playing = True
    score = [0, 0]

    while keep_playing:
        word = raw_input('Enter a letter: ')
        while True:
            word = decide_best(word)
            if word in all_words:
                print('Couldn\'t think of anything; spelled %r' % word)
                score[0] += 1
                break

            print('AI turn: %s' % word)
            word = raw_input('Your turn: ')
            if word in all_words:
                print('You made a word %r; you lose' % word)
                score[1] += 1
                break

            if word not in wins:
                new_word = raw_input('My vocabulary isn\'t that big - what can you spell with that? ')
                add_to_vocabulary(new_word, wins)
                score[0] += 1
                break

        print('Current score: %d (you) to %d (AI).' % (score[0], score[1]))
        next_game = raw_input('(C)ontinue or [Q]uit? ')
        keep_playing = ('c' == next_game.lower())

build_vocabulary()
play_game()