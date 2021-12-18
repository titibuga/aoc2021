
x = 0
y = 0
for l in eachline("input.txt")
    dir, val = split(l)
    val = parse(Int64, val)
    if dir == "forward"
        global x += val
    elseif dir == "down"
        global y += val
    elseif dir == "up"
        global y -= val
    end
end
println(x)
println(y)
println(x*y)