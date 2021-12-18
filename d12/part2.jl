
function main()
    input_f = open("input.txt", "r")
    nodes = Set()
    adj = Dict()
    for l in eachline(input_f)
        e = split(l, "-")
        println("Edge: $e")
        (u,v) = e
        addEdge((u,v), nodes, adj)
    end

    println("==== Adj ====")
    println(adj)

    println(enumPaths(adj))
    
end

function isBig(v)
    return !(match(r"[A-Z]", v) === nothing)
end

function isSmall(v)
    return !isBig(v) && !(v in ["start", "end"])
end

function dfsR(s, adj, current_path)
    if s == "end"
        println("== Path found!: $(join(current_path))")
        return 1
    end
    
    if s in current_path && !isBig(s)
        filtered_path = [v for v in current_path if isSmall(v)] 
        if !isSmall(s) || length(filtered_path) != length(Set(filtered_path))
            return 0
        end
    end

    push!(current_path, s)

    total = sum(dfsR(v, adj, current_path) for v in adj[s])  
    
    pop!(current_path)

    return total


end

function enumPaths(adj)
    return dfsR("start", adj, [])
end

function addEdge(a, nodes, adj)
    (u,v) = a
    if !(u in nodes)
        push!(nodes, u)
        adj[u] = []
    end
    push!(adj[u],v)

    if !(v in nodes)
        push!(nodes, v)
        adj[v] = []
    end
    push!(adj[v],u)

end


main()
