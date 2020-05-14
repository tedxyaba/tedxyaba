class AddOrderPositionToTeam < ActiveRecord::Migration[6.0]
  def change
    add_column :teams, :order_position, :integer
  end
end
