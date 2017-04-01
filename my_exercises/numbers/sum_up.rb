# sum up the numbers from 1 to n

def sum(n)
  sum = 0
  for i in (1..n)
    sum = sum + i
  end
  sum
end

def product(n)
  product = 1
  for i in (1..n)
    product = product * i
  end
  product
end

def sum2(n)
  sum = 0
  (1..n).each { |number| sum += number }
  sum
end

def product2(n)
  product = 1
  (1..n).each { |number| product *= number }
  product
end

def sum3(n)
  (1..n).inject(&:+)
end

def product3(n)
  (1..n).inject(&:*)
end

p sum(5) # 15
p sum2(5)
p sum3(5)
p product(5) # 120
p product2(5)
p product3(5)
