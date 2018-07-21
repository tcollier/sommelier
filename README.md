# Stable Marriage

[![Numberphile: Stable Marriage Problem](https://img.youtube.com/vi/Qcv1IqHWAzg/0.jpg)](https://www.youtube.com/watch?v=Qcv1IqHWAzg)

The [Stable Marriage Problem](https://en.wikipedia.org/wiki/Stable_marriage_problem)
is a mathematical problem that attempts to uniquely match a set of _N_ items
(classically male suitors) with another set of _N_ items (classically females the
suitors wish to marry). The final matches are referred to as proposals.

## Gale-Shapely Algorithm

This gem provides a variant of the [Gale-Shapely algorithm](https://en.wikipedia.org/wiki/Stable_marriage_problem#Solution).
Gale-Shapely guarantees a complete matching (i.e. every suitor is paired with
exactly one female and vice versa). Though this algorithm assumes every member
of either group has a complete ranking of the other group. For large populations,
this is not always practical.

## Variation

The algorithm applied here has 2 primary differences from Gale-Shapely

1. Neither suitors nor suitees need to have a complete ranking of the other set.
2. The rankings are determined by a symmetrical match score. For example, the match
score for Alice and Steve is the same as for Steve and Alice. Though scores are
relative, so Alice's match score for Steve may be her highest scoring match, but
that same score may only be the fifth highest scoring match for Steve.

Because of these differences, not every suitor or suitee is guaranteed to have
a proposal. Swapping the suitor and suitee sets can have dramatic effects on the
final set of proposals.

## Usage

```bash
gem install stable_marriage
```

```ruby
require 'stable_marriage'
sm = StableMarriage.new
sm.add_match('Alice', 'Marcus', 0.366)
sm.add_match('Alice', 'Steve', 0.453)
sm.add_match('Alice', 'Will', 0.245)
sm.add_match('Janice', 'Phil', 0.486)
sm.add_match('Janice', 'Steve', 0.304)
sm.add_match('Lily', 'Steve', 0.299)
sm.add_match('Maria', 'Steve', 0.602)
puts sm.proposals
# {
#   "Maria" => "Steve",
#   "Janice" => "Phil",
#   "Alice" => "Marcus"
# }

# Note: neither Lily nor Will were matched in the proposals map
```