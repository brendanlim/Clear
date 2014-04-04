require "sqlite3"

class Database
  FILENAME  = "LocalTasks.sqlite"
  PACKAGE   = "com.realmacsoftware.clear.mac"
  PATH      = "/Library/Containers/#{PACKAGE}/Data/Library/Application " +
    "Support/#{PACKAGE}/#{FILENAME}"

  def initialize
    connect
  end

  def connection
    connect if @@connection.nil?
    @@connection
  end

  def completed(&block)
    connection.execute( "select * from completed_tasks" ) do |row|
      block.call(row) unless block.nil?
    end
  end

  def lists(&block)
    connection.execute( "select * from lists" ) do |row|
      block.call(row) unless block.nil?
    end
  end

  def tasks(list, &block)
    query = "select * from tasks"
    unless list.nil?
      query = "select * from tasks where list_identifier = \"#{list.identifier}\""
    end

    connection.execute(query) do |row|
      block.call(row) unless block.nil?
    end
  end

  private

  def connect
    @@connection = SQLite3::Database.new(File.expand_path('~') + PATH,
      :results_as_hash => true)
  end
end
