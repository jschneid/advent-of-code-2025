require 'rulp'

A_i >= 0
B_i >= 0
C_i >= 0
D_i >= 0

constraints = [
  A_i + C_i == 20,
  B_i + D_i == 15,
  B_i + C_i + D_i == 29,
  B_i == 1
]

problem = Rulp::Min(A_i + B_i + C_i + D_i) [ constraints ]

problem.glpk
