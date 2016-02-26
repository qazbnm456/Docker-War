desc "Database related tasks"
namespace :database do
  desc "Convert to utf8mb4"
  task convert_to_utf8mb4: :environment do
    connection = ActiveRecord::Base.connection
    database = connection.current_database

    connection.execute "ALTER DATABASE #{database} CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci;"
    puts "Converted #{database} character set"

    # Change all tables
    connection.tables.each do |table|
      connection.columns(table).each do |column|
        if column.sql_type == "varchar(255)"
          puts "#{column.name} is varchar(255)"
          # Check for 255 indexed columns
          connection.indexes(table).each do |index|
            if index.columns.include?(column.name)
              puts "#{column.name} has index, altering length..."
              connection.execute "ALTER TABLE #{table} CHANGE `#{column.name}` `#{column.name}` varchar(191);"
              puts "...done!"
            end
          end
        end
      end

      puts "Converting #{table}..."
      connection.execute "ALTER TABLE #{table} CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
      puts "...#{table} converted!"

      connection.columns(table).each do |column|
        if column.type == :string || column.type == :text
          puts "Converting #{column.name}..."
          connection.execute "ALTER TABLE #{table} CHANGE `#{column.name}` `#{column.name}` #{column.sql_type} CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
          puts "...#{column.name} done!"
        end
      end

      puts "Repairing #{table}..."
      connection.execute "REPAIR TABLE #{table};"
      puts "...#{table} repaired!"
      puts "Optimizing #{table}..."
      connection.execute "OPTIMIZE TABLE #{table};"
      puts "...#{table} optimized!"
    end
  end
end