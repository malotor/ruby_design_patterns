class Task
  attr_reader :name
  def initialize(name)
    @name = name
  end
  def get_time_required
    0.0
  end
end
class AddDryIngredientsTask < Task
  def initialize
    super('Add dry ingredients')
  end
  def get_time_required
    1.0 # 1 minute to add flour and sugar
  end
end
class MixTask < Task
  def initialize
    super('Mix that batter up!')
  end
  def get_time_required
    3.0 # Mix for 3 minutes
  end
end



class CompositeTask < Task

  attr_reader :sub_tasks

  def initialize(name)
    super(name)
    @sub_tasks = []
  end
  def <<(task)
    @sub_tasks << task
  end

  def get_time_required
    time=0.0
    @sub_tasks.each {|task| time += task.get_time_required}
    time
  end
end

class Recipe
  attr_reader :composite_task
  attr_accessor :formatter
  def initialize(composite_task, &formatter)
    @composite_task = composite_task
    @formatter = formatter
  end
  def print
    @formatter.call( self )
  end
end

make_batter_task = CompositeTask.new('Make Batter')
make_batter_task << AddDryIngredientsTask.new
make_batter_task << MixTask.new

FORMATTER = lambda do |context|
  puts("RECIPE: #{context.composite_task.name}")
  puts('*******************************************')
  puts("Total time #{context.composite_task.get_time_required}")
  puts("Tasks:")
  context.composite_task.sub_tasks.each do |line|
    puts(" - #{line.name} (#{line.get_time_required}) " )
  end
end

my_recipe = Recipe.new(make_batter_task, &FORMATTER)
my_recipe.print
