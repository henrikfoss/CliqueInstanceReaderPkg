module CliqueInstanceReader

function readInstance(filename, cut_of_no_nodes)
    isfile(filename) || error("cannot find data-file: $(filename)")
    ff = open(filename)

    no_nodes::Int32=0
    no_edges::Int32=0
    while( !eof(ff) )
        line = readline(ff)
        if line[1]=='c'
            #println(li, " c: $(line)")
        elseif line[1]=='p'
            #println("p $(line)")
            data = split(line)
            no_nodes= parse(Int32,data[3])
            no_edges= parse(Int32,data[4])
            break
        elseif line[1]=='e'
            li+=1
            exit(0)
        else
            println("wrong format: >$(line)<")
            exit(0)'
        end
    end

    if cut_of_no_nodes<0
       cut_of_no_nodes=no_nodes
    end
    println("datafile: ",filename," nodes: ", no_nodes, " edges: ", no_edges)
    println("cut_of_no_nodes: ",cut_of_no_nodes)
    if no_nodes<cut_of_no_nodes
        cut_of_no_nodes=no_nodes
    end
    edges=zeros(Int8,cut_of_no_nodes,cut_of_no_nodes)
    while( !eof(ff) )
        line = readline(ff)
        if line[1]=='c'
            #println(li, " c: $(line)")
        elseif line[1]=='p'
            #println(li, "p $(line)")
        elseif line[1]=='e'
            data = split(line)
            la_node= parse(Int32,data[2])
            sm_node= parse(Int32,data[3])
            if la_node<=cut_of_no_nodes  && sm_node<=cut_of_no_nodes
                edges[la_node,sm_node]=1
                edges[sm_node,la_node]=1
            end
        else
            println("wrong format: >$(line)<")
            exit(0)'
        end
    end

    return edges
end

export readInstance

end
