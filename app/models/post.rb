class Post

  attr_accessor :title, :content
  attr_reader :id

  def initialize(id = nil)
    @id = id
  end

  def self.all
    results = DB.execute("SELECT * FROM posts")

    results.collect do |row|
      Post.new_from_db(row)
    end
  end

  def self.create_table
    sql = <<-SQL
      CREATE TABLE IF NOT EXISTS posts (
      id INTEGER PRIMARY KEY
      title TEXT,
      content TEXT
      );
    SQL

    DB.execute(sql)
  end

  def self.new_from_db(row)
    Post.new(row[0]).tap do |p|
      p.title   = row[1]
      p.content = row[2]
    end
  end

  def ==(other_post)
    self.id == other_post.id
  end

  def persisted?
    self.id
  end

  def save
    persisted? ? update : insert
    # if persisted?
    #   update
    # else
    #   insert
    # end
  end

  private
    def insert
      sql = <<-SQL
        INSERT INTO posts (title, content) VALUES (?, ?);
      SQL

      DB.execute(sql, self.title, self.content)
    end

    def update
      sql = <<-SQL
        UPDATE posts SET title = ?, content = ? WHERE id = ?
      SQL
      DB.execute(sql, self.title, self.content, self.id)
    end


end
