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
#blue[Perspective Strategies] or #blue[P-strategies] are strategies, depending only on the part of the run that is within a player's domain, given by $rho:V_1^(plus.circle) -> V_1$.
]

== Formal Description
Game Graph $G = angle.l V_1, V_2, E, v_0, "AP", tau angle.r$
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
Given a game graph $G$, let the set of all finite runs on it be defined as $V^ast.circle$.

Given a finite run $rho$, we define $pi_p:V^ast.circle ->V_p^ast$ as the projection map, which drops all vertices in the run not belonging to player $p$.

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
A probabalistic strategy for player $i$ is a function $V^ast.circle V_i -> cal(D)(V)$, where $cal(D)(V)$ is the set of probability distributions on $V$. Given strategies $g_1$ and $g_2$ for both players we define
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

== Alternating Tree Automata

== Upper Bound

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
phi, ::=, "AP",|, not phi ,|, phi or phi,|,angle.l.double S angle.r.double psi,|,angle.l.double S angle.r.double_p psi
)
$

- And there are path formulas $psi$
$
mat(
psi, ::=, phi,|, not psi ,|, psi or psi,|, circle psi,|, psi cal(U) psi
)
$

There is also the logic $"ATL"$ (similarly perspective-$"ATL"$), which simplifies $"ATL"^*$ by forcing all path operators to be preceeded by path quantifiers. eg $angle.l.double 1 angle.r.double circle circle p$ is not allowed.

== Model Checking
Model Checking is the problem of verifying if a given model $M$ satisfies a given formula $phi$.

#rule[
The model checking problem for $"perspective-ATL"^*$ is $"2-EXPTIME-complete"$. The model checking problem for $"perspective-ATL"$ is $"PTIME-complete"$.
]

= Other Fun Stuff

== Probabalistic Setting

== Structural Winning Condition

== Memoryless Strategies

= Thank You!


