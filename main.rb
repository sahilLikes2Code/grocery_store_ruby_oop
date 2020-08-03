require_relative "cart"
require_relative "valid_items"
require_relative "grocery_item"

puts "Please enter all the items purchased separated by a comma"

items_entered_by_user = gets.chomp
list_of_items = items_entered_by_user.gsub(" ", "").split(",")

if list_of_items.length < 1
  puts "Please enter atleast one item to calculate the bill"
  exit
end

for item in list_of_items
  if ValidItems::LIST_OF_ITEMS.include?(item)
    next
  else
    puts "Please recheck the items list, one or more items entered are invalid"
    exit
  end
end

cart = Cart.new

list_of_items.each { |item|
  grocery_item = nil
  case item
  when "apple"
    grocery_item = GroceryItem.new("Apple", 0.89)
  when "banana"
    grocery_item = GroceryItem.new("Banana", 0.99)
  when "milk"
    grocery_item = GroceryItem.new("Milk", 3.97, 2, 5)
  when "bread"
    grocery_item = GroceryItem.new("Bread", 2.17, 3, 6)
  end
  cart.add_item(grocery_item)
}
