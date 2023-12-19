class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality()
    # Cases where items input does not match the requirements such as a regular item with negative quality, Sulfuras with quality other than 80, quality or sellin not an integer value, etc. were not covered because I was not sure if we can modify the quality value and if yes, what should be the value of quality.
    @items.each do |item|
      if item.name != "Aged Brie" and item.name != "Backstage passes to a TAFKAL80ETC concert"
        if item.quality > 0
          if item.name != "Sulfuras, Hand of Ragnaros"
            item.quality = item.quality - 1
            if item.name == "Conjured Mana Cake" && item.quality > 0
              item.quality = item.quality - 1
            end
          end
        end
      else
        if item.quality < 50
          item.quality = item.quality + 1
          if item.name == "Backstage passes to a TAFKAL80ETC concert"
            if item.sell_in < 11
              if item.quality < 50
                item.quality = item.quality + 1
              end
            end
            if item.sell_in < 6
              if item.quality < 50
                item.quality = item.quality + 1
              end
            end
          end
        end
      end
      if item.name != "Sulfuras, Hand of Ragnaros"
        item.sell_in = item.sell_in - 1
      end
      if item.sell_in < 0
        if item.name != "Aged Brie"
          if item.name != "Backstage passes to a TAFKAL80ETC concert"
            if item.quality > 0
              if item.name != "Sulfuras, Hand of Ragnaros"
                item.quality = item.quality - 1
                if item.name == "Conjured Mana Cake" && item.quality > 0
                  item.quality = item.quality - 1
                end
              end
            end
          else
            item.quality = item.quality - item.quality
          end
        else
          # Since in condition page nothing is mentioned regarding increase quantity of aged Brie, i am assuming that code indicating Aged Brie increase by 1 before sellIn is 0 and increase by 2 after sellIn is less than or equal to 0 is correct
          if item.quality < 50
            item.quality = item.quality + 1
          end
        end
      end
    end
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
