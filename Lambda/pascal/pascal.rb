def triangulo(n)
    if n <= 0
        [1]
    else
        anterior = triangulo(n - 1)
        resultado = []
        0.upto(anterior.size - 2) do |i|
            resultado << anterior[i] + anterior[i + 1]
        end
        [1] + resultado + [1]
    end
end