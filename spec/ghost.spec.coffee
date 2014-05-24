{ghost} = require './ghost'

describe 'ghost', () ->
    describe 'is_even', () ->

        it 'returns [1, 1] for "butt"', () ->
            expect(Ghost.is_even('butt')).toBe([1, 1])

        it 'shouldn\'t have', () ->
            expect(true).toBe true

        it 'is a very nice woman', () ->
            expect(true).toBe true
