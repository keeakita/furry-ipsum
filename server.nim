import jester, asyncdispatch, json, math, strutils

# Categories of phrases
type
    Category = tuple
        weight:  int         # Makes category more or less likely to be chosen
        phrases: seq[string]

let lingo: Category = (weight: 5,
    phrases: @["furry", "fursona", "popufur", "pawsome", "furry trash",
               "furries", "fandom", "convention", "fursuit", "fursuiter",
               "fluff", "fuzz", "fuzzbutt", "furr", "fluffbutt", "cutie",
               "fursuiting", "everyfur", "nofur", "anyfur", "somefur"])

let anatomy: Category = (weight: 3,
    phrases: @["paw", "paws", "footpaws", "handpaws", "tail", "tails", "ears"])

let species: Category = (weight: 3,
    phrases: @["wolf", "fox", "otter", "snep", "deer", "husky", "dragon",
               "jackal", "raccoon", "goat", "bunny", "trash panda", "foxes",
               "wuff", "waffle"])

# TODO: permute species to create hybrids

let roleplay: Category = (weight: 1,
    phrases: @["*nuzzles you*", "*hugs*"])

let noises: Category = (weight: 3,
    phrases: @["meow", "bark", "bork", "woof", "yap", "purr"])

let emoji: Category = (weight: 1, phrases: @["🐺", ":3", ":3c", "^w^", "o.o"])

let conventions: Category = (weight: 2,
    phrases: @["Anthrocon", "Midwest FurFest", "Biggest Little Fur Con",
               "Rainfurrest"])

# All cateogires together
let all_categories = [lingo, anatomy, species, roleplay, noises, emoji, conventions]

# Sum up total weights
var total_weight = 0
for category in all_categories:
    total_weight += category.weight

# Shuffles a sequnce using the Fisher-Yates algorithm
proc shuffle[T](deck: var seq[T]) =
    for i in 0..(len(deck)-2):
        let j = random(len(deck)-i)
        let temp: T = deck[i]
        deck[i] = deck[i+j]
        deck[i+j] = temp

# Jester routes
routes:
    get "/api/ipsum":
        var phrases: seq[string] = @[]

        for category in all_categories:
            var selections = round(category.weight / total_weight * 100)
            for i in 0..selections:
                phrases.add(category.phrases[random(len(category.phrases))])

        phrases.shuffle()
        resp phrases.join(" ")

runForever()
