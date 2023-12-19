require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do

  describe "#update_quality" do
    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo"
    end

    context "when item is Aged Brie" do
      before do
        @items = [
          Item.new("Aged Brie", 3, 6),
          Item.new("Aged Brie", 0, 5),
          Item.new("Aged Brie", -3, 8),
          Item.new("Aged Brie", -5, 50)
        ]
        GildedRose.new(@items).update_quality()
      end
      it "should increase quality as it gets older if quality is less than 50" do
        expect(@items[0].quality).to eq 7
        expect(@items[0].sell_in).to eq 2
        expect(@items[1].quality).to eq 7
        expect(@items[1].sell_in).to eq -1
        expect(@items[2].quality).to eq 10
        expect(@items[2].sell_in).to eq -4
      end

      it "should not increase the quality if quality is 50" do
        expect(@items[3].quality).to eq 50
        expect(@items[3].sell_in).to eq -6
      end
    end

    context "when item is Backstage Passes" do
      before do
        @items = [
          Item.new("Backstage passes to a TAFKAL80ETC concert", 12, 6),
          Item.new("Backstage passes to a TAFKAL80ETC concert", 7, 33),
          Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 20),
          Item.new("Backstage passes to a TAFKAL80ETC concert", 0, 30),
          Item.new("Backstage passes to a TAFKAL80ETC concert", 4, 50),
        ]
        GildedRose.new(@items).update_quality()
      end

      it "should increase quality by 1 if sellIn is greater than 10" do
        expect(@items[0].quality).to eq 7
        expect(@items[0].sell_in).to eq 11
      end

      it "should increase quality by 2 if sellIn is greater than 5 but less than or equal to 10" do
        expect(@items[1].quality).to eq 35
        expect(@items[1].sell_in).to eq 6
      end

      it "should increase quality by 3 if sellIn is greater than 0 but less than or equal to 5" do
        expect(@items[2].quality).to eq 23
        expect(@items[2].sell_in).to eq 4
      end

      it "should drop quality to 0 if sellIn is less than or equal to 0" do
        expect(@items[3].quality).to eq 0
        expect(@items[3].sell_in).to eq -1
      end

      it "should not increase the quality if quality is 50" do
        expect(@items[4].quality).to eq 50
        expect(@items[4].sell_in).to eq 3
      end
    end

    context "when item is Sulfuras" do
      before do
        @items = [
          Item.new("Sulfuras, Hand of Ragnaros", 3, 80),
          Item.new("Sulfuras, Hand of Ragnaros", 0, 80),
          Item.new("Sulfuras, Hand of Ragnaros", -3, 80)
        ]
        GildedRose.new(@items).update_quality()
      end

      it "should fix the quantity to 80 regardless of sellIn value" do
        expect(@items[0].quality).to eq 80
        expect(@items[0].sell_in).to eq 3
        expect(@items[1].quality).to eq 80
        expect(@items[1].sell_in).to eq 0
        expect(@items[2].quality).to eq 80
        expect(@items[2].sell_in).to eq -3
      end
    end

    context "when item is Conjured" do
      before do
        @items = [
          Item.new("Conjured Mana Cake", 3, 6),
          Item.new("Conjured Mana Cake", 0, 5),
          Item.new("Conjured Mana Cake", -3, 8),
          Item.new("Conjured Mana Cake", -5, 0)
        ]
        GildedRose.new(@items).update_quality()
      end

      it 'should degrade quality by 2 if sellIn is greater than 0' do
        expect(@items[0].quality).to eq(4)
        expect(@items[0].sell_in).to eq 2
      end

      it 'should degrade quality by 4 if sellIn is less than or equal to 0' do
        expect(@items[1].quality).to eq(1)
        expect(@items[1].sell_in).to eq -1
        expect(@items[2].quality).to eq(4)
        expect(@items[2].sell_in).to eq -4
      end

      it 'should not degrade quality if quality is already 0 regardless of sellIn value' do
        expect(@items[3].quality).to eq(0)
        expect(@items[3].sell_in).to eq -6
      end
    end

    context "when item is other than the above" do
      before do
        @items = [
          Item.new("Cake", 3, 6),
          Item.new("Cake", 0, 5),
          Item.new("Cake", -3, 8),
          Item.new("Cake", -5, 0)
        ]
        GildedRose.new(@items).update_quality()
      end

      it 'should degrade quality by 1 if sellIn is greater than 0' do
        expect(@items[0].quality).to eq(5)
        expect(@items[0].sell_in).to eq 2
      end

      it 'should degrade quality by 2 if sellIn is less than or equal to 0' do
        expect(@items[1].quality).to eq(3)
        expect(@items[1].sell_in).to eq -1
        expect(@items[2].quality).to eq(6)
        expect(@items[2].sell_in).to eq -4
      end

      it 'should not degrade quality if quality is already 0 regardless of sellIn value' do
        expect(@items[3].quality).to eq(0)
        expect(@items[3].sell_in).to eq -6
      end
    end
  end

end
