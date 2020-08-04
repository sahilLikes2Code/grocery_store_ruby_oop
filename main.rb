require "terminal-table/import"
require_relative "cart"
require_relative "valid_items"
require_relative "item"

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

list_of_items.each { |i|
  item = nil
  case i
  when "apple"
    item = Item.new("Apple", 0.89)
  when "banana"
    item = Item.new("Banana", 0.99)
  when "milk"
    item = Item.new("Milk", 3.97, 2, 5)
  when "bread"
    item = Item.new("Bread", 2.17, 3, 6)
  end
  cart.add_item(item)
}

item_price_qty_breakup = cart.item_price_qty_breakup
items_table = table { |t|
  t.headings = "Item", "Quantity", "Price"
  item_price_qty_breakup.each { |row| t << row }
}

items_table.style = { :width => 40, :border_x => "-", :border_i => "-", :border_bottom => false, :border_y => "" }

puts items_table
amount_before_discount = cart.amount_before_after_discount[0]
amount_after_discount = cart.amount_before_after_discount[1]

print "\n"
puts "Total price : $#{amount_after_discount.round(2)}"
puts "You saved $#{(amount_before_discount - amount_after_discount).round(2)} today."
