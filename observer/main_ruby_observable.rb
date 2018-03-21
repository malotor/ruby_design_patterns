require 'observer'

class Employee

  include Observable

  attr_reader :name, :title
  attr_reader :salary
  def initialize( name, title, salary)
    @name = name
    @title = title
    @salary = salary
  end

  def salary=(new_salary)
    @salary = new_salary
    changed
    notify_observers(self)
  end
end



class Payroll
  def update( changed_employee )
    puts("Cut a new check for #{changed_employee.name}!")
    puts("His salary is now #{changed_employee.salary}!")
  end
end

class OtherPayroll
  def update( changed_employee )
    puts("******* #{changed_employee.name} => #{changed_employee.salary}! ")
  end
end

fred = Employee.new("Fred Flintstone", "Crane Operator", 30000.0)
fred.add_observer(Payroll.new)
fred.add_observer(OtherPayroll.new)
# Give Fred a raise
fred.salary=35000.0
