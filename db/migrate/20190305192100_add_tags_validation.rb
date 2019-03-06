class AddTagsValidation < ActiveRecord::Migration[5.2]

  def up
    execute("INSERT INTO tags(name) values ('dummy')")
    tag_id = query("SELECT id FROM tags WHERE name='dummy'").first.first

    sql = <<-SQL

      INSERT INTO taggings(tag_id, taggable_id, taggable_type, context, created_at)
        Select #{tag_id}, images.id, 'Image', 'tags', '#{Time.now}' FROM images
        LEFT JOIN taggings ON images.id = taggings.taggable_id
        WHERE taggings.tag_id is null;

    SQL
    execute(sql)
  end

  def down
    tag_id = query("SELECT id FROM tags WHERE name='dummy'").first.first

    sql = <<-SQL

      DELETE FROM taggings WHERE tag_id = #{tag_id};

    SQL
    execute(sql)
    execute("DELETE FROM tags WHERE name='dummy'")
  end

end
