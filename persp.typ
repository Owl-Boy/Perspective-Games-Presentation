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


= Deterministic Setting Analysis

== Introduction

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
We can think of a strategy as a tree. For player 1, if a play is in $V_1$ we choose one vertex as its successor. If the play is in $V_2$, then the control can go back to player 1 in multiple ways. This is how we interpret a strategy as a tree.

Thus, for our tree automata, we will simulate strategies on the game:
- $Q' = V times Q times [1..n]$
- $q_0'= chevron v_0, q_0, 0 chevron.r$

If the game was in configuration $(v, q)$ such that $v in V_1$ and player 1 chooses to go to $v'$.
- Let $S_(v, q)^v'$ be $bot$ if from $v' in V_2$ player 2 can force the game in $v_2$ and win.
- Let $S_(v, q)^v'$ be all such $(v'', q', i)$ where player 2 can take the game from $v'$ to $v''$, $q'$ is the vertex in the word-automata reached after following the path, and $i$ is the highest priority seen along the path.

We now define the edges to be:
- From $(v, q, i)$ if $S_(v, q)^v'= bot$ or there is no edge from $v$ to $v'$ the transision is $(v, q, i)$ on reading $v'$ goes to $"fail"$.
- Otherwise $(v, q, i)$  on reading $v'$ goes to all vertices $(v'', q', i')$ in $S_(v, q)^v'$ for vertex $v''$, if the set is empty, we accept the run.
  
Our winning condition is again parity, an for any vertex $(v, q, i)$ we define its parity to be $i$.

We then have the following theorem:
#rule[
Given a game $cal(G)= chevron G, cal(U) chevron.r$ where $cal(U)$ is a universal parity tree game, we can convert it to a equivalent non-deterministic Rabin tree game and find a witness in time polynomial to $|G|$ and exponential to $|cal(U)|$. Furthermore, we can make a transducer to extract a witness.
]

== Lower Bound (Reachability)

We show a reduction from membership for linear bounded alternating turing machines. We assuming the automata alternates between existential and universal nodes.

Given such a machine $M$ along with a word $w$, we know the size of the tape required, so we know the size of the configuration. Both players will take turns picking transitions of the from $Q times Gamma -> Q times Gamma times {L, R}$ that the machine will take. Player 1 will have a winning strategy iff $M$ accepts $w$.

Since the number of configurations is exponential in size of the word, we will only keep track of one specific position in the tape during the game.

Since the entire information of the tape is not kept track of, both players need simulate the turing machine. We punish player 1 if the simulation is not faithful, and we give her the power to force player 2 to play correctly.

The game proceeds by:
- Player 2 selecting a cell of the tape on which transitions will be verified.
- Player 1 does not know what cell player 2 selected, so she must play safely by remembering the tape content correctly.
- Player 1 takes her turn in 2 steps
    - she picks a transition $q_"in", gamma ->q', gamma', d$ and claims tape symbol was $gamma$.
    - She claims that the tape content under the head now, is $lambda$.
- For player 2, the machine is in state $q'$ and player 1 said the current tape letter is $lambda$, so she must take a transition of the form $q', lambda -> q'', gamma'', d'$
- This process repeats with player 1 taking a transition from whatever state the turing machine is in.
- The run is accepted if the machine reaches the accept state.
  
This is a polynomial time reduction, this we have proved the $"EXPTIME"$-hardness.

== LTL Winning Condition

For a game $cal(G)= chevron G, psi chevron.r$
- Build Buchi Automata that satisfies $not psi$. Construction is exponential.
- Dualize to get a universal co-Buchi Automata, which is also a parity automata.
- Use the previous algorith, which is exponential in the size of the automaton.
This proves the upper bound.

The proof for the lower bound reduces the realizablity problem for an $"LTL"$ formula $psi$ to a game $cal(G)=(G, psi)$. Finding an $F$ strategy is known to be $"2-EXPTIME"$-complete.

The states of $G$ are 2 copies of $2^"AP"$, one for player 1 and 1 for player 2, and all transitions are of the from $V_1$ to $V_2$ or $V_2$ to $V_1$. Here, finding a $P$-strategy is equivalent to finding an $F$-startegy as vertices alternate.

= Probabilistic Setting

== Introduction

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

== Undecidability

#rule[
  Deciding whether Player 1 $(P, F)$-almost wins and whether they $(P,
  P)$-almost win a perspective game with a deterministic co-Büchi condition
  is undecidable.
]

- This can be shown by reduction from emptiness problem of a simplified
  probabilistic co-Büchi automata (PCW) which has already been proved to be
  undecidable.
- A simplified PCW is $cal(P) = chevron Sigma, Q, q_0, delta, alpha chevron.r$
  with the transition function $delta: Q times Sigma -> chevron q_1, ..., q_n
  chevron.r$, where $delta(q, sigma)$ is the tuple of states that the automata
  can transition to, each with $1/n$ probability.
  A word $w in Sigma^w$ is accepted by $cal(P)$ if the acceptance probability
  of $w$ in $cal(P)$ (denoted $"Prp"(w)$) is $1$.
- We construct a game $cal(G) = chevron G, cal(A) chevron.r$, where $cal(A)$
  is a deterministic co-Büchi automata such that $cal(P)$ is nonempty iff
  Player 1 $(P, F)$-almost wins $cal(G)$. Intuitively, the probabilistic
  transitions of $cal(P)$ are simulated by randomized strategies of players
  in $cal(G)$.

== Undecidability

#image("img/prob_reduction.png")

== Undecidability

