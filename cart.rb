class Cart
  def initialize
    @items = []
  end

  def add_item(item)
    @items.push(item)
  end

  def amount_before_after_discount
    total_amount_before_discount = @items.map { |item| item.regular_price }.inject { |sum, n| sum + n }

    items_group = @items.group_by { |item| item.name }

    discounted_amount = items_group.inject(0) { |total, (name, list)|
      total += total_price_each_item(list)
    }

    [total_amount_before_discount, discounted_amount]
  end

  def total_price_each_item(collection)
    size = collection.size
    item = collection[0]

    if item.sale_price.nil?
      return size * item.regular_price
    end

    group_buy_packs = size / item.min_qty_for_dscnt
    remaining_qty = size % item.min_qty_for_dscnt
    (group_buy_packs * item.sale_price) + (remaining_qty * item.regular_price)
  end

  def item_price_qty_breakup
    item_name_price_qty = []
    items_group = @items.group_by { |item| item.name }

    items_group.each { |name, list|
      item_name_price_qty.push([name, list.size, "$#{total_price_each_item(list)}"])
    }

    item_name_price_qty
  end
end
