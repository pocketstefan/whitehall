class CreateMinisters < ActiveRecord::Migration[5.1]
  def change
    create_view :ministers
  end
end
