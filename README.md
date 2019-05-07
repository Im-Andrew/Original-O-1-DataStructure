# SwapStack

A data structure I designed which is kind of like a stack, but with arbitrary access and arbitrary removal. It does so with a constant time complexity for adding, removing, and access. 


# Try it with no setup

Because Haxe is an uncommon language, it may be convenient for you to 
install Haxe just to demo this Data Structure. You can try it in your browser with the link
below.

Link: https://try.haxe.org/#45f53


# About the Data Structure

## Usecase 
This is a data structure I wrote that would be useful for adding a whole bunch of 
sequence independent data that needed to be flexible and fast for reading, adding, and
removing data. It was made specifically with game development in mind that resembles
something like a "pool" of objects that were fairly volatile. This means that it was
designed to perform well with 60 iterations a second with thousands of elements that
were possibly being popped on and off the list at any given moment from any given index.


## How it works
Similarly to a stack, each element can be found at the index it 'pushed on' at all times, but
what it does differently is keep that trait while allowing you to remove arbitrary
elements all without shifting the underlying array or creating 'holes' which would otherwise
slow down iteration.

What happens when you access an index that was recently "popped" out? It will be an element which 
took its place or, if the index is greater than the number of elements, probably out of bounds. 

This is intentional, as I wanted iterations to be out of n( elements ) and not out of k( size )
because k is greater than or equal to n at any given time. Because it does this directly on the indexes,
we also get the benefit of having random access over the span of existing elements instead of reaching
holes where an element was removed.

## The "downside":
Because of the implementation, the actual order of elements in this data structure is volatile 
and will never be held after items have been removed. This can be circumvented, however, by
adding extra properties to the SwapNodes which indicates the 'next' in order - like a linked list. I 
imagine the benefit of a SwapStack over a linked list at this point would be the arbitrary index
access. I hypothesize it would perform better, compared to a linked list, because the SwapNodes have 
a similar memory footprint to a LinkedNode while also being stored on top of an array.


# Setup

If you already have Haxe installed, testing this project on your
computer will be easy. Otherwise, you'll need to install Haxe and Neko on your computer.

You can find the installation for Haxe here: https://haxe.org/download/version/4.0.0-rc.2/

After you run through your operating system's installer, you should 
have `Haxe` and `Neko` available through your command line.


# Test it

Testing the data structure is simple. Just follow below and copy and paste.

1. Clone the repo to a directory on your computer: `git clone https://github.com/Im-Andrew/Self-made-O-n-DataStructure.git .`
2. Build a NekoVM file using the build file: `haxe build.hxml`
3. Test the code in Neko via `neko bin/main`


# Profiling

This was a very basic attempt at capturing the actual speed of my algorithm but the 
haxe implementation for arrays doesn't seem to have an arbitrary index deletion like
my swap stack does. It does have `splice`, but that allocates an entire new array each time
_and_ shifts the original array; so splice wouldn't be a fair comparison at all.
The code I use will attempt to use the closest comparable function.


The result I found for five iterations over a size of 50,000 items was as follows:

| Data Structure | Pushing  | Read Access | Popping   |
|----------------|----------|-------------|-----------|
| Int SwapStack  | ~76.99ms | ~18.00ms    | ~82.00ms  |
| Int Array      | ~22.99ms | ~13.00ms     | ~714.05ms |

_note: the target being used was Neko._

While it does what it should do, it doesn't match up _exactly_ what we should expect.
This could be for a large number of reasons coming down to not using a profiling tool,
or a better profiling technique, or simply some VM tricks happening under the hood,
but I intend on updating this later to be a better test. At the moment, this is simply
supposed to demonstrate how this algorithm should, in theory, benefit you.


# [Contact me](https://www.making.codes/#contact-me)
I am available for hire. You can quickly get in contact with me here:
[making.codes/#contact-me](https://www.making.codes/#contact-me)
