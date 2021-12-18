using Statistics


function main()
    input_f = open("input.txt", "r")
    positions = [parse(Int64,a) for a in split(readline(input_f), ",")]

    goal = median(positions)
    println(sum(abs.(positions .- goal)))
end

main()
