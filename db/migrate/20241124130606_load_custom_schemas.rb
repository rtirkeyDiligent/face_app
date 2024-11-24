class LoadCustomSchemas < ActiveRecord::Migration[8.0]
  def up
    # Load cache schema
    load Rails.root.join('db', 'cache_schema.rb')

    # Load cable schema
    load Rails.root.join('db', 'cable_schema.rb')

    # Load queue schema
    load Rails.root.join('db', 'queue_schema.rb')
  end

  def down
    # Optionally drop tables if rollback is needed
    raise ActiveRecord::IrreversibleMigration, "Cannot roll back custom schema loading"
  end
end