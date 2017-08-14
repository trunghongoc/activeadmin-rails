json.extract! book, :id, :name, :price, :sale, :user_id, :created_at, :updated_at
json.url book_url(book, format: :json)
