using Statistics

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
    point_dict = Dict(')' => 1,
                  ']' => 2,
                  '}' => 3,
                  '>' => 4)
                #   '(' => 3,
                #   '[' => 57,
                #   '{' => 1197,
                #   '<' => 25137]
    total = 0
    points_vec = []
    input_f = open("input.txt", "r")
    for l in eachline(input_f)
        println("===== $l")
        stack = []
        for c in l
            if c in keys(point_dict)
                if length(stack) == 0 || (c2 = pop!(stack)) != p_char[c]
                    total += point_dict[c]
                    stack = []
                    break
                end
            else
                push!(stack, c)
            end
        end
        
        if length(stack) > 0
            println("Incomplete line!")
            println(stack)
            value =  score([point_dict[p_char[c]] for c in stack])
            push!(points_vec, value)
        end
       
    end
    println(points_vec)
    println(median(points_vec))
end



function score(p_list)
    total = 0
    while length(p_list) > 0
        p = pop!(p_list)
        total = total*5 + p
    end
    return total
end
main()
