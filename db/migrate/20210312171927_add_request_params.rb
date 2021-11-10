class AddRequestParams < ActiveRecord::Migration[6.1]
  def change
    add_column :events, :request_params, :json
  end
end
