aim = 0
x = 0
y = 0
for l in eachline("input.txt")
    dir, val = split(l)
    val = parse(Int64, val)
    if dir == "forward"
        global x += val
        global y += aim*val
    elseif dir == "down"
        global aim += val
    elseif dir == "up"
        global aim -= val
    end
end
println(x)
println(y)
println(aim)
println(x*y)