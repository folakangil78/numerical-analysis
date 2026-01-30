function f = is_fib(num)

prev = 1;
curr = 1;

while curr < num
    next = prev + curr;
    prev = curr;
    curr = next;
end
f = (curr == num);

end