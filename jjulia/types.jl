abstract type Expression end
abstract type Atoms <: Expression end

mutable struct List_ <: Expression
    list::Array{Expression}
end

mutable struct Dict_ <: Expression
    dict::Dict{Expression, Expression}
end

struct Float_ <: Atoms
    val::Float64
end

struct String_ <: Atoms
    val::String
end

struct Integer_ <: Atoms
    val::Int64
end

struct Nil_ <: Atoms
end

struct True_ <: Atoms
end

struct False_ <: Atoms
end

struct Symbol_ <: Expression
    val::String
end
