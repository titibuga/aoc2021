


function main()
    input_str = readline("input.txt")
    bin_str = parseToB(input_str)
    v, b_str = readPackets(bin_str)
    println("Final v: $v")    
end

function parseToB(input_str)
    htb = Dict('0' => "0000",
                '1' => "0001",
                '2' => "0010",
                '3' => "0011",
                '4' => "0100",
                '5' => "0101",
                '6' => "0110",
                '7' => "0111",
                '8' => "1000",
                '9' => "1001",
                'A' => "1010",
                'B' => "1011",
                'C' => "1100",
                'D' => "1101",
                'E' => "1110",
                'F' => "1111")

    return join(htb[c] for c in input_str)
end

function isNonZero(b_str)
    for c in b_str
        if c != '0'
            return true
        end
    end
    return false
end

function readPackets(bin_str; num_packets = Inf)
    value_list = Int[]
    original_length = length(bin_str)
    n_packets_read = 0
    total_ver = 0
    while isNonZero(bin_str) && n_packets_read < num_packets
        (v,id,bin_str) = getVersionAndId(bin_str)
        total_ver += v
        println("== ID: $id")
        if id == 4
            (val, bin_str) = getValuePacket(bin_str, original_length - length(bin_str))
            push!(value_list, val)
        else
            println("=== OP package")
            (temp_val_list, bin_str) = getOpPacket(bin_str)
            val = 0
            println("Going to use ID: $id ")
            if id == 0
                val = sum(temp_val_list)
            elseif id == 1
                val = prod(temp_val_list)
            elseif id == 2
                val = minimum(temp_val_list)
            elseif id == 3
                val = maximum(temp_val_list)
            elseif id == 5
                val = temp_val_list[1] > temp_val_list[2]
            elseif id == 6
                val = temp_val_list[1] < temp_val_list[2]
            elseif id == 7
                val = temp_val_list[1] == temp_val_list[2]
            end
            push!(value_list, val)
        end
        println("= Reminder: $bin_str")
        n_packets_read += 1
    end
    return value_list, bin_str
end


function getOpPacket(bin_str)
    length_type_ID = bin_str[1]
    bin_str = bin_str[2:end]
    value_list = []
    if length_type_ID == '0'
        println("Length type: 0")
        num_bits = parseBtoInt( bin_str[1:15] )
        println("Num bits: $num_bits")
        bin_str = bin_str[16:end]
        contained_bin_str = bin_str[1:num_bits]
        bin_str = bin_str[(num_bits + 1):end]
        (value_list, _) = readPackets(contained_bin_str)
    else
        println("Length type: 0")
        num_packets = parseBtoInt( bin_str[1:11] )
        bin_str = bin_str[12:end]
        value_list, bin_str = readPackets(bin_str, num_packets = num_packets) 

    end
    return value_list, bin_str
end

function getValuePacket(b_str, n_bits_read)
    c = '1'
    bits_read = 0
    final_number = ""
    while c == '1'
        word = b_str[1:5]
        b_str = b_str[6:end]
        bits_read += 5
        c = word[1]

        final_number = join([final_number, word[2:end]])
    end
    #pad = (4 - (n_bits_read + bits_read) % 4) % 4 + 1
    pad = 1

    println("== Value: $final_number | Pad: $pad")
    return parseBtoInt(final_number), b_str[pad:end]
end

function parseBtoInt(b_str)
    n = length(b_str)
    return sum((2^(n - i))*parse(Int,b_str[i]) for i in 1:n)
end

function getVersionAndId(input_str)
    v = parseBtoInt(input_str[1:3])
    id = parseBtoInt(input_str[4:6])
    return (v, id, input_str[7:end])

end



main()
