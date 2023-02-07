class CreateVotes < ActiveRecord::Migration[7.0]
  def change
    create_table :votes do |t|
      t.references :question, null: false, foreign_key: true
      t.string :answer
      t.string :voter_ip

      t.timestamps
    end
  end
end
