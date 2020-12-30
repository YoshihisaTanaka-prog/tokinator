# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      ## Database authenticatable
      t.string   :email,              null: false, default: ""
      t.string   :encrypted_password, null: false, default: ""

      t.integer  :level,              null: false, default: 0
      t.datetime :request_levelup_at

      t.integer  :edit_route_count,   null: false, default: 0
      t.time     :edit_route_count_start 

      t.integer  :edit_goal_count,    null: false, default: 0
      t.time     :edit_goal_count_start 

      t.integer  :support_count,      null: false, default: 0
      t.time     :support_count_start 

      t.time     :reset_password_sent_at

      ## Recoverable
      t.string   :reset_password_token

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      # t.integer  :sign_in_count, default: 0, null: false
      # t.datetime :current_sign_in_at
      # t.datetime :last_sign_in_at
      # t.string   :current_sign_in_ip
      # t.string   :last_sign_in_ip

      ## Confirmable
      # t.string   :confirmation_token
      # t.datetime :confirmed_at
      # t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at


      t.timestamps null: false
    end

    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
    # add_index :users, :confirmation_token,   unique: true
    # add_index :users, :unlock_token,         unique: true
  end
end
