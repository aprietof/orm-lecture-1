class Post

  def self.create_table
    DB.execute("CREATE TABLE IF NOT EXISTS posts (id INTEGER PRIMARY KEY)")
  end

end
