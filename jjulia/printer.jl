#!/usr/bin/env julia

include("./types.jl")

# ":" entfernen? "return string name of symbol"
pr_str(atom::Symbol_) = atom.val
pr_str(atom::Union{Float_, Integer_}) = string(atom.val)
pr_str(atom::True_) = "true"
pr_str(atom::False_) = "false"
pr_str(atom::String_) = atom.val
pr_str(atom::Nil_) = "nil"
pr_str(l::List_) = string("(", join([pr_str(atom) for atom in l.list], " "), ")")
