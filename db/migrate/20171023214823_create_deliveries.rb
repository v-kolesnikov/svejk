# frozen_string_literal: true

ROM::SQL.migration do
  change do
    create_table :deliveries do
      primary_key :id, 'uuid'

      foreign_key :webhook_id, :webhooks, null: false

      column :request,  'jsonb', default: Sequel.pg_jsonb({}), null: false
      column :response, 'jsonb'

      column :created_at,   Time, null: false
      column :delivered_at, Time
    end
  end
end
