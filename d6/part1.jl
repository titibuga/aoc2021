
function main()
    input_f = open("input.txt", "r")
    state = [parse(Int64,a) for a in split(readline(input_f), ",")]
    days = 80

    fish_mask = []
    for i in 1:days
        fish_mask = state .== 0
        append!(state, [9 for i in 1:sum(fish_mask)])
        fish_mask = state .== 0
        state[fish_mask] .= 7
        state = state .- 1
        #println("Day $i: $state | $(length(state))")
        
        
    end

    println(length(state))

end

main()
