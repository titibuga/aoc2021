


function main()
    p_char = Dict(
        '(' => ')',
        '{' => '}',
        '<' => '>',
        '[' => ']',
        ')' => '(',
        '}' => '{',
        '>' => '<',
        ']' => '['
    )
    point_dict = Dict(')' => 3,
                  ']' => 57,
                  '}' => 1197,
                  '>' => 25137)
                #   '(' => 3,
                #   '[' => 57,
                #   '{' => 1197,
                #   '<' => 25137]
    total = 0
    input_f = open("input.txt", "r")
    for l in eachline(input_f)
        println("===== $l")
        stack = []
        for c in l
            if c in keys(point_dict)
                println("Closing! ($c)")
                if length(stack) == 0 || (c2 = pop!(stack)) != p_char[c]
                    println("Corrupted line! Expected $(p_char[c2]) but saw $c")
                    total += point_dict[c]
                end
            else
                push!(stack, c)
                println(stack)
            end
        end
       
    end
    println(total)
end



main()
