[![Build Status](https://travis-ci.org/tcollier/sommelier.svg?branch=master)](https://travis-ci.org/tcollier/sommelier)

# Sommelier

Sommelier provides a solution to a variant of the Stable Marriage problem in
mathematics. In this gem, the classical suitors are replaced with dishes from a
restaurant menu and the brides-to-be are wines.

## Stable Marriage Problem

[![Numberphile: Stable Marriage Problem](https://img.youtube.com/vi/Qcv1IqHWAzg/0.jpg)](https://www.youtube.com/watch?v=Qcv1IqHWAzg)

The [Stable Marriage Problem](https://en.wikipedia.org/wiki/Stable_marriage_problem)
is a mathematical problem that attempts to uniquely match a set of _N_ items
(classically male suitors) with another set of _N_ items (classically females the
suitors wish to marry).

## Gale-Shapely Algorithm

This gem provides a variant of the [Gale-Shapely algorithm](https://en.wikipedia.org/wiki/Stable_marriage_problem#Solution).
Gale-Shapely guarantees a complete matching (i.e. every suitor is paired with
exactly one female and vice versa). Though this algorithm assumes every member
of either group has a complete ranking of the other group. For large populations,
this is not always practical.

## Variation

The algorithm applied here has a few key differences from Gale-Shapely

1. The number of dishes and wines do not need to be equal.
2. Neither dishes nor wines need to have a complete ranking of the other set.
3. The rankings are determined by a symmetrical match score. For example, the match
score for Eggplant and Cabernet is the same as for Cabernet and Eggplant. Though scores are
relative, so Eggplant's match score for Cabernet may be its highest scoring match, but
that same score may only be the fifth highest scoring match for Cabernet.

Because of these differences, not every dish or wine is guaranteed to be in the
pairings map. Swapping the dish and wine sets in the match catalog alter the final
set of pairings.

## Usage

### Installation

```bash
gem install tcollier-sommelier
```

### Example

```ruby
require 'sommelier'
sommelier = Sommelier.new
sommelier.add_match('Asparagus', 'Pinot Noir', 0.366)
sommelier.add_match('Asparagus', 'Sauvignon Blanc', 0.453)
sommelier.add_match('Asparagus', 'Chardonnay', 0.245)
sommelier.add_match('Tofu', 'Rosé', 0.486)
sommelier.add_match('Tofu', 'Sauvignon Blanc', 0.304)
sommelier.add_match('Eggplant', 'Sauvignon Blanc', 0.299)
sommelier.add_match('Salmon', 'Sauvignon Blanc', 0.602)
puts sommelier.pairings
# {
#   "Salmon" => "Sauvignon Blanc",
#   "Tofu" => "Rosé",
#   "Asparagus" => "Pinot Noir"
# }

# Note: neither "Eggplant" nor "Chardonnay" were matched in the pairings map
```

### CSV

This gem provides a rake task to apply the Sommelier algorithm to a CSV file.
The file must have a header row and the columns are expected to be in the following
order:

1. `dish`
2. `wine`
3. `score`

Note: the header row is simply ignored, so the columns can be named anything.

Any additional columns will be ignored.

```csv
# matches.csv
dish,wine,score
Asparagus,Pinot Noir,0.366
Asparagus,Sauvignon Blanc,0.453
Asparagus,Chardonnay,0.245
Tofu,Rosé,0.486
Tofu,Sauvignon Blanc,0.304
Eggplant,Sauvignon Blanc,0.299
Salmon,Sauvignon Blanc,0.602
```

```bash
rake sommelier:from_csv matches.csv
# Salmon => Sauvignon Blanc
# Tofu => Rosé
# Asparagus => Pinot Noir
```
