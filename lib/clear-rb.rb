require 'clear-rb/version.rb'
require 'clear-rb/database.rb'
require 'clear-rb/task.rb'
require 'clear-rb/list.rb'
require 'colored'

# Add requires for other files you add to your project here, so
# you just need to require this one file in your bin file
class Clearrb
  def initialize
    @@db = nil
    @@lists = []
  end

  def list_tasks
    retrieve_lists
    puts

    @@lists.each do |list|
      next if list.tasks.size == 0

      puts " " + "#{list.title}".red.bold
      list.tasks.each do |task|
        puts " [#{task.id.to_s}] ".cyan + task.title
      end
      puts
    end
  end

  def retrieve_lists
    @@lists = []

    connection.lists do |row|
      list = List.new
      list.id = row["id"]
      list.identifier = row["identifier"]
      list.title = row["title"]
      list.tasks = []

      retrieve_tasks(list)
      @@lists << list
    end
  end

  def retrieve_tasks(list)
    connection.tasks(list) do |row|
      task = Task.new
      task.id = row["id"]
      task.title = row["title"]

      list.tasks << task
    end
  end

  def lists
    @@lists || []
  end

  def db
    @@db
  end

  private

  def connection
    @@db = Database.new if @@db.nil?
    @@db
  end
end
