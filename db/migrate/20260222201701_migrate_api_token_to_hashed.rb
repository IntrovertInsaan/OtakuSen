class MigrateApiTokenToHashed < ActiveRecord::Migration[8.0]
  def change
    # 1: Add the new column for the digest
    add_column :users, :hashed_api_token, :string
    add_index :users, :hashed_api_token, unique: true

    # 2. Refresh the User model so it 'sees' the new column
    User.reset_column_information

    # 3. Back-fill: hash all existing plaintext tokens
    # We use in_batches to keep memory usage low
    User.in_batches(of: 500) do |batch|
      batch.each do |user|
        # Skip users who don't have a token yet
        next if user.api_token.blank?
        user.update_column(
          :hashed_api_token,
          Digest::SHA256.hexdigest(user.api_token)
        )
      end
    end
  end
end
