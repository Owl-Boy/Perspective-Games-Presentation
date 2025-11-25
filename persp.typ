#import "slides.typ" : *

#let author = [Shubh Sharma, Siddhant Agarwal]
#let title = [Perspective Games] 
#let subtitle = [Now you see me, now you don't]

#show: slides.with(author:author, title:title, subtitle:subtitle)

#let purp(content) = text(fill: rgb(155, 79, 150))[#content]
#let blue(content) = text(fill: rgb("#2159a5"))[#content]

#title-slide()

= Introduction

== Perspective Games
#purp[Partial Information games] : Games where players don't have all the information about the game arena and game state at all times. 

#linebreak()

#purp[Transverse Uncertainty] : Sometimes player see all the information, some times they do not, like:
- Concurrent threads given control by a scheduler
- Clients connecting to a server, one at a time.
- Games with concurrent moves
  
#rule[
#blue[Perspective Strategies] or #blue[P-strategies] are strategies, depending only on the part of the run that is within a player's domain, given by $rho:V_1^(plus.o) -> V_1$.
]

== Formal Description
Game Graph $G = chevron.l V_1, V_2, E, v_0, "AP", tau chevron.r$
- $"AP"$ is a finite set of atomic propositions.
- $tau : V_1 union.sq V_2-> 2^"AP"$ assigns which atomic propositions are true in which locations.
  
#linebreak()
Given a run $rho = (rho_1 dot rho_2 dot rho_3 space dots.c) : V^omega$, the #purp[computation] of a run $tau(rho) : (2^"AP")^omega$ is defined as 
$
tau(rho) = tau(rho_1) dot tau(rho_2) dot tau(rho_3) space dots.c
$

Winning condition $L$ decides which runs are winning, given as one of the following:
- An $"LTL"$ formula
- An $omega$-automata
  
Thus $L subset.eq (2^"AP")^omega$.

== Perspective Strategies
Given a game graph $G$, let the set of all finite runs on it be defined as $V^ast.op.o$.

Given a finite run $rho$, we define $pi_p:V^ast.op.o ->V_p^ast$ as the projection map, which drops all vertices in the run not belonging to player $p$.

#rule[
A #blue[Perspective strategy] $sigma_p$ for a player $p$ takes the part of a run restricted to player $p$ vertices and decides a move based on that. 

Thus, given a function $f:V_p^* -> V_p$, the following describes a #blue[P-strategy]:
$
sigma_(p)(rho) :equiv f(space pi_1(rho) space)
$
]

We consider games where each player can have a different kind of strategy,eg. in a $"PF"$-game, player 1 has a perspective strategy and player 2 has an ordinary (or full) strategy.

== Deterministic Setting
We say that a strategy $sigma$ is #purp[winning] for player 1, if for any strategy $tau$ for player 2, the play induced by the strategies satisfies the winning condition. 

#linebreak()
Some nice theorems:
#rule[
- Given a game $cal(G)$
    - Player 1 $"FF"$-wins $cal(G)$ iff Player 1 $"FP"$-wins $cal(G)$
    - Player 1 $"PF"$-wins $cal(G)$ iff Player 1 $"PP"$-wins $cal(G)$

- There is a game $cal(G)$ such that player 1 $F$-wins $cal(G)$ but does not $P$-win $cal(G)$.

- Perspective Games are not determined.
]

== Probabalistic Setting
A probabalistic strategy for player $i$ is a function $V^ast.op.o V_i -> cal(D)(V)$, where $cal(D)(V)$ is the set of probability distributions on $V$. Given strategies $g_1$ and $g_2$ for both players we define
$
cal(P)_(g_1,g_2)(L) = [| rho" is in "L | rho "is generated using "g_1, g_2|]
$

A strategy $sigma$ is #purp[almost winning] for player 1 if for every strategy $tau$ we have $cal(P)_(g_1,g_2)(L)=1$.

Some nice Theorems:
#rule[
- There is a game $cal(G)$ that is $"PF"$-almost winning for player 1, but not $P$-winning.
- There is a game $cal(G)$ that is $"PP"$-almost winning but not $"PF"$-almost winning for player 1.
- Perspective games are not almost-determined.
]


