---
title: Cryptopals!
date: 2019-06-07
published: true
---

I've been meaning to 1. Learn more python, 2. Increase my understanding of cryptography and 3. Prune my backlog of 'interesting stuff to checkout someday maybe'. To that end, I'm gonna jump into the [https://cryptopals.com](https://cryptopals.com) challenges.

Python solutions over yonder: [https://github.com/rpavlov/cryptopals](https://github.com/rpavlov/cryptopals)

### Encoding: Hexadecimal, base64

The difference between Base64 and hex is really just how bytes are represented. Hex is another way of saying "Base16". Hex will take two characters for each byte - Base64 takes 4 characters for every 3 bytes, so it's more efficient than hex. Assuming you're using UTF-8 to encode the XML document,a 100K file will take 200K to encode in hex, or 133K in Base64. Of course it may well be that you don't care about the space efficiency - in many cases it won't matter. If it does matter, then clearly Base64 is better on that front. (There are alternatives which are even more efficient, but they're not as common.)

There is more to base selection than efficiency, however.

Base64 uses more than just letters and numbers. Different implementations use different punctuation characters for indiciating padding, and making up the last two characters of the set of 64. These can include plus "+" and equal "=". both problematic in HTTP query strings.

So one reason to favour base16 over base64 is that base16 values can be composed directly into HTTP query strings without requiring additional encoding. Is that important to you?

Notice that this is an additional concern, over and above efficiency. Neither base is inherently better or worse; they're just two different points on a scale, at which you'll find different properties that will be more or less attractive in different situations.

For example, consider base32. It's 20% less efficient than base64, but is still suitable for use in HTTP query strings. Most of its inefficiency comes from being case-insensitive and avoiding zero "0" and one "1", to mistakes in reproduction by humans.

So base32 introduces a new concern; ease of reproduction for humans. Is that a concern for you? If it's not, you could go for something like base62, which is still convenient in HTTP query strings, but is case sensitive and includes zero "0" and "1". base32 is case insensitive.

### Why is XOR important in cryptography?

XOR represents the inequality function, i.e., the output is true if the inputs are not alike otherwise the output is false. A way to remember XOR is "one or the other but not both".

Imagine you have a string of binary digits 10101 and you XOR the string 10111 with it you get 00010

Now your original string is encoded and the second string becomes your key if you XOR your key with your encoded string you get your original string back.

### Python sidenotes

#### 1: Statements vs functions

In python we have statements and functions, which is a little confusing. Certain things, in this case
`assert` are functions in other languages. In python assert is a statement! Crazy!

So `assert(False, "Oh no, something is wrong)` will deceptively not trigger the error message. However, `assert False, "Oh no..."` will behave as expected:

`/home/rpavlov/Projects/cryptopals/set1.py:30: SyntaxWarning: assertion is always true, perhaps remove parentheses? assert(len(byte_str1) == len(byte_str2), 'Byte arrays are of different lengths!')`

In the switch from python2->python3 this is even more confusing, because `print` went from being an expression to a function. Coming from ruby, `puts 'hey'` and `puts('hey')` behave exactly the same.

#### 2: zip()

The zip() function in Python 3 returns an iterator. It's typically used to interleave two lists.

```python
numbersList = [1, 2, 3]
numbersTuple = ('ONE', 'TWO', 'THREE', 'FOUR')

result = zip(numbersList, numbersTuple)

resultSet = set(result)
print(resultSet)

{(2, 'TWO'), (3, 'THREE'), (1, 'ONE')}

strList = ['one', 'two']
result = zip(numbersList, strList, numbersTuple)

resultSet = set(result)
print(resultSet)

{(2, 'two', 'TWO'), (1, 'one', 'ONE')}
```

#### 3: bytearray([ord(char)] * len(hex_to_byte_array(buff)))

The purpose of this line is to expand a single character to a byte string of the same length as the one we want to xor against.

### Misc notes

* Ciphertext: result of running a piece of text throught a Cipher, otherwise known as an algorithm.
* In cryptanalysis, frequency analysis (also known as counting letters) is the study of the frequency of letters or groups of letters in a ciphertext. The method is used as an aid to breaking classical ciphers.
* Summarize the example in