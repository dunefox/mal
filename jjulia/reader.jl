#!/usr/bin/env julia

include("types.jl")

mutable struct Tokens
    position::Int64
    tokens::Array{String}
end

"""
    next(tokens::Tokens)

'next' returns the token at the current position and increments the position
"""
function next(t::Tokens)
    let token = t.tokens[t.position]
        t.position += 1
        return token
    end
end

"""
    peek(tokens::Tokens)

'peek' just returns the token at the current position
"""
function peek(t::Tokens)
    return t.tokens[t.position]
end

function tokenize(s::String)
    re = r"[\s,]*(~@|[\[\]{}()'`~^@]|\"(?:\\.|[^\\\"])*\"?|;.*|[^\s\[\]{}('\"`,;)]*)"
    [m[1] for m in eachmatch(re, s) if m[1] != ""]
end

function read_form(tk::Tokens)
    let fst = peek(tk)
        if fst == "("
            read_list(tk)
        else
            read_atom(tk)
        end
    end
end

function read_list(tk::Tokens)
    elements = List_([])
    next(tk)
    while (symbol = peek(tk)) != ")"
        push!(elements.list, read_form(tk))
    end
    next(tk)
    elements
end

function read_dict(tk::Tokens)
    elements = Dict_()
    next(tk)
    while (symbol = peek(tk)) != "}"
        push!(elements.list, read_form(tk))
    end
    next(tk)
    elements
end

function read_atom(tk::Tokens)
    let sym = next(tk)
        if (m = match(r"[\-\+]?[0-9]+\.[0-9]+", sym)) != nothing
            Float_(parse(Float64, m.match))
        elseif (m = match(r"[\-\+]?[0-9]+", sym)) != nothing
            Integer_(parse(Int64, m.match))
        elseif (m = match(r"^\".*\"$", sym)) != nothing
            String_(m.match)
        elseif (m = match(r"nil", sym)) != nothing
            Nil_()
        elseif (m = match(r"true", sym)) != nothing
            True_()
        elseif (m = match(r"false", sym)) != nothing
            False_()
        elseif (m = match(r"^[a-zA-Z]+[a-zA-Z0-9]*$", sym)) != nothing
            Symbol_(sym)
        elseif (m = match(r"^[\+\-\*]{1,}$", sym)) != nothing
            Symbol_(sym)
        # else
        #     error("no Atom parsed")
        end
    end
end

function read_str(s::String)
    tk = Tokens(1, tokenize(String(rstrip(s))))
    read_form(tk)
end
