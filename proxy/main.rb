class BankAccount
  attr_reader :balance
  def initialize(starting_balance=0)
    @balance = starting_balance
  end
  def deposit(amount)
    @balance += amount
  end
  def withdraw(amount)
    @balance -= amount
  end
end

class AccountProxy
  def initialize(real_account)
    @subject = real_account
  end
  def method_missing(name, *args)
    puts("Delegating #{name} message to subject.")
    @subject.send(name, *args)
  end
end

class VirtualAccountProxy
  def initialize(starting_balance=0)
    @starting_balance=starting_balance
  end
  def deposit(amount)
    s = subject
    return s.deposit(amount)
  end
  def withdraw(amount)
    s = subject
    return s.withdraw(amount)
  end
  def balance
    s = subject
    return s.balance
  end
  def subject
    @subject || (@subject = BankAccount.new(@starting_balance))
  end
end


class VirtualProxyRubyWay
  def initialize(&creation_block)
    @creation_block = creation_block
  end
  def method_missing(name, *args)
    s = subject
    s.send( name, *args)
  end
  def subject
    @subject = @creation_block.call unless @subject
    @subject
  end
end

account = BankAccount.new(100)
account.deposit(50)
account.withdraw(10)

proxy = AccountProxy.new(account)
proxy.deposit(50)
proxy.withdraw(10)

proxy = VirtualAccountProxy.new(account)
proxy.deposit(50)
proxy.withdraw(10)
