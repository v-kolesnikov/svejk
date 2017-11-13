# frozen_string_literal: true

ROM::SQL.migration do
  change do
    create_table :webhooks do
      primary_key :id

      column :name, String, null: false
      column :url, String, null: false
      column :secret_key, String
      column :events, 'text[]', default: [], null: false

      DateTime :created_at
      DateTime :updated_at
    end
  end
end