= Deterministic Setting Analysis

== Results

#rule[
  Deciding whether Player 1 $P$-wins and finding a $P$-strategy in a
  perspective game $chevron G, cal(U) chevron.r$ is $"EXPTIME"$-complete
  when $cal(U)$ is a universal automata with a parity or a reachability winning
  condition. The problem can be solved in time polynomial in $|G|$ and
  exponential in $|cal(U)|$.
]

#rule[
  Deciding whether Player 1 $P$-wins and finding a $P$-strategy in a
  perspective game $chevron G, psi chevron.r$ is $"2EXPTIME"$-complete when
  $psi$ is an LTL specification. The problem can be solved in time polynomial
  in $|G|$ and doubly exponential in $|psi|$.
]

== Outline for Upper Bound

#v(2cm)

- Perform a polynomial conversion from winning condition $cal(U)$ to an alternating tree automaton $cal(A_G)$.
- Show that finding a $P$-strategy for Player 1 is equivalent to finding an accepting run in $cal(A_G)$.
- Solving the emptiness problem for $cal(A_G)$ gives an upper bound for finding Player 1 $P$-strategy.

== Tree Automata

A Tree Automata is given by the following tuple
$
cal(A) = chevron Sigma, Q, q_"in", delta, alpha chevron.r
$
where
- $alpha subset.eq Q^omega$ is the winning condition.
- $delta: Q times Sigma -> Q^*$ gives the list of locations corresponding to children of the tree.
- $Sigma$ is set of labels for the nodes of the tree.
  
A run of the automata on a tree $T$ can be through as wapping the tree along the edges of the automata. It can be given as a function $r:T->Q$ such that.
- $r("root"_T)=q_"in"$
- If $v$ is a node labelled by $a$ with children $v_1,v_2...v_n$ such that $r(v)=q$. Let $delta(q, a) = q_1,q_2...q_n$ we have $r(v_i)=q_i$.
  
#rule[
#v(2cm)
#align(center, "Add Diagram")
#v(2cm)
]

Non-deterministic and Universal tree automata transitions return a list of words. Both of these can be combined and represented uniquely by descriving an alternating tree automata where the transitions have the type:
$
delta : Q times Sigma -> cal(B)(Q times D)
$
Where $cal(B)(Q times D)$ are positive boolean formulas. Note that runs of ATAs can be over more than 1 trees. One would pick a set nodes, and directions for edge labels.

== Upper Bound (Parity Automata)
Consider a universal parity automata $cal U$

== Lower Bound

== LTL Winning Condition

= Perspective $"ATL"^*$ Model Checking

== Perspective $"ATL"^*$ 
$"ATL"^*$ is an extension of the logic $"CTL"^*$ which captures the existence of strategies in a game. Perspective-$"ATL"^*$ lets us quantify over perspective startegies. 

There are 2 types of formulas
- State formulas $phi$
  
#set math.mat(delim: none)
$
mat(
phi, ::=, "AP",|, not phi ,|, phi or phi,|,chevron.l.double S chevron.r.double psi,|,chevron.l.double S chevron.r.double_p psi
)
$

- And there are path formulas $psi$
$
mat(
psi, ::=, phi,|, not psi ,|, psi or psi,|, circle psi,|, psi cal(U) psi
)
$

There is also the logic $"ATL"$ (similarly perspective-$"ATL"$), which simplifies $"ATL"^*$ by forcing all path operators to be preceeded by path quantifiers. eg $chevron.l.double 1 chevron.r.double circle circle p$ is not allowed.

== Model Checking

Model Checking is the problem of verifying if a given model $M$ satisfies a given formula $phi$.

#rule[
The model checking problem for $"perspective-ATL"^*$ is $"2-EXPTIME-complete"$. The model checking problem for $"perspective-ATL"$ is $"PTIME-complete"$.
]

= Conclusion

== Probabalistic Setting

== Structural Winning Condition

== Memoryless Strategies

== Thank You!

Thank you for attending our presentation. If you are interested in reading the paper, it can be found here:

#figure(image("img/paper_qr_code.png", width: 30%), caption: [https://dl.acm.org/doi/10.1145/3627705], numbering: none)
