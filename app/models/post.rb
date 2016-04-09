class Post

  attr_accessor :title, :content

  def self.create_table
    sql = <<-SQL
      CREATE TABLE IF NOT EXISTS posts (
      id INTEGER PRIMARY KEY,
      title TEXT,
      content TEXT
      );
    SQL

    DB.execute(sql)
  end

  def insert
    sql = <<-SQL
      INSERT INTO posts (title, content) VALUES (?, ?);

    SQL

    DB.execute(sql, self.title, self.content)
  end


end
