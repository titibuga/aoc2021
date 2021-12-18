
function main()
    vec = nothing 
    for l in eachline("input.txt")
        line_vec = [(parse(Int64, a)*2 -1) for a in l]
        
        if vec === nothing
            vec = zeros(length(line_vec))
        end
        
        vec += line_vec
    end

    epsilon_vec = vec .> 0
    gamma_vec = vec .< 0
    n = length(vec)
    println(epsilon_vec)
    println(gamma_vec)
    eps_val = sum(epsilon_vec[i]*(2^(n - i)) for i in 1:n)
    gamma_val = sum(gamma_vec[i]*(2^(n - i)) for i in 1:n)
    println(eps_val)
    println(gamma_val)
    println(eps_val*gamma_val)

end

main()
