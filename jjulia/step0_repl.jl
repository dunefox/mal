#!/usr/bin/env julia

function read(x::String)
    x::String
end

function eval(x::String)
    x::String
end

function print(x::String)
    x::String
end

function rep(x::String)
    print(eval(read(x)))
end # function

while true
    println("user> ")
    flush(stdout)
    line = readline(stdin)
    if line == "" break end
    println(rep(line))
end
