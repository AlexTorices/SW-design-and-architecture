arbol = ['A',
            ['B',
                ['D', [], []],
                []],
            ['C',
                ['E', [], []],
                ['F',
                    ['G', [], []],
                    ['H', [], []]]]]

def inorder_aux(arbol, yielder)
    return if arbol == []
    inorder_aux(arbol[1], yielder)
    yielder << arbol[0]
    inorder_aux(arbol[2], yielder)
end

def inorder(arbol)
    Enumerator.new do |yielder|
        inorder_aux(arbol, yielder)
    end
end

e = inorder(arbol)

p e.to_a
p e.take(5)