- We create $cal(G)$ with a game graph that looks like the above. A play in
  $G$ is an infinite sequence of rounds, such that in each round Player 1
  chooses $sigma in Sigma$, Player 2 chooses an index $i in {0, ... n - 1}$
  and then Player 1 chooses an index $j in {0 ... n - 1}$
- Since Player 1 only has perspective visibility, the chose of $i$ and $j$
  are independent. So, each player in $cal(G)$ has the possibility to
  ensure exact simulation of the probabilistic transitions of $cal(P)$
  by choosing transitions to the ${0, ..., n - 1}$ vertices in $G$ uniformly
  at random. If Player 2 chooses $i$ uniformly at random and then Player 1
  chooses $j$ without knowing $i$, the index $(i + j) mod n$ is
  distributed uniformly in ${0,..., n - 1}$.

== Undecidability

- If $cal(P)$ is nonempty and $w in L(cal(P))$, let $g_1$ be a randomized
  $P$-strategy of Player 1. Since for every random choice of Player 2 the
  index $(i + j) mod n$ is distributed uniformly, we have for every randomized
  strategy $g_2$ of Player 2, $"Pr"_(g_1, g_2)(L(cal(A))) = "Prp"(w) = 1$
- Assume $cal(P)$ is empty. Let $g_2$ be a randomized $P$-strategy of Player 2
  such that $i in {0,...,n - 1}$ is chosen uniformly at random. For every
  randomized strategy $g_1$ of Player 1, we have that $Pr_(g_1, g_2)(L(cal(A)))$
  is the probability that $P$ accepts a word $w$ that is drawn according to
  some distribution that is induced $g_1$. Since $"Prp"(w) < 1$ for every $w$,
  we also have $Pr_(g_1, g_2)(L(cal(A))) < 1$
- Every strategy discussed for Player 2 has also been perspective, so we also
  have $cal(P)$ is nonempty iff Player 1 $(P, P)$-almost wins.

= Conclusion

== Memoryless Strategies

- Let $cal(G) = chevron G, L chevron.r$ be a game. Deciding whether Player 1
  has a winning memoryless strategy and finding such a strategy in $G$ is
  $"PSPACE"$ complete when $L$ is given by an LTL formula and is $"NP"$-complete
  when $L$ is given by a reachability condition or a universal parity automata.
- When $L$ is an LTL formula $psi$, we can fix a memoryless strategy $sigma$ for
  Player 1 and check whether the induced graph from $sigma$ satisfies $psi$ or
  not. LTL model checking is known to be in $"PSPACE"$. The case where all
  vertices of $G$ belong to Player 2 is exactly the LTL model checking problem,
  thus showing the hardness of finding memoryless strategies.
- To show that $<cal(G), cal(A)>$ is in NP, we can do something similar and guess
  memoryless strategies for Player 1. We can check a guessed strategy by
  checking for the non emptiness of the intersection of the induced subgraph
  with the complement of $cal(A)$. The hardness of the problem is obtained via
  reduction from 2DP.

== Perspective $"ATL"^*$ Model Checking

$"ATL"^*$ is an extension of the logic $"CTL"^*$ which captures the existence
of strategies in a game. Perspective-$"ATL"^*$ lets us quantify over
perspective strategies. 

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

== Perspective $"ATL"^*$ Model Checking

There is also the logic $"ATL"$ (similarly perspective-$"ATL"$), which
simplifies $"ATL"^*$ by forcing all path operators to be preceded by path
quantifiers. eg $chevron.l.double 1 chevron.r.double circle circle p$ is not
allowed.
 
#rule[
The model checking problem for $"Perspective-ATL"^*$ is $"2-EXPTIME-complete"$.
The model checking problem for $"Perspective-ATL"$ is $"PTIME-complete"$.
]

== Structural Winning Condition

- The games which admit memoryless strategies (Büchi, Parity, etc) admit
  P-strategies as well because memoryless strategies are also P-strategies.
- Generalised Büchi games admit P-strategies. Let $G = chevron V_1, V_2, v_0,
  E, alpha chevron.r$ be a game with a generalised Büchi winning condition. We
  denote by $G^v$ the game graph obtained by changing the initial vertex to $v$.
  Let $alpha = {alpha_1, ..., alpha_k}$
- Let $f_1$ be a winning $F$-strategy for Player 1 in $cal(G)$ and let $U
  subset.eq V$ be the set of vertices that are reachable when Player 1 plays
  according to $f_1$. $f_1$ will also be winning in $chevron G^v, alpha
  chevron.r$ for every $v in U$.
- For every $1 <= i <= k$ and $v in U$, $f_1$ induces a winning strategy for
  Player 1 in the Büchi game on $G^v$ with objective $alpha_i inter U$

== Structural Winning Condition

- Use the following $P$-strategy for Player 1: Start with $i = 1$, play
  according to the memoryless strategy of $<G^v, alpha_i inter U>$ while
  maintaining a counter which is increased every time the play visits $V_1$.
  When the counter is at least $n$ and the play reaches a vertex $v$ in $U
  inter V_1$, Player 1 resets the counter and increases $i$ to $i + 1 mod k$
  and starts playing the memoryless strategy of the new Büchi game $chevron
  G^v, alpha_i inter U chevron.r$
- In $n$ steps the play is guaranteed to reach a vertex in $alpha_i$, so before
  incrementing $i$, we always visit $alpha_i$. This way each set in $alpha$ is
  visited infinitely often.

== Thank You!

Thank you for attending our presentation. If you are interested in reading the paper, it can be found here:

#figure(image("img/paper_qr_code.png", width: 30%), caption: [https://dl.acm.org/doi/10.1145/3627705], numbering: none)
