# block similarity

We want to find blocks that have similar api function usage to a user's given block. The first thing I tried is implementing a cosine similarity test outlined by @mathnathan in this doc:

[google doc](https://docs.google.com/document/d/1mMGeK_NLjMrUmBf1IUN9eRtr5uHyv5bN0_vZCorG5OQ/edit?usp=sharing)

I have a vector for each gist in the [blocksplorer](http://bl.ocksplorer.org/) dataset of the format:
```
{"d3.geo":1, "d3.geo.path":1, "d3.svg.line":0...}
```
I wrote my own dot product and cosine similarity function (currently in test.coffee)


# setup
Requires coffee-script

```
wget wget https://s3.amazonaws.com/d3examples.bocoup.com/api/api.zip
unzip api.zip
coffee setup.coffee
```
this will generate a `functions.json` which is an array of all the d3 functions and `gists.json` which is an array of the vectors described above.


To find the similarity for a test vector, just run:
```
coffee test.coffee
```

# notes

I'm suspicious of the results. It might just be that there are too few blocks for this to work out, but I feel like it should return a 1.0 if there are exact matches, which i'm not getting.

Right now I'm just using 1 and 0 for the values in the vector (1 if an api function is present)