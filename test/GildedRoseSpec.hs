module GildedRoseSpec (spec) where

import Test.Hspec
import GildedRose

spec :: Spec
spec =
  describe "updateQuality" $ do

    it "decrements sellIn and quality" $
      let inventory = [Item "item" 10 10]
          actual = updateQuality inventory
          expected = [Item "item" 9 9]
      in actual `shouldBe` expected
    it "never decrements quality below zero" $
      let inventory = [Item "item" 10 0]
          actual = updateQuality inventory
          expected = [Item "item" 9 0]
      in actual `shouldBe` expected
    it "decrements quality twice after sellIn passed" $
      let inventory = [Item "item" 0 10]
          actual = updateQuality inventory
          expected = [Item "item" (-1) 8]
      in actual `shouldBe` expected
    it "never decrements quality below zero after sellIn passed" $
      let inventory = [Item "item" 0 1]
          actual = updateQuality inventory
          expected = [Item "item" (-1) 0]
      in actual `shouldBe` expected
    it "never decrements quality below zero after sellIn passed even when quality is 0" $
      let inventory = [Item "item" 0 0]
          actual = updateQuality inventory
          expected = [Item "item" (-1) 0]
      in actual `shouldBe` expected
    it "Aged Brie quality increases" $
        let inventory = [Item "Aged Brie" 10 10]
            actual = updateQuality inventory
            expected = [Item "Aged Brie" 9 11]
        in actual `shouldBe` expected
    it "Aged Brie quality increases only up to 50" $
        let inventory = [Item "Aged Brie" 10 50]
            actual = updateQuality inventory
            expected = [Item "Aged Brie" 9 50]
        in actual `shouldBe` expected
    it "Sulfuras never changes" $
        let itemName = "Sulfuras, Hand of Ragnaros"
            inventory = [Item itemName 10 5]
            actual = updateQuality inventory
            expected = [Item itemName 10 5]
        in actual `shouldBe` expected
    it "Backstage passes quality increases as sellIn approaches" $
        let passes = Item "Backstage passes to a TAFKAL80ETC concert"
            -- tuples with given sellIn, given quality and expected quality
            values = [(20, 10, 11)
                     ,(11, 10, 11)
                     ,(10, 10, 12)
                     ,( 9, 10, 12)
                     ,( 6, 10, 12)
                     ,( 5, 10, 13)
                     ,( 4, 10, 13)
                     ,( 1, 10, 13)
                     ,( 0, 10,  0)
                     ,(-1, 10,  0)
                     ,(20, 50, 50)
                     ,( 9, 50, 50)
                     ,( 3, 50, 50)]
            given    = [ [passes s     q] | (s, q, _) <- values]
            expected = [ [passes (s-1) q] | (s, _, q) <- values]
            actual   = map updateQuality given
        in actual `shouldBe` expected
