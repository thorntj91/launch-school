require 'pry'

class Todo
  DONE_MARKER = 'X'
  UNDONE_MARKER = ' '

  attr_accessor :title, :description, :done

  def initialize(title, description='')
    @title = title
    @description = description
    @done = false
  end

  def done!
    self.done = true
  end

  def done?
    done
  end

  def undone!
    self.done = false
  end

  def to_s
    "[#{done? ? DONE_MARKER : UNDONE_MARKER}] #{title}"
  end
end


# This class represents a collection of Todo objects.
# You can perform typical collection-oriented actions
# on a TodoList object, including iteration and selection.

class TodoList
  attr_accessor :title

  def initialize(title)
    @title = title
    @todos = []
  end

  def add(item)
    raise TypeError, 'Can only add Todo objects' unless item.kind_of? Todo
    @todos << item
    @todos
  end


  def <<(item)
    add(item)
  end

  def size
    @todos.size
  end

  def first
    @todos.first
  end

  def last
    @todos.last
  end

  def item_at(index)
    raise IndexError, 'List index out of bounds' if index >= @todos.size
    @todos[index]
  end

  def mark_done_at(index)
    raise IndexError, 'List index out of bounds' if index >= @todos.size
    @todos[index].done!
  end

  def shift
    @todos.shift
  end

  def pop
    @todos.pop
  end

  def remove_at(index)
    raise IndexError, 'List index out of bounds' if index >= @todos.size
    @todos.delete_at(index)
  end

  def to_s
    string = "# ---- #{@title} ----\n"
    @todos.each { |item| string << "# #{item}\n" }
    string
  end

  def each
    @todos.each do |todo|
      yield(todo)
    end
    self
  end

  def select
    selected = TodoList.new(title)
    each do |todo|
      selected << todo if yield(todo)
    end
    selected
  end

  def find_by_title(string)
    each do |todo|
      return todo if todo.title.downcase == string.downcase
    end
    puts "Item not found"
  end


  def all_done
    select { |todo| todo.done? }
  end

  def all_not_done
    select { |todo| !todo.done? }
  end

  def mark_done(string)
    find_by_title(string).done!
  end

  def mark_all_done
    each do |todo|
      todo.done!
    end
  end

  def mark_all_undone
    each do |todo|
      todo.undone!
    end
  end

end

todo1 = Todo.new("Buy milk")
todo2 = Todo.new("Clean room")
todo3 = Todo.new("Go to gym")
todo4 = Todo.new("Do homework")

list = TodoList.new("Today's Todos")
list.add(todo1)
list.add(todo2)
list.add(todo3)
list.add(todo4)

todo1.done!
todo2.done!

puts "Should expect Todo clean room"
puts list.find_by_title("Clean room")

puts "\nShould expect 'Buy milk', 'Clean room"
puts list.all_done

puts "\nShould expect 'Go to gym', 'Do homework'"
puts list.all_not_done

puts "\nShould expect 'done'"
list.mark_all_done
puts list

puts "\nShould expect 'not done'"
list.mark_all_undone
puts list

puts "\nShould expect 'Buy milk done'"
puts list.mark_done("buy milk")
puts list 



