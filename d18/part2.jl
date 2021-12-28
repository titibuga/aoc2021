mutable struct Node
    l
    r
    p
    v
end


function main()
    input_f = open("input.txt", "r")
    num_list = []    
    for l in eachline(input_f)
        # push!(num_list, readSnailNum(line, nothing))
        lst = parseLine(l)
        num = readSnailNum(lst, nothing)
        println(strSnailNum(num))
        push!(num_list, num)
    end
    println("==== Done reading ====")
    #println(strSnailNum(findDeepNode(num_list[1], 0)))

    maxMag = -Inf

    println(strSnailNum(num_list[1]))
    for i in 1:length(num_list)
        for j in 1:length(num_list)
            if i != j
                s = snailSum(num_list[i], num_list[j])
                reduceNum(s)
                mag = snailMag(s)
                maxMag = max(maxMag, mag)
            end
        end
    end
    println("----")
    println(strSnailNum(num_list[1]))

    println("=== Final sum ====")
    println(maxMag)
end


function reduceNum(root)
    nd = nd2 = root
    i = 0
    while !(nd === nothing && nd2 === nothing)
        nd = nd2 = nothing
        #println("=============================")
        #println("--- Before reduce: $(strSnailNum(root))")
        nd = findDeepNode(root, 0)
        explodeNode(nd)
        #println("--- After explode: $(strSnailNum(root))")
        if !(nd === nothing)
            continue
        end
        nd2 = findSplitNode(root)
        splitNode(nd2)
        #println("--- After reduce: $(strSnailNum(root))")
        i += 1
        # if i > 10
        #     break
        # end
    end

end

function snailMag(nd)
    if isLeaf(nd)
        return nd.v
    end

    return 3*snailMag(nd.l) + 2*snailMag(nd.r)
end

function explodeNode(nd)
    if nd === nothing
        return
    end
    
    ln = findLeftNeighbour(nd)
    rn = findRightNeighbour(nd)

    # println("Left: $(strSnailNum(ln.p.p))")
    # println("Right: $(strSnailNum(rn.p))")

    if !(ln === nothing)
        ln.v += nd.l.v
    end
    if !(rn === nothing)
        rn.v += nd.r.v
    end

    p = nd.p
    if p.l == nd
        p.l = Node(nothing, nothing, p, 0)
    else
        p.r = Node(nothing, nothing, p, 0)
    end
end


function findLeftNeighbour(nd)
    cnd = nd
    #println("Starting: $(strSnailNum(nd))")
    p = cnd.p
    #println("Parent: $(strSnailNum(p))")
    while !(p === nothing) && p.l === cnd
        #println(" Up! $(strSnailNum(cnd))  ")
        cnd = p 
        p = cnd.p
    end

    if p === nothing
        return nothing
    end

    cnd = p.l
    while !(cnd.r === nothing)
        cnd = cnd.r
    end

    #println("Found: $(strSnailNum(cnd))")

    return cnd
end

function findRightNeighbour(nd)
    cnd = nd
    #println("Starting: $(strSnailNum(nd))")
    p = cnd.p
    #println("Parent: $(strSnailNum(p))")
    while !(p === nothing) && p.r === cnd
        #println(" Up! $(strSnailNum(cnd))  ")
        cnd = p
        p = cnd.p
    end

    if p === nothing
        return nothing
    end

    cnd = p.r
    while !(cnd.l === nothing)
        cnd = cnd.l
    end

    #println("Found: $(strSnailNum(cnd))")

    return cnd
end

function findSplitNode(nd)

    result = nothing
    if !(nd === nothing)

        if isLeaf(nd) && nd.v >= 10
            #println("-> Found split! $(nd.v)")
            return nd
        end

        result = findSplitNode(nd.l)
        if result === nothing
            result = findSplitNode(nd.r)
        end
    end

    return result

end


function splitNode(nd)
    if nd === nothing
        return
    end

    #println("Node to split: $(strSnailNum(nd))")
    v = nd.v 
    nd.v = nothing
    nd.l = Node(nothing, nothing, nd, Int(floor(v/2)))
    nd.r = Node(nothing, nothing, nd, Int(ceil(v/2)))
end

function findDeepNode(nd, depth)

    result = nothing
    if !(nd === nothing) && !isLeaf(nd)

        #println(" ---- Depth $depth")
        #println("$(strSnailNum(nd))")

        if isLeaf(nd.l) && isLeaf(nd.r) && depth >= 4 
            #println("Found explode node: $(strSnailNum(nd))")
            return nd
        end

        result = findDeepNode(nd.l, depth + 1)
        if result === nothing
            result = findDeepNode(nd.r, depth + 1)
        end
        #println(" -- Result ($depth): $(strSnailNum(result))")
    end

    return result

end

function copySnailNum(nd)
    if nd === nothing
        return nothing
    end
    cnd = Node(nothing, nothing, nothing, nd.v)
    cnd.l = copySnailNum(nd.l)
    if !(cnd.l === nothing)
        cnd.l.p = cnd
    end
    cnd.r = copySnailNum(nd.r)
    if !(cnd.r === nothing)
        cnd.r.p = cnd
    end

    return cnd
end

function snailSum(nd1, nd2)
    cnd1 = copySnailNum(nd1)
    cnd2 = copySnailNum(nd2)
    cnd = Node( cnd1, cnd2 , nothing, nothing)
    cnd1.p = cnd
    cnd2.p = cnd
    return cnd
end

function isLeaf(nd::Node)
    return nd.l === nothing && nd.r === nothing
end

function strSnailNum(nd)
    if nd === nothing
        return "-"
    end
    if isLeaf(nd)
        return "$(nd.v)"
    else
        return "[ $(strSnailNum(nd.l)), $(strSnailNum(nd.r)) ]"
    end

end

function parseLine(line)
    stack = []
    for c in line
        if c in "0123456789"
            push!(stack, parse(Int, c))
        elseif c == ']'
            el2 = pop!(stack)
            el1 = pop!(stack)
            push!(stack, [el1, el2])
        end
    end
    return stack[1]
end


function readSnailNum(lst, parent)
    if !(typeof(lst) == Int)

        (l,r) = lst
        cn = Node(nothing, nothing, parent, nothing)
        cn.l = readSnailNum(l, cn)
        cn.r = readSnailNum(r, cn)
        
        return cn
    else 
        return Node(nothing, nothing, parent, lst)
    end
end

main()