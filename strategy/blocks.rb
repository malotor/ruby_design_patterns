def execute
  yield
end

hello = lambda do
  puts('Hello')
  puts('I am inside a proc')
end
hello.call

bye = lambda { puts('Bye bye, I am inside a proc') }
bye.call


puts "TEST"
execute &hello
execute &bye

def run_it_with_parameter(&block)
  puts('Before the call')
  block.call(24)
  puts('After the call')
end

def run_it_with_parameter_yield
  puts('Before the call')
  yield 24
  puts('After the call')
end

my_proc = lambda {|x| puts("The value of x is #{x}")}
run_it_with_parameter &my_proc
run_it_with_parameter_yield &my_proc
