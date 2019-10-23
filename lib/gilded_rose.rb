require 'delegate'

class GildedRose
attr_accessor :items

  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      AllItems.wrap(item).update
    end
  end
end

class AllItems < SimpleDelegator

  def self.wrap(item)
    case item.name
    when "Aged Brie"
      AgedBrie.new(item)
    when "Sulfuras, Hand of Ragnaros"
      SulfurasItem.new(item)
    when "Backstage passes to a TAFKAL80ETC concert"
      BackstagePass.new(item)
    when "Conjured Mana Cake"
      ConjuredItem.new(item)
    else
      new(item)
    end
  end

  def update
    adjust_sell_in_date
    adjust_quality
  end

#For standard Items
  def adjust_sell_in_date
    self.sell_in -= 1
  end

  def adjust_quality
    self.sell_in < 0 ? self.quality -= 2 : self.quality -= 1
    self.quality < 0 ? self.quality = 0 : self.quality = self.quality
  end
end

#Below Classes for special cases
class AgedBrie < AllItems
  def adjust_quality
    self.quality += 1
    self.quality > 50 ? self.quality = 50 : self.quality = self.quality
  end
end

class SulfurasItem < AllItems
  def adjust_quality
    # do nothing
  end

  def adjust_sell_in_date
    # do nothing
  end
end

class BackstagePass < AllItems
  def adjust_quality
    if self.sell_in < 0
      self.quality = 0
    elsif self.sell_in < 5
      self.quality += 3
    elsif self.sell_in < 10
      self.quality += 2
    else
      self.quality += 1
    end
  end
end

class ConjuredItem < AllItems
  def adjust_quality
    self.sell_in < 0 ? self.quality -= 4 : self.quality -= 2
    self.quality < 0 ? self.quality = 0 : self.quality = self.quality
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
