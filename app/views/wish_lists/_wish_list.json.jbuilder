json.extract! wish_list, :id, :name, :ISBN, :price, :stock, :created_at, :updated_at
json.url wish_list_url(wish_list, format: :json)
