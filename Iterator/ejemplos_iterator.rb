a = [5, 1 , 6 ,7 ,4]

a.each do |item|
    puts item
end

puts

def f_with_yield
    yield 5, 4
    yield 20, 7
end

f_with_yield {|x, y| puts x + y}

e = a.to_enum

# Devuelve el objeto y el índice
e.each_with_index do |item, index|
    puts "[#{index}] #{item}"
end

puts

puts e.next
puts e.peek
puts e.next

e.rewind
puts

begin
    5.times do
        puts e.next
    end
rescue StopIteration
    puts "END"
end

puts "hi"

e.rewind

loop do
    puts e.next
end

puts

# Usando generadores
e = Enumerator.new do |yielder|
    x = 5
    yielder << x
    x += 10
    yielder << x
    x *= 2
    yielder << x
end

loop do
    puts e.next
end

puts

e = Enumerator.new do |yielder|
    i = 1
    j = 2
    loop do
        j = i
        yielder << j
        i = i + j
    end
end

puts e.next
puts e.next
puts e.next