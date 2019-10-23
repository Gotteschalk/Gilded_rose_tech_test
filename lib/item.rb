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

  def depreciates?
    @name == "+5 Dexterity Vest" ||
    @name == "Elixir of the Mongoose" ||
    @name == "Conjured Mana Cake"
  end

  def appreciates?
    @name == "Aged Brie" || @name == "Backstage passes to a TAFKAL80ETC concert"
  end
end
