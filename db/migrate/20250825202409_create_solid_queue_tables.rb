class CreateSolidQueueTables < ActiveRecord::Migration[8.0]
  def change
    create_table :solid_queue_jobs do |t|
      t.string :queue_name, null: false
      t.string :class_name, null: false
      t.text :arguments
      t.integer :priority, default: 0
      t.datetime :scheduled_at
      t.datetime :finished_at
      t.text :serialized_params
      t.timestamps

      t.index [:queue_name, :finished_at]
      t.index [:scheduled_at, :finished_at]
    end

    create_table :solid_queue_scheduled_executions do |t|
      t.references :job, null: false, foreign_key: { to_table: :solid_queue_jobs }
      t.string :queue_name, null: false
      t.integer :priority, default: 0
      t.datetime :scheduled_at, null: false
      t.timestamps

      t.index [:scheduled_at, :priority, :queue_name], name: "index_solid_queue_scheduled_executions_for_polling"
    end

    create_table :solid_queue_ready_executions do |t|
      t.references :job, null: false, foreign_key: { to_table: :solid_queue_jobs }
      t.string :queue_name, null: false
      t.integer :priority, default: 0
      t.timestamps

      t.index [:priority, :queue_name], name: "index_solid_queue_ready_executions_for_polling"
    end

    create_table :solid_queue_claimed_executions do |t|
      t.references :job, null: false, foreign_key: { to_table: :solid_queue_jobs }
      t.references :process, null: false
      t.timestamps

      t.index :process_id
      t.index [:process_id, :job_id]
    end

    create_table :solid_queue_blocked_executions do |t|
      t.references :job, null: false, foreign_key: { to_table: :solid_queue_jobs }
      t.string :queue_name, null: false
      t.integer :priority, default: 0
      t.string :concurrency_key, null: false
      t.datetime :expires_at, null: false
      t.timestamps

      t.index [:concurrency_key, :priority, :queue_name], name: "index_solid_queue_blocked_executions_for_polling"
    end

    create_table :solid_queue_failed_executions do |t|
      t.references :job, null: false, foreign_key: { to_table: :solid_queue_jobs }
      t.text :error
      t.timestamps
    end

    create_table :solid_queue_pauses do |t|
      t.string :queue_name, null: false
      t.timestamps

      t.index :queue_name, unique: true
    end

    create_table :solid_queue_processes do |t|
      t.string :kind, null: false
      t.datetime :last_heartbeat_at, null: false
      t.bigint :supervisor_id
      t.integer :pid, null: false
      t.string :hostname
      t.text :metadata
      t.timestamps
    end

    create_table :solid_queue_semaphores do |t|
      t.string :key, null: false
      t.integer :value, default: 1
      t.datetime :expires_at
      t.timestamps

      t.index :key, unique: true
      t.index :expires_at
    end
  end
end
